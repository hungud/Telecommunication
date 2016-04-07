CREATE OR REPLACE PROCEDURE HOT_BILLING_CHECK IS
  flag       integer;
  SMS        VARCHAR2(2000);
  phone_num  varchar2(11);
  v_username varchar2(50);
  cursor curp is
    SELECT regexp_substr(str, '[^,]+', 1, level) str
      FROM (SELECT MS_params.GET_PARAM_VALUE('PHONE_NOTICE_HOT_BILL_ERROR') str
              FROM dual) t
    CONNECT BY instr(str, ',', 1, level - 1) > 0;
begin
  select case
           when max(to_date(substr(hbf.file_name, -19, 15),
                            'yyyymmdd-hh24miss')) <=
                sysdate -
                (to_number(MS_params.GET_PARAM_VALUE('MAX_DELAY_NEXT_HOT_BILL_FILE')) * 2) / 24 then
            1
           else
            0
         end case
    into flag
    from hot_billing_files hbf
    where substr(hbf.file_name,-3)='csv';
  if flag > 0 then
    SELECT user INTO v_username FROM dual;
    open curp;
    loop
      FETCH curp
        into phone_num;
      EXIT WHEN curp%NOTFOUND;
      select count(*)
        into flag
        from tar_log tl
       where tl.insert_date >=
             sysdate -
             to_number(MS_params.GET_PARAM_VALUE('DELAY_NOTICE_HOT_BILL_ERROR')) / 24
         and tl.type_log = 2
         and substr(tl.error_text, -10) = phone_num;
      if flag = 0 then
        SMS := LOADER3_pckg.SEND_SMS(phone_num,
                                     'SMS-info',
                                     'Ќовых файлов гор€чего биллинга нет уже более ' ||
                                     to_char(to_number(MS_params.GET_PARAM_VALUE('MAX_DELAY_NEXT_HOT_BILL_FILE')) * 2) ||
                                     ' часов.');
        INSERT INTO tar_log
          (tuser, insert_date, error_text, type_log)
        VALUES
          (v_username,
           null,
           'ќтправлено оповещение о задержки файлов гор€чего биллинга на номер ' ||
           phone_num,
           2);
        commit;
      end if;
    end loop;
    close curp;
  end if;
end;

--GRANT EXECUTE ON HOT_BILLING_CHECK TO CORP_MOBILE_ROLE;