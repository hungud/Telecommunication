
  CREATE OR REPLACE FUNCTION "LONTANA"."NEW_TARIFF_OPT_GROUP_COST_ID" RETURN NUMBER IS
--#Version=1
  vRES NUMBER;
BEGIN
  SELECT S_NEW_TARIFF_OPT_GROUP_COST_ID.NEXTVAL
  INTO vRES
  FROM DUAL;
  RETURN vRES;
END; 