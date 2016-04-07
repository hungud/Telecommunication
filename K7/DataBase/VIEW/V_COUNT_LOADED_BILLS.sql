CREATE OR REPLACE FORCE VIEW V_COUNT_LOADED_BILLS AS
--
--#VERSION=4
--
  SELECT T."ACCOUNT_ID",
         T."YEAR_MONTH",
         T."COU1" as "COUNT_DETAIL_NONZERO_BILL",
         T."COU2" as "COUNT_NONZERO_BILL_FROM_ACC",
         T."COU3" as "COUNT_DETAIL_BILL",
         T."COU4" as "COUNT_BILL_FROM_ACC",
         T."COU_ZERO" AS "COUNT_PHONES_ON_END_MONTH",
         T.COU2 - T.COU1 AS "DIF_BETWEEN_NONZERO_BILLS",
         T.COU4 - T.COU3 AS "DIF_BETWEEN_BILLS",
         (SELECT COUNT (*)
            FROM db_loader_bills V
            WHERE V.ACCOUNT_ID = t.ACCOUNT_ID
              AND V.YEAR_MONTH = t.YEAR_MONTH
              AND V.PHONE_NUMBER NOT IN ('0000000000', '0886980555','0881113623','0884222349','0886978201')
              and v.BILL_SUM > 0
              AND EXISTS (SELECT 1
                            FROM db_loader_account_phones BS
                            WHERE BS.ACCOUNT_ID = V.ACCOUNT_ID
                              AND BS.YEAR_MONTH = T.NOW_YEAR_MONTH
                              AND BS.PHONE_NUMBER = V.PHONE_NUMBER)
              AND NOT EXISTS (SELECT 1
                                FROM DB_LOADER_FULL_FINANCE_BILL fb
                                WHERE fb.ACCOUNT_ID = V.ACCOUNT_ID
                                  AND fb.YEAR_MONTH = v.YEAR_MONTH
                                  AND fb.PHONE_NUMBER = V.PHONE_NUMBER
                                  and fb.COMPLETE_BILL = 1
                                  AND NVL(FB.BAN, 0) <> -1 )
         ) QUERY_LOAD,
         (SELECT LOGIN
            FROM ACCOUNTS
            WHERE ACCOUNTS.ACCOUNT_ID = T.ACCOUNT_ID) LOGIN
    FROM (SELECT FB.ACCOUNT_ID,
                 FB.YEAR_MONTH,
                 (SELECT COUNT (*)
                    FROM DB_LOADER_FULL_FINANCE_BILL FB2
                    WHERE FB2.ACCOUNT_ID = FB.ACCOUNT_ID
                      AND FB2.BILL_SUM <> 0
                      AND FB2.YEAR_MONTH = FB.YEAR_MONTH
                      AND FB2.COMPLETE_BILL = 1) COU1,
                 (SELECT COUNT (*)
                    FROM DB_LOADER_BILLS FB3
                    WHERE FB3.ACCOUNT_ID = FB.ACCOUNT_ID
                      AND FB3.BILL_SUM <> 0
                      AND FB3.PHONE_NUMBER <> '0000000000'
                      AND FB3.YEAR_MONTH = FB.YEAR_MONTH) COU2,
                 (SELECT COUNT (*)
                    FROM DB_LOADER_FULL_FINANCE_BILL FB2
                    WHERE FB2.ACCOUNT_ID = FB.ACCOUNT_ID
                      AND FB2.YEAR_MONTH = FB.YEAR_MONTH
                      AND FB2.COMPLETE_BILL = 1) COU3,
                 (SELECT COUNT (*)
                    FROM DB_LOADER_BILLS FB3
                    WHERE FB3.ACCOUNT_ID = FB.ACCOUNT_ID
                      AND FB3.PHONE_NUMBER <> '0000000000'
                      AND FB3.YEAR_MONTH = FB.YEAR_MONTH) COU4,
                 (SELECT COUNT (*)
                    FROM DB_LOADER_ACCOUNT_PHONES FB_ZERO
                    WHERE FB_ZERO.ACCOUNT_ID = FB.ACCOUNT_ID
                      AND FB_ZERO.PHONE_NUMBER <> '0000000000'
                      AND FB_ZERO.YEAR_MONTH = FB.YEAR_MONTH) COU_ZERO,
                 (SELECT MAX(AC.YEAR_MONTH) 
                    FROM DB_LOADER_ACCOUNT_PHONES AC 
                    WHERE AC.ACCOUNT_ID = FB.ACCOUNT_ID ) NOW_YEAR_MONTH
            FROM DB_LOADER_FULL_FINANCE_BILL FB
            WHERE FB.COMPLETE_BILL = 1
            GROUP BY ACCOUNT_ID, YEAR_MONTH) T
    ORDER BY T.ACCOUNT_ID;
