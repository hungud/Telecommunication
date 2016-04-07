
  CREATE OR REPLACE FORCE VIEW "CORP_MOBILE"."V_FIN_REP_OUTFLOW" ("YEAR_MONTH", "PHONE_NUMBER", "BAN", "DATE_INSERT", "CONTRACT_ID", "PHONE_IS_ACTIVE") AS 
  SELECT L."YEAR_MONTH",L."PHONE_NUMBER",L."BAN",L."DATE_INSERT", 
         (select c.CONTRACT_ID
            from contracts c
            where c.PHONE_NUMBER_FEDERAL = l.PHONE_NUMBER
              and not exists (select 1
                                from contract_cancels cc
                                where cc.CONTRACT_ID = c.CONTRACT_ID
                                  AND CC.CONTRACT_CANCEL_DATE <= LAST_DAY(TO_DATE(L.YEAR_MONTH, 'YYYYMM')))) CONTRACT_ID,   
         (select d.PHONE_IS_ACTIVE
            from db_loader_account_phone_hists d
            where d.PHONE_NUMBER = l.PHONE_NUMBER
              and d.END_DATE = (select max(d1.END_DATE)
                                    from db_loader_account_phone_hists d1
                                    where d1.PHONE_NUMBER = d.PHONE_NUMBER)
              and rownum <=1) PHONE_IS_ACTIVE                     
    FROM PHONE_ACTIV_LOG L
    WHERE NOT EXISTS (SELECT 1
                        FROM PHONE_ACTIV_LOG L1
                        WHERE L1.PHONE_NUMBER = L.PHONE_NUMBER
                          AND L1.YEAR_MONTH = 
                                CASE
                                  WHEN L.YEAR_MONTH - 12 = TRUNC(L.YEAR_MONTH/100)*100 THEN L.YEAR_MONTH + 88 + 1
                                  ELSE L.YEAR_MONTH + 1
                                END) 