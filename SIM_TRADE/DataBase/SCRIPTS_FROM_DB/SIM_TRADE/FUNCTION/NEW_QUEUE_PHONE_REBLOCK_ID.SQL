
  CREATE OR REPLACE FUNCTION "SIM_TRADE"."NEW_QUEUE_PHONE_REBLOCK_ID" RETURN NUMBER IS
--#Version=1
  vRES NUMBER;
BEGIN
  SELECT S_NEW_QUEUE_PHONE_REBLOCK_ID.NEXTVAL
  INTO vRES
  FROM DUAL;
  RETURN vRES;
END; 