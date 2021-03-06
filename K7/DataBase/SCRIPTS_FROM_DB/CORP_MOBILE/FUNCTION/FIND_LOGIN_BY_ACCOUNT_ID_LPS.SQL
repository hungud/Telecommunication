
  CREATE OR REPLACE FUNCTION "CORP_MOBILE"."FIND_LOGIN_BY_ACCOUNT_ID_LPS" (
  pACCOUNT_ID IN number
  ) RETURN VARCHAR2 IS
  RES ACCOUNTS.LOGIN%TYPE;
--#Version=1
BEGIN
  SELECT LOGIN
    INTO RES
    FROM ACCOUNTS acc
    WHERE acc.account_id=pACCOUNT_ID;
  RETURN RES;
EXCEPTION WHEN NO_DATA_FOUND THEN
  RAISE_APPLICATION_ERROR(-20500, 'LOGIN NOT FOUND');

END;
