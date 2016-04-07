CREATE OR REPLACE FUNCTION CRM_UNBLOCK_PHONE (pPHONE_NUMBER VARCHAR2)
   RETURN VARCHAR2
IS
   --Version = 5
   --
   -- v.5 10.12.2014 - Матюнин. Поправлен, чтобы в LOG_CHANGE_CONTRACT_DOP_STATUS писались только те пномера, что были в первоначальной блокировке
   -- v.4 05.12.2014 - Афросин вставил в условие ELSE  ADD_LOG_CHANGE_CONTRACT_DOP_STATUS
   -- v.3 03.12.2014 Афросин добавил запись о смене доп статуса в таблицу LOG_CHANGE_CONTRACT_DOP_STATUS
   -- 2. 31.10.2014 Крайнов. Добавлены "Первоначальная" и логирование доп статуса.
   --
   PRAGMA AUTONOMOUS_TRANSACTION;
   tmpVar                 NUMBER;
   DiscLim                NUMBER;
   ConLim                 NUMBER;
   bal                    NUMBER;
   UNLOCK_PH              VARCHAR2 (2000);
   vPHONE_DOP_STATUS_ID   INTEGER;
   vCONTRACT_ID           INTEGER;

   PROCEDURE ADD_LOG_CHANGE_CONTRACT (inPhone          VARCHAR2,
                                      inDopStatusID    INTEGER)
   AS
   BEGIN
     IF inDopStatusID = 222 THEN  -- V.5  ДЛЯ ЭТОГО ЛОГА(ОТЧЕТА) ВАЖНА ТОЛЬКО "ПЕРВОНАЧАЛЬНЫЙ БЛОКИРОВКА"   
       INSERT
         INTO LOG_CHANGE_CONTRACT_DOP_STATUS (PHONE_NUMBER, DOP_STATUS_ID)
       VALUES (inPhone, nvl(inDopStatusID, -1));
     END IF;
     COMMIT;
   END;
BEGIN
   tmpVar := 0;

   SELECT COUNT (1)
     INTO tmpVar
     FROM V_PHONES_FOR_UNLOCK_CRM_N vv
    WHERE vv.PHONE_NUMBER_FEDERAL = pPHONE_NUMBER;

   SELECT VV.DOP_STATUS_ID, VV.CONTRACT_ID
     INTO vPHONE_DOP_STATUS_ID, vCONTRACT_ID
     FROM V_PHONES_FOR_UNLOCK_CRM_N vv
    WHERE vv.PHONE_NUMBER_FEDERAL = pPHONE_NUMBER;


   IF tmpVar = 1
   THEN
      SELECT vv.balance,
             NVL (vv.disconnect_limit, 0),
             NVL (vv.connect_limit, NVL (vv.balunlock, 0))
        INTO bal, DiscLim, ConLim
        FROM V_PHONES_FOR_UNLOCK_CRM_N vv
       WHERE vv.PHONE_NUMBER_FEDERAL = pPHONE_NUMBER;


      ADD_LOG_CHANGE_CONTRACT (pPHONE_NUMBER, vPHONE_DOP_STATUS_ID);

      IF bal - DiscLim > ConLim
      THEN
         UNLOCK_PH := beeline_api_pckg.UNLOCK_PHONE (pPHONE_NUMBER, 0);



         IF REGEXP_INSTR (UNLOCK_PH,
                          'Заявка на разблок №\d+') <= 0
         THEN
            INSERT INTO AUTO_UNBLOCKED_PHONE (phone_number,
                                              Ballance,
                                              Note,
                                              unblock_date_time,
                                              ABONENT_FIO)
                 VALUES (pPHONE_NUMBER,
                         bal,
                         SUBSTR ('Ошибка. ' || UNLOCK_PH, 1, 300),
                         SYSDATE,
                         'Разблокировка через CRM');

            INSERT INTO CRM_UNBLOCK_PHONE_LOG (PHONE_NUMBER,
                                               BALANCE,
                                               DATE_INSERT,
                                               ERROR_TEXT,
                                               CRM_MESSAGE_TYPE,
                                               DOP_STATUS_ID)
                 VALUES (pPHONE_NUMBER,
                         bal,
                         SYSDATE,
                         SUBSTR ('Ошибка. ' || UNLOCK_PH, 1, 300),
                         1,
                         vPHONE_DOP_STATUS_ID);

            COMMIT;
            RETURN    'Ошибка при разблокировке номера.'
                   || UNLOCK_PH;
         ELSE
            INSERT INTO CRM_UNBLOCK_PHONE_LOG (PHONE_NUMBER,
                                               BALANCE,
                                               DATE_INSERT,
                                               ERROR_TEXT,
                                               CRM_MESSAGE_TYPE,
                                               DOP_STATUS_ID)
                 VALUES (pPHONE_NUMBER,
                         bal,
                         SYSDATE,
                         NULL,
                         2,
                         vPHONE_DOP_STATUS_ID);

            UPDATE CONTRACTS C
               SET C.DOP_STATUS = NULL
             WHERE C.CONTRACT_ID = vCONTRACT_ID;

            COMMIT;
            RETURN 'Номер успешно отправлен на разблокировку.';
         END IF;
      ELSE
         INSERT INTO CRM_UNBLOCK_PHONE_LOG (PHONE_NUMBER,
                                            BALANCE,
                                            DATE_INSERT,
                                            ERROR_TEXT,
                                            CRM_MESSAGE_TYPE,
                                            DOP_STATUS_ID)
              VALUES (pPHONE_NUMBER,
                      bal,
                      SYSDATE,
                      NULL,
                      3,
                      vPHONE_DOP_STATUS_ID);

         COMMIT;
         RETURN 'Недостаточно денежных средств для разблокировки';
      END IF;
   ELSE
      INSERT INTO CRM_UNBLOCK_PHONE_LOG (PHONE_NUMBER,
                                         BALANCE,
                                         DATE_INSERT,
                                         ERROR_TEXT,
                                         CRM_MESSAGE_TYPE,
                                         DOP_STATUS_ID)
           VALUES (pPHONE_NUMBER,
                   bal,
                   SYSDATE,
                   NULL,
                   3,
                   vPHONE_DOP_STATUS_ID);

      ADD_LOG_CHANGE_CONTRACT (pPHONE_NUMBER, vPHONE_DOP_STATUS_ID);

      COMMIT;
      RETURN 'Номер не может быть разблокирован.';
   END IF;
EXCEPTION
   WHEN NO_DATA_FOUND
   THEN
      RETURN 'Ошибка при разблокировке номера.';
   WHEN OTHERS
   THEN
      -- Consider logging the error and then re-raise
      RETURN    'Ошибка при разблокировке номера. '
             || SQLERRM;
      RAISE;
END CRM_UNBLOCK_PHONE;
/
