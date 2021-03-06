
  CREATE OR REPLACE FORCE VIEW "SIM_TRADE"."V_ACCOUNT_PHONES_LIST" ("ACCOUNT_NUMBER", "ACCOUNT_ID", "YEAR_MONTH", "PHONE_NUMBER", "PHONE_IS_ACTIVE", "CELL_PLAN_CODE", "NEW_CELL_PLAN_CODE", "NEW_CELL_PLAN_DATE", "LAST_CHECK_DATE_TIME", "ORGANIZATION_ID", "CONSERVATION", "SYSTEM_BLOCK", "DETAIL_SUM", "IS_CONTRACT") AS 
  SELECT A.ACCOUNT_NUMBER,
            P."ACCOUNT_ID",
            P."YEAR_MONTH",
            P."PHONE_NUMBER",
            P."PHONE_IS_ACTIVE",
            P."CELL_PLAN_CODE",
            P."NEW_CELL_PLAN_CODE",
            P."NEW_CELL_PLAN_DATE",
            P."LAST_CHECK_DATE_TIME",
            P."ORGANIZATION_ID",
            P."CONSERVATION",
            P."SYSTEM_BLOCK",
            DL.DETAIL_SUM,
            CASE CHECK_CONTRACTS_BY_YEAR_MONTH (P.PHONE_NUMBER, P.YEAR_MONTH)
               WHEN 1 THEN 'да'
               ELSE 'нет'
            END
               IS_CONTRACT
       FROM DB_LOADER_ACCOUNT_PHONES P, ACCOUNTS A, DB_LOADER_REPORT_DATA DL
      WHERE     P.PHONE_NUMBER = DL.PHONE_NUMBER(+)
            AND P.YEAR_MONTH = DL.YEAR_MONTH(+)
            AND P.ACCOUNT_ID = A.ACCOUNT_ID(+)
   ORDER BY P.PHONE_NUMBER ASC