CREATE OR REPLACE PACKAGE LOADER3_PCKG
IS
   --
   --#Version=13
   --v.13 16.02.2015 Афросин добавил параметр по умолчанию в LOCK_PHONE   
   --30.01.2015 Алексеев. На время тестирования изменил функцию SEND_SMS_MULTI, на номера 9057728987, 9057728557 настроил провайдер со статусом 0 
   --01.11.2012 Николаев. 11. Добавлена функция для загрузки деталки с сайта.
   --24.08.2011 Крайнов. 6. Вставил исключения в блокировку и разблокировку
   --
   FUNCTION GET_PHONE_DETAIL (pYEAR           IN INTEGER,
                              pMONTH          IN INTEGER,
                              pPHONE_NUMBER   IN VARCHAR2)
      RETURN CLOB;

   FUNCTION GET_SITE_PHONE_DETAIL (pLOADING_YEAR    IN INTEGER,
                                   pLOADING_MONTH   IN INTEGER,
                                   pPHONE_NUMBER    IN VARCHAR2)
      RETURN CLOB;

   --
   FUNCTION LOCK_PHONE (pPHONE_NUMBER      IN VARCHAR2,
                        pMANUAL_BLOCK      IN INTEGER DEFAULT 1,
                        --
                        pNew_site_method   IN INTEGER DEFAULT 0,
                        pLock_TYPE in  varchar2 default 'WIO'
                        )
      RETURN VARCHAR2;

   --
   FUNCTION UNLOCK_PHONE (pPHONE_NUMBER      IN VARCHAR2,
                          pMANUAL_UNLOCK     IN INTEGER DEFAULT 1,
                          --
                          pNew_site_method   IN INTEGER DEFAULT 0)
      RETURN VARCHAR2;

   --
   /*  FUNCTION SEND_SMS_MULTI(
       pPHONE_NUMBERS IN DBMS_SQL.VARCHAR2_TABLE,
       pMAILING_NAME IN VARCHAR2,
     --  pSENDER_NAME IN VARCHAR2,
       pSMS_TEXT IN VARCHAR2
       ) RETURN VARCHAR2;*/
   --
   FUNCTION SEND_SMS (pPHONE_NUMBER      IN VARCHAR2,
                      pMAILING_NAME      IN VARCHAR2,
                      --    pSENDER_NAME IN VARCHAR2,
                      pSMS_TEXT          IN VARCHAR2,
                      pUSE_REPEAT_SEND   IN INTEGER DEFAULT 0,
                      pSENDER_NAME       IN VARCHAR2 DEFAULT NULL
                      )
      RETURN VARCHAR2;
