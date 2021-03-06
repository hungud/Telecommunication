
  CREATE OR REPLACE FUNCTION "SIM_TRADE"."GET_NEW_FULL_FINANCE_ABON_TP" (
  pACCOUNT_ID IN INTEGER,
  pYEAR_MONTH IN INTEGER,
  pPHONE_NUMBER IN VARCHAR2
  ) RETURN NUMBER IS
--Version=2
  CURSOR C IS
    SELECT AP.*
      FROM V_BILL_ABON_PER_FOR_CLIENT AP
      WHERE AP.ACCOUNT_ID = pACCOUNT_ID
        AND AP.YEAR_MONTH = pYEAR_MONTH
        AND AP.PHONE_NUMBER = pPHONE_NUMBER;
  ITOG NUMBER(15, 4);      
BEGIN 
  ITOG:=0;
  FOR rec IN C LOOP
    ITOG:=ITOG + rec.ABON_MAIN;
  END LOOP;
  RETURN ITOG;
END;

--GRANT EXECUTE ON GET_NEW_FULL_FINANCE_ABON_TP TO SIM_TRADE_ROLE;

--GRANT EXECUTE ON GET_NEW_FULL_FINANCE_ABON_TP TO LONTANA_ROLE;

--GRANT EXECUTE ON GET_NEW_FULL_FINANCE_ABON_TP TO CORP_MOBILE_ROLE; 