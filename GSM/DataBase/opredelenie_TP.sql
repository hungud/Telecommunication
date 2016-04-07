/*begin
  update TMPDB_LOADER_BILLS b
    set new_tar_code = (select r.TARIFF_CODE 
                          from DB_LOADER_ACCOUNT_TARIFFS r 
                          where r.ACCOUNT_ID = b.ACCOUNT_ID
                            and r.TARIFF_NAME = b.TARIFF_CODE)
    where 1 = (select count(*) 
                from DB_LOADER_ACCOUNT_TARIFFS r 
                where r.ACCOUNT_ID = b.ACCOUNT_ID
                  and r.TARIFF_NAME = b.TARIFF_CODE)
      and new_tar_code is null;    
  --               
  update TMPDB_LOADER_BILLS b
    set new_tar_code = (select r.TARIFF_CODE 
                          from DB_LOADER_ACCOUNT_TARIFFS r 
                          where r.ACCOUNT_ID = b.ACCOUNT_ID
                            and r.TARIFF_NAME = b.TARIFF_CODE
                            and (b.PHONE_NUMBER, r.TARIFF_CODE) in (select h.PHONE_NUMBER, h.CELL_PLAN_CODE 
                                                                      from db_loader_account_phone_hists h
                                                                      where h.END_DATE >= to_date('20140101', 'yyyymmdd') 
                                                                        and h.BEGIN_DATE <= to_date('20140201', 'yyyymmdd') - 1/24/60 ) )
    where 1 < (select count(*) 
                from DB_LOADER_ACCOUNT_TARIFFS r 
                where r.ACCOUNT_ID = b.ACCOUNT_ID
                  and r.TARIFF_NAME = b.TARIFF_CODE
                  )      
      and 1 = (select count(*)
                from DB_LOADER_ACCOUNT_TARIFFS r 
                where r.ACCOUNT_ID = b.ACCOUNT_ID
                  and r.TARIFF_NAME = b.TARIFF_CODE
                  and (b.PHONE_NUMBER, r.TARIFF_CODE) in (select h.PHONE_NUMBER, h.CELL_PLAN_CODE 
                                                            from db_loader_account_phone_hists h
                                                            where h.END_DATE >= to_date('20140101', 'yyyymmdd') 
                                                              and h.BEGIN_DATE <= to_date('20140201', 'yyyymmdd') - 1/24/60 ) )   
      and new_tar_code is null;       
  --  
  update TMPDB_LOADER_FULL_BILL_AB_PER b
    set new_tar_code = (select r.TARIFF_CODE 
                          from DB_LOADER_ACCOUNT_TARIFFS r 
                          where r.ACCOUNT_ID = b.ACCOUNT_ID
                            and r.TARIFF_NAME = b.TARIFF_CODE)
    where 1 = (select count(*) 
                from DB_LOADER_ACCOUNT_TARIFFS r 
                where r.ACCOUNT_ID = b.ACCOUNT_ID
                  and r.TARIFF_NAME = b.TARIFF_CODE)
      and new_tar_code is null
      and b.TARIFF_CODE<> 'Не указан';    
  --               
  update TMPDB_LOADER_FULL_BILL_AB_PER b
    set new_tar_code = (select r.TARIFF_CODE 
                          from DB_LOADER_ACCOUNT_TARIFFS r 
                          where r.ACCOUNT_ID = b.ACCOUNT_ID
                            and r.TARIFF_NAME = b.TARIFF_CODE
                            and (b.PHONE_NUMBER, r.TARIFF_CODE) in (select h.PHONE_NUMBER, h.CELL_PLAN_CODE 
                                                                      from db_loader_account_phone_hists h
                                                                      where h.END_DATE >= to_date('20140101', 'yyyymmdd') 
                                                                        and h.BEGIN_DATE <= to_date('20140201', 'yyyymmdd') - 1/24/60 ) )
    where 1 < (select count(*) 
                from DB_LOADER_ACCOUNT_TARIFFS r 
                where r.ACCOUNT_ID = b.ACCOUNT_ID
                  and r.TARIFF_NAME = b.TARIFF_CODE
                  )      
      and 1 = (select count(*)
                from DB_LOADER_ACCOUNT_TARIFFS r 
                where r.ACCOUNT_ID = b.ACCOUNT_ID
                  and r.TARIFF_NAME = b.TARIFF_CODE
                  and (b.PHONE_NUMBER, r.TARIFF_CODE) in (select h.PHONE_NUMBER, h.CELL_PLAN_CODE 
                                                            from db_loader_account_phone_hists h
                                                            where h.END_DATE >= to_date('20140101', 'yyyymmdd') 
                                                              and h.BEGIN_DATE <= to_date('20140201', 'yyyymmdd') - 1/24/60 ) )   
      and new_tar_code is null
      and b.TARIFF_CODE<> 'Не указан';       
  --      
  commit;         
end  */
begin end;
/*
begin
  insert into DB_LOADER_FULL_BILL_ABON_PER(ACCOUNT_ID,YEAR_MONTH,PHONE_NUMBER,DATE_BEGIN,DATE_END, TARIFF_CODE,ABON_MAIN,ABON_ADD,ABON_ALL)
    select                                 ACCOUNT_ID,YEAR_MONTH,PHONE_NUMBER,DATE_BEGIN,DATE_END,new_TAR_CODE,ABON_MAIN,ABON_ADD,ABON_ALL
      from TMPDB_LOADER_FULL_BILL_AB_PER
        where YEAR_MONTH = 201401;
        --
  insert into DB_LOADER_FULL_BILL_MG_ROUMING(ACCOUNT_ID,YEAR_MONTH,PHONE_NUMBER,DATE_BEGIN,DATE_END,ROUMING_COUNTRY,ROUMING_CALLS,ROUMING_GPRS,ROUMING_SMS,COMPANY_TAX,ROUMING_SUM)
    select                                   ACCOUNT_ID,YEAR_MONTH,PHONE_NUMBER,DATE_BEGIN,DATE_END,ROUMING_COUNTRY,ROUMING_CALLS,ROUMING_GPRS,ROUMING_SMS,COMPANY_TAX,ROUMING_SUM
      from TMPDB_LOADER_FULL_BILL_MG_ROW
        where YEAR_MONTH = 201401;
        --
  insert into DB_LOADER_FULL_BILL_MN_ROUMING(ACCOUNT_ID,YEAR_MONTH,PHONE_NUMBER,DATE_BEGIN,DATE_END,ROUMING_COUNTRY,ROUMING_CALLS,ROUMING_GPRS,ROUMING_SMS,COMPANY_TAX,ROUMING_SUM)
    select                                   ACCOUNT_ID,YEAR_MONTH,PHONE_NUMBER,DATE_BEGIN,DATE_END,ROUMING_COUNTRY,ROUMING_CALLS,ROUMING_GPRS,ROUMING_SMS,COMPANY_TAX,ROUMING_SUM
      from TMPDB_LOADER_FULL_BILL_MN_ROW
        where YEAR_MONTH = 201401;
        --
  insert into DB_LOADER_FULL_FINANCE_BILL(ACCOUNT_ID,YEAR_MONTH,PHONE_NUMBER,ABONKA,CALLS,SINGLE_PAYMENTS,DISCOUNTS,BILL_SUM,COMPLETE_BILL,
                                          ABON_MAIN,ABON_ADD,ABON_OTHER,SINGLE_MAIN,SINGLE_ADD,SINGLE_PENALTI,SINGLE_CHANGE_TARIFF,
                                          SINGLE_TURN_ON_SERV,SINGLE_CORRECTION_ROUMING,SINGLE_INTRA_WEB,SINGLE_VIEW_BLACK_LIST,SINGLE_OTHER,
                                          DISCOUNT_YEAR,DISCOUNT_SMS_PLUS,DISCOUNT_CALL,DISCOUNT_COUNT_ON_PHONES,DISCOUNT_OTHERS,
                                          CALLS_COUNTRY,CALLS_SITY,CALLS_LOCAL,CALLS_SMS_MMS,CALLS_GPRS,CALLS_RUS_RPP,CALLS_ALL,ROUMING_NATIONAL,ROUMING_INTERNATIONAL,DISCOUNT_SOVINTEL,BAN)
    select                                ACCOUNT_ID,YEAR_MONTH,PHONE_NUMBER,ABONKA,CALLS,SINGLE_PAYMENTS,DISCOUNTS,BILL_SUM,COMPLETE_BILL,
                                          ABON_MAIN,ABON_ADD,ABON_OTHER,SINGLE_MAIN,SINGLE_ADD,SINGLE_PENALTI,SINGLE_CHANGE_TARIFF,
                                          SINGLE_TURN_ON_SERV,SINGLE_CORRECTION_ROUMING,SINGLE_INTRA_WEB,SINGLE_VIEW_BLACK_LIST,SINGLE_OTHER,
                                          DISCOUNT_YEAR,DISCOUNT_SMS_PLUS,DISCOUNT_CALL,DISCOUNT_COUNT_ON_PHONES,DISCOUNT_OTHERS,
                                          CALLS_COUNTRY,CALLS_SITY,CALLS_LOCAL,CALLS_SMS_MMS,CALLS_GPRS,CALLS_RUS_RPP,CALLS_ALL,ROUMING_NATIONAL,ROUMING_INTERNATIONAL,DISCOUNT_SOVINTEL,BAN
      from TMPDB_LOADER_FULL_FINANCE_BILL
        where YEAR_MONTH = 201401
          and not exists (select 1 
                            from DB_LOADER_FULL_FINANCE_BILL
                            where DB_LOADER_FULL_FINANCE_BILL.ACCOUNT_ID=TMPDB_LOADER_FULL_FINANCE_BILL.ACCOUNT_ID
                              and DB_LOADER_FULL_FINANCE_BILL.YEAR_MONTH=TMPDB_LOADER_FULL_FINANCE_BILL.YEAR_MONTH
                              and DB_LOADER_FULL_FINANCE_BILL.PHONE_NUMBER =TMPDB_LOADER_FULL_FINANCE_BILL.PHONE_NUMBER);
  --
  insert into DB_LOADER_BILLS(ACCOUNT_ID,YEAR_MONTH,PHONE_NUMBER,DATE_BEGIN,DATE_END,BILL_SUM,SUBSCRIBER_PAYMENT_MAIN,SUBSCRIBER_PAYMENT_ADD,SINGLE_PAYMENTS,
                              CALLS_LOCAL_COST,CALLS_OTHER_CITY_COST,CALLS_OTHER_COUNTRY_COST,MESSAGES_COST,INTERNET_COST,OTHER_COUNTRY_ROAMING_COST,
                              NATIONAL_ROAMING_COST,PENI_COST,DISCOUNT_VALUE,   TARIFF_CODE,OTHER_COUNTRY_ROAMING_CALLS,OTHER_COUNTRY_ROAMING_MESSAGES,
                              OTHER_COUNTRY_ROAMING_INTERNET,NATIONAL_ROAMING_CALLS,NATIONAL_ROAMING_MESSAGES,NATIONAL_ROAMING_INTERNET,BILL_CHECKED)
    select                    ACCOUNT_ID,YEAR_MONTH,PHONE_NUMBER,DATE_BEGIN,DATE_END,BILL_SUM,SUBSCRIBER_PAYMENT_MAIN,SUBSCRIBER_PAYMENT_ADD,SINGLE_PAYMENTS,
                              CALLS_LOCAL_COST,CALLS_OTHER_CITY_COST,CALLS_OTHER_COUNTRY_COST,MESSAGES_COST,INTERNET_COST,OTHER_COUNTRY_ROAMING_COST,
                              NATIONAL_ROAMING_COST,PENI_COST,DISCOUNT_VALUE,  new_TAR_CODE,OTHER_COUNTRY_ROAMING_CALLS,OTHER_COUNTRY_ROAMING_MESSAGES,
                              OTHER_COUNTRY_ROAMING_INTERNET,NATIONAL_ROAMING_CALLS,NATIONAL_ROAMING_MESSAGES,NATIONAL_ROAMING_INTERNET,BILL_CHECKED
      from TMPDB_LOADER_BILLS
        where YEAR_MONTH = 201401
          and not exists (select 1 
                            from DB_LOADER_BILLS
                            where DB_LOADER_BILLS.ACCOUNT_ID=TMPDB_LOADER_BILLS.ACCOUNT_ID
                              and DB_LOADER_BILLS.YEAR_MONTH=TMPDB_LOADER_BILLS.YEAR_MONTH
                              and DB_LOADER_BILLS.PHONE_NUMBER =TMPDB_LOADER_BILLS.PHONE_NUMBER);
  --   
  commit;
  --                         
end;
*/
begin end;

