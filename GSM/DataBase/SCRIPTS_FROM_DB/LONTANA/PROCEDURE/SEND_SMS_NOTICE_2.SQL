
  CREATE OR REPLACE PROCEDURE "LONTANA"."SEND_SMS_NOTICE_2" (pAccountId INTEGER)
AS
   --
   --#Version=4
   --
   --v.4 23.02.2016 Кочнев вывод долга делаем через char для отображения 2ч знаков после запятой
    --v.3 18.02.2016 Афросин убрал рассылку одинаковых смс об отрицательном балансе
   --v.2 23.03.2015 Афросин - разбиение по счетам
   --v.1 09.09.2011 Крайнов. Вынесен во вьюшку отбор телефонов
   --
   CURSOR C
   IS
      SELECT PHONE_NUMBER_FEDERAL,
             BALANCE,
             FIO,
             DISCONNECT_LIMIT,
             BALANCE_NOTICE_TEXT,
             ACCOUNT_ID
        FROM V_PHONE_NUMBERS_FOR_NOTICE_BAL
       WHERE account_id = pAccountId;

   vREC      C%ROWTYPE;

   --
   CURSOR BL (ID INTEGER)
   IS
      SELECT ACCOUNTS.DO_BALANCE_NOTICE
        FROM ACCOUNTS
       WHERE ID = ACCOUNTS.ACCOUNT_ID;

   --
   vBL       BL%ROWTYPE;
   v_d       VARCHAR2 (2000);
   v_t       VARCHAR2 (2000);
   SMS       VARCHAR2 (2000);
   v_SMS_TXT   VARCHAR2 (2000);
   v_ct integer;
--
BEGIN
   --
   IF (   (    (TO_NUMBER (
                   TO_CHAR (SYSDATE, 'D', 'NLS_DATE_LANGUAGE=RUSSIAN')) < 6)
           AND (TO_NUMBER (TO_CHAR (SYSDATE, 'hh24')) BETWEEN 8 AND 18))
       OR (    (TO_NUMBER (
                   TO_CHAR (SYSDATE, 'D', 'NLS_DATE_LANGUAGE=RUSSIAN')) > 5)
           AND (TO_NUMBER (TO_CHAR (SYSDATE, 'hh24')) BETWEEN 11 AND 18)))
   THEN
      FOR vREC IN C
      LOOP
         OPEN BL (vREC.ACCOUNT_ID);

         FETCH BL INTO vBL;

         CLOSE BL;

         IF vBL.DO_BALANCE_NOTICE = 1 THEN
         
            v_d := TO_CHAR (SYSDATE, 'mm/dd/yyyy');
            v_t := TO_CHAR (SYSDATE, 'hh24:mi');
            v_SMS_TXT := REPLACE (vREC.BALANCE_NOTICE_TEXT, '%balance%', to_char (ROUND (vRec.Balance, 2), 'fm99990.00'));
               --REPLACE (vREC.BALANCE_NOTICE_TEXT, '%balance%', ROUND (vRec.Balance));
            
            v_SMS_TXT := REPLACE (v_SMS_TXT, '%dolg%', to_char (ROUND (-vRec.Balance, 2), 'fm99990.00'));
            
            
            --делаем проверку на повторность отправки смс
            SELECT count(*) into v_ct
            FROM
              log_send_sms s
            WHERE
              phone_number = vREC.PHONE_NUMBER_FEDERAL AND
              trunc(date_send) = trunc(sysdate)
              and s.sms_text = v_SMS_TXT; 
            
            --если не отправляли такой смс сегодня, то шлем
            if nvl(v_ct, 0) = 0 then
            
            
              SMS :=
                 LOADER3_pckg.SEND_SMS (vREC.PHONE_NUMBER_FEDERAL,
                                        'Смс-оповещение',
                                        v_SMS_TXT);
              DBMS_LOCK.SLEEP (2);

              IF SMS IS NULL THEN
                 INSERT
                   INTO BLOCK_SEND_SMS (phone_number,
                                        SEND_DATE_TIME,
                                        ABONENT_FIO)
                 VALUES (vREC.PHONE_NUMBER_FEDERAL, SYSDATE, vREC.FIO);
              END IF;
              
            end if;-- if nvl(v_ct, 0) = 0 then

            COMMIT;
         END IF;
      END LOOP;
   END IF;
END;