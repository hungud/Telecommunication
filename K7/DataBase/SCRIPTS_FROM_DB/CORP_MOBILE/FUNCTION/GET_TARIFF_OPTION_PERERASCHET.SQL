
  CREATE OR REPLACE FUNCTION "CORP_MOBILE"."GET_TARIFF_OPTION_PERERASCHET" (
  pPHONE_NUMBER IN VARCHAR2,
  pDATE_BEGIN IN DATE,
  pDATE_END IN DATE,
  pYEAR_MONTH IN INTEGER,
  pTARIFF_CODE IN VARCHAR2,
  pADD_ABON_OPT IN NUMBER,
  pOPTIONS IN VARCHAR2 DEFAULT NULL
  ) RETURN NUMBER IS
--Version=7
CURSOR C IS
  SELECT CONTRACTS.CONTRACT_DATE
    FROM CONTRACTS
    WHERE CONTRACTS.PHONE_NUMBER_FEDERAL=pPHONE_NUMBER
    ORDER BY CONTRACTS.CONTRACT_DATE DESC;
CURSOR H IS
  SELECT DB_LOADER_ACCOUNT_PHONE_HISTS.CELL_PLAN_CODE
    FROM DB_LOADER_ACCOUNT_PHONE_HISTS
    WHERE DB_LOADER_ACCOUNT_PHONE_HISTS.PHONE_NUMBER=pPHONE_NUMBER
      AND DB_LOADER_ACCOUNT_PHONE_HISTS.BEGIN_DATE<=pDATE_END
      AND DB_LOADER_ACCOUNT_PHONE_HISTS.END_DATE>=pDATE_END;
