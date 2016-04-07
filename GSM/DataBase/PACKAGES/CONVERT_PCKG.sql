CREATE OR REPLACE PACKAGE CONVERT_PCKG AS
--
--#Version=5
-- v5 26.05.2015  очнев, првоер€ющий ћатюнин. «адача #2885 добавлена ф-€ TIME_TO_MIN(pTIME IN VARCHAR2) RETURN VARCHAR2 принимает время в формате '03:12:34' 
-- и преобразует в минуты, где 3 секунды = уже минута    
-- 27.11.14 јфросин. ƒобавлена функци€ YEAR_MONTH_NAME, котора€ возвращает название мес€ца и год, в зависимости от переданных параметров. 
-- 18.11.14  райнов. ƒобавил GET_IS_COLLECTOR_BY_PHONE и GET_ACCOUNT_ID_BY_PHONE
-- 02.10.14 ћатюнин. ƒобавлена функци€ MONTH_NAME, котора€ возвращает наименование мес€ца по его номеру.
-- 23.07.13  райнов. —оздание пакета.
--
  FUNCTION TIMESTAMP_TZ_TO_DATE(
    pTIME_TZ IN VARCHAR2
    ) RETURN DATE;  
--      
  FUNCTION TIMESTAMP_TZ_TO_STRING_TZ(
    pTIME_TZ IN VARCHAR2
    ) RETURN VARCHAR2;  
--      
  FUNCTION STRING_TO_NUMBER(
    pSTRING IN VARCHAR2
    ) RETURN NUMBER; 
--
  FUNCTION MONTH_NAME(
    pNUM_MONTH IN NUMBER  
    ) RETURN VARCHAR2;
--    
  FUNCTION STATUS_CODE_TO_STATUS_ID(
    pSTATUS_CODE IN VARCHAR2  
    ) RETURN INTEGER;
--    
  FUNCTION GET_IS_COLLECTOR_BY_PHONE(
    pPHONE_NUMBER IN VARCHAR2  
    ) RETURN INTEGER;
--    
  FUNCTION GET_ACCOUNT_ID_BY_PHONE(
    pPHONE_NUMBER IN VARCHAR2
    ) RETURN INTEGER;
--
  FUNCTION YEAR_MONTH_NAME(
    pYEAR_MONTH IN NUMBER,
    pPARAM_STR IN VARCHAR2 DEFAULT 'mmyyyy'  
    ) RETURN VARCHAR2;
--       
 FUNCTION TIME_TO_MIN(
    pTIME IN VARCHAR2  
    ) RETURN VARCHAR2;
--    
END;
/

