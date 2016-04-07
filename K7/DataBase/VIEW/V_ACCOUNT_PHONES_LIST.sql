CREATE OR REPLACE VIEW V_ACCOUNT_PHONES_LIST AS
-- Version = 1
  SELECT A.ACCOUNT_NUMBER,
         P.*, 
         DL.DETAIL_SUM, 
         CASE CHECK_CONTRACTS_BY_YEAR_MONTH(P.PHONE_NUMBER, P.YEAR_MONTH) 
          WHEN 1 THEN '��'
          ELSE '���'
         END IS_CONTRACT
    FROM DB_LOADER_ACCOUNT_PHONES P,
         ACCOUNTS A, 
         DB_LOADER_REPORT_DATA DL
    WHERE P.PHONE_NUMBER = DL.PHONE_NUMBER(+)
      AND P.YEAR_MONTH = DL.YEAR_MONTH(+)
      AND P.ACCOUNT_ID=A.ACCOUNT_ID(+)
    ORDER BY P.PHONE_NUMBER ASC;
    
GRANT SELECT ON V_ACCOUNT_PHONES_LIST TO CORP_MOBILE_ROLE;    
    
GRANT SELECT ON V_ACCOUNT_PHONES_LIST TO CORP_MOBILE_ROLE_RO;    