
  CREATE OR REPLACE FUNCTION "SIM_TRADE"."NEW_CONTRACT_CANCEL_TYPE_ID" RETURN NUMBER IS
--#Version=1
  vRES NUMBER;
BEGIN
  SELECT S_NEW_CONTRACT_CANCEL_TYPE_ID.NEXTVAL
  INTO vRES
  FROM DUAL;
  RETURN vRES;
END; 