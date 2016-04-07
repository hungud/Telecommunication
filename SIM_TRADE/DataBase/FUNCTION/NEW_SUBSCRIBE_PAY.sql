CREATE OR REPLACE FUNCTION NEW_SUBSCRIBE_PAY(
  pPHONE_NUMBER IN VARCHAR2,
  pADD_COST IN INTEGER,
  pYEAR_MONTH IN INTEGER
  ) RETURN NUMBER IS
--
--Vresion=1
--
--12.10.2011 �������. ��������.
CURSOR C IS
  SELECT CONTRACTS.CONTRACT_DATE
    FROM CONTRACTS
    WHERE CONTRACTS.PHONE_NUMBER_FEDERAL=pPHONE_NUMBER
    ORDER BY CONTRACTS.CONTRACT_DATE DESC;
ADD_COST NUMBER(12, 2); 
ITOG NUMBER(12, 2);   
MONTH_BEGIN DATE;
MONTH_END DATE;
COUNT_DAYS INTEGER;
LAST_DAY_PERIOD DATE;
DATE_CONTRACT DATE;
BEGIN
  OPEN C;
  FETCH C INTO DATE_CONTRACT;
  IF C%NOTFOUND THEN 
    DATE_CONTRACT:=NULL;
  END IF; 
  CLOSE C;
  ITOG:=0;
  MONTH_BEGIN:=TRUNC(TO_DATE(TO_CHAR(pYEAR_MONTH)||'01','YYYYMMDD'));
  MONTH_END:=TRUNC(LAST_DAY(MONTH_BEGIN));
  COUNT_DAYS:=0;
  LAST_DAY_PERIOD:=TRUNC(TO_DATE('19861124','YYYYMMDD'));
  FOR rec IN(
    SELECT DB_LOADER_ACCOUNT_PHONE_HISTS.BEGIN_DATE,
           DB_LOADER_ACCOUNT_PHONE_HISTS.END_DATE
      FROM DB_LOADER_ACCOUNT_PHONE_HISTS
      WHERE DB_LOADER_ACCOUNT_PHONE_HISTS.PHONE_NUMBER=pPHONE_NUMBER
        AND DB_LOADER_ACCOUNT_PHONE_HISTS.PHONE_IS_ACTIVE=1
        AND DB_LOADER_ACCOUNT_PHONE_HISTS.BEGIN_DATE<=MONTH_END
        AND DB_LOADER_ACCOUNT_PHONE_HISTS.END_DATE>=MONTH_BEGIN
        AND ((DATE_CONTRACT IS NULL)
              OR(DB_LOADER_ACCOUNT_PHONE_HISTS.END_DATE>=DATE_CONTRACT))
    )
  LOOP
    IF rec.BEGIN_DATE<MONTH_BEGIN THEN
      rec.BEGIN_DATE:=MONTH_BEGIN;
    END IF;
    IF rec.END_DATE>MONTH_END THEN
      rec.END_DATE:=MONTH_END;
    END IF;  
    IF (DATE_CONTRACT IS NOT NULL)AND(DATE_CONTRACT>rec.BEGIN_DATE) THEN
      rec.BEGIN_DATE:=DATE_CONTRACT;
    END IF; 
    COUNT_DAYS:=COUNT_DAYS+TRUNC(to_number(to_char(rec.END_DATE,'dd'))-to_number(to_char(rec.BEGIN_DATE,'dd')))+1;
    IF TRUNC(rec.BEGIN_DATE)=LAST_DAY_PERIOD THEN
      COUNT_DAYS:=COUNT_DAYS-1;
    END IF;    
    LAST_DAY_PERIOD:=TRUNC(rec.END_DATE);
  END LOOP;
  ITOG:=pADD_COST*COUNT_DAYS/(MONTH_END-MONTH_BEGIN+1);   
  RETURN ITOG;
END;
/  