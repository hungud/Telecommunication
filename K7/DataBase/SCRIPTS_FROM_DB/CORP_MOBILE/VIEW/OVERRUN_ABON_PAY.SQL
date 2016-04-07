
  CREATE OR REPLACE FORCE VIEW "CORP_MOBILE"."OVERRUN_ABON_PAY" ("ACCOUNT_NUMBER", "PHONE_NUMBER", "CALLS_COST", "SMS_COST", "MMS_COST", "INTERNET_COST", "YEAR_MONTH", "ACCOUNT_ID", "IS_COLLECTOR") AS 
  select 
      ac.account_number,
      ds.phone_number,
      ds.CALLS_COST,
      ds.SMS_COST,
      ds.MMS_COST,
      ds.INTERNET_COST,
      ds.year_month,
      ds.account_id,
      ac.is_collector
        
  from 
 
 DB_LOADER_PHONE_STAT ds, accounts ac 
 
 where 
  ds.Account_ID = ac.account_id
 
 
 and  ( (CALLS_COST <> 0)
         OR (SMS_COST <> 0)
         OR (MMS_COST <> 0)
         OR (INTERNET_COST <> 0)
    )