
  CREATE OR REPLACE TRIGGER "SIM_TRADE"."TD_DB_LOADER_FULL_FINANCE_BILL" 
--
--#Version=1
--
BEFORE DELETE
ON DB_LOADER_FULL_FINANCE_BILL
REFERENCING NEW AS New OLD AS Old
FOR EACH ROW
BEGIN
    delete from DB_LOADER_FULL_BILL_ABON_PER 
        where 
              account_id = :OLD.account_id
              and year_month = :OLD.year_month
              and phone_number = :OLD.phone_number;
              
    delete from DB_LOADER_FULL_BILL_MG_ROUMING 
        where 
              account_id = :OLD.account_id
              and year_month = :OLD.year_month
              and phone_number = :OLD.phone_number;
   
   delete from DB_LOADER_FULL_BILL_MN_ROUMING 
        where 
              account_id = :OLD.account_id
              and year_month = :OLD.year_month
              and phone_number = :OLD.phone_number;
END TD_DB_LOADER_FULL_FINANCE_BILL; 

ALTER TRIGGER "SIM_TRADE"."TD_DB_LOADER_FULL_FINANCE_BILL" ENABLE