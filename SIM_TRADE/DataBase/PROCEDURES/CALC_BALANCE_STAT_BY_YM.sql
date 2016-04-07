CREATE OR REPLACE PROCEDURE CALC_BALANCE_STAT_BY_YM(
  pPHONE_NUMBER IN VARCHAR2,
  pBALANCE_DATE IN DATE DEFAULT NULL,
  pYEAR_MONTH IN INTEGER,
  pBALANCE IN OUT NUMBER,
  pCHARGES IN OUT NUMBER,
  pABON IN OUT NUMBER,
  pABON_BE IN OUT NUMBER,
  pUSL IN OUT NUMBER,
  pBILLS IN OUT NUMBER,
  pBILL_AB IN OUT NUMBER,
  pBILL_AB_BE IN OUT NUMBER,
  pBILL_USL IN OUT NUMBER 
  ) IS
--#Version=1
  DATE_ROWS DBMS_SQL.DATE_TABLE; 
  COST_ROWS DBMS_SQL.NUMBER_TABLE; 
  DESCRIPTION_ROWS DBMS_SQL.VARCHAR2_TABLE;
  vRESULT NUMBER(15, 2);
  L BINARY_INTEGER;
  vBALANCE_DATE DATE;
  vDAYS integer;
  vCODE VARCHAR2(20 CHAR);
  vSUM VARCHAR2(20 CHAR);
  vACT NUMBER;
  vABON INTEGER;  
  FUNCTION TO_NUM(RES IN VARCHAR2) RETURN NUMBER IS
    ITOG NUMBER(15,4);  
    vRES VARCHAR2(15 CHAR);
    BEGIN    
      vRES:=REPLACE(RES, ',', '.');
      BEGIN
        ITOG:=TO_NUMBER(vRES);
      EXCEPTION
        WHEN OTHERS THEN
          ITOG:=TO_NUMBER(REPLACE(vRES, '.', ','));
      END;
      RETURN ITOG;
    END;
BEGIN
  pBALANCE:=0;
  pCHARGES:=0;
  pABON:=0;
  pABON_BE:=0;
  pUSL:=0;
  pBILLS:=0;
  pBILL_AB:=0;
  pBILL_AB_BE:=0;
  pBILL_USL:=0;
  vBALANCE_DATE:=pBALANCE_DATE;
  select last_day(to_date(pYEAR_MONTH, 'yyyymm'))-to_date(pYEAR_MONTH, 'yyyymm')+1 into vDAYS from dual;
  CALC_BALANCE_ROWS2(pPHONE_NUMBER, DATE_ROWS, COST_ROWS, DESCRIPTION_ROWS, TRUE, vBALANCE_DATE);
  L := COST_ROWS.LAST;
  IF L IS NOT NULL THEN
    FOR I IN COST_ROWS.FIRST..L LOOP
      pBALANCE := pBALANCE + COST_ROWS(I);
      IF (TO_CHAR(TRUNC(DATE_ROWS(I)),'YYYYMM')=TO_CHAR(pYEAR_MONTH)) AND (COST_ROWS(I) < 0) THEN
        pCHARGES := pCHARGES + COST_ROWS(I);        
        IF INSTR(DESCRIPTION_ROWS(I), '��������� (') > 0 THEN
          pABON := pABON + COST_ROWS(I);
          if pABON_BE <> -1 then
            vCODE:=SUBSTR(DESCRIPTION_ROWS(I), INSTR(DESCRIPTION_ROWS(I), '(') + 1,  INSTR(DESCRIPTION_ROWS(I), ',') - INSTR(DESCRIPTION_ROWS(I), '(') - 1);
            vSUM:=SUBSTR(DESCRIPTION_ROWS(I), INSTR(DESCRIPTION_ROWS(I), '(', 1, 2) + 1,  INSTR(DESCRIPTION_ROWS(I), ' ', INSTR(DESCRIPTION_ROWS(I), '(', 1, 2)) - INSTR(DESCRIPTION_ROWS(I), '(', 1, 2) - 1);            
            IF INSTR(DESCRIPTION_ROWS(I), '��������') > 0 THEN 
              vACT:=1;
            ELSE
              vACT:=0.5;
            END IF;            
            vABON:= -1;
            SELECT TID INTO vABON
              FROM TEMP4
              WHERE STR1 = vCODE
                AND ROWNUM <=1;
            IF (vABON <> -1) AND (vABON IS NOT NULL) THEN
              pABON_BE:=pABON_BE + vACT * (vABON/vDAYS) * (COST_ROWS(I)/TO_NUM(vSUM));
            ELSE
              pABON_BE:= -1;
            END IF;
          end if;
        END IF;       
        IF INSTR(DESCRIPTION_ROWS(I), '��������� �� ������') > 0 THEN
          pUSL := pUSL + COST_ROWS(I);
        END IF;
      END IF;
    END LOOP;
  END IF;
  SELECT -SUM(V.BILL_SUM_NEW), -SUM(V.ABON_TP_NEW), -SUM(V.ABON_TP_OLD), -SUM(V.ABON_ADD_NEW) INTO pBILLS, pBILL_AB, pBILL_AB_BE, pBILL_USL 
    FROM V_BILL_FINANCE_FOR_CLIENTS V
    WHERE V.PHONE_NUMBER = pPHONE_NUMBER
      AND V.YEAR_MONTH = pYEAR_MONTH;
  pBALANCE:=ROUND(pBALANCE, 4);
  pCHARGES:=ROUND(pCHARGES, 4);
  pABON:=ROUND(pABON, 4);
  pABON_BE:=ROUND(pABON_BE, 4);
  pUSL:=ROUND(pUSL, 4);
  pBILLS:=ROUND(pBILLS, 4);
  pBILL_AB:=ROUND(pBILL_AB, 4);
  pBILL_AB_BE:=ROUND(pBILL_AB_BE, 4);
  pBILL_USL:=ROUND(pBILL_USL, 4);
END;
/