begin
  insert into DB_LOADER_FULL_FINANCE_BILL(ACCOUNT_ID,YEAR_MONTH,PHONE_NUMBER,
                                          ABONKA,CALLS,
                                          SINGLE_PAYMENTS,DISCOUNTS,BILL_SUM,COMPLETE_BILL,
                                          ABON_MAIN, ABON_ADD,ABON_OTHER,
                                          SINGLE_MAIN,SINGLE_ADD,SINGLE_PENALTI,SINGLE_CHANGE_TARIFF,SINGLE_TURN_ON_SERV,
                                          SINGLE_CORRECTION_ROUMING,SINGLE_INTRA_WEB,SINGLE_VIEW_BLACK_LIST,SINGLE_OTHER,
                                          DISCOUNT_YEAR,DISCOUNT_SMS_PLUS,DISCOUNT_CALL,DISCOUNT_COUNT_ON_PHONES,DISCOUNT_OTHERS,
                                          CALLS_COUNTRY,CALLS_SITY,CALLS_LOCAL,CALLS_SMS_MMS,CALLS_GPRS,CALLS_RUS_RPP,CALLS_ALL,
                                          ROUMING_NATIONAL,ROUMING_INTERNATIONAL,DISCOUNT_SOVINTEL,BAN)
    select                                b.ACCOUNT_ID,b.YEAR_MONTH,b.PHONE_NUMBER,
                                          b.SUBSCRIBER_PAYMENT_MAIN+b.SUBSCRIBER_PAYMENT_ADD,b.BILL_SUM-b.SUBSCRIBER_PAYMENT_MAIN-b.SUBSCRIBER_PAYMENT_ADD-b.SINGLE_PAYMENTS-b.DISCOUNT_VALUE, 
                                          b.SINGLE_PAYMENTS ,b.DISCOUNT_VALUE,b.BILL_SUM,1,
                                          b.SUBSCRIBER_PAYMENT_MAIN, b.SUBSCRIBER_PAYMENT_ADD, 0, --ABON_MAIN, ABON_ADD,ABON_OTHER,
                                          0,0,0,0,0,  --SINGLE_MAIN,SINGLE_ADD,SINGLE_PENALTI,SINGLE_CHANGE_TARIFF,SINGLE_TURN_ON_SERV,
                                          0,0,0,0,  --SINGLE_CORRECTION_ROUMING,SINGLE_INTRA_WEB,SINGLE_VIEW_BLACK_LIST,SINGLE_OTHER,
                                          0,0,0,0,0,  --DISCOUNT_YEAR,DISCOUNT_SMS_PLUS,DISCOUNT_CALL,DISCOUNT_COUNT_ON_PHONES,DISCOUNT_OTHERS,
                                          0,0,0,0,0,0,0,  --CALLS_COUNTRY,CALLS_SITY,CALLS_LOCAL,CALLS_SMS_MMS,CALLS_GPRS,CALLS_RUS_RPP,CALLS_ALL,
                                          0,0,0,0  --ROUMING_NATIONAL,ROUMING_INTERNATIONAL,DISCOUNT_SOVINTEL,BAN
      from DB_LOADER_BILLS b
        where YEAR_MONTH = 201404
          and b.BILL_SUM = 0
          and not exists (select 1 
                            from DB_LOADER_FULL_FINANCE_BILL
                            where DB_LOADER_FULL_FINANCE_BILL.ACCOUNT_ID=b.ACCOUNT_ID
                              and DB_LOADER_FULL_FINANCE_BILL.YEAR_MONTH=b.YEAR_MONTH
                              and DB_LOADER_FULL_FINANCE_BILL.PHONE_NUMBER =b.PHONE_NUMBER);
  --                              
  insert into DB_LOADER_FULL_BILL_ABON_PER(ACCOUNT_ID,YEAR_MONTH,PHONE_NUMBER, DATE_BEGIN,DATE_END, 
                                           TARIFF_CODE,
                                           ABON_MAIN,ABON_ADD,ABON_ALL)
    select                                 b.ACCOUNT_ID, b.YEAR_MONTH, b.PHONE_NUMBER, to_date(to_char(b.YEAR_MONTH)||'01','yyyymmdd') DATE_BEGIN,add_months(to_date(to_char(b.YEAR_MONTH)||'01','yyyymmdd'), 1)-1 DATE_END,
                                           nvl(
                                           (select ax.TARIFF_CODE from DB_LOADER_FULL_BILL_ABON_PER ax
                                              where ax.ACCOUNT_ID = b.ACCOUNT_ID and ax.PHONE_NUMBER=b.PHONE_NUMBER and ax.YEAR_MONTH=201401 and ax.TARIFF_CODE is not null and rownum <=1),
                                           (select h.CELL_PLAN_CODE from db_loader_account_phone_hists h where h.PHONE_NUMBER=b.PHONE_NUMBER 
                                              and h.END_DATE>to_date(to_char(b.YEAR_MONTH)||'01','yyyymmdd') and h.begin_DATE<add_months(to_date(to_char(b.YEAR_MONTH)||'01','yyyymmdd'), 1)-1 and rownum <=1)  ) TAR_CODE, 
                                           b.SUBSCRIBER_PAYMENT_MAIN ABON_MAIN,b.SUBSCRIBER_PAYMENT_ADD ABON_ADD,b.SUBSCRIBER_PAYMENT_MAIN+b.SUBSCRIBER_PAYMENT_ADD ABON_ALL  -- ABON_MAIN,ABON_ADD,ABON_ALL
      from DB_LOADER_BILLS b
        where YEAR_MONTH = 201404
          and b.BILL_SUM <> 0
          and not exists (select 1 
                            from DB_LOADER_FULL_FINANCE_BILL
                            where DB_LOADER_FULL_FINANCE_BILL.ACCOUNT_ID=b.ACCOUNT_ID
                              and DB_LOADER_FULL_FINANCE_BILL.YEAR_MONTH=b.YEAR_MONTH
                              and DB_LOADER_FULL_FINANCE_BILL.PHONE_NUMBER =b.PHONE_NUMBER) ;                           
  --                                                                        
  insert into DB_LOADER_FULL_FINANCE_BILL(ACCOUNT_ID,YEAR_MONTH,PHONE_NUMBER,
                                          ABONKA,CALLS,
                                          SINGLE_PAYMENTS,DISCOUNTS,BILL_SUM,COMPLETE_BILL,
                                          ABON_MAIN, ABON_ADD,ABON_OTHER,
                                          SINGLE_MAIN,SINGLE_ADD,SINGLE_PENALTI,SINGLE_CHANGE_TARIFF,SINGLE_TURN_ON_SERV,
                                          SINGLE_CORRECTION_ROUMING,SINGLE_INTRA_WEB,SINGLE_VIEW_BLACK_LIST,SINGLE_OTHER,
                                          DISCOUNT_YEAR,DISCOUNT_SMS_PLUS,DISCOUNT_CALL,DISCOUNT_COUNT_ON_PHONES,DISCOUNT_OTHERS,
                                          CALLS_COUNTRY,CALLS_SITY,CALLS_LOCAL,CALLS_SMS_MMS,CALLS_GPRS,CALLS_RUS_RPP,CALLS_ALL,
                                          ROUMING_NATIONAL,ROUMING_INTERNATIONAL,DISCOUNT_SOVINTEL,BAN)
    select                                b.ACCOUNT_ID,b.YEAR_MONTH,b.PHONE_NUMBER,
                                          b.SUBSCRIBER_PAYMENT_MAIN+b.SUBSCRIBER_PAYMENT_ADD,b.BILL_SUM-b.SUBSCRIBER_PAYMENT_MAIN-b.SUBSCRIBER_PAYMENT_ADD-b.SINGLE_PAYMENTS-b.DISCOUNT_VALUE, 
                                          b.SINGLE_PAYMENTS,b.DISCOUNT_VALUE,b.BILL_SUM,1,
                                          b.SUBSCRIBER_PAYMENT_MAIN, b.SUBSCRIBER_PAYMENT_ADD, 0, --ABON_MAIN, ABON_ADD,ABON_OTHER,
                                          0,0,0,0,0,  --SINGLE_MAIN,SINGLE_ADD,SINGLE_PENALTI,SINGLE_CHANGE_TARIFF,SINGLE_TURN_ON_SERV,
                                          0,0,0,b.SINGLE_PAYMENTS,  --SINGLE_CORRECTION_ROUMING,SINGLE_INTRA_WEB,SINGLE_VIEW_BLACK_LIST,SINGLE_OTHER,
                                          0,0,0,0,b.DISCOUNT_VALUE,  --DISCOUNT_YEAR,DISCOUNT_SMS_PLUS,DISCOUNT_CALL,DISCOUNT_COUNT_ON_PHONES,DISCOUNT_OTHERS,
                                          b.CALLS_OTHER_COUNTRY_COST,b.CALLS_OTHER_CITY_COST,b.CALLS_LOCAL_COST,b.MESSAGES_COST,b.INTERNET_COST,0,  
                                          --CALLS_COUNTRY,           CALLS_SITY,             CALLS_LOCAL,       CALLS_SMS_MMS,  CALLS_GPRS, CALLS_RUS_RPP,
                                          b.CALLS_OTHER_COUNTRY_COST+b.CALLS_OTHER_CITY_COST+b.CALLS_LOCAL_COST+b.MESSAGES_COST+b.INTERNET_COST, --CALLS_ALL,
                                          b.NATIONAL_ROAMING_COST,b.OTHER_COUNTRY_ROAMING_COST,0,-1  
                                          --ROUMING_NATIONAL,ROUMING_INTERNATIONAL,DISCOUNT_SOVINTEL,BAN
      from DB_LOADER_BILLS b
        where YEAR_MONTH = 201404
          and b.BILL_SUM <> 0
          and not exists (select 1 
                            from DB_LOADER_FULL_FINANCE_BILL
                            where DB_LOADER_FULL_FINANCE_BILL.ACCOUNT_ID=b.ACCOUNT_ID
                              and DB_LOADER_FULL_FINANCE_BILL.YEAR_MONTH=b.YEAR_MONTH
                              and DB_LOADER_FULL_FINANCE_BILL.PHONE_NUMBER =b.PHONE_NUMBER);  
  --
  commit;
