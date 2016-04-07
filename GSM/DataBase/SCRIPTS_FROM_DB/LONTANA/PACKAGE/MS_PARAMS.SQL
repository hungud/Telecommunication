
  CREATE OR REPLACE PACKAGE "LONTANA"."MS_PARAMS" 
AS
   --
   --#Version=3
   --
   -- 19.02.2015 Афросин.Добавил процедуру получения занчений из таблицы REF_TEXT   
   -- 23.07.13 Крайнов. Добавление кэширования GET_PARAM_VALUE(помним про права на пакет DBMS_RESULT_CACHE под SYS).
   --
   TYPE num_vars_t IS TABLE OF NUMBER
      INDEX BY VARCHAR2 (64);

   num_vars   num_vars_t;

   --
   FUNCTION get_num_var (p_name VARCHAR2)
      RETURN NUMBER;

   --
   PROCEDURE set_num_var (p_name VARCHAR2, p_value NUMBER);

   --
   -- Получить значение константы
   --
   FUNCTION GET_PARAM_VALUE (PARAM_NAME VARCHAR2)
      RETURN VARCHAR2
      RESULT_CACHE;

   --
   -- Установить значение константы (возвращает 0 если такой константы нет)
   --
   FUNCTION SET_PARAM_VALUE (PARAM_NAME VARCHAR2, PARAM_VALUE VARCHAR2)
      RETURN INTEGER;

   --
   -- Добавить константу
   --
   PROCEDURE NEW_PARAM (PARAM_NAME     VARCHAR2,
                        PARAM_VALUE    VARCHAR2,
                        PARAM_DESCR    VARCHAR2,
                        PARAM_TYPE     VARCHAR2);
--
--PRAGMA RESTRICT_REFERENCES (GET_PARAM_VALUE, WNDS, WNPS );
--
   --
   -- Получить значение параметра из REF_TEXT
   --

 FUNCTION GET_REF_TEXT_VALUE (pREF_TEXT_NAME VARCHAR2)
      RETURN VARCHAR2 RESULT_CACHE;
      
END;
CREATE OR REPLACE PACKAGE BODY "LONTANA"."MS_PARAMS" AS
--
-- 23.10.2012 г. А. Пискунов Добавлены функции для работы с кэшированными переменными пакета

  function get_num_var(
    p_name varchar2
    ) return number is
  begin
      return num_vars(p_name);
  end;
--  
  procedure set_num_var(
    p_name varchar2, 
    p_value number
    ) is
  begin
      num_vars(p_name) := p_value;
  end;
--
  FUNCTION GET_PARAM_VALUE(
    PARAM_NAME VARCHAR2
    ) RETURN VARCHAR2 RESULT_CACHE RELIES_ON(PARAMS) IS
  S VARCHAR2(600);
  BEGIN
    SELECT VALUE INTO S FROM PARAMS WHERE NAME = PARAM_NAME;
      RETURN (S);
  EXCEPTION
    WHEN NO_DATA_FOUND THEN
      RETURN (NULL);
  END;
--
-- Установить значение константы
--
  FUNCTION SET_PARAM_VALUE(
    PARAM_NAME VARCHAR2, 
    PARAM_VALUE VARCHAR2
    ) RETURN INTEGER IS
  BEGIN
    UPDATE PARAMS SET VALUE = PARAM_VALUE WHERE NAME = PARAM_NAME;
      RETURN (TO_CHAR(SQL%ROWCOUNT));
  EXCEPTION
    WHEN NO_DATA_FOUND THEN
      RETURN (NULL);
  END;
--
-- Добавить константу
--
  PROCEDURE NEW_PARAM(
    PARAM_NAME VARCHAR2, 
    PARAM_VALUE VARCHAR2,
    PARAM_DESCR VARCHAR2, 
    PARAM_TYPE VARCHAR2
    ) IS
  BEGIN
    INSERT INTO PARAMS(PARAM_ID, NAME, DESCR, TYPE, VALUE)
      VALUES(s_new_param_id.nextval, PARAM_NAME, PARAM_DESCR, PARAM_TYPE, PARAM_VALUE);
  END;
  
  --
-- Получить значение параметра из REF_TEXT
--
FUNCTION GET_REF_TEXT_VALUE (pREF_TEXT_NAME VARCHAR2)
  RETURN VARCHAR2  RESULT_CACHE RELIES_ON(REF_TEXT) IS
  S VARCHAR2(100);
begin
  SELECT REF_TEXT_VALUE INTO S FROM REF_TEXT WHERE REF_TEXT_NAME = pREF_TEXT_NAME;
      RETURN (S);
  EXCEPTION
    WHEN NO_DATA_FOUND THEN
      RETURN (NULL);
end;   
-- 07.11.12 г. А. Пискунов Одноразовая процедура, вызывается один раз при первом вызове пакета
BEGIN 

  Ms_PARAMs.set_num_var('CRIT_SMS_COUNT', GET_PARAM_VALUE('CRIT_SMS_COUNT'));
       
END;