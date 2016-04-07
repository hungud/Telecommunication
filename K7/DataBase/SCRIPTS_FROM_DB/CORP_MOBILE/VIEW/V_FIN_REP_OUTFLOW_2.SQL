
  CREATE OR REPLACE FORCE VIEW "CORP_MOBILE"."V_FIN_REP_OUTFLOW_2" ("YEAR_MONTH", "PHONE_NUMBER", "BAN", "DATE_INSERT", "CONTRACT_ID", "PHONE_IS_ACTIVE", "CONTRACT_DATE", "DOP_STATUS", "DATE_LAST_BLOCK", "BILL_PRIROST", "CONTRACT_CANCEL_DATE") AS 
  select SUBQ."YEAR_MONTH",SUBQ."PHONE_NUMBER",SUBQ."BAN",SUBQ."DATE_INSERT",SUBQ."CONTRACT_ID",SUBQ."PHONE_IS_ACTIVE",SUBQ."CONTRACT_DATE",SUBQ."DOP_STATUS",
         --GET_ABONENT_BALANCE(SUBQ.PHONE_NUMBER) BALANCE,
         CASE
           WHEN SUBQ.phone_is_active = 0 THEN
             (SELECT d.BEGIN_DATE
                from db_loader_account_phone_hists d
                where d.PHONE_NUMBER = SUBQ.PHONE_NUMBER
                  and d.END_DATE = (select max(d1.END_DATE)
                                        from db_loader_account_phone_hists d1
                                        where d1.PHONE_NUMBER = d.PHONE_NUMBER)
                  and rownum <=1)
           ELSE NULL
         END DATE_LAST_BLOCK,
         (SELECT SUM(V.BILL_SUM_NEW - V.BILL_SUM_OLD)
            FROM BILL_FINANCE_FOR_CLIENTS_SAVED V,
                 ACCOUNT_LOADED_BILLS AB
            WHERE V.PHONE_NUMBER = SUBQ.PHONE_NUMBER
              AND V.YEAR_MONTH >= TO_NUMBER(TO_CHAR(SUBQ.CONTRACT_DATE, 'YYYYMM'))
              AND AB.ACCOUNT_ID = V.ACCOUNT_ID
              AND AB.YEAR_MONTH = V.YEAR_MONTH
              AND AB.LOAD_BILL_IN_BALANCE = 1  ) BILL_PRIROST,
         (SELECT CC.CONTRACT_CANCEL_DATE
            FROM CONTRACT_CANCELS CC
            WHERE CC.CONTRACT_ID = SUBQ.CONTRACT_ID) CONTRACT_CANCEL_DATE
    from (SELECT V.*, 
                 C.CONTRACT_DATE,
                 (SELECT CDS.DOP_STATUS_NAME
                    FROM CONTRACT_DOP_STATUSES CDS
                    WHERE CDS.DOP_STATUS_ID = C.DOP_STATUS) DOP_STATUS              
            FROM V_FIN_REP_OUTFLOW V, CONTRACTS C
            WHERE V.CONTRACT_ID = C.CONTRACT_ID(+) ) SUBQ 