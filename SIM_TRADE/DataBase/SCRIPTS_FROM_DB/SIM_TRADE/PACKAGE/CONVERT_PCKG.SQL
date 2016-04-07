
  CREATE OR REPLACE PACKAGE "SIM_TRADE"."CONVERT_PCKG" AS
--
--#Version=2
-- 02.10.14 Матюнин. Добавлена функция MONTH_NAME, которая возвращает наименование месяца по его номеру.
-- 23.07.13 Крайнов. Создание пакета.
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
END; 
CREATE OR REPLACE PACKAGE BODY "SIM_TRADE"."CONVERT_PCKG" AS
--
  FUNCTION TIMESTAMP_TZ_TO_DATE(
    pTIME_TZ IN VARCHAR2
    ) RETURN DATE IS
    vDATE DATE;
  BEGIN
    vDATE:=CAST(to_timestamp_tz(pTIME_TZ, 'yyyy-mm-dd"T"hh24:mi:ss tzh:tzm') AS DATE);
    RETURN vDATE;
  END;
--
  FUNCTION TIMESTAMP_TZ_TO_STRING_TZ(
    pTIME_TZ IN VARCHAR2
    ) RETURN VARCHAR2 IS
    vSTRING_TZ VARCHAR2(200 CHAR);
  BEGIN
    vSTRING_TZ:=TO_CHAR(to_timestamp_tz(pTIME_TZ, 'yyyy-mm-dd"T"hh24:mi:ss tzh:tzm'), 'DD.MM.YYYY HH24:MI:SS TZH:TZM');
    RETURN vSTRING_TZ;
  END; 
--      
  FUNCTION STRING_TO_NUMBER(
    pSTRING IN VARCHAR2
    ) RETURN NUMBER IS
    pCOST  VARCHAR2(20);
    vNEW_COST NUMBER;  
  BEGIN
    BEGIN
        pCOST := REPLACE (pSTRING, '.', ',');
        vNEW_COST := TO_NUMBER (pCOST);
    EXCEPTION
    WHEN OTHERS THEN
        pCOST := REPLACE (pCOST, ',', '.');
        vNEW_COST := TO_NUMBER (pCOST);
    END;
    RETURN vNEW_COST;    
  END;
--  
  FUNCTION MONTH_NAME(
    pNUM_MONTH IN NUMBER  
    ) RETURN VARCHAR2 IS
    vMONTH_NAME VARCHAR2 (15 CHAR);
  BEGIN
    --vMONTH_NAME := select DECODE(pNUM_MONTH, 1, 'январь', 2, 'февраль', 3, 'март', 4, 'апрель', 5, 'май', 6, 'июнь', 7, 'июль', 8, 'август', 9, 'сентябрь', 10, 'октябрь', 11, 'ноябрь', 12, 'декабрь') from dual;
    case  
      when pNUM_MONTH = 1 then vMONTH_NAME := 'январь';
      when pNUM_MONTH = 2 then vMONTH_NAME := 'февраль';
      when pNUM_MONTH = 3 then vMONTH_NAME := 'март';
      when pNUM_MONTH = 4 then vMONTH_NAME := 'апрель'; 
      when pNUM_MONTH = 5 then vMONTH_NAME := 'май'; 
      when pNUM_MONTH = 6 then vMONTH_NAME := 'июнь'; 
      when pNUM_MONTH = 7 then vMONTH_NAME := 'июль'; 
      when pNUM_MONTH = 8 then vMONTH_NAME := 'август'; 
      when pNUM_MONTH = 9 then vMONTH_NAME := 'сентябрь'; 
      when pNUM_MONTH = 10 then vMONTH_NAME := 'октябрь'; 
      when pNUM_MONTH = 11 then vMONTH_NAME := 'ноябрь'; 
      when pNUM_MONTH = 12 then vMONTH_NAME := 'декабрь';
      else null;
    end case;  
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
      vNEW_ID:=DUMMY.STATUS_ID;
    ELSE
      IF (pSTATUS_CODE IS NULL) OR (LENGTH(PSTATUS_CODE) = 0) THEN
        vNEW_ID:=NULL;
      ELSE   
        INSERT INTO BEELINE_STATUS_CODE(STATUS_CODE, IS_ACTIVE, IS_CONSERVATION, IS_SYSTEM_BLOCK, ACCESS_BLOCK, ACCESS_UNLOCK)
          VALUES(                      pSTATUS_CODE, 1,         0,               0,               0,            0);
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
END; 