
  CREATE OR REPLACE FORCE VIEW "LONTANA"."V_PHONE_NUMBERS_FOR_BLOCK" ("PHONE_NUMBER_FEDERAL", "BALANCE", "FIO", "DISCONNECT_LIMIT", "IS_CREDIT_CONTRACT", "BLOCK_NOTICE_TEXT", "ACCOUNT_ID", "BALANCE_BLOCK") AS 
  SELECT V.PHONE_NUMBER_FEDERAL,
          GET_ABONENT_BALANCE (V.PHONE_NUMBER_FEDERAL) BALANCE,
          V.SURNAME || ' ' || V.NAME || ' ' || V.PATRONYMIC FIO,
          V.DISCONNECT_LIMIT,
          V.IS_CREDIT_CONTRACT,
          CASE
             WHEN V.IS_CREDIT_CONTRACT = 1
             THEN
                ACCOUNTS.TEXT_NOTICE_BLOCK_CREDIT
             ELSE
                ACCOUNTS.BLOCK_NOTICE_TEXT
          END
             BLOCK_NOTICE_TEXT,
          /*CASE
             WHEN V.IS_CREDIT_CONTRACT = 1 THEN ACCOUNTS.BALANCE_BLOCK_CREDIT
             ELSE ACCOUNTS.BALANCE_BLOCK
          END
             BALANCE_BLOCK,*/
          ACCOUNTS.ACCOUNT_ID,
          NVL (
             CASE
                WHEN NVL (V.IS_CREDIT_CONTRACT, 0) = 1
                THEN
                   TARIFFS.BALANCE_BLOCK_CREDIT
                ELSE
                   TARIFFS.BALANCE_BLOCK
             END,
             NVL (
                CASE
                   WHEN NVL (V.IS_CREDIT_CONTRACT, 0) = 1
                   THEN
                      ACCOUNTS.BALANCE_BLOCK_CREDIT
                   ELSE
                      ACCOUNTS.BALANCE_BLOCK
                END,
                0))
          + NVL (V.DISCONNECT_LIMIT, 0)
             BALANCE_BLOCK
     FROM v_abonent_balances_2 V, ACCOUNTS, TARIFFS
    WHERE     loader_script_name IS NOT NULL
          AND V.ACCOUNT_ID = ACCOUNTS.ACCOUNT_ID(+)
          AND TARIFFS.TARIFF_ID(+) = V.TARIFF_ID
          AND (GET_ABONENT_BALANCE (V.PHONE_NUMBER_FEDERAL)
               - NVL (V.DISCONNECT_LIMIT, 0) <
                  NVL (
                     CASE
                        WHEN NVL (V.IS_CREDIT_CONTRACT, 0) = 1
                        THEN
                           TARIFFS.BALANCE_BLOCK_CREDIT
                        ELSE
                           TARIFFS.BALANCE_BLOCK
                     END,
                     NVL (
                        CASE
                           WHEN NVL (V.IS_CREDIT_CONTRACT, 0) = 1
                           THEN
                              ACCOUNTS.BALANCE_BLOCK_CREDIT
                           ELSE
                              ACCOUNTS.BALANCE_BLOCK
                        END,
                        0)))
          AND V.phone_is_active_code = 1
          AND V.HAND_BLOCK = 0
          AND EXISTS
                 (SELECT 1
                    FROM DB_LOADER_ACCOUNT_PHONES
                   WHERE V.PHONE_NUMBER_FEDERAL =
                            DB_LOADER_ACCOUNT_PHONES.PHONE_NUMBER
                         AND DB_LOADER_ACCOUNT_PHONES.LAST_CHECK_DATE_TIME >
                                SYSDATE - 5)
          AND NOT EXISTS
                     (SELECT 1
                        FROM AUTO_BLOCKED_PHONE
                       WHERE V.PHONE_NUMBER_FEDERAL =
                                AUTO_BLOCKED_PHONE.PHONE_NUMBER
                             -- Не более 1 часа паузы
                             AND (AUTO_BLOCKED_PHONE.BLOCK_DATE_TIME >
                                     SYSDATE - 1 / 24)
                             AND AUTO_BLOCKED_PHONE.Note IS NULL)
          AND NOT EXISTS
                     (SELECT 1
                        FROM LOYAL_PHONE_FOR_BLOCK
                       WHERE V.PHONE_NUMBER_FEDERAL =
                                LOYAL_PHONE_FOR_BLOCK.PHONE_NUMBER)