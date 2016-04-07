CREATE OR REPLACE FUNCTION CORP_MOBILE.CRM_UNBLOCK_PHONE (pPHONE_NUMBER VARCHAR2)
   RETURN VARCHAR2
IS
   --Version = 7
   -- v 8 12.10.2015 Kочнев Дабавил проверку на вьюху V_UNBLOCK_BETWEEN_LIMITS по #3473
   -- v.7 06.02.2015 - Матюнин. Убралд обновление даты контракта, которое было добавлено в V.6.
   -- v.6 06.02.2015 - Матюнин. При смене доп статуса "Первоначальая блокирвка" обновлять дату договора.
   -- v.5 10.12.2014 - Матюнин. Поправлен, чтобы в LOG_CHANGE_CONTRACT_DOP_STATUS писались только те пномера, что были в первоначальной блокировке
   -- v.4 05.12.2014 - Афросин вставил в условие ELSE  ADD_LOG_CHANGE_CONTRACT_DOP_STATUS
   -- v.3 03.12.2014 Афросин добавил запись о смене доп статуса в таблицу LOG_CHANGE_CONTRACT_DOP_STATUS
   -- 2. 31.10.2014 Крайнов. Добавлены "Первоначальная" и логирование доп статуса.
   --
   PRAGMA AUTONOMOUS_TRANSACTION;
   tmpVar                 NUMBER;
   tmpVar2                NUMBER;
   DiscLim                NUMBER;
   ConLim                 NUMBER;
   bal                    NUMBER;
   UNLOCK_PH              VARCHAR2 (2000);
   vPHONE_DOP_STATUS_ID   INTEGER;
   vCONTRACT_ID           INTEGER;
   tmpAnswer              NUMBER;
   b_lim                  NUMBER; 
   ub_lim                 NUMBER;
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
   tmpAnswer := 0;
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
        tmpAnswer := 1;         
      ELSE
        tmpAnswer := 0;
        select count(1) into tmpVar2
          FROM V_UNBLOCK_BETWEEN_LIMITS V
         WHERE NOT EXISTS 
                         (SELECT 1 FROM AUTO_UNBLOCKED_PHONE R
                           WHERE R.PHONE_NUMBER = V.PHONE_NUMBER_FEDERAL
                             AND R.UNBLOCK_DATE_TIME > SYSDATE - 15/24/60)
           and V.PHONE_NUMBER_FEDERAL = pPHONE_NUMBER;           
        if tmpVar2 > 0 then
          select V.BLOCK_LIMIT, v.UNBLOCK_LIMIT into b_lim, ub_lim
            FROM V_UNBLOCK_BETWEEN_LIMITS V
           WHERE NOT EXISTS 
                           (SELECT 1 FROM AUTO_UNBLOCKED_PHONE R
                             WHERE R.PHONE_NUMBER = V.PHONE_NUMBER_FEDERAL
                               AND R.UNBLOCK_DATE_TIME > SYSDATE - 15/24/60)
             and V.PHONE_NUMBER_FEDERAL = pPHONE_NUMBER; 
          IF (bal > b_lim) AND (bal < ub_lim) THEN
            tmpAnswer := 1;         
          else
           tmpAnswer := 0;                      
          end if;
        else
          tmpAnswer := 0;
        end if;
      END IF;
      
      if tmpAnswer = 1 then
        UNLOCK_PH := beeline_api_pckg.UNLOCK_PHONE (pPHONE_NUMBER, 0);
        IF REGEXP_INSTR (UNLOCK_PH, 'Заявка на разблок №\d+') <= 0 THEN
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
          RETURN    'Ошибка при разблокировке номера.' || UNLOCK_PH;
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
      end if; -- if tmpAnswer = 1 then
      
      if tmpAnswer = 0 then
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
      end if; -- if tmpAnswer = 0
   ELSE -- IF tmpVar = 1
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
   END IF; --IF tmpVar = 1
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