end;     
                         
begin end;

begin
  update DB_LOADER_FULL_FINANCE_BILL fb set FB.SINGLE_MAIN = fb.ABON_MAIN * fb.SINGLE_OTHER / fb.ABONKA 
  where fb.YEAR_MONTH = 201404 and fb.COMPLETE_BILL = 1 and ban = -1 and fb.ABONKA <> 0 and fb.ABONKA + fb.SINGLE_PAYMENTS >= 0 and fb.SINGLE_OTHER < 0; 
  update DB_LOADER_FULL_FINANCE_BILL fb set FB.SINGLE_ADD = fb.SINGLE_OTHER - FB.SINGLE_MAIN
  where fb.YEAR_MONTH = 201404 and fb.COMPLETE_BILL = 1 and ban = -1 and fb.ABONKA <> 0 and fb.ABONKA + fb.SINGLE_PAYMENTS >= 0 and fb.SINGLE_OTHER < 0; 
  update DB_LOADER_FULL_FINANCE_BILL fb set  fb.SINGLE_OTHER =0
  where fb.YEAR_MONTH = 201404 and fb.COMPLETE_BILL = 1 and ban = -1 and fb.ABONKA <> 0 and fb.ABONKA + fb.SINGLE_PAYMENTS >= 0 and fb.SINGLE_OTHER < 0; 
  commit;
