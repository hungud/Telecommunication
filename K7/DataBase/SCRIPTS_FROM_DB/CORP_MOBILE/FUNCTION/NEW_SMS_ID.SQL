
  CREATE OR REPLACE FUNCTION "CORP_MOBILE"."NEW_SMS_ID" RETURN INTEGER IS
--#Version=1
  vRES NUMBER;
BEGIN
  SELECT S_NEW_SMS_ID.NEXTVAL
    INTO vRES
    FROM DUAL;
  RETURN vRES;
END; 