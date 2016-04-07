
  CREATE OR REPLACE PROCEDURE "LONTANA"."SEND_SMS_NOTICE" 
AS
   --
   --#Version=15
   --
   --09.09.2011 Крайнов. Вынесен во вьюшку отбор телефонов
   --
   CURSOR C
   IS
      SELECT PHONE_NUMBER_FEDERAL,
             BALANCE,
             FIO,
             DISCONNECT_LIMIT,
             BALANCE_NOTICE_TEXT,
             ACCOUNT_ID
        FROM V_PHONE_NUMBERS_FOR_NOTICE_BAL;

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
   SMS_TXT   VARCHAR2 (2000);
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

         IF vBL.DO_BALANCE_NOTICE = 1
         THEN
            v_d := TO_CHAR (SYSDATE, 'mm/dd/yyyy');
            v_t := TO_CHAR (SYSDATE, 'hh24:mi');
            SMS_TXT :=
               REPLACE (vREC.BALANCE_NOTICE_TEXT,
                        '%balance%',
                        ROUND (vRec.Balance));
            SMS_TXT := REPLACE (SMS_TXT, '%dolg%', ROUND (-vRec.Balance));
            SMS :=
               LOADER3_pckg.SEND_SMS (vREC.PHONE_NUMBER_FEDERAL,
                                      'Смс-оповещение',
                                      SMS_TXT);
            DBMS_LOCK.SLEEP (2);

            IF SMS IS NULL
            THEN
               INSERT
                 INTO BLOCK_SEND_SMS (phone_number,
                                      SEND_DATE_TIME,
                                      ABONENT_FIO)
               VALUES (vREC.PHONE_NUMBER_FEDERAL, SYSDATE, vREC.FIO);
            END IF;

            COMMIT;
         END IF;
      END LOOP;
   END IF;
END;