
  CREATE OR REPLACE FORCE VIEW "CORP_MOBILE"."V_PHONE_NUMBERS_FOR_NOTICE_BAL" ("PHONE_NUMBER_FEDERAL", "BALANCE", "FIO", "DISCONNECT_LIMIT", "IS_CREDIT_CONTRACT", "DEALER_KOD", "BALANCE_NOTICE_TEXT", "BALANCE_NOTICE", "ACCOUNT_ID") AS 
  SELECT V.PHONE_NUMBER_FEDERAL,
       V.BALANCE,
       V.SURNAME || ' ' || V.NAME || ' ' || V.PATRONYMIC FIO,
       V.DISCONNECT_LIMIT,
       V.IS_CREDIT_CONTRACT,
       V.DEALER_KOD,
       CASE
         WHEN MS_CONSTANTS.GET_CONSTANT_VALUE('SERVER_NAME')='CORP_MOBILE' THEN
           CASE
             WHEN (nvl(V.IS_CREDIT_CONTRACT, 0) = 1) and
                  (nvl(V.HAND_BLOCK,0) = 0) and
                  (V.BALANCE - NVL(V.DISCONNECT_LIMIT, 0) <=
                         nvl(ACCOUNTS.BALANCE_NOTICE_CREDIT2, 0)) and
                  (nvl(ACCOUNTS.BALANCE_NOTICE_CREDIT2, 0) <
                  nvl(ACCOUNTS.BALANCE_NOTICE_CREDIT, 0)) THEN
              nvl(ACCOUNTS.TEXT_NOTICE_BALANCE_CREDIT2,
                  ACCOUNTS.TEXT_NOTICE_BALANCE_CREDIT)
             WHEN (nvl(V.IS_CREDIT_CONTRACT, 0) = 1) and
                  (nvl(V.HAND_BLOCK,0) = 0) and
                  (V.BALANCE - NVL(V.DISCONNECT_LIMIT, 0) >
                         nvl(ACCOUNTS.BALANCE_NOTICE_CREDIT2, 0)) and
                  (nvl(ACCOUNTS.BALANCE_NOTICE_CREDIT2, 0) <
                  nvl(ACCOUNTS.BALANCE_NOTICE_CREDIT, 0)) THEN
              nvl(ACCOUNTS.TEXT_NOTICE_BALANCE_CREDIT,
                  ACCOUNTS.TEXT_NOTICE_BALANCE_CREDIT2)

             WHEN (nvl(V.IS_CREDIT_CONTRACT, 0) = 1) and
                  (nvl(V.HAND_BLOCK,0) = 0) and
                  (V.BALANCE - NVL(V.DISCONNECT_LIMIT, 0) <=
                         nvl(ACCOUNTS.BALANCE_NOTICE_CREDIT, 0)) and
                  (nvl(ACCOUNTS.BALANCE_NOTICE_CREDIT2, 0) >
                  nvl(ACCOUNTS.BALANCE_NOTICE_CREDIT, 0)) THEN
              nvl(ACCOUNTS.TEXT_NOTICE_BALANCE_CREDIT,
                  ACCOUNTS.TEXT_NOTICE_BALANCE_CREDIT2)
             WHEN (nvl(V.IS_CREDIT_CONTRACT, 0) = 1) and
                  (nvl(V.HAND_BLOCK,0) = 0) and
                  (V.BALANCE - NVL(V.DISCONNECT_LIMIT, 0) >
                         nvl(ACCOUNTS.BALANCE_NOTICE_CREDIT, 0)) and
                  (nvl(ACCOUNTS.BALANCE_NOTICE_CREDIT2, 0) >
                  nvl(ACCOUNTS.BALANCE_NOTICE_CREDIT, 0)) THEN
              nvl(ACCOUNTS.TEXT_NOTICE_BALANCE_CREDIT2,
                  ACCOUNTS.TEXT_NOTICE_BALANCE_CREDIT)

             ELSE
                   MESSAGE_TEXTS.TEXT_NOTIFY_SMS2
           END
         ELSE
           CASE
             WHEN (nvl(V.IS_CREDIT_CONTRACT, 0) = 1) and
                  (V.BALANCE - NVL(V.DISCONNECT_LIMIT, 0) <=
                         nvl(ACCOUNTS.BALANCE_NOTICE_CREDIT2, 0)) and
                  (nvl(ACCOUNTS.BALANCE_NOTICE_CREDIT2, 0) <
                  nvl(ACCOUNTS.BALANCE_NOTICE_CREDIT, 0)) THEN
              nvl(ACCOUNTS.TEXT_NOTICE_BALANCE_CREDIT2,
                  ACCOUNTS.TEXT_NOTICE_BALANCE_CREDIT)
             WHEN (nvl(V.IS_CREDIT_CONTRACT, 0) = 1) and
                  (V.BALANCE - NVL(V.DISCONNECT_LIMIT, 0) >
                         nvl(ACCOUNTS.BALANCE_NOTICE_CREDIT2, 0)) and
                  (nvl(ACCOUNTS.BALANCE_NOTICE_CREDIT2, 0) <
                  nvl(ACCOUNTS.BALANCE_NOTICE_CREDIT, 0)) THEN
              nvl(ACCOUNTS.TEXT_NOTICE_BALANCE_CREDIT,
                  ACCOUNTS.TEXT_NOTICE_BALANCE_CREDIT2)

             WHEN (nvl(V.IS_CREDIT_CONTRACT, 0) = 1) and
                  (V.BALANCE - NVL(V.DISCONNECT_LIMIT, 0) <=
                         nvl(ACCOUNTS.BALANCE_NOTICE_CREDIT, 0)) and
                  (nvl(ACCOUNTS.BALANCE_NOTICE_CREDIT2, 0) >
                  nvl(ACCOUNTS.BALANCE_NOTICE_CREDIT, 0)) THEN
              nvl(ACCOUNTS.TEXT_NOTICE_BALANCE_CREDIT,
                  ACCOUNTS.TEXT_NOTICE_BALANCE_CREDIT2)
             WHEN (nvl(V.IS_CREDIT_CONTRACT, 0) = 1) and
                  (V.BALANCE - NVL(V.DISCONNECT_LIMIT, 0) >
                         nvl(ACCOUNTS.BALANCE_NOTICE_CREDIT, 0)) and
                  (nvl(ACCOUNTS.BALANCE_NOTICE_CREDIT2, 0) >
                  nvl(ACCOUNTS.BALANCE_NOTICE_CREDIT, 0)) THEN
              nvl(ACCOUNTS.TEXT_NOTICE_BALANCE_CREDIT2,
                  ACCOUNTS.TEXT_NOTICE_BALANCE_CREDIT)

             WHEN (nvl(V.IS_CREDIT_CONTRACT, 0) <> 1) and
                  (V.BALANCE - NVL(V.DISCONNECT_LIMIT, 0) <=
                         nvl(ACCOUNTS.BALANCE_NOTICE2, 0)) and
                  (nvl(ACCOUNTS.BALANCE_NOTICE2, 0) <
                  nvl(ACCOUNTS.BALANCE_NOTICE, 0)) THEN
                    nvl(ACCOUNTS.BALANCE_NOTICE_TEXT2,
                        ACCOUNTS.BALANCE_NOTICE_TEXT)
             WHEN (nvl(V.IS_CREDIT_CONTRACT, 0) <> 1) and
                  (V.BALANCE - NVL(V.DISCONNECT_LIMIT, 0) >
                         nvl(ACCOUNTS.BALANCE_NOTICE2, 0)) and
                  (nvl(ACCOUNTS.BALANCE_NOTICE2, 0) <
                  nvl(ACCOUNTS.BALANCE_NOTICE, 0)) THEN
                    nvl(ACCOUNTS.BALANCE_NOTICE_TEXT,
                        ACCOUNTS.BALANCE_NOTICE_TEXT2)
              WHEN (nvl(V.IS_CREDIT_CONTRACT, 0) <> 1) and
                  (V.BALANCE - NVL(V.DISCONNECT_LIMIT, 0) <=
                         nvl(ACCOUNTS.BALANCE_NOTICE, 0)) and
                  (nvl(ACCOUNTS.BALANCE_NOTICE2, 0) >
                  nvl(ACCOUNTS.BALANCE_NOTICE, 0)) THEN
                    nvl(ACCOUNTS.BALANCE_NOTICE_TEXT,
                        ACCOUNTS.BALANCE_NOTICE_TEXT2)
             ELSE
               nvl(ACCOUNTS.BALANCE_NOTICE_TEXT2,
                   ACCOUNTS.BALANCE_NOTICE_TEXT)
           END
       END BALANCE_NOTICE_TEXT,
       CASE
         WHEN MS_CONSTANTS.GET_CONSTANT_VALUE('SERVER_NAME')='CORP_MOBILE' THEN
           CASE
             WHEN (nvl(V.IS_CREDIT_CONTRACT, 0) = 1) and
                  (nvl(V.HAND_BLOCK,0) = 0) and
                  (V.BALANCE - NVL(V.DISCONNECT_LIMIT, 0) <=
                         nvl(ACCOUNTS.BALANCE_NOTICE_CREDIT2, 0)) and
                  (nvl(ACCOUNTS.BALANCE_NOTICE_CREDIT2, 0) <
                  nvl(ACCOUNTS.BALANCE_NOTICE_CREDIT, 0)) THEN
              nvl(ACCOUNTS.BALANCE_NOTICE_CREDIT2,
                  ACCOUNTS.BALANCE_NOTICE_CREDIT)
             WHEN (nvl(V.IS_CREDIT_CONTRACT, 0) = 1) and
                  (nvl(V.HAND_BLOCK,0) = 0) and
                  (V.BALANCE - NVL(V.DISCONNECT_LIMIT, 0) >
                         nvl(ACCOUNTS.BALANCE_NOTICE_CREDIT2, 0)) and
                  (nvl(ACCOUNTS.BALANCE_NOTICE_CREDIT2, 0) <
                  nvl(ACCOUNTS.BALANCE_NOTICE_CREDIT, 0)) THEN
              nvl(ACCOUNTS.BALANCE_NOTICE_CREDIT,
                  ACCOUNTS.BALANCE_NOTICE_CREDIT2)

             WHEN (nvl(V.IS_CREDIT_CONTRACT, 0) = 1) and
                  (nvl(V.HAND_BLOCK,0) = 0) and
                  (V.BALANCE - NVL(V.DISCONNECT_LIMIT, 0) <=
                         nvl(ACCOUNTS.BALANCE_NOTICE_CREDIT, 0)) and
                  (nvl(ACCOUNTS.BALANCE_NOTICE_CREDIT2, 0) >
                  nvl(ACCOUNTS.BALANCE_NOTICE_CREDIT, 0)) THEN
              nvl(ACCOUNTS.BALANCE_NOTICE_CREDIT,
                  ACCOUNTS.BALANCE_NOTICE_CREDIT2)
             WHEN (nvl(V.IS_CREDIT_CONTRACT, 0) = 1) and
                  (nvl(V.HAND_BLOCK,0) = 0) and
                  (V.BALANCE - NVL(V.DISCONNECT_LIMIT, 0) >
                         nvl(ACCOUNTS.BALANCE_NOTICE_CREDIT, 0)) and
                  (nvl(ACCOUNTS.BALANCE_NOTICE_CREDIT2, 0) >
                  nvl(ACCOUNTS.BALANCE_NOTICE_CREDIT, 0)) THEN
              nvl(ACCOUNTS.BALANCE_NOTICE_CREDIT2,
                  ACCOUNTS.BALANCE_NOTICE_CREDIT)

             WHEN (nvl(V.IS_CREDIT_CONTRACT, 0) <> 1) and
                  (nvl(V.HAND_BLOCK,0) = 0) and
                  (V.BALANCE - NVL(V.DISCONNECT_LIMIT, 0) <=
                         nvl(ACCOUNTS.BALANCE_NOTICE2, 0)) and
                  (nvl(ACCOUNTS.BALANCE_NOTICE2, 0) <
                  nvl(ACCOUNTS.BALANCE_NOTICE, 0)) THEN
                      nvl(ACCOUNTS.BALANCE_NOTICE2,
                          ACCOUNTS.BALANCE_NOTICE)
             WHEN (nvl(V.IS_CREDIT_CONTRACT, 0) <> 1) and
                  (nvl(V.HAND_BLOCK,0) = 0) and
                  (V.BALANCE - NVL(V.DISCONNECT_LIMIT, 0) >
                         nvl(ACCOUNTS.BALANCE_NOTICE2, 0)) and
                  (nvl(ACCOUNTS.BALANCE_NOTICE2, 0) <
                  nvl(ACCOUNTS.BALANCE_NOTICE, 0)) THEN
                      nvl(ACCOUNTS.BALANCE_NOTICE,
                          ACCOUNTS.BALANCE_NOTICE2)
             WHEN (nvl(V.IS_CREDIT_CONTRACT, 0) <> 1) and
                  (nvl(V.HAND_BLOCK,0) = 0) and
                  (V.BALANCE - NVL(V.DISCONNECT_LIMIT, 0) <=
                         nvl(ACCOUNTS.BALANCE_NOTICE, 0)) and
                  (nvl(ACCOUNTS.BALANCE_NOTICE2, 0) >
                  nvl(ACCOUNTS.BALANCE_NOTICE, 0)) THEN
                      nvl(ACCOUNTS.BALANCE_NOTICE,
                          ACCOUNTS.BALANCE_NOTICE2)
             WHEN (nvl(V.HAND_BLOCK,0) = 1) and
                  (V.BALANCE - NVL(V.DISCONNECT_LIMIT, 0) <=
                   V.BALANCE_NOTICE_HAND_BLOCK) THEN
                   V.BALANCE_NOTICE_HAND_BLOCK
             ELSE
                   nvl(ACCOUNTS.BALANCE_NOTICE2,
                       ACCOUNTS.BALANCE_NOTICE)
           END
         ELSE
           CASE
             WHEN (nvl(V.IS_CREDIT_CONTRACT, 0) = 1) and
                  (V.BALANCE - NVL(V.DISCONNECT_LIMIT, 0) <=
                         nvl(ACCOUNTS.BALANCE_NOTICE_CREDIT2, 0)) and
                  (nvl(ACCOUNTS.BALANCE_NOTICE_CREDIT2, 0) <
                  nvl(ACCOUNTS.BALANCE_NOTICE_CREDIT, 0)) THEN
              nvl(ACCOUNTS.BALANCE_NOTICE_CREDIT2,
                  ACCOUNTS.BALANCE_NOTICE_CREDIT)
             WHEN (nvl(V.IS_CREDIT_CONTRACT, 0) = 1) and
                  (V.BALANCE - NVL(V.DISCONNECT_LIMIT, 0) >
                         nvl(ACCOUNTS.BALANCE_NOTICE_CREDIT2, 0)) and
                  (nvl(ACCOUNTS.BALANCE_NOTICE_CREDIT2, 0) <
                  nvl(ACCOUNTS.BALANCE_NOTICE_CREDIT, 0)) THEN
              nvl(ACCOUNTS.BALANCE_NOTICE_CREDIT,
                  ACCOUNTS.BALANCE_NOTICE_CREDIT2)

             WHEN (nvl(V.IS_CREDIT_CONTRACT, 0) = 1) and
                  (V.BALANCE - NVL(V.DISCONNECT_LIMIT, 0) <=
                         nvl(ACCOUNTS.BALANCE_NOTICE_CREDIT, 0)) and
                  (nvl(ACCOUNTS.BALANCE_NOTICE_CREDIT2, 0) >
                  nvl(ACCOUNTS.BALANCE_NOTICE_CREDIT, 0)) THEN
              nvl(ACCOUNTS.BALANCE_NOTICE_CREDIT,
                  ACCOUNTS.BALANCE_NOTICE_CREDIT2)
             WHEN (nvl(V.IS_CREDIT_CONTRACT, 0) = 1) and
                  (V.BALANCE - NVL(V.DISCONNECT_LIMIT, 0) >
                         nvl(ACCOUNTS.BALANCE_NOTICE_CREDIT, 0)) and
                  (nvl(ACCOUNTS.BALANCE_NOTICE_CREDIT2, 0) >
                  nvl(ACCOUNTS.BALANCE_NOTICE_CREDIT, 0)) THEN
              nvl(ACCOUNTS.BALANCE_NOTICE_CREDIT2,
                  ACCOUNTS.BALANCE_NOTICE_CREDIT)

             WHEN (nvl(V.IS_CREDIT_CONTRACT, 0) <> 1) and
                  (V.BALANCE - NVL(V.DISCONNECT_LIMIT, 0) <=
                         nvl(ACCOUNTS.BALANCE_NOTICE2, 0)) and
                  (nvl(ACCOUNTS.BALANCE_NOTICE2, 0) <
                  nvl(ACCOUNTS.BALANCE_NOTICE, 0)) THEN
                      nvl(ACCOUNTS.BALANCE_NOTICE2,
                          ACCOUNTS.BALANCE_NOTICE)
             WHEN (nvl(V.IS_CREDIT_CONTRACT, 0) <> 1) and
                  (V.BALANCE - NVL(V.DISCONNECT_LIMIT, 0) >
                         nvl(ACCOUNTS.BALANCE_NOTICE2, 0)) and
                  (nvl(ACCOUNTS.BALANCE_NOTICE2, 0) <
                  nvl(ACCOUNTS.BALANCE_NOTICE, 0)) THEN
                      nvl(ACCOUNTS.BALANCE_NOTICE,
                          ACCOUNTS.BALANCE_NOTICE2)
             WHEN (nvl(V.IS_CREDIT_CONTRACT, 0) <> 1) and
                  (V.BALANCE - NVL(V.DISCONNECT_LIMIT, 0) <=
                         nvl(ACCOUNTS.BALANCE_NOTICE, 0)) and
                  (nvl(ACCOUNTS.BALANCE_NOTICE2, 0) >
                  nvl(ACCOUNTS.BALANCE_NOTICE, 0)) THEN
                      nvl(ACCOUNTS.BALANCE_NOTICE,
                          ACCOUNTS.BALANCE_NOTICE2)
             ELSE
                   nvl(ACCOUNTS.BALANCE_NOTICE2,
                       ACCOUNTS.BALANCE_NOTICE)
           END
       END BALANCE_NOTICE,
       ACCOUNTS.ACCOUNT_ID
  FROM v_abonent_balances V, ACCOUNTS, TARIFFS, MESSAGE_TEXTS
 WHERE loader_script_name is not null
   AND V.ACCOUNT_ID = ACCOUNTS.ACCOUNT_ID(+)
   AND TARIFFS.TARIFF_ID(+) = V.TARIFF_ID
   and V.BALANCE - NVL(V.DISCONNECT_LIMIT, 0) <
       NVL(CASE
             WHEN nvl(V.IS_CREDIT_CONTRACT, 0) = 1 THEN
               CASE
                 WHEN (nvl(V.HAND_BLOCK,0) = 1) AND
                      (MS_CONSTANTS.GET_CONSTANT_VALUE('SERVER_NAME')='CORP_MOBILE') THEN
                 nvl(V.BALANCE_NOTICE_HAND_BLOCK, TARIFFS.BALANCE_NOTICE_CREDIT)
               ELSE
                TARIFFS.BALANCE_NOTICE_CREDIT
               END
             ELSE
               CASE
                 WHEN (nvl(V.HAND_BLOCK,0) = 1) AND
                      (MS_CONSTANTS.GET_CONSTANT_VALUE('SERVER_NAME')='CORP_MOBILE') THEN
                 nvl(V.BALANCE_NOTICE_HAND_BLOCK, TARIFFS.BALANCE_NOTICE)
               ELSE
                TARIFFS.BALANCE_NOTICE
               END
           END,
           NVL(CASE
                 WHEN nvl(V.IS_CREDIT_CONTRACT, 0) = 1 THEN
                  greatest(nvl(ACCOUNTS.BALANCE_NOTICE_CREDIT, 0),
                           nvl(ACCOUNTS.BALANCE_NOTICE_CREDIT2, 0))
                 ELSE
                  greatest(nvl(ACCOUNTS.BALANCE_NOTICE, 0),
                           nvl(ACCOUNTS.BALANCE_NOTICE2, 0))
               END,
               0))
   AND (V.BALANCE - NVL(V.DISCONNECT_LIMIT, 0)) >=
       NVL(CASE
             WHEN nvl(V.IS_CREDIT_CONTRACT, 0) = 1 THEN
               CASE
                 WHEN (nvl(V.HAND_BLOCK,0) = 1) AND
                    (MS_CONSTANTS.GET_CONSTANT_VALUE('SERVER_NAME')='CORP_MOBILE') THEN
                 nvl(V.BALANCE_BLOCK_HAND_BLOCK, TARIFFS.BALANCE_BLOCK_CREDIT)
               ELSE
                TARIFFS.BALANCE_BLOCK_CREDIT
               END
             ELSE
               CASE
                 WHEN (nvl(V.HAND_BLOCK,0) = 1) AND
                      (MS_CONSTANTS.GET_CONSTANT_VALUE('SERVER_NAME')='CORP_MOBILE') THEN
                 nvl(V.BALANCE_BLOCK_HAND_BLOCK, TARIFFS.BALANCE_BLOCK)
               ELSE
                TARIFFS.BALANCE_BLOCK
               END
           END,
           NVL(CASE
                 WHEN nvl(V.IS_CREDIT_CONTRACT, 0) = 1 THEN
                  ACCOUNTS.BALANCE_BLOCK_CREDIT
                 ELSE
                  ACCOUNTS.BALANCE_BLOCK
               END,
               0))
   and V.phone_is_active_code = 1
