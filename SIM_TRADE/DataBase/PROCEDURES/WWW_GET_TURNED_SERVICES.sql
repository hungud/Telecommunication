CREATE OR REPLACE PROCEDURE WWW_GET_TURNED_SERVICES(
  pUSER_ID IN INTEGER,
  pNAME_OPT_ROWS OUT DBMS_SQL.VARCHAR2_TABLE,
  pDATE_ROWS OUT DBMS_SQL.DATE_TABLE 
--  pMONTHLY_COST_ROWS OUT DBMS_SQL.NUMBER_TABLE 
  ) IS
--#Version=1 
CURSOR C IS
SELECT *
  FROM V_TURNED_SERVICES
  WHERE pUSER_ID=USER_ID;
I INTEGER;  
BEGIN
  FOR rec IN C LOOP
    I:=pNAME_OPT_ROWS.COUNT+1;
    pNAME_OPT_ROWS(I):=rec.OPTION_NAME;
    pDATE_ROWS(I):=rec.TURN_ON_DATE;
--    pMONTHLY_COST_ROWS(I):=rec.MONTHLY_COST;
  END LOOP;
END;  
    
GRANT EXECUTE ON WWW_GET_TURNED_SERVICES TO LONTANA_WWW;  