CREATE OR REPLACE PACKAGE BODY CONVERT_PCKG AS
   --
  FUNCTION TIMESTAMP_TZ_TO_DATE(
    pTIME_TZ IN VARCHAR2
    ) RETURN DATE IS
  vDATE DATE;
  BEGIN
    vDATE :=CAST(TO_TIMESTAMP_TZ (pTIME_TZ, 'yyyy-mm-dd"T"hh24:mi:ss tzh:tzm') AS DATE);
    RETURN vDATE;
  END;
   --
  FUNCTION TIMESTAMP_TZ_TO_STRING_TZ(
    pTIME_TZ IN VARCHAR2
    ) RETURN VARCHAR2 IS
    vSTRING_TZ   VARCHAR2 (200 CHAR);
  BEGIN
    vSTRING_TZ:=TO_CHAR(TO_TIMESTAMP_TZ (pTIME_TZ, 'yyyy-mm-dd"T"hh24:mi:ss tzh:tzm'),
                        'DD.MM.YYYY HH24:MI:SS TZH:TZM');
    RETURN vSTRING_TZ;
  END;
   --
  FUNCTION STRING_TO_NUMBER(
    pSTRING IN VARCHAR2
    ) RETURN NUMBER IS
    pCOST VARCHAR2 (20);
    vNEW_COST NUMBER;
  BEGIN
    BEGIN
      pCOST := REPLACE(pSTRING, '.', ',');
      vNEW_COST := TO_NUMBER(pCOST);
    EXCEPTION
      WHEN OTHERS THEN
        pCOST := REPLACE(pCOST, ',', '.');
        vNEW_COST := TO_NUMBER(pCOST);
    END;
    RETURN vNEW_COST;
  END;
   --
  FUNCTION MONTH_NAME(
    pNUM_MONTH IN NUMBER
    ) RETURN VARCHAR2 IS
    vMONTH_NAME   VARCHAR2 (15 CHAR);
  BEGIN
    --vMONTH_NAME := select DECODE(pNUM_MONTH, 1, '€нварь', 2, 'февраль', 3, 'март', 4, 'апрель', 5, 'май', 6, 'июнь', 7, 'июль', 8, 'август', 9, 'сент€брь', 10, 'окт€брь', 11, 'но€брь', 12, 'декабрь') from dual;
    CASE
      WHEN pNUM_MONTH = 1 THEN vMONTH_NAME := '€нварь';
      WHEN pNUM_MONTH = 2 THEN vMONTH_NAME := 'февраль';
      WHEN pNUM_MONTH = 3 THEN vMONTH_NAME := 'март';
      WHEN pNUM_MONTH = 4 THEN vMONTH_NAME := 'апрель';
      WHEN pNUM_MONTH = 5 THEN vMONTH_NAME := 'май';
      WHEN pNUM_MONTH = 6 THEN vMONTH_NAME := 'июнь';
      WHEN pNUM_MONTH = 7 THEN vMONTH_NAME := 'июль';
      WHEN pNUM_MONTH = 8 THEN vMONTH_NAME := 'август';
      WHEN pNUM_MONTH = 9 THEN vMONTH_NAME := 'сент€брь';
      WHEN pNUM_MONTH = 10 THEN vMONTH_NAME := 'окт€брь';
      WHEN pNUM_MONTH = 11 THEN vMONTH_NAME := 'но€брь';
      WHEN pNUM_MONTH = 12 THEN vMONTH_NAME := 'декабрь';
      ELSE NULL;
    END CASE;
    RETURN vMONTH_NAME;
  END;
   --
  FUNCTION STATUS_CODE_TO_STATUS_ID(
  pSTATUS_CODE IN VARCHAR2
  ) RETURN INTEGER IS
  PRAGMA AUTONOMOUS_TRANSACTION;
  CURSOR C IS
  SELECT BEELINE_STATUS_CODE.STATUS_ID
  FROM BEELINE_STATUS_CODE
  WHERE BEELINE_STATUS_CODE.STATUS_CODE = pSTATUS_CODE;
  DUMMY C%ROWTYPE;
  vNEW_ID INTEGER;
  BEGIN
    OPEN C;
    FETCH C INTO DUMMY;
    IF C%FOUND THEN
      vNEW_ID := DUMMY.STATUS_ID;
    ELSE
      IF (pSTATUS_CODE IS NULL) OR (LENGTH (PSTATUS_CODE) = 0) THEN
        vNEW_ID := NULL;
      ELSE
        INSERT INTO BEELINE_STATUS_CODE (STATUS_CODE, IS_ACTIVE, IS_CONSERVATION, IS_SYSTEM_BLOCK, ACCESS_BLOCK, ACCESS_UNLOCK)
          VALUES (pSTATUS_CODE, 1, 0, 0, 0, 0);
      END IF;
      COMMIT;
      SELECT BEELINE_STATUS_CODE.STATUS_ID INTO vNEW_ID
        FROM BEELINE_STATUS_CODE
        WHERE BEELINE_STATUS_CODE.STATUS_CODE = pSTATUS_CODE;
    END IF;
    CLOSE C;
    RETURN vNEW_ID;
  END;
   --
  FUNCTION GET_IS_COLLECTOR_BY_PHONE(
    pPHONE_NUMBER IN VARCHAR2
    ) RETURN INTEGER IS
  --Vesion=1
  CURSOR C IS
    SELECT NVL(AC.IS_COLLECTOR, 0) IS_COLLECTOR
      FROM DB_LOADER_ACCOUNT_PHONES D, ACCOUNTS AC
      WHERE D.PHONE_NUMBER = pPHONE_NUMBER
        AND D.ACCOUNT_ID = AC.ACCOUNT_ID(+)
      ORDER BY D.LAST_CHECK_DATE_TIME DESC;
  DUMMY   NUMBER (13, 2);
  ITOG    NUMBER (13, 2);
  BEGIN
    OPEN C;
    FETCH C INTO DUMMY;
    IF C%FOUND THEN
      ITOG := DUMMY;
    ELSE
      ITOG := 0;
    END IF;
    CLOSE C;
    RETURN ITOG;
  END;
   --
  FUNCTION GET_ACCOUNT_ID_BY_PHONE(
    pPHONE_NUMBER IN VARCHAR2
    ) RETURN INTEGER IS
  --Vesion=1
  CURSOR C IS
    SELECT DB_LOADER_ACCOUNT_PHONES.ACCOUNT_ID
      FROM DB_LOADER_ACCOUNT_PHONES
      WHERE DB_LOADER_ACCOUNT_PHONES.PHONE_NUMBER = pPHONE_NUMBER
      ORDER BY DB_LOADER_ACCOUNT_PHONES.LAST_CHECK_DATE_TIME DESC;
  DUMMY   NUMBER (13, 2);
  ITOG    NUMBER (13, 2);
  BEGIN
    OPEN C;
    FETCH C INTO DUMMY;
    IF C%FOUND THEN
      ITOG := DUMMY;
    ELSE
      ITOG := 0;
    END IF;
    CLOSE C;
    RETURN ITOG;
  END;
  --
  FUNCTION YEAR_MONTH_NAME(
    pYEAR_MONTH IN NUMBER,
    pPARAM_STR IN VARCHAR2 DEFAULT 'mmyyyy'
    ) RETURN VARCHAR2 IS
  res varchar2(50);
  yyyy integer;
  mm integer;
  BEGIN
