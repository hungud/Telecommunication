
  CREATE OR REPLACE FUNCTION "SIM_TRADE"."NEW_DOP_STATUS_ID" RETURN NUMBER IS
--#Version=1
  vRES NUMBER;
BEGIN
  SELECT S_NEW_DOP_STATUS_ID.NEXTVAL
    INTO vRES
    FROM DUAL;
  RETURN vRES;
END; 