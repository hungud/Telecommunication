
  CREATE OR REPLACE FORCE VIEW "CORP_MOBILE"."V_PHONE_BEELINE_BILLS" ("ACCOUNT_ID", "YEAR_MONTH", "PHONE_NUMBER", "BILL_SUM_OLD", "ABON_TP_OLD", "ABON_ADD_OLD") AS 
  select min(fb.ACCOUNT_ID) ACCOUNT_ID,
         fb.YEAR_MONTH,
         fb.PHONE_NUMBER,
         sum(case when fb.BILL_SUM <=0 then 0 else fb.BILL_SUM end) BILL_SUM_OLD,
         sum(case when fb.BILL_SUM <=0 then 0 else fb.ABON_MAIN + fb.SINGLE_MAIN end) ABON_TP_OLD,
         sum(case when fb.BILL_SUM <=0 then 0 else fb.ABON_ADD + fb.SINGLE_ADD end) ABON_ADD_OLD         
    from db_loader_full_finance_bill fb
    where fb.BILL_SUM >= 0
    group by fb.YEAR_MONTH, fb.PHONE_NUMBER 