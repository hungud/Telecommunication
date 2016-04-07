--#IF GETVERSION("CHECK_STANDBY_LOG") < 1 THEN
CREATE OR REPLACE Procedure CHECK_STANDBY_LOG is
--#Version=1  
-- Проверка наката архивлогов на стендбае
  callv varchar2(4000);
  k     number;
  cf    utl_file.file_type;
  Procedure send_sys_msg(message in varchar2) is
    sFld        varchar2(200);
    nPozDivider number;
    nIndexField number;
    sTMP        varchar2(1000);
    res         varchar2(300);
  begin
    sTMP        := MS_PARAMS.GET_PARAM_VALUE('SMS_SYSTEM_ERROR_NOTICE_PHONES');
    nIndexField := 0;
    loop
      --парсинг строки
      nPozDivider := instr(sTMP, ';', 1, 1);
      sFld        := substr(sTMP, 1, nPozDivider - 1);
      sTMP        := substr(sTMP, nPozDivider + 1);
      res         := loader3_pckg.SEND_SMS(sfld, 'system', message);
      nIndexField := nIndexField + 1;
      exit when nPozDivider is null;
    end loop;
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
    send_sys_msg('Ошибка наката архивлогов. Удаление архивлогов не выполнено.');
    utl_file.put(cf, '0');
  end if;
  utl_file.fclose(cf);
end;
--#end if