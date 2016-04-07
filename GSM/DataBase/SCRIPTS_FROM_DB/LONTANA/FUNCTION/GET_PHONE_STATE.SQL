
  CREATE OR REPLACE FUNCTION "LONTANA"."GET_PHONE_STATE" (P_number in varchar2) return number is
  Result number;
begin
  select dbl.phone_is_active into Result from db_loader_account_phones dbl where
               P_number=dbl.phone_number
               and dbl.last_check_date_time =(select max(m.last_check_date_time)
                                              from DB_LOADER_ACCOUNT_PHONES m
                                              where m.phone_number=P_number and m.year_month=to_char(sysdate,'YYYYMM'));
  return(Result);
exception
  when no_data_found then return(null);
end get_phone_state;

