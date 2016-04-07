CREATE OR REPLACE FUNCTION GET_TARIFF_GUID(
  pPHONE_NUMBER VARCHAR2
  ) RETURN VARCHAR2 IS
  CURSOR C IS
    SELECT T.PHONE_NUMBER_FEDERAL, 
           T.TARIFF_ID, 
           TARIFFS.TARIFF_CODE_CRM
      FROM (SELECT C.PHONE_NUMBER_FEDERAL,
                   (SELECT GET_PHONE_TARIFF_ID(DB_LOADER_ACCOUNT_PHONES.PHONE_NUMBER,
                                               DB_LOADER_ACCOUNT_PHONES.CELL_PLAN_CODE,
                                               DB_LOADER_ACCOUNT_PHONES.LAST_CHECK_DATE_TIME)
                      FROM DB_LOADER_ACCOUNT_PHONES
                      WHERE DB_LOADER_ACCOUNT_PHONES.PHONE_NUMBER = C.PHONE_NUMBER_FEDERAL
                        AND ROWNUM <= 1
                        AND (DB_LOADER_ACCOUNT_PHONES.YEAR_MONTH = (SELECT MAX (T2.YEAR_MONTH)
                                                                      FROM DB_LOADER_ACCOUNT_PHONES T2
                                                                      WHERE T2.PHONE_NUMBER = C.PHONE_NUMBER_FEDERAL))
                   ) AS TARIFF_ID                  
              FROM V_CONTRACTS C
              WHERE C.CONTRACT_CANCEL_DATE IS NULL) T, TARIFFS
      WHERE T.TARIFF_ID = TARIFFS.TARIFF_ID
        AND t.PHONE_NUMBER_FEDERAL = pPHONE_NUMBER;
  vDUMMY C%ROWTYPE;      
  ITOG VARCHAR2(200 CHAR);
BEGIN
  OPEN C;
  FETCH C INTO vDUMMY;
  IF C%FOUND THEN
    ITOG:=vDUMMY.TARIFF_CODE_CRM;
  ELSE
    ITOG:='Not Found';    
  END IF;
  CLOSE C;
  RETURN ITOG;
END;

CREATE OR REPLACE SYNONYM WWW_DEALER.GET_TARIFF_GUID FOR GET_TARIFF_GUID