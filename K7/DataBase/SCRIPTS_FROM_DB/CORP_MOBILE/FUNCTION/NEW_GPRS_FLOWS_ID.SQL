
  CREATE OR REPLACE FUNCTION "CORP_MOBILE"."NEW_GPRS_FLOWS_ID" RETURN NUMBER IS
--#Version=1
  vRES NUMBER;
BEGIN
  SELECT GPRS_FLOWS_ID.NEXTVAL
  INTO vRES
  FROM DUAL;
  RETURN vRES;
END;