ITOG NUMBER(12,2);
COST_TURN NUMBER(12,2);
COST_ABON NUMBER(12,2);
COST_FULL_ABON NUMBER(12,2);
pTARIFF_ID INTEGER;
MIN_END DATE;
MAX_BEGIN DATE;
TEXT VARCHAR2(2000);
DATE_CONTRACT DATE;
vTARIFF_CODE VARCHAR2(30 CHAR);
DUMMY VARCHAR2(30 CHAR);
vTARIFF_ID INTEGER;
BEGIN
  IF pTARIFF_CODE IS NULL THEN
    OPEN H;
    FETCH H INTO DUMMY;
    CLOSE H;
    vTARIFF_CODE:=DUMMY;
  ELSE
    vTARIFF_CODE:=pTARIFF_CODE;
  END IF;
  ITOG:=0;
  COST_ABON:=0;
  COST_TURN:=0;
  COST_FULL_ABON:=0;
  OPEN C;
  FETCH C INTO DATE_CONTRACT;
  IF C%NOTFOUND THEN 
    DATE_CONTRACT:=NULL;
  END IF; 
  CLOSE C;
  vTARIFF_ID:=GET_PHONE_TARIFF_ID(pPHONE_NUMBER, vTARIFF_CODE, pDATE_END);
  FOR rec IN(
    SELECT TARIFF_OPTION_COSTS.TARIFF_OPTION_COST_ID,
           TARIFF_OPTION_COSTS.BEGIN_DATE,
           TARIFF_OPTION_COSTS.END_DATE,
           TARIFF_OPTION_COSTS.TURN_ON_COST,
           TARIFF_OPTION_COSTS.MONTHLY_COST,
           TARIFF_OPTION_COSTS.OPERATOR_TURN_ON_COST,
           TARIFF_OPTION_COSTS.OPERATOR_MONTHLY_COST,
           DB_LOADER_ACCOUNT_PHONE_OPTS.TURN_ON_DATE,
           DB_LOADER_ACCOUNT_PHONE_OPTS.TURN_OFF_DATE,
           DB_LOADER_ACCOUNT_PHONE_OPTS.OPTION_CODE,
           TARIFF_OPTIONS.CALC_UNBLOCK     
      FROM DB_LOADER_ACCOUNT_PHONE_OPTS, TARIFF_OPTIONS, TARIFF_OPTION_COSTS
      WHERE DB_LOADER_ACCOUNT_PHONE_OPTS.PHONE_NUMBER=pPHONE_NUMBER
        AND DB_LOADER_ACCOUNT_PHONE_OPTS.YEAR_MONTH=pYEAR_MONTH
        AND DB_LOADER_ACCOUNT_PHONE_OPTS.TURN_ON_DATE<=pDATE_END
        AND ((DB_LOADER_ACCOUNT_PHONE_OPTS.TURN_OFF_DATE>=pDATE_BEGIN)
            OR (DB_LOADER_ACCOUNT_PHONE_OPTS.TURN_OFF_DATE IS NULL))
        AND DB_LOADER_ACCOUNT_PHONE_OPTS.OPTION_CODE=TARIFF_OPTIONS.OPTION_CODE
        AND TARIFF_OPTIONS.TARIFF_OPTION_ID=TARIFF_OPTION_COSTS.TARIFF_OPTION_ID
        AND TARIFF_OPTION_COSTS.BEGIN_DATE<=pDATE_END
        AND ((TARIFF_OPTION_COSTS.END_DATE>=pDATE_BEGIN)
            OR (TARIFF_OPTION_COSTS.END_DATE IS NULL))
  ) LOOP    
    IF (INSTR(pOPTIONS, rec.OPTION_CODE)>0)OR(pOPTIONS IS NULL) THEN
      IF INSTR(pOPTIONS, rec.OPTION_CODE)>0 THEN
        FOR NEW_COST IN(
        SELECT TARIFF_OPTION_NEW_COST.TURN_ON_COST,
               TARIFF_OPTION_NEW_COST.MONTHLY_COST,
               TARIFF_OPTION_NEW_COST.TARIFF_ID,
               TARIFF_OPTION_COSTS.BEGIN_DATE 
          FROM TARIFF_OPTION_NEW_COST, TARIFF_OPTION_COSTS
          WHERE rec.TARIFF_OPTION_COST_ID=TARIFF_OPTION_NEW_COST.TARIFF_OPTION_COST_ID
            AND TARIFF_OPTION_COSTS.BEGIN_DATE<=pDATE_END
            AND ((TARIFF_OPTION_COSTS.END_DATE>=pDATE_BEGIN)
                OR (TARIFF_OPTION_COSTS.END_DATE IS NULL))
            AND TARIFF_OPTION_NEW_COST.DATE_CREATED<=TARIFF_OPTION_COSTS.END_DATE
            AND TARIFF_OPTION_NEW_COST.TARIFF_ID = vTARIFF_ID
          ORDER BY TARIFF_OPTION_COSTS.BEGIN_DATE DESC) 
        LOOP
          IF (pOPTIONS is null)OR(INSTR(pOPTIONS, rec.OPTION_CODE)>0) THEN
            rec.TURN_ON_COST:=NEW_COST.TURN_ON_COST;
          END IF;  
          IF (pOPTIONS is null)OR(INSTR(pOPTIONS, rec.OPTION_CODE)>0) THEN
            rec.MONTHLY_COST:=NEW_COST.MONTHLY_COST;
          END IF;   
          EXIT;
        END LOOP;
      END IF;
      
      IF rec.BEGIN_DATE>pDATE_BEGIN THEN
        MAX_BEGIN:=rec.BEGIN_DATE;
      ELSE
        MAX_BEGIN:=pDATE_BEGIN;
      END IF;   
      IF rec.TURN_ON_DATE>MAX_BEGIN THEN
        MAX_BEGIN:=rec.TURN_ON_DATE;
      END IF;  
       
      IF NVL(rec.END_DATE,TO_DATE('31.12.2200','DD.MM.YYYY'))<pDATE_END THEN
        MIN_END:=rec.END_DATE;
      ELSE
        MIN_END:=pDATE_END;
      END IF; 
      IF NVL(rec.TURN_OFF_DATE,TO_DATE('31.12.2200','DD.MM.YYYY'))<MIN_END THEN
        MIN_END:=rec.TURN_OFF_DATE;
      END IF; 
      IF (MAX_BEGIN<=MIN_END)
          AND(DATE_CONTRACT IS NOT NULL)
          AND(DATE_CONTRACT<MIN_END) THEN
        COST_ABON:=COST_ABON+(NVL(rec.MONTHLY_COST,0)-NVL(rec.OPERATOR_MONTHLY_COST,0))*((MIN_END-MAX_BEGIN+1)/(pDATE_END-pDATE_BEGIN+1));   
      END IF;
      COST_FULL_ABON:=COST_FULL_ABON+NVL(rec.OPERATOR_MONTHLY_COST,0);
      IF pDATE_BEGIN<=rec.TURN_ON_DATE THEN
        COST_TURN:=COST_TURN+NVL(rec.TURN_ON_COST,0)-NVL(rec.OPERATOR_TURN_ON_COST,0);
      END IF;           
    END IF;
  END LOOP; 
  IF (COST_FULL_ABON<pADD_ABON_OPT)or(COST_FULL_ABON=0) THEN
    ITOG:=COST_TURN+COST_ABON;
  ELSE
    ITOG:=COST_TURN+COST_ABON; --*pADD_ABON_OPT/COST_FULL_ABON;
  END IF;
  RETURN ITOG;
END; 