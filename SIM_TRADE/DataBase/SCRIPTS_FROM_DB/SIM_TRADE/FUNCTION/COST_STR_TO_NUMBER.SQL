
  CREATE OR REPLACE FUNCTION "SIM_TRADE"."COST_STR_TO_NUMBER" (COST_STR VARCHAR2)
   RETURN NUMBER
--
--#Version= 1
--
-- Преобразуем строку с ценой в численное значение
--
AS
   pCOST       VARCHAR2 (20);
   vNEW_COST   NUMBER;
BEGIN
   BEGIN
      pCOST := REPLACE (COST_STR, '.', ',');
      vNEW_COST := TO_NUMBER (pCOST);
   EXCEPTION
      WHEN OTHERS
      THEN
         pCOST := REPLACE (pCOST, ',', '.');
         vNEW_COST := TO_NUMBER (pCOST);
   END;

   RETURN vNEW_COST;
END;