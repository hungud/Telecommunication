
  CREATE OR REPLACE PROCEDURE "CORP_MOBILE"."CALC_BALANCE_ROWS" (
  pPHONE_NUMBER IN VARCHAR2,
  pBALANCE_DATE IN DATE DEFAULT NULL
  ) IS
--#Version=14
-- Не учитываем историю изменения условий тарифов (нет данных)
--
  DATE_ROWS DBMS_SQL.DATE_TABLE; 
  COST_ROWS DBMS_SQL.NUMBER_TABLE; 
  DESCRIPTION_ROWS DBMS_SQL.VARCHAR2_TABLE;
  vRESULT NUMBER(15, 2);
  L BINARY_INTEGER;
BEGIN
  DELETE FROM ABONENT_BALANCE_ROWS; -- быстрее чем TRUNCATE
  CALC_BALANCE_ROWS2(pPHONE_NUMBER, DATE_ROWS, COST_ROWS, DESCRIPTION_ROWS, TRUE, pBALANCE_DATE);
  L := COST_ROWS.LAST;
  IF L IS NOT NULL THEN
    FORALL I IN COST_ROWS.FIRST..L 
      INSERT INTO ABONENT_BALANCE_ROWS (ROW_DATE, ROW_COST, ROW_COMMENT)
      VALUES (DATE_ROWS(I), COST_ROWS(I), DESCRIPTION_ROWS(I));
  END IF;
END;