CREATE OR REPLACE VIEW V_BILLS_VIOL_COST_IN_BLOCK as
--Version=2
--2. Котенков. Добавил выдачу поля ACCOUNTS.ACCOUNT_NUMBER
  SELECT AP.ACCOUNT_ID,
         AP.YEAR_MONTH,
         AP.PHONE_NUMBER
    FROM DB_LOADER_ACCOUNT_PHONES AP
    WHERE AP.CONSERVATION = 1
      AND NOT EXISTS (SELECT 1 
                        FROM DB_LOADER_ACCOUNT_PHONE_HISTS H
                        WHERE H.PHONE_NUMBER = AP.PHONE_NUMBER
                          AND H.PHONE_IS_ACTIVE = 1
                          AND H.END_DATE >= TO_DATE(TO_CHAR(AP.YEAR_MONTH)||'01', 'YYYYMMDD')
                          AND H.BEGIN_DATE < ADD_MONTHS(TO_DATE(TO_CHAR(AP.YEAR_MONTH)||'01', 'YYYYMMDD'), 1));
                          
    /*  AND NOT EXISTS (SELECT 1
                        FROM 'CALL_'||TO_CHAR(AP.PHONE_NUMBER-TRUNC(AP.PHONE_NUMBER/100)*100)||'_'||TO_CHAR(TRUNC(AP.PHONE_NUMBER/100)) HB
                        WHERE HB.SUBSCR_NO = AP.PHONE_NUMBER);     */ 
                          
GRANT SELECT ON V_BILLS_VIOL_COST_IN_BLOCK TO CORP_MOBILE_ROLE;                                               