end;         
            
begin end;

begin
  --select * from DB_LOADER_FULL_FINANCE_BILL fb 
  update  DB_LOADER_FULL_FINANCE_BILL fb 
    set fb.DISCOUNT_YEAR = (fb.ABON_MAIN + fb.SINGLE_MAIN) * (select fb1.DISCOUNT_YEAR/(fb1.ABON_MAIN + fb1.SINGLE_MAIN) from DB_LOADER_FULL_FINANCE_BILL fb1 where FB.ACCOUNT_ID = fb1.ACCOUNT_ID 
                                                                and to_char(add_months(to_date(fb.YEAR_MONTH,'yyyymm'),-1),'yyyymm') = fb1.YEAR_MONTH 
                                                                and FB.phone_number = fb1.phone_number and fb1.DISCOUNT_YEAR <> 0 ),
        fb.DISCOUNT_OTHERS = fb.DISCOUNT_OTHERS - (fb.ABON_MAIN + fb.SINGLE_MAIN) * (select fb1.DISCOUNT_YEAR/(fb1.ABON_MAIN + fb1.SINGLE_MAIN) from DB_LOADER_FULL_FINANCE_BILL fb1 where FB.ACCOUNT_ID = fb1.ACCOUNT_ID 
                                                                and to_char(add_months(to_date(fb.YEAR_MONTH,'yyyymm'),-1),'yyyymm') = fb1.YEAR_MONTH 
                                                                and FB.phone_number = fb1.phone_number and fb1.DISCOUNT_YEAR <> 0 )  
    where fb.YEAR_MONTH = 201404 and ban = -1 and fb.DISCOUNT_OTHERS < 0 and fb.DISCOUNT_YEAR = 0 --and fb.PHONE_NUMBER = '9653263344'
      and exists (select 1 from DB_LOADER_FULL_FINANCE_BILL fb1 where FB.ACCOUNT_ID = fb1.ACCOUNT_ID 
                    and to_char(add_months(to_date(fb.YEAR_MONTH,'yyyymm'),-1),'yyyymm') = fb1.YEAR_MONTH and FB.phone_number = fb1.phone_number and fb1.DISCOUNT_YEAR <> 0 );