--pPARAM_STR = yyyymm - сначала идет год потом идет мес€ц
--pPARAM_STR = mmyyyy - сначала идет мес€ц потом год
    yyyy := TRUNC(pYEAR_MONTH/100);    
    mm := (pYEAR_MONTH / 100 - yyyy) * 100; 
    res := MONTH_NAME(mm);    
    case pPARAM_STR
      when 'yyyymm' then res:= to_char(yyyy) ||' '|| res;
      else res:= res ||' '|| to_char(yyyy);
    end case;    
    RETURN res;
  END;
  
 FUNCTION TIME_TO_MIN(pTIME IN VARCHAR2) RETURN VARCHAR2 
 IS
   ch Integer;
   mn integer;
   sc integer;
   min_char varchar2(15 char);
 begin
   min_char := 'не определено';
   ch:=0; 
   mn:=0; 
   sc:=0;
   if ((instr(pTIME, ':',1,1) > 0) and (instr(pTIME, ':',1,2) > 0)) then 
       
     ch := to_number(trim(to_char(to_date(pTIME,'HH24:MI:SS'),'HH24')));
     mn := to_number(trim(to_char(to_date(pTIME,'HH24:MI:SS'),'MI')));
     sc := to_number(trim(to_char(to_date(pTIME,'HH24:MI:SS'),'SS'))); 
     
     if (sc > 3) then
       mn := mn + 1;
     end if;
                     
     if (ch > 0) then
       mn := mn + (ch*60);
     end if;                
     
     min_char := to_char(mn);  
   end if;
   
   RETURN min_char;
 end;  
  
END;
/
