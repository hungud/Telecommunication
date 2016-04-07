create or replace view overrun_abon_pay
--
--Version= 1
--  
--v1 Афросин  27.11.2014 - Выбирает номера у которых ест ьплаты свыше абонентской платы
--
as
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
