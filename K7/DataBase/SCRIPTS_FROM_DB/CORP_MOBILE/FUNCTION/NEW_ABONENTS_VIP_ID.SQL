
  CREATE OR REPLACE FUNCTION "CORP_MOBILE"."NEW_ABONENTS_VIP_ID" RETURN NUMBER IS
--#Version=1
  vRES NUMBER;
BEGIN
  SELECT s_NEW_abonents_vip_ID.NEXTVAL
  INTO vRES
  FROM DUAL;
  RETURN vRES;
END; 
