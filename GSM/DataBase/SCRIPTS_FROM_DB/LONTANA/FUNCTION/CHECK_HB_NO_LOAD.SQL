
  CREATE OR REPLACE FUNCTION "LONTANA"."CHECK_HB_NO_LOAD" (pPHONE_NUMBER IN VARCHAR2)
  RETURN INTEGER IS
  C integer;
BEGIN
  select count(*)
    into C
    from (SELECT regexp_substr(str, '[^,]+', 1, level) str
            FROM (SELECT MS_params.GET_PARAM_VALUE('HOT_BILL_NO_LOAD_ACCOUNT_ID') str
                    FROM dual) t
          CONNECT BY instr(str, ',', 1, level - 1) > 0) tt
   where tt.str = to_char(get_account_id_by_phone(pPHONE_NUMBER));
  RETURN C;
EXCEPTION
  WHEN OTHERS THEN
    RETURN 0;
END;
