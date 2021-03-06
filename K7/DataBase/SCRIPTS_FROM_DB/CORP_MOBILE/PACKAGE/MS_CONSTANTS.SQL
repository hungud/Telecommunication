
  CREATE OR REPLACE PACKAGE "CORP_MOBILE"."MS_CONSTANTS" AS
--
--#Version=4
--
-- Крайнов. Добавли индескное кэширование, без проверки даты.
-- Крайнов. Добавление кэширования результатов GET_CONSTANT_VALUE(помним про права на пакет DBMS_RESULT_CACHE под SYS).
--
-- Получить значение константы
--
  FUNCTION GET_CONSTANT_VALUE(
    CONSTANT_NAME VARCHAR2
    ) RETURN VARCHAR2;
--
-- Установить значение константы (возвращает 0 если такой константы нет)
--
  FUNCTION SET_CONSTANT_VALUE(
    CONSTANT_NAME VARCHAR2, 
    CONSTANT_VALUE VARCHAR2
    ) RETURN INTEGER;
--
-- Добавить константу
--
  PROCEDURE NEW_CONSTANT(
    CONSTANT_NAME VARCHAR2, 
    CONSTANT_VALUE VARCHAR2,
    CONSTANT_DESCR VARCHAR2, 
    CONSTANT_TYPE VARCHAR2,
    pPAGE_NAME VARCHAR2 DEFAULT NULL, 
    pORDER_NUMBER INTEGER DEFAULT NULL, 
    pCAPTION VARCHAR2 DEFAULT NULL
    );
--
END; 
CREATE OR REPLACE PACKAGE BODY "CORP_MOBILE"."MS_CONSTANTS" AS
--
  vCACHE_EXPIRATION_DATE NUMBER;
  TYPE T_CACHE_ARRAY IS TABLE OF VARCHAR(256) INDEX BY VARCHAR2(30);
  vCACHE_ARRAY T_CACHE_ARRAY;
--
  PROCEDURE REFRESH_CACHE IS
  BEGIN 
    vCACHE_ARRAY.DELETE;
    FOR rec IN (SELECT C.NAME, C.VALUE
                  FROM CONSTANTS C)
    LOOP
      vCACHE_ARRAY(rec.NAME):=rec.VALUE;
    END LOOP;
    vCACHE_EXPIRATION_DATE:=DBMS_UTILITY.get_time + 300;  -- Время устаревания 3с, время в сотых секудны
  END; 
--
  FUNCTION GET_CONSTANT_VALUE(
    CONSTANT_NAME VARCHAR2
    ) RETURN VARCHAR2 IS
    S VARCHAR2(256);
  BEGIN
    IF DBMS_UTILITY.get_time > vCACHE_EXPIRATION_DATE THEN
      REFRESH_CACHE;
    END IF;
    RETURN vCACHE_ARRAY(CONSTANT_NAME);
  EXCEPTION 
    WHEN NO_DATA_FOUND THEN
      vCACHE_ARRAY(CONSTANT_NAME) := NULL;
      RETURN NULL;
  END;
--
-- Установить значение константы
--
  FUNCTION SET_CONSTANT_VALUE(
    CONSTANT_NAME VARCHAR2, 
    CONSTANT_VALUE VARCHAR2
    ) RETURN INTEGER IS
  BEGIN
    UPDATE CONSTANTS SET VALUE = CONSTANT_VALUE WHERE NAME = CONSTANT_NAME;
      RETURN (TO_CHAR(SQL%ROWCOUNT));
  EXCEPTION
    WHEN NO_DATA_FOUND THEN
      RETURN (NULL);
  END;
--
-- Добавить константу
--
  PROCEDURE NEW_CONSTANT(
    CONSTANT_NAME VARCHAR2, 
    CONSTANT_VALUE VARCHAR2,
    CONSTANT_DESCR VARCHAR2, 
    CONSTANT_TYPE VARCHAR2,
    pPAGE_NAME VARCHAR2 DEFAULT NULL, 
    pORDER_NUMBER INTEGER DEFAULT NULL, 
    pCAPTION VARCHAR2 DEFAULT NULL
    ) IS
  BEGIN
    INSERT INTO CONSTANTS(CONSTANT_ID, NAME, DESCR, TYPE, 
                          VALUE, PAGE_NAME, ORDER_NUMBER, CAPTION)
      VALUES(New_Constant_Id, CONSTANT_NAME, CONSTANT_DESCR, CONSTANT_TYPE, 
             CONSTANT_VALUE, pPAGE_NAME, pORDER_NUMBER, pCAPTION);
  END;
--
BEGIN
  REFRESH_CACHE;
END; 