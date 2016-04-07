
  CREATE OR REPLACE FORCE VIEW "LONTANA"."V_PHONE_NUMBER_FOR_UNBL_SAVE" ("ACCOUNT_ID", "PHONE_NUMBER", "BALANCE") AS 
  SELECT DB_LOADER_ACCOUNT_PHONES.ACCOUNT_ID,
         DB_LOADER_ACCOUNT_PHONES.PHONE_NUMBER,
         GET_ABONENT_BALANCE(DB_LOADER_ACCOUNT_PHONES.PHONE_NUMBER) BALANCE
    FROM DB_LOADER_ACCOUNT_PHONES,
         TARIFFS       
    WHERE DB_LOADER_ACCOUNT_PHONES.YEAR_MONTH=TO_NUMBER(TO_CHAR(SYSDATE,'YYYYMM'))
      AND DB_LOADER_ACCOUNT_PHONES.PHONE_IS_ACTIVE=0
      AND DB_LOADER_ACCOUNT_PHONES.CONSERVATION=1   
      AND tariffs.tariff_id(+)=get_phone_tariff_id(db_loader_account_phones.phone_number,
                                                   db_loader_account_phones.cell_plan_code,
                                                   db_loader_account_phones.last_check_date_time)
      AND GET_ABONENT_BALANCE(DB_LOADER_ACCOUNT_PHONES.PHONE_NUMBER)>=NVL(TARIFFS.BALANCE_UNBLOCK, 0) 