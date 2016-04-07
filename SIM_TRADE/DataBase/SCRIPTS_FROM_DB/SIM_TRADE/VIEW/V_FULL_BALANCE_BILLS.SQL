
  CREATE OR REPLACE FORCE VIEW "SIM_TRADE"."V_FULL_BALANCE_BILLS" ("PHONE_NUMBER", "BILL_DATE", "BILL_SUM", "REMARK", "BILL_CHECKED") AS 
  SELECT V_BILL_FINANCE_FOR_CLIENTS.PHONE_NUMBER,
          LAST_DAY (
             TO_DATE (V_BILL_FINANCE_FOR_CLIENTS.YEAR_MONTH || '01',
                      'YYYYMMDD'))
             AS BILL_DATE,
          CASE
             WHEN (TO_NUMBER (TO_CHAR (SYSDATE, 'DD')) <= 14)
                  AND (TO_CHAR (V_BILL_FINANCE_FOR_CLIENTS.YEAR_MONTH) =
                          TO_CHAR (SYSDATE - 16, 'YYYYMM'))
                  AND (CHECK_PHONE_CREDIT (
                          V_BILL_FINANCE_FOR_CLIENTS.PHONE_NUMBER,
                          LAST_DAY (
                             TO_DATE (
                                V_BILL_FINANCE_FOR_CLIENTS.YEAR_MONTH || '01',
                                'YYYYMMDD'))) = 1)
             THEN
                  V_BILL_FINANCE_FOR_CLIENTS.BILL_SUM_NEW
                - V_BILL_FINANCE_FOR_CLIENTS.ABON_TP_NEW
                - V_BILL_FINANCE_FOR_CLIENTS.ABON_ADD_NEW
                - V_BILL_FINANCE_FOR_CLIENTS.DISCOUNT_NEW
             ELSE
                V_BILL_FINANCE_FOR_CLIENTS.BILL_SUM_NEW
          END
             AS BILL_SUM,
          CASE
             WHEN (TO_NUMBER (TO_CHAR (SYSDATE, 'DD')) <= 14)
                  AND (TO_CHAR (V_BILL_FINANCE_FOR_CLIENTS.YEAR_MONTH) =
                          TO_CHAR (SYSDATE - 16, 'YYYYMM'))
                  AND (CHECK_PHONE_CREDIT (
                          V_BILL_FINANCE_FOR_CLIENTS.PHONE_NUMBER,
                          LAST_DAY (
                             TO_DATE (
                                V_BILL_FINANCE_FOR_CLIENTS.YEAR_MONTH || '01',
                                'YYYYMMDD'))) = 1)
             THEN
                'Счёт оператора без аб. пл. с '
                || TO_CHAR (
                      TO_DATE (V_BILL_FINANCE_FOR_CLIENTS.YEAR_MONTH || '01',
                               'YYYYMMDD'),
                      'DD.MM.YYYY')
                || ' по '
                || TO_CHAR (
                      LAST_DAY (
                         TO_DATE (
                            V_BILL_FINANCE_FOR_CLIENTS.YEAR_MONTH || '01',
                            'YYYYMMDD')),
                      'DD.MM.YYYY')
             ELSE
                'Счёт оператора с '
                || TO_CHAR (
                      TO_DATE (V_BILL_FINANCE_FOR_CLIENTS.YEAR_MONTH || '01',
                               'YYYYMMDD'),
                      'DD.MM.YYYY')
                || ' по '
                || TO_CHAR (
                      LAST_DAY (
                         TO_DATE (
                            V_BILL_FINANCE_FOR_CLIENTS.YEAR_MONTH || '01',
                            'YYYYMMDD')),
                      'DD.MM.YYYY')
          END
             AS REMARK,
          V_BILL_FINANCE_FOR_CLIENTS.COMPLETE_BILL AS BILL_CHECKED
     FROM V_BILL_FINANCE_FOR_CLIENTS
   UNION ALL
   SELECT V_BILL_FOR_CLIENT.PHONE_NUMBER,
          V_BILL_FOR_CLIENT.DATE_END AS BILL_DATE,
          CASE
             WHEN (TO_NUMBER (TO_CHAR (SYSDATE, 'DD')) <= 14)
                  AND (TO_CHAR (V_BILL_FOR_CLIENT.YEAR_MONTH) =
                          TO_CHAR (SYSDATE - 16, 'YYYYMM'))
                  AND (CHECK_PHONE_CREDIT (V_BILL_FOR_CLIENT.PHONE_NUMBER,
                                           V_BILL_FOR_CLIENT.DATE_END) = 1)
             THEN
                  V_BILL_FOR_CLIENT.BILL_SUM
                - V_BILL_FOR_CLIENT.SUBSCRIBER_PAYMENT_NEW
                - V_BILL_FOR_CLIENT.SUBSCRIBER_PAYMENT_ADD_OLD
                - V_BILL_FOR_CLIENT.SUBSCRIBER_PAYMENT_ADD_VOZVRAT
             ELSE
                V_BILL_FOR_CLIENT.BILL_SUM
          END
             AS BILL_SUM,
          CASE
             WHEN (TO_NUMBER (TO_CHAR (SYSDATE, 'DD')) <= 14)
                  AND (TO_CHAR (V_BILL_FOR_CLIENT.YEAR_MONTH) =
                          TO_CHAR (SYSDATE - 16, 'YYYYMM'))
                  AND (CHECK_PHONE_CREDIT (V_BILL_FOR_CLIENT.PHONE_NUMBER,
                                           V_BILL_FOR_CLIENT.DATE_END) = 1)
             THEN
                   'Счёт оператора без аб. пл. с '
                || TO_CHAR (V_BILL_FOR_CLIENT.DATE_BEGIN, 'DD.MM.YYYY')
                || ' по '
                || TO_CHAR (V_BILL_FOR_CLIENT.DATE_END, 'DD.MM.YYYY')
             ELSE
                   'Счёт оператора с '
                || TO_CHAR (V_BILL_FOR_CLIENT.DATE_BEGIN, 'DD.MM.YYYY')
                || ' по '
                || TO_CHAR (V_BILL_FOR_CLIENT.DATE_END, 'DD.MM.YYYY')
          END
             AS REMARK,
          NVL (V_BILL_FOR_CLIENT.BILL_CHECKED, 0) AS BILL_CHECKED
     FROM V_BILL_FOR_CLIENT, V_BILL_FINANCE_FOR_CLIENTS
    WHERE V_BILL_FOR_CLIENT.ACCOUNT_ID =
             V_BILL_FINANCE_FOR_CLIENTS.ACCOUNT_ID(+)
          AND V_BILL_FOR_CLIENT.YEAR_MONTH =
                 V_BILL_FINANCE_FOR_CLIENTS.YEAR_MONTH(+)
          AND V_BILL_FOR_CLIENT.PHONE_NUMBER =
                 V_BILL_FINANCE_FOR_CLIENTS.PHONE_NUMBER(+)
          AND V_BILL_FINANCE_FOR_CLIENTS.PHONE_NUMBER IS NULL    
          AND V_BILL_FOR_CLIENT.YEAR_MONTH <= 201312
   UNION ALL
   SELECT DB_LOADER_PHONE_STAT.PHONE_NUMBER,
          CASE
             WHEN LAST_DAY (
                     TO_DATE (
                        TO_CHAR (DB_LOADER_PHONE_STAT.YEAR_MONTH || '01'),
                        'YYYYMMDD')) >
                     DB_LOADER_PHONE_STAT.LAST_CHECK_DATE_TIME
             THEN
                TRUNC (DB_LOADER_PHONE_STAT.LAST_CHECK_DATE_TIME)
             ELSE
                LAST_DAY (
                   TO_DATE (
                      TO_CHAR (DB_LOADER_PHONE_STAT.YEAR_MONTH || '01'),
                      'YYYYMMDD'))
          END
             AS BILL_DATE,
          RECALC_CHARGE_COST (DB_LOADER_PHONE_STAT.PHONE_NUMBER,
                              DB_LOADER_PHONE_STAT.ESTIMATE_SUM)
             AS BILL_SUM,
          'Детализация звонков за '
          || LOWER (
                TO_CHAR (TO_DATE (DB_LOADER_PHONE_STAT.YEAR_MONTH, 'YYYYMM'),
                         'MM.YYYY'))
          || ' (на '
          || TO_CHAR (DB_LOADER_PHONE_STAT.LAST_CHECK_DATE_TIME,
                      'DD.MM.YYYY HH24:MI')
          || ')',
          1 AS BILL_CHECKED
     FROM DB_LOADER_PHONE_STAT
    WHERE NOT EXISTS
                 (SELECT 1
                    FROM DB_LOADER_BILLS
                   WHERE DB_LOADER_BILLS.ACCOUNT_ID =
                            DB_LOADER_PHONE_STAT.ACCOUNT_ID
                         AND DB_LOADER_BILLS.PHONE_NUMBER =
                                DB_LOADER_PHONE_STAT.PHONE_NUMBER
                         AND DB_LOADER_BILLS.YEAR_MONTH <=201312
                         AND DB_LOADER_BILLS.YEAR_MONTH =
                                DB_LOADER_PHONE_STAT.YEAR_MONTH -- AND nvl(DB_LOADER_BILLS.BILL_CHECKED, 0) = 1
                                                               )
          AND NOT EXISTS
                     (SELECT 1
                        FROM V_BILL_FINANCE_FOR_CLIENTS
                       WHERE V_BILL_FINANCE_FOR_CLIENTS.BILL_SUM_OLD > 0
                             AND V_BILL_FINANCE_FOR_CLIENTS.PHONE_NUMBER =
                                    DB_LOADER_PHONE_STAT.PHONE_NUMBER
                             AND V_BILL_FINANCE_FOR_CLIENTS.YEAR_MONTH =
                                    DB_LOADER_PHONE_STAT.YEAR_MONTH) 