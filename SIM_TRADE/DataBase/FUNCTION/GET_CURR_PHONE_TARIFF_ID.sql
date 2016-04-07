CREATE OR REPLACE FUNCTION GET_CURR_PHONE_TARIFF_ID(
  pPHONE_NUMBER IN VARCHAR2
  ) RETURN INTEGER IS
--
--Version = 2
--
--2. 12.11.2014. Крайнов. Поправка на верный код тарифа.
--Овсянников 23.01.2012 Определение текущего ID тарифа
  pCONTRACT_CANCEL_DATE date;
  pTARIFF_ID INTEGER;
  pTARIFF_CODE VARCHAR2(30 CHAR);
  NDF int;
  vRESULT INTEGER;
BEGIN
  BEGIN
    NDF := 0;
    SELECT CONTRACT_CANCEL_DATE, TARIFF_ID INTO pCONTRACT_CANCEL_DATE,pTARIFF_ID 
      FROM V_CONTRACTS
      WHERE CONTRACT_CANCEL_DATE is null
        and PHONE_NUMBER_FEDERAL=pPHONE_NUMBER;  
  EXCEPTION 
    WHEN TOO_MANY_ROWS THEN 
      NDF := 2;
    WHEN NO_DATA_FOUND THEN 
      BEGIN 
        NDF := 1;
      END;
  END;
  -- если договор расторгнут, то 
  IF (NDF=1) OR (NDF=2) THEN
    IF NDF=1 THEN  
      vRESULT:=-1;
    ELSE 
      vRESULT:=-2;
    END IF; 
  ELSE
    IF pCONTRACT_CANCEL_DATE IS NOT NULL THEN 
      vRESULT:=-1;
    ELSE
      /*select tariff_code INTO pTARIFF_CODE 
        from tariffs 
        where TARIFF_ID=pTARIFF_ID;*/
      BEGIN
        SELECT D.CELL_PLAN_CODE INTO pTARIFF_CODE 
          FROM DB_LOADER_ACCOUNT_PHONES D 
          WHERE D.YEAR_MONTH = TO_NUMBER(TO_CHAR(SYSDATE, 'YYYYMM'))
            AND D.PHONE_NUMBER = pPHONE_NUMBER
            AND ROWNUM <= 1;
      EXCEPTION 
        WHEN NO_DATA_FOUND THEN 
          pTARIFF_CODE := '';
      END;          
      vRESULT:= GET_PHONE_TARIFF_ID(pPHONE_NUMBER, pTARIFF_CODE , sysdate);
    END IF;
  END IF;
  RETURN vRESULT;
END;
/
