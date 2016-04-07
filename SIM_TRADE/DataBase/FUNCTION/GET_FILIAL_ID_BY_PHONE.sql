CREATE OR REPLACE FUNCTION GET_FILIAL_ID_BY_PHONE(
  pPHONE_NUMBER IN VARCHAR
  ) RETURN INTEGER IS 
  CURSOR C IS
    SELECT A.FILIAL_ID
      FROM ACCOUNTS A,
           DB_LOADER_ACCOUNT_PHONES D
      WHERE A.ACCOUNT_ID = D.ACCOUNT_ID
        AND D.YEAR_MONTH = TO_NUMBER(TO_CHAR(SYSDATE, 'yyyymm'))
        AND D.PHONE_NUMBER = pPHONE_NUMBER;
  DUMMY C%ROWTYPE;      
BEGIN
  OPEN C;
  FETCH C INTO DUMMY;
  IF C%FOUND THEN
    RETURN DUMMY.FILIAL_ID;
  ELSE
    RETURN 0;
  END IF;
  CLOSE C;
END;

GRANT EXECUTE ON GET_FILIAL_ID_BY_PHONE TO LONTANA_ROLE;