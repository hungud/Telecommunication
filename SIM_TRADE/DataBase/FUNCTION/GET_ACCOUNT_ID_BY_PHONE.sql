CREATE OR REPLACE FUNCTION GET_ACCOUNT_ID_BY_PHONE(
  pPHONE_NUMBER IN VARCHAR2
  ) RETURN INTEGER IS
--Vesion=1  
CURSOR C IS 
  SELECT DB_LOADER_ACCOUNT_PHONES.ACCOUNT_ID
    FROM DB_LOADER_ACCOUNT_PHONES
    WHERE DB_LOADER_ACCOUNT_PHONES.PHONE_NUMBER=pPHONE_NUMBER
    ORDER BY DB_LOADER_ACCOUNT_PHONES.LAST_CHECK_DATE_TIME DESC;    
DUMMY NUMBER(13, 2);     
ITOG NUMBER(13, 2);     
BEGIN
  OPEN C;
  FETCH C INTO DUMMY;
  IF C%FOUND THEN 
    ITOG:=DUMMY;
  ELSE
    ITOG:=0;
  END IF;
  CLOSE C;
  RETURN ITOG;
END;

GRANT EXECUTE ON GET_ACCOUNT_ID_BY_PHONE TO LONTANA_ROLE;
GRANT EXECUTE ON GET_ACCOUNT_ID_BY_PHONE TO CORP_MOBILE_ROLE;
GRANT EXECUTE ON GET_ACCOUNT_ID_BY_PHONE TO CORP_MOBILE_ROLE_RO;
GRANT EXECUTE ON GET_ACCOUNT_ID_BY_PHONE TO CORP_MOBILE_LK;
