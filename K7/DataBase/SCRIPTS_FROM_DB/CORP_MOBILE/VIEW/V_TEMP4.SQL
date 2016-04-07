
  CREATE OR REPLACE FORCE VIEW "CORP_MOBILE"."V_TEMP4" ("PHONE_NUMBER") AS 
  select "PHONE_NUMBER" 
    from (SELECT distinct H.PHONE_NUMBER
            FROM V_HISTORY_ACTIV_PHONE h
            WHERE H.BEGIN_YM <=201310
              and h.END_YM >= 201310) v
    where exists (select 1
                    from db_loader_payments p
                    where p.PHONE_NUMBER = v.PHONE_NUMBER  
                      and ( to_char(p.PAYMENT_DATE, 'yyyymm') = 201310
                        or to_char(add_months(p.PAYMENT_DATE, 1), 'yyyymm') = 201310)) 