
  CREATE OR REPLACE FUNCTION "CORP_MOBILE"."NEW_COUNTRY_ID" RETURN NUMBER IS
--#Version=1
  vRES NUMBER;
BEGIN
  SELECT S_NEW_COUNTRY_ID.NEXTVAL
  INTO vRES
  FROM DUAL;
  RETURN vRES;
END; 