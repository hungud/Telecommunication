CREATE OR REPLACE FUNCTION WWW_GET_USER_ID(
  pPHONE_NUMBER IN VARCHAR2, 
  pPASSWORD IN VARCHAR2
  ) RETURN INTEGER IS
--#Version=1
CURSOR C IS
  SELECT CONTRACT_ID
    FROM CONTRACTS
    WHERE PHONE_NUMBER_FEDERAL=pPHONE_NUMBER 
    AND USER_PASSWORD=pPASSWORD
    ;
vUSER_ID CONTRACTS.CONTRACT_ID%TYPE;      
BEGIN
  vUSER_ID:=NULL;
  OPEN C;
  FETCH C INTO vUSER_ID;
  CLOSE C;
  RETURN vUSER_ID; 
END;
/

GRANT EXECUTE ON WWW_GET_USER_ID TO LONTANA_WWW;
/       