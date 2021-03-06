
  CREATE OR REPLACE FORCE VIEW "CORP_MOBILE"."V_COUNT_CLIENT_BY_YEAR_MONTH" ("YEAR_MONTH", "ACCOUNT_ID", "ACCOUNT_NUMBER", "COUNT_CLIENT") AS 
  SELECT T1.YEAR_MONTH, 
         T1.ACCOUNT_ID, 
         ACCOUNTS.ACCOUNT_NUMBER, 
         T1.COUNT_CLIENT
    FROM ACCOUNTS,
    (SELECT YEAR_MONTH, 
            ACCOUNT_ID, 
            COUNT (*) COUNT_CLIENT
       FROM (SELECT *
               FROM DB_LOADER_PHONE_STAT
               WHERE (   DB_LOADER_PHONE_STAT.ZEROCOST_OUTCOME_COUNT <> 0
                     OR DB_LOADER_PHONE_STAT.ZEROCOST_OUTCOME_MINUTES <> 0
                     OR DB_LOADER_PHONE_STAT.CALLS_COUNT <> 0
                     OR DB_LOADER_PHONE_STAT.CALLS_MINUTES <> 0
                     OR DB_LOADER_PHONE_STAT.CALLS_COST <> 0
                     OR DB_LOADER_PHONE_STAT.SMS_COUNT <> 0
                     OR DB_LOADER_PHONE_STAT.SMS_COST <> 0
                     OR DB_LOADER_PHONE_STAT.MMS_COUNT <> 0
                     OR DB_LOADER_PHONE_STAT.MMS_COST <> 0
                     OR DB_LOADER_PHONE_STAT.INTERNET_MB <> 0
                     OR DB_LOADER_PHONE_STAT.INTERNET_COST <> 0
                    ))
   GROUP BY YEAR_MONTH, ACCOUNT_ID) T1
   WHERE T1.ACCOUNT_ID=ACCOUNTS.ACCOUNT_ID(+)
   ORDER BY T1.YEAR_MONTH, T1.ACCOUNT_ID aSC 