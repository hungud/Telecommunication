
  CREATE OR REPLACE FUNCTION "LONTANA"."NEW_CONTRACT_CHANGE_ID" RETURN NUMBER IS
--#Version=1
  vRES NUMBER;
BEGIN
  SELECT S_NEW_CONTRACT_CHANGE_ID.NEXTVAL
  INTO vRES
  FROM DUAL;
  RETURN vRES;
END; 