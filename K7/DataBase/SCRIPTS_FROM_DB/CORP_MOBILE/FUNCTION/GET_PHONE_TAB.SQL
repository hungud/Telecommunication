
  CREATE OR REPLACE FUNCTION "CORP_MOBILE"."GET_PHONE_TAB" (pPHONE_LIST_ARRAY in DBMS_SQL.VARCHAR2_TABLE)
  return TPHONE_LIST_ARRAY
  PIPELINED AS

BEGIN
  FOR i IN pPHONE_LIST_ARRAY.FIRST .. pPHONE_LIST_ARRAY.LAST LOOP
        PIPE ROW(PHONE_LIST_ARRAYT(pPHONE_LIST_ARRAY(i)));

  END LOOP;
  RETURN;
END;
