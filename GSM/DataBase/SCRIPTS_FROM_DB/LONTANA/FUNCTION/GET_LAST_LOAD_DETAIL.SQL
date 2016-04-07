
  CREATE OR REPLACE FUNCTION "LONTANA"."GET_LAST_LOAD_DETAIL" (MSISDN IN VARCHAR2,
                                                LYEAR  IN VARCHAR2,
                                                LMONTH IN VARCHAR2)
  RETURN date IS
  RES date;
  --#Version=1
BEGIN
  select dlp.last_check_date_time
    into res
    from db_loader_phone_stat dlp
   where dlp.phone_number = MSISDN
     and dlp.year_month = to_number(LYEAR || LMONTH);
  RETURN RES;
EXCEPTION
  WHEN others THEN
    return to_date('31.12.2000', 'dd.mm.yyyy');
END;
