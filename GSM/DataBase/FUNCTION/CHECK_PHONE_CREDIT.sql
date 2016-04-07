CREATE OR REPLACE FUNCTION CHECK_PHONE_CREDIT(
  pPHONE_NUMBER IN VARCHAR,
  pCHECK_DATE IN DATE
  ) RETURN INTEGER IS
--
--#Version=2
--
-- 2. 08.11.2012 Уколов. Ускорил открывание запроса, добавил CLOSE CURSOR.
--06.04.2012 Крайнов. Проверка кредитности договора по номеру и дате.  
CURSOR C IS
  SELECT V.IS_CREDIT_CONTRACT
    FROM ((SELECT c.contract_date,
          c.phone_number_federal,
          c.is_credit_contract,
          (SELECT ccs.contract_cancel_date
             FROM contract_cancels ccs
            WHERE ccs.contract_id = c.contract_id
              AND ROWNUM < 2) contract_cancel_date
     FROM contracts c)) V  
    WHERE V.PHONE_NUMBER_FEDERAL=pPHONE_NUMBER
      AND V.CONTRACT_DATE<=pCHECK_DATE
      AND (V.CONTRACT_CANCEL_DATE>=pCHECK_DATE
            OR V.CONTRACT_CANCEL_DATE IS NULL);
DUMMY C%ROWTYPE;            
ITOG INTEGER;
BEGIN
  OPEN C;
  FETCH C INTO DUMMY;
  IF C%FOUND THEN 
    ITOG:=DUMMY.IS_CREDIT_CONTRACT;
  ELSE
    ITOG:=0;
  END IF;
  CLOSE C;
  RETURN ITOG;
END;           