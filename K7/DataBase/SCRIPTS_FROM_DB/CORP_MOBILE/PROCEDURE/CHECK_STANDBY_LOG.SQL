
  CREATE OR REPLACE PROCEDURE "CORP_MOBILE"."CHECK_STANDBY_LOG" is
  --#Version=1  
  -- Проверка наката архивлогов на стендбае
  callv       varchar2(4000);
  k           number;
  cf          utl_file.file_type;
  RESULT_CLOB clob;
  Procedure send_sys_msg(message in varchar2) is
    cursor curp is
      SELECT regexp_substr(str, '[^;]+', 1, level) str
        FROM (SELECT MS_params.GET_PARAM_VALUE('SMS_SYSTEM_ERROR_NOTICE_PHONES') str
                FROM dual) t
      CONNECT BY instr(str, ';', 1, level - 1) > 0;
    phone_num varchar2(10);
    SMS       varchar2(2000);
  begin
    open curp;
    loop
      FETCH curp
        into phone_num;
      EXIT WHEN curp%NOTFOUND;
      SMS := LOADER3_pckg.SEND_SMS(phone_num, 'system', message);
    end loop;
    close curp;
  end;
BEGIN
  cf := utl_file.fopen('BACKUPDIR', 'sequence.txt', 'R');
  utl_file.get_line(cf, callv);
  utl_file.get_line(cf, callv);
  utl_file.fclose(cf);
  SELECT max(vl.SEQUENCE#)
    into k
    FROM v$archived_log vl
   where vl.BACKUP_COUNT > 0;
  cf := utl_file.fopen('SCRIPTDIR', 'check.txt', 'W');
  if to_number(trim(callv)) > k then
    utl_file.put(cf, '1');
  else
    RESULT_CLOB := 'Ошибка наката архивлогов. Удаление архивлогов не выполнено.';
    MAIl_REQ_ADD('Резервный сервер',
                 RESULT_CLOB,
                 'MAIL_CHECK_STANDBY');
    --    send_sys_msg('Ошибка наката архивлогов. Удаление архивлогов не выполнено.');
    utl_file.put(cf, '0');
  end if;
  utl_file.fclose(cf);
exception
  when others then
    RESULT_CLOB := 'Ошибка наката архивлогов. Удаление архивлогов не выполнено.';
    MAIl_REQ_ADD('Резервный сервер',
                 RESULT_CLOB,
                 'MAIL_CHECK_STANDBY');
    --    send_sys_msg('Ошибка наката архивлогов. Удаление архивлогов не выполнено.');
    utl_file.fclose(cf);
    cf := utl_file.fopen('SCRIPTDIR', 'check.txt', 'W');
    utl_file.put(cf, '0');
    utl_file.fclose(cf);
end;
