CREATE OR REPLACE VIEW V_ACTIVE_NUMBERS_OUT_CONTRACTS AS
SELECT
--#Version=4
  va.PHONE_NUMBER,
  va.ACCOUNT_ID,
  ac.login,
  ac.company_name 
FROM
  V_ALL_NUMBERS_OUT_CONTRACTS va,accounts ac
WHERE
  va.PHONE_IS_ACTIVE = 1
  and va.ACCOUNT_ID=ac.account_id
/
