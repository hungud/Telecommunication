CREATE OR REPLACE FUNCTION CHECK_DAY_ACTIV_BY_PHONE(
  pPHONE_NUMBER IN VARCHAR2,
  pCHECK_DATE IN DATE
  ) RETURN INTEGER IS
  CURSOR C IS 
    SELECT 1
      FROM db_loader_account_phone_hists H
      WHERE H.PHONE_NUMBER = pPHONE_NUMBER
        AND H.PHONE_IS_ACTIVE = 1
        AND H.END_DATE >= TRUNC(pCHECK_DATE) + 1/24/60/60
        AND H.BEGIN_DATE <= TRUNC(pCHECK_DATE+1) - 1/24/60/60;
  DUMMY C%ROWTYPE;      
BEGIN
  OPEN C;
  FETCH C INTO DUMMY;
  IF C%FOUND THEN 
    RETURN 1;
  ELSE
    RETURN 0;
  END IF;
  CLOSE C;
END;  