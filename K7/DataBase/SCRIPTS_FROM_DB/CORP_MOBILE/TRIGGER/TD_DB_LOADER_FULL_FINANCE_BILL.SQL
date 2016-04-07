
  CREATE OR REPLACE TRIGGER "CORP_MOBILE"."TD_DB_LOADER_FULL_FINANCE_BILL" 
--
--#Version=2
--
BEFORE DELETE
ON DB_LOADER_FULL_FINANCE_BILL
REFERENCING NEW AS New OLD AS Old
FOR EACH ROW
BEGIN
  delete 
    from DB_LOADER_FULL_BILL_ABON_PER 
    where account_id = :OLD.account_id
      and year_month = :OLD.year_month
      and phone_number = :OLD.phone_number
      and nvl(ban, 0) = nvl(:OLD.ban, 0);                
  delete 
    from DB_LOADER_FULL_BILL_MG_ROUMING 
    where account_id = :OLD.account_id
      and year_month = :OLD.year_month
      and phone_number = :OLD.phone_number
      and nvl(ban, 0) = nvl(:OLD.ban, 0);     
  delete 
    from DB_LOADER_FULL_BILL_MN_ROUMING 
    where account_id = :OLD.account_id
      and year_month = :OLD.year_month
      and phone_number = :OLD.phone_number
      and nvl(ban, 0) = nvl(:OLD.ban, 0);
END TD_DB_LOADER_FULL_FINANCE_BILL; 
ALTER TRIGGER "CORP_MOBILE"."TD_DB_LOADER_FULL_FINANCE_BILL" ENABLE