
  CREATE OR REPLACE FUNCTION "CORP_MOBILE"."NEW_TAS_CONTACT_ID" RETURN NUMBER IS
--#Version=1
  vRES NUMBER;
BEGIN
  SELECT S_NEW_TAS_CONTACT_ID.NEXTVAL
  INTO vRES
  FROM DUAL;
  RETURN vRES;
END; 