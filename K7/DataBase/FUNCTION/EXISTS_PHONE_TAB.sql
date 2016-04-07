create or replace function EXISTS_PHONE_TAB(pphone            in varchar2,
                                            pPHONE_LIST_ARRAY in TPHONE_LIST_ARRAY)
  return number is

BEGIN
  FOR i IN pPHONE_LIST_ARRAY.FIRST .. pPHONE_LIST_ARRAY.LAST LOOP
    if pPHONE_LIST_ARRAY(i).p = pphone then
      return 1;
    end if;
  END LOOP;
  return 0;
END;
/
