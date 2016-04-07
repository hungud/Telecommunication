
  CREATE OR REPLACE FUNCTION "LONTANA"."RECALC_CHARGE_COST" (
  PHONE_NUMBER IN VARCHAR2,
  COSTS IN NUMBER
  ) RETURN NUMBER IS
-- Version=1
--Начисление некоего процента к стоимости 
--
-- 1.Крайнов. Создание
BEGIN
  RETURN COSTS*1;
END; 