CREATE OR REPLACE FUNCTION GET_ABONENT_BALANCE(
  pPHONE_NUMBER IN VARCHAR2,
  pBALANCE_DATE IN DATE DEFAULT NULL,
  pIOT_BALANCE IN VARCHAR2 DEFAULT null
  ) RETURN NUMBER IS
--#Version=3
--
--v3 Афросин 21.08.2015 - убрал проблему с прыгающей копейкой
--                       убрал мусор  
--
  PRAGMA AUTONOMOUS_TRANSACTION;
  CURSOR C IS
    SELECT *
      FROM DB_LOADER_ACCOUNT_PHONES AP
      WHERE AP.ACCOUNT_ID = 225
        AND AP.YEAR_MONTH = TO_CHAR(SYSDATE, 'YYYYMM')
        AND AP.PHONE_NUMBER = pPHONE_NUMBER;
  DUMMY C%ROWTYPE;
  DATE_ROWS DBMS_SQL.DATE_TABLE; 
  COST_ROWS DBMS_SQL.NUMBER_TABLE; 
  DESCRIPTION_ROWS DBMS_SQL.VARCHAR2_TABLE;
  vRESULT NUMBER(15, 4);
  L BINARY_INTEGER;
  vBALANCE_DATE DATE;
BEGIN
  vRESULT := 0;
  vBALANCE_DATE:=pBALANCE_DATE;

  IF (NVL(pBALANCE_DATE, SYSDATE)>=TO_DATE('28122012', 'DDMMYYYY'))AND(NVL(pBALANCE_DATE, SYSDATE)<=TO_DATE('01012013', 'DDMMYYYY')) THEN  
    vBALANCE_DATE:=TO_DATE('01012013', 'DDMMYYYY');      
  END IF;
  
  OPEN C;
  FETCH C INTO DUMMY;
  IF NOT(C%FOUND) THEN
    CALC_BALANCE_ROWS2(pPHONE_NUMBER, DATE_ROWS, COST_ROWS, DESCRIPTION_ROWS, true, vBALANCE_DATE);
    L := COST_ROWS.LAST;
    IF L IS NOT NULL THEN
      FOR I IN COST_ROWS.FIRST..L LOOP
        vRESULT := vRESULT + COST_ROWS(I);
      END LOOP;
    END IF;
  ELSE
--    READ_BALANCE_EKO(pPHONE_NUMBER);
    ECOMOBILE_PCKG.GETPAYMENTS(pPHONE_NUMBER);
    select sum(ROW_COST) into vRESULT
      from ABONENT_BALANCE_ROWS;
  END IF;
  close c;
  
  vRESULT := round(vRESULT, 2);
  
  if  pIOT_BALANCE is null then
      IF pBALANCE_DATE IS NULL THEN
        UPDATE IOT_CURRENT_BALANCE CB
          SET CB.BALANCE = vRESULT,
              CB.LAST_UPDATE = SYSDATE,
              CB.UPDATE_TYPE = 2
          WHERE CB.PHONE_NUMBER = pPHONE_NUMBER;
        IF SQL%ROWCOUNT=0 THEN 
            INSERT INTO IOT_CURRENT_BALANCE (
                                              PHONE_NUMBER,
                                              BALANCE,
                                              LAST_UPDATE,UPDATE_TYPE
                                            )
                                     VALUES (
                                              pPHONE_NUMBER,
                                              vRESULT,
                                              SYSDATE, 
                                              2
                                            );
        END IF;  
        COMMIT;
      END IF;
  END IF;
  
  RETURN vRESULT;
END;