commit;
end;                    
                       
begin end;  
  
begin
  --select * from DB_LOADER_FULL_FINANCE_BILL fb 
  update  DB_LOADER_FULL_FINANCE_BILL fb 
    set fb.DISCOUNT_SMS_PLUS = -(fb.single_add +705),
        fb.DISCOUNT_OTHERS = fb.DISCOUNT_OTHERS + (fb.single_add +705)  
    where fb.YEAR_MONTH = 201404 and ban = -1 and fb.DISCOUNT_OTHERS < -300 and fb.DISCOUNT_SMS_PLUS = 0 and fb.ABON_ADD > 700
      and exists (select 1 from DB_LOADER_FULL_FINANCE_BILL fb1 where FB.ACCOUNT_ID = fb1.ACCOUNT_ID 
                    and to_char(add_months(to_date(fb.YEAR_MONTH,'yyyymm'),-1),'yyyymm') = fb1.YEAR_MONTH and FB.phone_number = fb1.phone_number and fb1.DISCOUNT_SMS_PLUS <> 0 );
commit;
end;                
    
update DB_LOADER_FULL_FINANCE_BILL fb  
    set fb.BILL_SUM = fb.BILL_SUM - (fb.CALLS - fb.CALLS_ALL),
        fb.CALLS = fb.CALLS - (fb.CALLS - fb.CALLS_ALL ),
        fb.COMPLETE_BILL = 1   
    where fb.YEAR_MONTH = 201404 and ban = -1 and fb.CALLS <> fb.CALLS_ALL and abs(fb.CALLS - fb.CALLS_ALL) = 0.01 and fb.COMPLETE_BILL=0;
    
