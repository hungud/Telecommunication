
  CREATE OR REPLACE FORCE VIEW "CORP_MOBILE"."V_PHONE_NUMBERS_FOR_BLOCK_MON" ("DEALER_KOD", "BALANCE_UNBLOCK", "PHONE_NUMBER_FEDERAL", "BALANCE", "FIO", "DISCONNECT_LIMIT", "IS_CREDIT_CONTRACT", "BLOCK_NOTICE_TEXT", "BALANCE_BLOCK", "ACCOUNT_ID", "IS_COLLECTOR", "BLOCK_BALANCE") AS 
  SELECT V.DEALER_KOD,
          TARIFFS.BALANCE_UNBLOCK,
          V.PHONE_NUMBER_FEDERAL,
          ICB.BALANCE,
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
          CASE
             WHEN V.IS_CREDIT_CONTRACT = 1 THEN ACCOUNTS.BALANCE_BLOCK_CREDIT
             ELSE ACCOUNTS.BALANCE_BLOCK
          END
             BALANCE_BLOCK,
          ACCOUNTS.ACCOUNT_ID,
          ACCOUNTS.IS_COLLECTOR,
            CASE
               WHEN     (NVL (V.HAND_BLOCK, 0) = 1)
                    AND (MS_CONSTANTS.GET_CONSTANT_VALUE ('SERVER_NAME') =
                            'CORP_MOBILE')
               THEN
                  V.BALANCE_BLOCK_HAND_BLOCK
               ELSE
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
            END
          + NVL (V.DISCONNECT_LIMIT, 0)
             block_balance
     FROM v_abonent_balances_2 V,
          ACCOUNTS,
          TARIFFS,
          IOT_CURRENT_BALANCE ICB
    WHERE     loader_script_name IS NOT NULL
          AND V.ACCOUNT_ID = ACCOUNTS.ACCOUNT_ID(+)
          AND TARIFFS.TARIFF_ID(+) = V.TARIFF_ID
          AND V.PHONE_NUMBER_FEDERAL = ICB.PHONE_NUMBER(+)
          AND (ICB.BALANCE - NVL (V.DISCONNECT_LIMIT, 0) <
                  CASE
                     WHEN     (NVL (V.HAND_BLOCK, 0) = 1)
                          AND (MS_CONSTANTS.GET_CONSTANT_VALUE (
                                  'SERVER_NAME') = 'CORP_MOBILE')
                     THEN
                        V.BALANCE_BLOCK_HAND_BLOCK
                     ELSE
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
                  END)
          AND V.phone_is_active_code = 1
          --    and V.HAND_BLOCK=0
          AND EXISTS
                 (SELECT 1
                    FROM DB_LOADER_ACCOUNT_PHONES
                   WHERE     V.PHONE_NUMBER_FEDERAL =
                                DB_LOADER_ACCOUNT_PHONES.PHONE_NUMBER
                         AND DB_LOADER_ACCOUNT_PHONES.YEAR_MONTH >=
                                TO_NUMBER (TO_CHAR (SYSDATE - 5, 'yyyymm'))
                         AND DB_LOADER_ACCOUNT_PHONES.LAST_CHECK_DATE_TIME >
                                SYSDATE - 5)
          AND NOT EXISTS
                     (SELECT 1
                        FROM AUTO_BLOCKED_PHONE
                       WHERE     V.PHONE_NUMBER_FEDERAL =
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