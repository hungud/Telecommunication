
  CREATE OR REPLACE FUNCTION "LONTANA"."COST_STR_TO_NUMBER" (COST_STR varchar2) Return Number
--
--#Version= 1
--
-- Преобразуем строку с ценой в численное значение
--
as
    pCOST  varchar2(20);
    vNEW_COST number;  
begin
    BEGIN
        pCOST := REPLACE (COST_STR, '.', ',');
        vNEW_COST := TO_NUMBER (pCOST);
    EXCEPTION
    WHEN OTHERS THEN
        pCOST := REPLACE (pCOST, ',', '.');
        vNEW_COST := TO_NUMBER (pCOST);
    END;
    Return vNEW_COST;
end;