update DB_LOADER_FULL_FINANCE_BILL fb  
    set fb.BILL_SUM = fb.BILL_SUM - (fb.CALLS - fb.CALLS_ALL),
        fb.CALLS = fb.CALLS - (fb.CALLS - fb.CALLS_ALL ),
        fb.COMPLETE_BILL = 1   
    where fb.YEAR_MONTH = 201404 and ban = -1 and fb.CALLS <> fb.CALLS_ALL and abs(fb.CALLS - fb.CALLS_ALL) = 0.02 and fb.COMPLETE_BILL=0;
    
  update  DB_LOADER_FULL_FINANCE_BILL fb 
    set fb.DISCOUNT_SOVINTEL = fb.DISCOUNT_SOVINTEL + (-304.79) ,
        fb.DISCOUNT_OTHERS = fb.DISCOUNT_OTHERS - (-304.79)  
 -- select * from        DB_LOADER_FULL_FINANCE_BILL fb
    where fb.YEAR_MONTH = 201404 and ban = -1 and fb.DISCOUNT_OTHERS < -150 
      and exists (select 1 from DB_LOADER_FULL_FINANCE_BILL fb1 where FB.ACCOUNT_ID = fb1.ACCOUNT_ID 
                    and to_char(add_months(to_date(fb.YEAR_MONTH,'yyyymm'),-1),'yyyymm') = fb1.YEAR_MONTH and FB.phone_number = fb1.phone_number and fb1.DISCOUNT_SOVINTEL <> 0 )    