END LOADER3_PCKG;
/
CREATE OR REPLACE PACKAGE BODY LOADER3_PCKG
IS
   --
   FUNCTION GET_PHONE_DETAIL (pYEAR           IN INTEGER,
                              pMONTH          IN INTEGER,
                              pPHONE_NUMBER   IN VARCHAR2)
      RETURN CLOB
   IS
      --
      CURSOR C
      IS
         SELECT DISTINCT ACCOUNTS.LOGIN
           FROM DB_LOADER_PHONE_STAT, ACCOUNTS
          WHERE         --DB_LOADER_PHONE_STAT.YEAR_MONTH = pYEAR*100 + pMONTH
               DB_LOADER_PHONE_STAT.PHONE_NUMBER = pPHONE_NUMBER
                AND ACCOUNTS.ACCOUNT_ID = DB_LOADER_PHONE_STAT.ACCOUNT_ID;

      --
      vLOGIN    ACCOUNTS.LOGIN%TYPE;
      res       CLOB;
      new_res   CLOB;
   BEGIN
      FOR rec IN c
      LOOP
         IF rec.login IS NOT NULL
         THEN
            new_res :=
               LOADER_CALL_PCKG.GET_PHONE_DETAIL (rec.login,
                                                  pYEAR,
                                                  pMONTH,
                                                  pPHONE_NUMBER);

            IF res IS NULL
            THEN
               res := new_res;
            ELSE
               IF new_res IS NOT NULL
               THEN
                  DBMS_LOB.APPEND (res, new_res);
               END IF;
            END IF;
         END IF;
      END LOOP;

      RETURN res;
   END;

   --
   FUNCTION GET_SITE_PHONE_DETAIL (pLOADING_YEAR    IN INTEGER,
                                   pLOADING_MONTH   IN INTEGER,
                                   pPHONE_NUMBER    IN VARCHAR2)
      RETURN CLOB
   IS
      --
      CURSOR C
      IS
         SELECT DISTINCT ACCOUNTS.LOGIN
           FROM DB_LOADER_PHONE_STAT, ACCOUNTS
          WHERE         --DB_LOADER_PHONE_STAT.YEAR_MONTH = pYEAR*100 + pMONTH
               DB_LOADER_PHONE_STAT.PHONE_NUMBER = pPHONE_NUMBER
                AND ACCOUNTS.ACCOUNT_ID = DB_LOADER_PHONE_STAT.ACCOUNT_ID;

      --
      vLOGIN    ACCOUNTS.LOGIN%TYPE;
      res       CLOB;
      new_res   CLOB;
   BEGIN
      FOR rec IN c
      LOOP
         IF rec.login IS NOT NULL
         THEN
            new_res :=
               LOADER_CALL_PCKG.GET_SITE_PHONE_DETAIL (rec.login,
                                                       pLOADING_YEAR,
                                                       pLOADING_MONTH,
                                                       pPHONE_NUMBER);

            IF res IS NULL
            THEN
               res := new_res;
            ELSE
               IF new_res IS NOT NULL
               THEN
                  DBMS_LOB.APPEND (res, new_res);
               END IF;
            END IF;
         END IF;
      END LOOP;

      RETURN res;
   END;

   --
   FUNCTION LOCK_PHONE (pPHONE_NUMBER      IN VARCHAR2,
                        pMANUAL_BLOCK      IN INTEGER DEFAULT 1,
                        --
                        pNew_site_method   IN INTEGER DEFAULT 0,
                        pLock_TYPE in  varchar2 default 'WIO'
                        
                        )
      RETURN VARCHAR2
   IS
      --
      --Овсянников Л.В. 19.11.2012 Исправление выборки определения ACCOUNT_ID в курсоре C. Изменена таблица DB_LOADER_PHONE_STAT на DB_LOADER_ACCOUNT_PHONES
      --Назин П.В. 13.03.2013 Добавление параметра и ссылки на блокировку через новый кабинет
      CURSOR C
      IS
           SELECT Accounts.Account_Id,
                  ACCOUNTS.LOGIN,
                  ACCOUNTS.PASSWORD,
                  OPERATORS.LOADER_SCRIPT_NAME,
                  LOADER_SETTINGS.LOADER_DB_CONNECTION,
                  LOADER_SETTINGS.LOADER_DB_USER_NAME,
                  LOADER_SETTINGS.LOADER_DB_PASSWORD
             FROM --DB_LOADER_PHONE_STAT,
                  DB_LOADER_ACCOUNT_PHONES,
                  ACCOUNTS,
                  OPERATORS,
                  LOADER_SETTINGS
            WHERE          --DB_LOADER_PHONE_STAT.PHONE_NUMBER = pPHONE_NUMBER
                 DB_LOADER_ACCOUNT_PHONES.PHONE_NUMBER = pPHONE_NUMBER
                  --AND ACCOUNTS.ACCOUNT_ID=DB_LOADER_PHONE_STAT.ACCOUNT_ID
                  AND ACCOUNTS.ACCOUNT_ID = DB_LOADER_ACCOUNT_PHONES.ACCOUNT_ID
                  AND OPERATORS.OPERATOR_ID = ACCOUNTS.OPERATOR_ID
         ORDER BY --DB_LOADER_PHONE_STAT.YEAR_MONTH DESC;
                  DB_LOADER_ACCOUNT_PHONES.YEAR_MONTH DESC;

      --
      CURSOR ABONENT
      IS
           SELECT ABONENTS.SURNAME,
                  ABONENTS.NAME,
                  ABONENTS.PATRONYMIC,
                  V_CONTRACTS.PHONE_NUMBER_FEDERAL
             FROM ABONENTS, V_CONTRACTS
            WHERE     V_CONTRACTS.PHONE_NUMBER_FEDERAL = pPHONE_NUMBER
                  AND V_CONTRACTS.CONTRACT_CANCEL_DATE IS NULL
                  AND V_CONTRACTS.ABONENT_ID = ABONENTS.ABONENT_ID
         ORDER BY V_CONTRACTS.CONTRACT_DATE DESC;

      vREC       C%ROWTYPE;
      abREC      ABONENT%ROWTYPE;
      FIO        VARCHAR2 (2000);
      V_RESULT   VARCHAR2 (2000);
      Respond    VARCHAR2 (1000);                 -- ответ от  нового кабинета
   BEGIN
      OPEN C;

      FETCH C INTO vREC;

      CLOSE C;

      IF vREC.LOGIN IS NOT NULL
      THEN
         BEGIN
            IF pNew_site_method = 1
            THEN
               BEGIN                       --загрузка с нового кабинета Билайн
                  NULL;
                  Respond :=
                     loader_call_pckg_n.lock_phone (vREC.Account_Id,
                                                    pPHONE_NUMBER,
                                                    pLock_TYPE
                                                    );
                  V_RESULT := '';
               EXCEPTION
                  WHEN OTHERS
                  THEN
                     Respond := 'Error';
               END;
            END IF;

            IF Respond = 'Error' OR pNew_site_method = 0
            THEN
               V_RESULT :=
                  LOADER_CALL_PCKG.LOCK_PHONE (vREC.LOGIN,
                                               vREC.PASSWORD,
                                               vREC.LOADER_SCRIPT_NAME,
                                               vREC.LOADER_DB_CONNECTION,
                                               vREC.LOADER_DB_USER_NAME,
                                               vREC.LOADER_DB_PASSWORD,
                                               pPHONE_NUMBER);
            END IF;
         EXCEPTION
            WHEN OTHERS
            THEN
               V_RESULT := SQLERRM;
         END;

         IF V_RESULT IS NULL
         THEN
            OPEN ABONENT;

            FETCH ABONENT INTO abREC;

            CLOSE ABONENT;

            FIO :=
               abREC.SURNAME || ' ' || abREC.NAME || ' ' || abREC.PATRONYMIC;

            INSERT INTO AUTO_BLOCKED_PHONE (PHONE_NUMBER,
                                            BALLANCE,
                                            BLOCK_DATE_TIME,
                                            MANUAL_BLOCK,
                                            USER_NAME,
                                            ABONENT_FIO)
                 VALUES (pPHONE_NUMBER,
                         GET_ABONENT_BALANCE (pPHONE_NUMBER),
                         SYSDATE,
                         pMANUAL_BLOCK,
                         USER,
                         FIO);
         END IF;

         IF Respond <> 'Error' AND pNew_site_method = 1 AND pMANUAL_BLOCK = 1
         THEN
            RETURN Respond;
         ELSE
            RETURN V_RESULT;
         END IF;
      ELSE
         RETURN    pPHONE_NUMBER
                || ' не найден в базе данных.';
      END IF;
   END;

   --
   FUNCTION UNLOCK_PHONE (pPHONE_NUMBER      IN VARCHAR2,
                          pMANUAL_UNLOCK     IN INTEGER DEFAULT 1,
                          --
                          pNew_site_method   IN INTEGER DEFAULT 0)
      RETURN VARCHAR2
   IS
      --
      --Овсянников Л.В. 19.11.2012 Исправление выборки определения ACCOUNT_ID в курсоре C. Изменена таблица DB_LOADER_PHONE_STAT на DB_LOADER_ACCOUNT_PHONES
      --Назин П.В. 13.03.2013 Добавление параметра и ссылки на блокировку через новый кабинет

      CURSOR C
      IS
           SELECT ACCOUNTS.ACCOUNT_ID,
                  ACCOUNTS.LOGIN,
                  ACCOUNTS.PASSWORD,
                  OPERATORS.LOADER_SCRIPT_NAME,
                  LOADER_SETTINGS.LOADER_DB_CONNECTION,
                  LOADER_SETTINGS.LOADER_DB_USER_NAME,
                  LOADER_SETTINGS.LOADER_DB_PASSWORD
             FROM --DB_LOADER_PHONE_STAT,
                  DB_LOADER_ACCOUNT_PHONES,
                  ACCOUNTS,
                  OPERATORS,
                  LOADER_SETTINGS
            WHERE          --DB_LOADER_PHONE_STAT.PHONE_NUMBER = pPHONE_NUMBER
                 DB_LOADER_ACCOUNT_PHONES.PHONE_NUMBER = pPHONE_NUMBER
                  --AND ACCOUNTS.ACCOUNT_ID=DB_LOADER_PHONE_STAT.ACCOUNT_ID
                  AND ACCOUNTS.ACCOUNT_ID = DB_LOADER_ACCOUNT_PHONES.ACCOUNT_ID
                  AND OPERATORS.OPERATOR_ID = ACCOUNTS.OPERATOR_ID
         ORDER BY --DB_LOADER_PHONE_STAT.YEAR_MONTH DESC;
                  DB_LOADER_ACCOUNT_PHONES.YEAR_MONTH DESC;

      --
      CURSOR ABONENT
      IS
           SELECT ABONENTS.SURNAME,
                  ABONENTS.NAME,
                  ABONENTS.PATRONYMIC,
                  V_CONTRACTS.PHONE_NUMBER_FEDERAL
             FROM ABONENTS, V_CONTRACTS
            WHERE     V_CONTRACTS.PHONE_NUMBER_FEDERAL = pPHONE_NUMBER
                  AND V_CONTRACTS.CONTRACT_CANCEL_DATE IS NULL
                  AND V_CONTRACTS.ABONENT_ID = ABONENTS.ABONENT_ID
         ORDER BY V_CONTRACTS.CONTRACT_DATE DESC;

      vREC       C%ROWTYPE;
      abREC      ABONENT%ROWTYPE;
      FIO        VARCHAR2 (2000);
      V_RESULT   VARCHAR2 (2000);
      Respond    VARCHAR2 (1000);                 -- ответ от  нового кабинета
   BEGIN
      OPEN C;

      FETCH C INTO vREC;

      CLOSE C;

      IF vREC.LOGIN IS NOT NULL
      THEN
         BEGIN
            IF pNew_site_method = 1
            THEN
               BEGIN                       --загрузка с нового кабинета Билайн
                  NULL;
                  Respond :=
                     loader_call_pckg_n.unlock_phone (vREC.Account_Id,
                                                      pPHONE_NUMBER);
                  V_RESULT := '';
               EXCEPTION
                  WHEN OTHERS
                  THEN
                     Respond := 'Error';
               END;
            END IF;

            IF Respond = 'Error' OR pNew_site_method = 0
            THEN
               V_RESULT :=
                  LOADER_CALL_PCKG.UNLOCK_PHONE (vREC.LOGIN,
                                                 vREC.PASSWORD,
                                                 vREC.LOADER_SCRIPT_NAME,
                                                 vREC.LOADER_DB_CONNECTION,
                                                 vREC.LOADER_DB_USER_NAME,
                                                 vREC.LOADER_DB_PASSWORD,
                                                 pPHONE_NUMBER);
            END IF;
         EXCEPTION
            WHEN OTHERS
            THEN
               V_RESULT := SQLERRM;
         END;

         IF V_RESULT IS NULL
         THEN
            OPEN ABONENT;

            FETCH ABONENT INTO abREC;

            CLOSE ABONENT;

            FIO :=
               abREC.SURNAME || ' ' || abREC.NAME || ' ' || abREC.PATRONYMIC;

            INSERT INTO AUTO_UNBLOCKED_PHONE (PHONE_NUMBER,
                                              BALLANCE,
                                              UNBLOCK_DATE_TIME,
                                              MANUAL_BLOCK,
                                              USER_NAME,
                                              ABONENT_FIO)
                 VALUES (pPHONE_NUMBER,
                         GET_ABONENT_BALANCE (pPHONE_NUMBER),
                         SYSDATE,
                         pMANUAL_UNLOCK,
                         USER,
                         FIO);
         END IF;

         IF Respond <> 'Error' AND pNew_site_method = 1
         THEN
            RETURN Respond;
         ELSE
            RETURN V_RESULT;
         END IF;
      ELSE
         RETURN    pPHONE_NUMBER
                || ' не найден в базе данных.';
      END IF;
   END;

   --
   FUNCTION SEND_SMS_MULTI (pPHONE_NUMBERS   IN DBMS_SQL.VARCHAR2_TABLE,
                            pMAILING_NAME    IN VARCHAR2,
                            --    pSENDER_NAME IN VARCHAR2,
                            pSMS_TEXT        IN VARCHAR2)
      RETURN VARCHAR2
   IS
      --

      CURSOR C
      IS
         SELECT SMS_SEND_PARAMETRS.LOGIN,
                SMS_SEND_PARAMETRS.PASSWORD,
                SMS_SEND_PARAMETRS.SENDER_NAME,
                SMS_SEND_PARAMETRS.PROVIDER_NAME
           FROM SMS_SEND_PARAMETRS
          WHERE SMS_SEND_PARAMETRS.Status = (select 
                                                                           case
                                                                             when (pPHONE_NUMBERS(1) = '9057728987') or (pPHONE_NUMBERS(1) = '9057728557') then 0
                                                                             else 1
                                                                           end st
                                                                         from dual); --1;*/

      --
      vREC            C%ROWTYPE;
      vMAILING_NAME   VARCHAR2 (30 CHAR);

      CURSOR SI
      IS
         SELECT NVL (MAX (SMS_ID), 0) SMS_ID
           FROM LOG_SEND_SMS
          WHERE LOG_SEND_SMS.YEAR_MONTH =
                   TO_NUMBER (TO_CHAR (SYSDATE, 'YYYYMM'));

      DUMMY_SI        SI%ROWTYPE;
      RESUL           VARCHAR2 (300 CHAR);
      vYEAR_MONTH     INTEGER;
   BEGIN
      OPEN C;

      FETCH C INTO vREC;

      CLOSE C;

      vMAILING_NAME := pMAILING_NAME;

      OPEN SI;

      FETCH SI INTO DUMMY_SI;

      CLOSE SI;

      DUMMY_SI.SMS_ID := DUMMY_SI.SMS_ID + 1;
      vYEAR_MONTH := TO_NUMBER (TO_CHAR (SYSDATE, 'YYYYMM'));

      INSERT INTO LOG_SEND_SMS (SMS_ID, PHONE_NUMBER, SMS_TEXT)
           VALUES (DUMMY_SI.SMS_ID, pPHONE_NUMBERS (1), pSMS_TEXT);

      vMAILING_NAME := TO_CHAR (DUMMY_SI.SMS_ID);
      -- IF vREC.LOGIN IS NOT NULL THEN
      RESUL :=
         LOADER_CALL_PCKG.SEND_SMS_MULTI (vREC.LOGIN,
                                          vREC.PASSWORD,
                                          vREC.PROVIDER_NAME,
                                          pPHONE_NUMBERS,
                                          vMAILING_NAME,
                                          vREC.SENDER_NAME,
                                          pSMS_TEXT);

      UPDATE LOG_SEND_SMS
         SET NOTE = SUBSTR (RESUL, 1, 100)
       WHERE YEAR_MONTH = vYEAR_MONTH AND SMS_ID = DUMMY_SI.SMS_ID;

      COMMIT;
      RETURN RESUL;
   END;

   --
   FUNCTION SEND_SMS (pPHONE_NUMBER      IN VARCHAR2,
                      pMAILING_NAME      IN VARCHAR2,
                      --   pSENDER_NAME IN VARCHAR2,
                      pSMS_TEXT          IN VARCHAR2,
                      pUSE_REPEAT_SEND   IN INTEGER DEFAULT 0,
                      pSENDER_NAME       IN VARCHAR2 DEFAULT NULL
                      )
      RETURN VARCHAR2
   IS
      CURSOR C
      IS
         SELECT FORWARDING_PHONE_NUMBER.PHONE_NUMBER_RECIPIENT,
                FORWARDING_PHONE_NUMBER.SMS_TEXT_ADD
           FROM FORWARDING_PHONE_NUMBER
          WHERE FORWARDING_PHONE_NUMBER.PHONE_NUMBER = pPHONE_NUMBER;

      vPHONE_NUMBERS   DBMS_SQL.VARCHAR2_TABLE;
      ITOG             VARCHAR2 (200 CHAR);
      vREC             C%ROWTYPE;
      vSMS_TEXT        VARCHAR2 (500 CHAR);
   BEGIN
      IF MS_CONSTANTS.GET_CONSTANT_VALUE ('FORWARDING_SYSTEM_ENABLE') = '1'
      THEN
         OPEN C;

         FETCH C INTO vREC;

         IF C%FOUND
         THEN
            vPHONE_NUMBERS (1) := vREC.PHONE_NUMBER_RECIPIENT;
            vSMS_TEXT := vREC.SMS_TEXT_ADD || ' ' || pSMS_TEXT;
         ELSE
            vPHONE_NUMBERS (1) := pPHONE_NUMBER;
            vSMS_TEXT := pSMS_TEXT;
         END IF;

         CLOSE C;
      ELSE
         vPHONE_NUMBERS (1) := pPHONE_NUMBER;
         vSMS_TEXT := pSMS_TEXT;
      END IF;

      ITOG := SEND_SMS_MULTI (vPHONE_NUMBERS, pMAILING_NAME, --      pSENDER_NAME,
                                                             vSMS_TEXT);

      IF (pUSE_REPEAT_SEND = 1) AND (ITOG IS NOT NULL)
      THEN
         INSERT INTO SEND_SMS_QUERY (PHONE_NUMBER,
                                     SEND_NAME,
                                     TEXT,
                                     NOTE)
              VALUES (pPHONE_NUMBER,
                      pMAILING_NAME,
                      pSMS_TEXT,
                      'На повторной отправке');
      END IF;

      RETURN ITOG;
   END;
END;
/