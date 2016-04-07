
  CREATE OR REPLACE FORCE VIEW "CORP_MOBILE"."V_ALL_NUMBERS_OUT_CONTRACTS" ("PHONE_NUMBER", "PHONE_IS_ACTIVE", "ACCOUNT_ID") AS 
  SELECT
--#Version=4
  PHONE_NUMBER,
  PHONE_IS_ACTIVE,
  ACCOUNT_ID
FROM
  DB_LOADER_ACCOUNT_PHONES PH_NEW
WHERE
      -- Проверяем только в самом позднем загруженном периоде 
  PH_NEW.YEAR_MONTH = to_char(sysdate,'yyyymm')
  AND PHONE_NUMBER NOT IN (
    SELECT CONTRACTS.PHONE_NUMBER_FEDERAL 
      FROM CONTRACTS
      where CONTRACTS.CONTRACT_ID not in(
        select CONTRACT_ID
          from contract_cancels)      
    )