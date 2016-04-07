
  CREATE OR REPLACE PROCEDURE "SIM_TRADE"."BLOCK_PHONE_WITHOUT_CONTRACTS" 
IS
   -- Version = 6
--
--v.6 16.02.2015 Афросин - добавил блокировку по сохранению для номеров без контракта
--       
   CURSOR C
   IS
      SELECT * FROM BLOCK_NO_CONTRACTS_SETTINGS;

   LOCK_PH              VARCHAR2 (2000);
   vDUMMY               C%ROWTYPE;
   ACCESS_DENIED_LIST   CLOB;
BEGIN
   OPEN C;

   FETCH C INTO vDUMMY;

   CLOSE C;

   IF (vDUMMY.URL_ACCESS_LIST IS NOT NULL)
   THEN
      ACCESS_DENIED_LIST := GET_LIST_PHONE_NO_BL_FROM_SYTE;
   ELSE
      ACCESS_DENIED_LIST := NULL;
   END IF;

   IF    (vDUMMY.CHECK_TIME = 0)
      OR (   (TRUNC (SYSDATE) + vDUMMY.TIME_END / 24 > SYSDATE) --  До скольки утром работать
          OR (TRUNC (SYSDATE) + vDUMMY.TIME_BEGIN / 24 < SYSDATE))
   THEN                                         -- До скольки вечером работать
      FOR rec
         IN (SELECT V_ACTIVE_NUMBERS_OUT_CONTRACTS.PHONE_NUMBER,
                    ACCOUNTS.ACCOUNT_NUMBER
               FROM V_ACTIVE_NUMBERS_OUT_CONTRACTS, ACCOUNTS
              WHERE     V_ACTIVE_NUMBERS_OUT_CONTRACTS.ACCOUNT_ID =
                           ACCOUNTS.ACCOUNT_ID(+)
                    AND NVL (ACCOUNTS.DO_AUTO_BLOCK, 0) = 1
                    AND NOT EXISTS
                               (SELECT 1
                                  FROM AUTO_BLOCKED_PHONE_NO_CONTRACT
                                 WHERE     AUTO_BLOCKED_PHONE_NO_CONTRACT.PHONE_NUMBER =
                                              V_ACTIVE_NUMBERS_OUT_CONTRACTS.PHONE_NUMBER
                                       AND AUTO_BLOCKED_PHONE_NO_CONTRACT.BLOCK_DATE_TIME >
                                              SYSDATE - 7 / 24 / 60)
                    AND NOT EXISTS
                               (SELECT 1
                                  FROM PHONE_NUMBER_BLOCK_DENIED
                                 WHERE PHONE_NUMBER_BLOCK_DENIED.PHONE_NUMBER =
                                          V_ACTIVE_NUMBERS_OUT_CONTRACTS.PHONE_NUMBER)
                    AND NOT EXISTS
                               (SELECT 1
                                  FROM QUEUE_PHONE_REBLOCK
                                 WHERE QUEUE_PHONE_REBLOCK.PHONE_NUMBER =
                                          V_ACTIVE_NUMBERS_OUT_CONTRACTS.PHONE_NUMBER))
      LOOP
         IF DBMS_LOB.INSTR (NVL (ACCESS_DENIED_LIST, '000'),
                            rec.PHONE_NUMBER) = 0
         THEN
            LOCK_PH := LOADER3_pckg.LOCK_PHONE (rec.PHONE_NUMBER, 0, 1, 'S1B');

            IF LOCK_PH IS NOT NULL
            THEN
               INSERT INTO AUTO_BLOCKED_PHONE_NO_CONTRACT (PHONE_NUMBER,
                                                           ACCOUNT_NUMBER,
                                                           BLOCK_DATE_TIME,
                                                           MANUAL_BLOCK,
                                                           USER_NAME,
                                                           NOTE)
                    VALUES (rec.PHONE_NUMBER,
                            rec.ACCOUNT_NUMBER,
                            SYSDATE,
                            0,
                            USER,
                            SUBSTR ('Ошибка. ' || LOCK_PH, 300));
            ELSE
               INSERT INTO AUTO_BLOCKED_PHONE_NO_CONTRACT (PHONE_NUMBER,
                                                           ACCOUNT_NUMBER,
                                                           BLOCK_DATE_TIME,
                                                           MANUAL_BLOCK,
                                                           USER_NAME,
                                                           NOTE)
                    VALUES (rec.PHONE_NUMBER,
                            rec.ACCOUNT_NUMBER,
                            SYSDATE,
                            0,
                            USER,
                            NULL);
            END IF;

            COMMIT;

            IF (vDUMMY.URL_ACCESS_LIST IS NOT NULL)
            THEN
               ACCESS_DENIED_LIST := GET_LIST_PHONE_NO_BL_FROM_SYTE;
            ELSE
               ACCESS_DENIED_LIST := NULL;
            END IF;
         END IF;
      END LOOP;
   END IF;

   IF MS_CONSTANTS.GET_CONSTANT_VALUE ('SERVER_NAME') = 'SIM_TRADE'
   THEN
      IF    (vDUMMY.CHECK_TIME = 0)
         OR (   (TRUNC (SYSDATE) + vDUMMY.TIME_END / 24 > SYSDATE) --  ?? ??????? ????? ????????
             OR (TRUNC (SYSDATE) + vDUMMY.TIME_BEGIN / 24 < SYSDATE))
      THEN                                      -- ?? ??????? ??????? ????????
         FOR rec
            IN (SELECT V_ACTIVE_NUMBERS_OUT_CONTRACTS.PHONE_NUMBER,
                       ACCOUNTS.ACCOUNT_NUMBER
                  FROM V_ACTIVE_NUMBERS_OUT_CONTRACTS, ACCOUNTS
                 WHERE     V_ACTIVE_NUMBERS_OUT_CONTRACTS.ACCOUNT_ID =
                              ACCOUNTS.ACCOUNT_ID(+)
                       AND NVL (ACCOUNTS.DO_AUTO_BLOCK, 0) = 1
                       AND NOT EXISTS
                                  (SELECT 1
                                     FROM AUTO_BLOCKED_PHONE_NO_CONTRACT
                                    WHERE     AUTO_BLOCKED_PHONE_NO_CONTRACT.PHONE_NUMBER =
                                                 V_ACTIVE_NUMBERS_OUT_CONTRACTS.PHONE_NUMBER
                                          AND AUTO_BLOCKED_PHONE_NO_CONTRACT.BLOCK_DATE_TIME >
                                                 SYSDATE - 15 / 24 / 60)
                       AND EXISTS
                              (SELECT 1
                                 FROM PHONE_NUMBER_BLOCK_DENIED
                                WHERE PHONE_NUMBER_BLOCK_DENIED.PHONE_NUMBER =
                                         V_ACTIVE_NUMBERS_OUT_CONTRACTS.PHONE_NUMBER))
         LOOP
            IF DBMS_LOB.INSTR (NVL (ACCESS_DENIED_LIST, '000'),
                               rec.PHONE_NUMBER) = 0
            THEN
               IF GET_ABONENT_BALANCE (rec.PHONE_NUMBER) < 0
               THEN
                  LOCK_PH := LOADER3_pckg.LOCK_PHONE (rec.PHONE_NUMBER, 0, 1, 'S1B');

                  IF LOCK_PH IS NOT NULL
                  THEN
                     INSERT
                       INTO AUTO_BLOCKED_PHONE_NO_CONTRACT (PHONE_NUMBER,
                                                            ACCOUNT_NUMBER,
                                                            BLOCK_DATE_TIME,
                                                            MANUAL_BLOCK,
                                                            USER_NAME,
                                                            NOTE)
                     VALUES (rec.PHONE_NUMBER,
                             rec.ACCOUNT_NUMBER,
                             SYSDATE,
                             0,
                             USER,
                             SUBSTR ('Ошибка. ' || LOCK_PH, 300));
                  ELSE
                     INSERT
                       INTO AUTO_BLOCKED_PHONE_NO_CONTRACT (PHONE_NUMBER,
                                                            ACCOUNT_NUMBER,
                                                            BLOCK_DATE_TIME,
                                                            MANUAL_BLOCK,
                                                            USER_NAME,
                                                            NOTE)
                     VALUES (rec.PHONE_NUMBER,
                             rec.ACCOUNT_NUMBER,
                             SYSDATE,
                             0,
                             USER,
                             NULL);
                  END IF;

                  COMMIT;
               END IF;
            END IF;
         END LOOP;
      END IF;
   END IF;
END;