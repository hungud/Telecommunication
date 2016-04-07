
  CREATE OR REPLACE FUNCTION "LONTANA"."GET_CURR_PHONE_TARIFF_ID" (
  pPHONE_NUMBER IN VARCHAR2
  ) RETURN INTEGER IS
  pCONTRACT_CANCEL_DATE date;
  pTARIFF_CODE VARCHAR2(30 CHAR);
  NDF int;
  vRESULT INTEGER;
--
--Version=4
--
--4. Крайнов. 2015.08.12 Причесал текст.
--3. Афросин 20.05.2015 переделал получение текущего ID тарифа
--2. 12.11.2014. Крайнов. Поправка на верный код тарифа.
--Овсянников 23.01.2012 Определение текущего ID тарифа
BEGIN
  vRESULT:=0;
  BEGIN
    NDF := 0;
    Select CONTRACT_CANCEL_DATE 
      INTO pCONTRACT_CANCEL_DATE 
      FROM v_contracts
      WHERE CONTRACT_CANCEL_DATE is null
        and PHONE_NUMBER_FEDERAL=pPHONE_NUMBER;  
  EXCEPTION 
    WHEN TOO_MANY_ROWS THEN 
      NDF := 2;
    WHEN NO_DATA_FOUND THEN 
      NDF := 1;
  END;
  -- если договор расторгнут, то 
  IF (NDF=1) OR (NDF=2) THEN
    IF NDF=1 THEN 
      vRESULT:=-1;
    ELSE 
      vRESULT:=-2;
    END IF; 
  ELSE
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
    vRESULT:=GET_PHONE_TARIFF_ID(pPHONE_NUMBER, pTARIFF_CODE, sysdate);
  END IF;
  RETURN vRESULT;
END; 