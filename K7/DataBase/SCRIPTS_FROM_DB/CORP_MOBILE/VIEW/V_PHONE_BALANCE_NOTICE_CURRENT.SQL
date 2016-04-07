
  CREATE OR REPLACE FORCE VIEW "CORP_MOBILE"."V_PHONE_BALANCE_NOTICE_CURRENT" ("PHONE_NUMBER_FEDERAL", "BALANCE", "FIO", "DISCONNECT_LIMIT", "IS_CREDIT_CONTRACT", "DEALER_KOD", "PARAMDISABLE_SMS", "BALANCE_NOTICE_TEXT", "BALANCE_NOTICE", "ACCOUNT_ID") AS 
  SELECT V.PHONE_NUMBER_FEDERAL,
          T.BALANCE,
          ab.SURNAME || ' ' || ab.NAME || ' ' || ab.PATRONYMIC FIO,
          V.DISCONNECT_LIMIT,
          V.IS_CREDIT_CONTRACT,
          V.DEALER_KOD,
          V.PARAMDISABLE_SMS,
          CASE
             WHEN MS_CONSTANTS.GET_CONSTANT_VALUE ('SERVER_NAME') =
                     'CORP_MOBILE'
             THEN
                CASE
                   WHEN (NVL (V.HAND_BLOCK, 0) = 0)
                   THEN
                      CASE
                         WHEN (NVL (V.IS_CREDIT_CONTRACT, 0) = 1)
                         THEN
                            CASE
                               WHEN (T.balance - NVL (V.DISCONNECT_LIMIT, 0) <=
                                        NVL (ACCOUNTS.BALANCE_NOTICE_CREDIT2,
                                             0))
                                    AND (NVL (
                                            ACCOUNTS.BALANCE_NOTICE_CREDIT2,
                                            0) <
                                            NVL (
                                               ACCOUNTS.BALANCE_NOTICE_CREDIT,
                                               0))
                               THEN
                                  NVL (ACCOUNTS.TEXT_NOTICE_BALANCE_CREDIT2,
                                       ACCOUNTS.TEXT_NOTICE_BALANCE_CREDIT)
                               WHEN (T.balance - NVL (V.DISCONNECT_LIMIT, 0) >
                                        NVL (ACCOUNTS.BALANCE_NOTICE_CREDIT2,
                                             0))
                                    AND (NVL (
                                            ACCOUNTS.BALANCE_NOTICE_CREDIT2,
                                            0) <
                                            NVL (
                                               ACCOUNTS.BALANCE_NOTICE_CREDIT,
                                               0))
                               THEN
                                  NVL (ACCOUNTS.TEXT_NOTICE_BALANCE_CREDIT,
                                       ACCOUNTS.TEXT_NOTICE_BALANCE_CREDIT2)
                               WHEN (T.balance - NVL (V.DISCONNECT_LIMIT, 0) <=
                                        NVL (ACCOUNTS.BALANCE_NOTICE_CREDIT,
                                             0))
                                    AND (NVL (
                                            ACCOUNTS.BALANCE_NOTICE_CREDIT2,
                                            0) >
                                            NVL (
                                               ACCOUNTS.BALANCE_NOTICE_CREDIT,
                                               0))
                               THEN
                                  NVL (ACCOUNTS.TEXT_NOTICE_BALANCE_CREDIT,
                                       ACCOUNTS.TEXT_NOTICE_BALANCE_CREDIT2)
                               WHEN (T.balance - NVL (V.DISCONNECT_LIMIT, 0) >
                                        NVL (ACCOUNTS.BALANCE_NOTICE_CREDIT,
                                             0))
                                    AND (NVL (
                                            ACCOUNTS.BALANCE_NOTICE_CREDIT2,
                                            0) >
                                            NVL (
                                               ACCOUNTS.BALANCE_NOTICE_CREDIT,
                                               0))
                               THEN
                                  NVL (ACCOUNTS.TEXT_NOTICE_BALANCE_CREDIT2,
                                       ACCOUNTS.TEXT_NOTICE_BALANCE_CREDIT)
                               ELSE
                                  MESSAGE_TEXTS.TEXT_NOTIFY_SMS2
                            END
                         ELSE
                            CASE
                               WHEN (ACCOUNTS.SMS_SETT_ACCOUNTS = 1)
                               THEN
                                  CASE
                                     WHEN (T.balance
                                           - NVL (V.DISCONNECT_LIMIT, 0) <=
                                              NVL (ACCOUNTS.BALANCE_NOTICE2,
                                                   0))
                                          AND (NVL (ACCOUNTS.BALANCE_NOTICE2,
                                                    0) <
                                                  NVL (
                                                     ACCOUNTS.BALANCE_NOTICE,
                                                     0))
                                     THEN
                                        NVL (ACCOUNTS.BALANCE_NOTICE_TEXT2,
                                             ACCOUNTS.BALANCE_NOTICE_TEXT)
                                     WHEN (T.balance
                                           - NVL (V.DISCONNECT_LIMIT, 0) >
                                              NVL (ACCOUNTS.BALANCE_NOTICE2,
                                                   0))
                                          AND (NVL (ACCOUNTS.BALANCE_NOTICE2,
                                                    0) <
                                                  NVL (
                                                     ACCOUNTS.BALANCE_NOTICE,
                                                     0))
                                     THEN
                                        NVL (ACCOUNTS.BALANCE_NOTICE_TEXT,
                                             ACCOUNTS.BALANCE_NOTICE_TEXT2)
                                     WHEN (T.balance
                                           - NVL (V.DISCONNECT_LIMIT, 0) <=
                                              NVL (ACCOUNTS.BALANCE_NOTICE,
                                                   0))
                                          AND (NVL (ACCOUNTS.BALANCE_NOTICE2,
                                                    0) >
                                                  NVL (
                                                     ACCOUNTS.BALANCE_NOTICE,
                                                     0))
                                     THEN
                                        NVL (ACCOUNTS.BALANCE_NOTICE_TEXT,
                                             ACCOUNTS.BALANCE_NOTICE_TEXT2)
                                     ELSE
                                        NVL (ACCOUNTS.BALANCE_NOTICE_TEXT2,
                                             ACCOUNTS.BALANCE_NOTICE_TEXT)
                                  END
                               ELSE
                                  MESSAGE_TEXTS.TEXT_NOTIFY_SMS2
                            END
                      END
                   ELSE
                     CASE
                       WHEN (ACCOUNTS.SMS_SETT_ACCOUNTS = 1)
                       THEN
                         CASE
                           WHEN ACCOUNTS.ACCOUNT_ID = 99  
                           THEN
                             MESSAGE_TEXTS.TEXT_NOTIFY_SMS_HAND_BLOCK_PIT  
                           ELSE
                             MESSAGE_TEXTS.TEXT_NOTIFY_SMS_HAND_BLOCK  
                         END
                       ELSE
                         MESSAGE_TEXTS.TEXT_NOTIFY_SMS2 
                     END
                END
             ELSE
                CASE
                   WHEN (NVL (V.IS_CREDIT_CONTRACT, 0) = 1)
                        AND (T.balance - NVL (V.DISCONNECT_LIMIT, 0) <=
                                NVL (ACCOUNTS.BALANCE_NOTICE_CREDIT2, 0))
                        AND (NVL (ACCOUNTS.BALANCE_NOTICE_CREDIT2, 0) <
                                NVL (ACCOUNTS.BALANCE_NOTICE_CREDIT, 0))
                   THEN
                      NVL (ACCOUNTS.TEXT_NOTICE_BALANCE_CREDIT2,
                           ACCOUNTS.TEXT_NOTICE_BALANCE_CREDIT)
                   WHEN (NVL (V.IS_CREDIT_CONTRACT, 0) = 1)
                        AND (T.balance - NVL (V.DISCONNECT_LIMIT, 0) >
                                NVL (ACCOUNTS.BALANCE_NOTICE_CREDIT2, 0))
                        AND (NVL (ACCOUNTS.BALANCE_NOTICE_CREDIT2, 0) <
                                NVL (ACCOUNTS.BALANCE_NOTICE_CREDIT, 0))
                   THEN
                      NVL (ACCOUNTS.TEXT_NOTICE_BALANCE_CREDIT,
                           ACCOUNTS.TEXT_NOTICE_BALANCE_CREDIT2)
                   WHEN (NVL (V.IS_CREDIT_CONTRACT, 0) = 1)
                        AND (T.balance - NVL (V.DISCONNECT_LIMIT, 0) <=
                                NVL (ACCOUNTS.BALANCE_NOTICE_CREDIT, 0))
                        AND (NVL (ACCOUNTS.BALANCE_NOTICE_CREDIT2, 0) >
                                NVL (ACCOUNTS.BALANCE_NOTICE_CREDIT, 0))
                   THEN
                      NVL (ACCOUNTS.TEXT_NOTICE_BALANCE_CREDIT,
                           ACCOUNTS.TEXT_NOTICE_BALANCE_CREDIT2)
                   WHEN (NVL (V.IS_CREDIT_CONTRACT, 0) = 1)
                        AND (T.balance - NVL (V.DISCONNECT_LIMIT, 0) >
                                NVL (ACCOUNTS.BALANCE_NOTICE_CREDIT, 0))
                        AND (NVL (ACCOUNTS.BALANCE_NOTICE_CREDIT2, 0) >
                                NVL (ACCOUNTS.BALANCE_NOTICE_CREDIT, 0))
                   THEN
                      NVL (ACCOUNTS.TEXT_NOTICE_BALANCE_CREDIT2,
                           ACCOUNTS.TEXT_NOTICE_BALANCE_CREDIT)
                   WHEN (NVL (V.IS_CREDIT_CONTRACT, 0) <> 1)
                        AND (T.balance - NVL (V.DISCONNECT_LIMIT, 0) <=
                                NVL (ACCOUNTS.BALANCE_NOTICE2, 0))
                        AND (NVL (ACCOUNTS.BALANCE_NOTICE2, 0) <
                                NVL (ACCOUNTS.BALANCE_NOTICE, 0))
                   THEN
                      NVL (ACCOUNTS.BALANCE_NOTICE_TEXT2,
                           ACCOUNTS.BALANCE_NOTICE_TEXT)
                   WHEN (NVL (V.IS_CREDIT_CONTRACT, 0) <> 1)
                        AND (T.balance - NVL (V.DISCONNECT_LIMIT, 0) >
                                NVL (ACCOUNTS.BALANCE_NOTICE2, 0))
                        AND (NVL (ACCOUNTS.BALANCE_NOTICE2, 0) <
                                NVL (ACCOUNTS.BALANCE_NOTICE, 0))
                   THEN
                      NVL (ACCOUNTS.BALANCE_NOTICE_TEXT,
                           ACCOUNTS.BALANCE_NOTICE_TEXT2)
                   WHEN (NVL (V.IS_CREDIT_CONTRACT, 0) <> 1)
                        AND (T.balance - NVL (V.DISCONNECT_LIMIT, 0) <=
                                NVL (ACCOUNTS.BALANCE_NOTICE, 0))
                        AND (NVL (ACCOUNTS.BALANCE_NOTICE2, 0) >
                                NVL (ACCOUNTS.BALANCE_NOTICE, 0))
                   THEN
                      NVL (ACCOUNTS.BALANCE_NOTICE_TEXT,
                           ACCOUNTS.BALANCE_NOTICE_TEXT2)
                   ELSE
                      NVL (ACCOUNTS.BALANCE_NOTICE_TEXT2,
                           ACCOUNTS.BALANCE_NOTICE_TEXT)
                END
          END
             BALANCE_NOTICE_TEXT,
          CASE
             WHEN MS_CONSTANTS.GET_CONSTANT_VALUE ('SERVER_NAME') =
                     'CORP_MOBILE'
             THEN
                CASE
                   WHEN (NVL (V.IS_CREDIT_CONTRACT, 0) = 1)
                        AND (NVL (V.HAND_BLOCK, 0) = 0)
                        AND (T.balance - NVL (V.DISCONNECT_LIMIT, 0) <=
                                NVL (ACCOUNTS.BALANCE_NOTICE_CREDIT2, 0))
                        AND (NVL (ACCOUNTS.BALANCE_NOTICE_CREDIT2, 0) <
                                NVL (ACCOUNTS.BALANCE_NOTICE_CREDIT, 0))
                   THEN
                      NVL (ACCOUNTS.BALANCE_NOTICE_CREDIT2,
                           ACCOUNTS.BALANCE_NOTICE_CREDIT)
                   WHEN (NVL (V.IS_CREDIT_CONTRACT, 0) = 1)
                        AND (NVL (V.HAND_BLOCK, 0) = 0)
                        AND (T.balance - NVL (V.DISCONNECT_LIMIT, 0) >
                                NVL (ACCOUNTS.BALANCE_NOTICE_CREDIT2, 0))
                        AND (NVL (ACCOUNTS.BALANCE_NOTICE_CREDIT2, 0) <
                                NVL (ACCOUNTS.BALANCE_NOTICE_CREDIT, 0))
                   THEN
                      NVL (ACCOUNTS.BALANCE_NOTICE_CREDIT,
                           ACCOUNTS.BALANCE_NOTICE_CREDIT2)
                   WHEN (NVL (V.IS_CREDIT_CONTRACT, 0) = 1)
                        AND (NVL (V.HAND_BLOCK, 0) = 0)
                        AND (T.balance - NVL (V.DISCONNECT_LIMIT, 0) <=
                                NVL (ACCOUNTS.BALANCE_NOTICE_CREDIT, 0))
                        AND (NVL (ACCOUNTS.BALANCE_NOTICE_CREDIT2, 0) >
                                NVL (ACCOUNTS.BALANCE_NOTICE_CREDIT, 0))
                   THEN
                      NVL (ACCOUNTS.BALANCE_NOTICE_CREDIT,
                           ACCOUNTS.BALANCE_NOTICE_CREDIT2)
                   WHEN (NVL (V.IS_CREDIT_CONTRACT, 0) = 1)
                        AND (NVL (V.HAND_BLOCK, 0) = 0)
                        AND (T.balance - NVL (V.DISCONNECT_LIMIT, 0) >
                                NVL (ACCOUNTS.BALANCE_NOTICE_CREDIT, 0))
                        AND (NVL (ACCOUNTS.BALANCE_NOTICE_CREDIT2, 0) >
                                NVL (ACCOUNTS.BALANCE_NOTICE_CREDIT, 0))
                   THEN
                      NVL (ACCOUNTS.BALANCE_NOTICE_CREDIT2,
                           ACCOUNTS.BALANCE_NOTICE_CREDIT)
                   WHEN (NVL (V.IS_CREDIT_CONTRACT, 0) <> 1)
                        AND (NVL (V.HAND_BLOCK, 0) = 0)
                        AND (T.balance - NVL (V.DISCONNECT_LIMIT, 0) <=
                                NVL (ACCOUNTS.BALANCE_NOTICE2, 0))
                        AND (NVL (ACCOUNTS.BALANCE_NOTICE2, 0) <
                                NVL (ACCOUNTS.BALANCE_NOTICE, 0))
                   THEN
                      NVL (ACCOUNTS.BALANCE_NOTICE2, ACCOUNTS.BALANCE_NOTICE)
                   WHEN (NVL (V.IS_CREDIT_CONTRACT, 0) <> 1)
                        AND (NVL (V.HAND_BLOCK, 0) = 0)
                        AND (T.balance - NVL (V.DISCONNECT_LIMIT, 0) >
                                NVL (ACCOUNTS.BALANCE_NOTICE2, 0))
                        AND (NVL (ACCOUNTS.BALANCE_NOTICE2, 0) <
                                NVL (ACCOUNTS.BALANCE_NOTICE, 0))
                   THEN
                      NVL (ACCOUNTS.BALANCE_NOTICE, ACCOUNTS.BALANCE_NOTICE2)
                   WHEN (NVL (V.IS_CREDIT_CONTRACT, 0) <> 1)
                        AND (NVL (V.HAND_BLOCK, 0) = 0)
                        AND (T.balance - NVL (V.DISCONNECT_LIMIT, 0) <=
                                NVL (ACCOUNTS.BALANCE_NOTICE, 0))
                        AND (NVL (ACCOUNTS.BALANCE_NOTICE2, 0) >
                                NVL (ACCOUNTS.BALANCE_NOTICE, 0))
                   THEN
                      NVL (ACCOUNTS.BALANCE_NOTICE, ACCOUNTS.BALANCE_NOTICE2)
                   WHEN (NVL (V.HAND_BLOCK, 0) = 1)
                        AND (T.balance - NVL (V.DISCONNECT_LIMIT, 0) <=
                                V.BALANCE_NOTICE_HAND_BLOCK)
                   THEN
                      V.BALANCE_NOTICE_HAND_BLOCK
                   ELSE
                      NVL (ACCOUNTS.BALANCE_NOTICE2, ACCOUNTS.BALANCE_NOTICE)
                END
             ELSE
                CASE
                   WHEN (NVL (V.IS_CREDIT_CONTRACT, 0) = 1)
                        AND (T.balance - NVL (V.DISCONNECT_LIMIT, 0) <=
                                NVL (ACCOUNTS.BALANCE_NOTICE_CREDIT2, 0))
                        AND (NVL (ACCOUNTS.BALANCE_NOTICE_CREDIT2, 0) <
                                NVL (ACCOUNTS.BALANCE_NOTICE_CREDIT, 0))
                   THEN
                      NVL (ACCOUNTS.BALANCE_NOTICE_CREDIT2,
                           ACCOUNTS.BALANCE_NOTICE_CREDIT)
                   WHEN (NVL (V.IS_CREDIT_CONTRACT, 0) = 1)
                        AND (T.balance - NVL (V.DISCONNECT_LIMIT, 0) >
                                NVL (ACCOUNTS.BALANCE_NOTICE_CREDIT2, 0))
                        AND (NVL (ACCOUNTS.BALANCE_NOTICE_CREDIT2, 0) <
                                NVL (ACCOUNTS.BALANCE_NOTICE_CREDIT, 0))
                   THEN
                      NVL (ACCOUNTS.BALANCE_NOTICE_CREDIT,
                           ACCOUNTS.BALANCE_NOTICE_CREDIT2)
                   WHEN (NVL (V.IS_CREDIT_CONTRACT, 0) = 1)
                        AND (T.balance - NVL (V.DISCONNECT_LIMIT, 0) <=
                                NVL (ACCOUNTS.BALANCE_NOTICE_CREDIT, 0))
                        AND (NVL (ACCOUNTS.BALANCE_NOTICE_CREDIT2, 0) >
                                NVL (ACCOUNTS.BALANCE_NOTICE_CREDIT, 0))
                   THEN
                      NVL (ACCOUNTS.BALANCE_NOTICE_CREDIT,
                           ACCOUNTS.BALANCE_NOTICE_CREDIT2)
                   WHEN (NVL (V.IS_CREDIT_CONTRACT, 0) = 1)
                        AND (T.balance - NVL (V.DISCONNECT_LIMIT, 0) >
                                NVL (ACCOUNTS.BALANCE_NOTICE_CREDIT, 0))
                        AND (NVL (ACCOUNTS.BALANCE_NOTICE_CREDIT2, 0) >
                                NVL (ACCOUNTS.BALANCE_NOTICE_CREDIT, 0))
                   THEN
                      NVL (ACCOUNTS.BALANCE_NOTICE_CREDIT2,
                           ACCOUNTS.BALANCE_NOTICE_CREDIT)
                   WHEN (NVL (V.IS_CREDIT_CONTRACT, 0) <> 1)
                        AND (T.balance - NVL (V.DISCONNECT_LIMIT, 0) <=
                                NVL (ACCOUNTS.BALANCE_NOTICE2, 0))
                        AND (NVL (ACCOUNTS.BALANCE_NOTICE2, 0) <
                                NVL (ACCOUNTS.BALANCE_NOTICE, 0))
                   THEN
                      NVL (ACCOUNTS.BALANCE_NOTICE2, ACCOUNTS.BALANCE_NOTICE)
                   WHEN (NVL (V.IS_CREDIT_CONTRACT, 0) <> 1)
                        AND (T.balance - NVL (V.DISCONNECT_LIMIT, 0) >
                                NVL (ACCOUNTS.BALANCE_NOTICE2, 0))
                        AND (NVL (ACCOUNTS.BALANCE_NOTICE2, 0) <
                                NVL (ACCOUNTS.BALANCE_NOTICE, 0))
                   THEN
                      NVL (ACCOUNTS.BALANCE_NOTICE, ACCOUNTS.BALANCE_NOTICE2)
                   WHEN (NVL (V.IS_CREDIT_CONTRACT, 0) <> 1)
                        AND (T.balance - NVL (V.DISCONNECT_LIMIT, 0) <=
                                NVL (ACCOUNTS.BALANCE_NOTICE, 0))
                        AND (NVL (ACCOUNTS.BALANCE_NOTICE2, 0) >
                                NVL (ACCOUNTS.BALANCE_NOTICE, 0))
                   THEN
                      NVL (ACCOUNTS.BALANCE_NOTICE, ACCOUNTS.BALANCE_NOTICE2)
                   ELSE
                      NVL (ACCOUNTS.BALANCE_NOTICE2, ACCOUNTS.BALANCE_NOTICE)
                END
          END
             BALANCE_NOTICE,
          ACCOUNTS.ACCOUNT_ID
     FROM iot_current_balance t,
          accounts,
          contracts v,
          tariffs,
          abonents ab,
          message_texts
    --

    WHERE EXISTS
             (SELECT *
                FROM db_loader_account_phones ph
               WHERE     ph.phone_is_active = 1
                     AND ph.phone_number = t.phone_number
                     AND ph.year_month = TO_CHAR (SYSDATE, 'YYYYMM'))
          --and t.balance<0
          AND accounts.account_id = get_account_id_by_phone (t.phone_number)
          AND v.phone_number_federal = t.phone_number
          AND NOT EXISTS
                 (SELECT 1
                    FROM contract_cancels cc
                   WHERE cc.contract_id = v.contract_id)
          --
          AND TARIFFS.TARIFF_ID(+) = V.TARIFF_ID
          AND t.BALANCE - NVL (V.DISCONNECT_LIMIT, 0) <
                 NVL (
                    CASE
                       WHEN NVL (V.IS_CREDIT_CONTRACT, 0) = 1
                       THEN
                          CASE
                             WHEN (NVL (V.HAND_BLOCK, 0) = 1)
                                  AND (MS_CONSTANTS.
                                        GET_CONSTANT_VALUE ('SERVER_NAME') =
                                          'CORP_MOBILE')
                             THEN
                                NVL (V.BALANCE_NOTICE_HAND_BLOCK,
                                     TARIFFS.BALANCE_NOTICE_CREDIT)
                             ELSE
                                TARIFFS.BALANCE_NOTICE_CREDIT
                          END
                       ELSE
                          CASE
                             WHEN (NVL (V.HAND_BLOCK, 0) = 1)
                                  AND (MS_CONSTANTS.
                                        GET_CONSTANT_VALUE ('SERVER_NAME') =
                                          'CORP_MOBILE')
                             THEN
                                NVL (V.BALANCE_NOTICE_HAND_BLOCK,
                                     TARIFFS.BALANCE_NOTICE)
                             ELSE
                                TARIFFS.BALANCE_NOTICE
                          END
                    END,
                    NVL (
                       CASE
                          WHEN NVL (V.IS_CREDIT_CONTRACT, 0) = 1
                          THEN
                             GREATEST (
                                NVL (ACCOUNTS.BALANCE_NOTICE_CREDIT, 0),
                                NVL (ACCOUNTS.BALANCE_NOTICE_CREDIT2, 0))
                          ELSE
                             GREATEST (NVL (ACCOUNTS.BALANCE_NOTICE, 0),
                                       NVL (ACCOUNTS.BALANCE_NOTICE2, 0))
                       END,
                       0))
          AND (t.BALANCE - NVL (V.DISCONNECT_LIMIT, 0)) >=
                 NVL (
                    CASE
                       WHEN NVL (V.IS_CREDIT_CONTRACT, 0) = 1
                       THEN
                          CASE
                             WHEN (NVL (V.HAND_BLOCK, 0) = 1)
                                  AND (MS_CONSTANTS.
                                        GET_CONSTANT_VALUE ('SERVER_NAME') =
                                          'CORP_MOBILE')
                             THEN
                                NVL (V.BALANCE_BLOCK_HAND_BLOCK,
                                     TARIFFS.BALANCE_BLOCK_CREDIT)
                             ELSE
                                TARIFFS.BALANCE_BLOCK_CREDIT
                          END
                       ELSE
                          CASE
                             WHEN (NVL (V.HAND_BLOCK, 0) = 1)
                                  AND (MS_CONSTANTS.
                                        GET_CONSTANT_VALUE ('SERVER_NAME') =
                                          'CORP_MOBILE')
                             THEN
                                NVL (V.BALANCE_BLOCK_HAND_BLOCK,
                                     TARIFFS.BALANCE_BLOCK)
                             ELSE
                                TARIFFS.BALANCE_BLOCK
                          END
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
          AND ab.abonent_id = v.abonent_id