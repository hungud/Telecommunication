CREATE OR REPLACE FUNCTION WWW_GET_PHONE_DETAIL(
  pCONTRACT_ID IN INTEGER,
  pYEAR_MONTH IN INTEGER
  ) RETURN CLOB IS
--#Version=1
CURSOR C IS
  SELECT CONTRACTS.PHONE_NUMBER_FEDERAL
    FROM CONTRACTS
    WHERE pCONTRACT_ID=CONTRACTS.CONTRACT_ID;
    
vPHONE_NUMBER CONTRACTS.PHONE_NUMBER_FEDERAL%TYPE;          
BEGIN
  OPEN C;
  FETCH C INTO vPHONE_NUMBER;
  CLOSE C;
  RETURN LOADER3_PCKG.GET_PHONE_DETAIL(TRUNC(pYEAR_MONTH/100),(pYEAR_MONTH-TRUNC(pYEAR_MONTH,-2)),vPHONE_NUMBER);
END;
/

GRANT EXECUTE ON WWW_GET_PHONE_DETAIL TO LONTANA_WWW;
/       