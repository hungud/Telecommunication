CREATE OR REPLACE VIEW V_ACCOUNT_PHONE_LIST AS
-- Version = 1
  SELECT AC.LOGIN,
         AP.ACCOUNT_ID,
         AP.PHONE_NUMBER,
         AP.CELL_PLAN_CODE TARIFF_CODE,
         CASE
           WHEN AP.PHONE_IS_ACTIVE = 1 THEN '���.'
           ELSE '����.'
         END PHONE_IS_ACTIVE,         
         CASE
           WHEN AP.CONSERVATION = 1 THEN '������.'
           ELSE NULL
         END CONSERVATION,         
         CASE
           WHEN AP.SYSTEM_BLOCK = 1 THEN '��. �� ���.'
           ELSE NULL
         END SYSTEM_BLOCK
    FROM DB_LOADER_ACCOUNT_PHONES AP,
         ACCOUNTS AC
    WHERE AP.YEAR_MONTH = (SELECT MAX(YEAR_MONTH)
                             FROM DB_LOADER_ACCOUNT_PHONES)
      AND AP.ACCOUNT_ID = AC.ACCOUNT_ID(+);
      
GRANT SELECT, INSERT, DELETE, UPDATE ON V_ACCOUNT_PHONE_LIST TO CORP_MOBILE_ROLE;     
      
GRANT SELECT ON V_ACCOUNT_PHONE_LIST TO CORP_MOBILE_ROLE_RO;        