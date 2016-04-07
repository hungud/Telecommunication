CREATE OR REPLACE FUNCTION CALC_KOMISSIYA_OPTIONS(
  pPHONE_NUMBER IN VARCHAR2,
  pYEAR_MONTH IN INTEGER,
  pDATE_BEGIN IN DATE,
  pDATE_END IN DATE,
  pADD_ABON_OPT IN NUMBER,
  pABON IN NUMBER,
  pVOSVART IN NUMBER
  ) RETURN NUMBER IS
--
-- Version=1
--
CURSOR C IS
  SELECT CONTRACTS.CONTRACT_DATE
    FROM CONTRACTS
    WHERE CONTRACTS.PHONE_NUMBER_FEDERAL=pPHONE_NUMBER
    ORDER BY CONTRACTS.CONTRACT_DATE DESC;
ITOG NUMBER(13, 2);
MIN_END DATE;
MAX_BEGIN DATE;
TEXT VARCHAR2(2000);
DATE_CONTRACT DATE;
COST_ABON NUMBER(13, 2);
COST_TURN NUMBER(13, 2);
COST_FULL_ABON NUMBER(13, 2);
COST_OPT_OPERATOR NUMBER(13, 2);
KOEF_ACT number;
BEGIN
  COST_ABON:=0;
  COST_TURN:=0;
  COST_FULL_ABON:=0;
  COST_OPT_OPERATOR:=
    CASE                  
      WHEN pVOSVART < 0 THEN 
        pADD_ABON_OPT 
          * (pABON + pADD_ABON_OPT + pVOSVART)
          / (pABON + pADD_ABON_OPT)
      ELSE pADD_ABON_OPT
    END;
  ITOG:=0;
  KOEF_ACT:=
    CASE                  
      WHEN pADD_ABON_OPT > 0 THEN COST_OPT_OPERATOR/pADD_ABON_OPT
      ELSE 0
    END; 
  IF KOEF_ACT>1 THEN
    KOEF_ACT:=1;
  END IF;  
  OPEN C;
  FETCH C INTO DATE_CONTRACT;
  IF C%NOTFOUND THEN 
    DATE_CONTRACT:=NULL;
  END IF; 
  CLOSE C; 
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
           TARIFF_OPTIONS.KOEF_KOMISS     
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
            OR (TARIFF_OPTION_COSTS.END_DATE IS NULL))) 
  LOOP           
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
      COST_ABON:=COST_ABON+NVL(rec.MONTHLY_COST,0)*NVL(rec.KOEF_KOMISS, 0);   
    END IF;
    COST_FULL_ABON:=COST_FULL_ABON+NVL(rec.OPERATOR_MONTHLY_COST,0);
    IF pDATE_BEGIN<=rec.TURN_ON_DATE THEN
      COST_TURN:=COST_TURN+NVL(rec.TURN_ON_COST,0);
    END IF;           
  END LOOP; 
  IF (PVOSVART=0)AND(COST_FULL_ABON<>0) THEN 
    KOEF_ACT:=PADD_ABON_OPT/COST_FULL_ABON;
  END IF;
  ITOG:=ITOG+COST_ABON*KOEF_ACT;
  RETURN ITOG;
END;
/  

--GRANT EXECUTE ON CALC_KOMISSIYA_OPTIONS TO CORP_MOBILE_ROLE;

--GRANT EXECUTE ON CALC_KOMISSIYA_OPTIONS TO CORP_MOBILE_ROLE_RO;