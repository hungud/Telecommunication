
  CREATE OR REPLACE PROCEDURE "SIM_TRADE"."BEELINE_BS_ZONE_CLEAR" (
  pZONE_NAME IN VARCHAR2
  ) IS
--#Version=1
BEGIN
  DELETE FROM BEELINE_BS_ZONES
  WHERE BEELINE_BS_ZONES.ZONE_NAME=pZONE_NAME;
END; 