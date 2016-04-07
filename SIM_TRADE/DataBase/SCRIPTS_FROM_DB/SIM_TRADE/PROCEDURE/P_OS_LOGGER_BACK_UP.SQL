
  CREATE OR REPLACE PROCEDURE "SIM_TRADE"."P_OS_LOGGER_BACK_UP" 
AS 
   --
   --#Version=3
   -- V.3 26.02.2015 Афросин А.Ю. Добавил архивирование и удаление выгруженных файлов, и архивов старше 5 дней
   -- V.2 06.02.2015 Афросин А.Ю. Добавил проверку на существование таблицы
   -- V.1 05.02.2015 Афросин А.Ю. Выгрузка таблиц с логами во внешние файлы
  ssql varchar2(1000);
  table_ext  Integer;
  arch_res varchar2(1000);
  ext_file_name varchar2(50);
  path_loader_call_n_log varchar2(1000);
  path_ext_beeline_soap_api_log varchar2(1000);
  del_res integer;
  
  procedure TRANC_DROP_TABLE (pTABLE_NAME varchar2, UseDrop Integer DEFAULT 0) as
  table_ext  Integer;
  begin
    
    select count(*) into table_ext from dba_tables
    where upper(table_name) =upper(pTABLE_NAME);
  
    if table_ext = 1 then
      if UseDrop = 1 then
        Execute immediate 'drop table '||pTABLE_NAME ||' cascade constraints';
      else
        Execute immediate 'truncate table '||pTABLE_NAME;
      end if;
    end if;
    
  end;
begin

  TRANC_DROP_TABLE ('temp_loader_call_n_log');
  insert into temp_loader_call_n_log (select * from loader_call_n_log t where t.load_date>sysdate-1/24);
  commit;
  
  
  TRANC_DROP_TABLE ('EXT_BEELINE_SOAP_API_LOG', 1);
  TRANC_DROP_TABLE ('EXT_LOADER_CALL_N_LOG', 1);
  
  select DIRECTORY_PATH into path_loader_call_n_log from dba_directories
          where DIRECTORY_NAME = 'E_CARE_BACKUP';
  
  select DIRECTORY_PATH into path_ext_beeline_soap_api_log from dba_directories
          where DIRECTORY_NAME = 'SOAPAPI_BACKUP';
  
  
  ext_file_name := 'ext_loader_call_n_log_'||to_char(sysdate, 'yyyy_mm_dd');
  
  ssql:='CREATE TABLE ext_loader_call_n_log
    ORGANIZATION EXTERNAL
    (
    TYPE ORACLE_DATAPUMP
    DEFAULT DIRECTORY e_care_backup
    LOCATION ('''||ext_file_name||'.dmp'')
    )
    AS SELECT * FROM loader_call_n_log';
  execute immediate ssql;
  
  
  arch_res := nvl(pack7z(path_loader_call_n_log||'/'||ext_file_name||'.dmp',
                         path_loader_call_n_log||'/'||ext_file_name||'.7z'), '0');
  if arch_res = '0' then
    TRANC_DROP_TABLE ('loader_call_n_log');
    del_res := PKG_TRF_FILEAPI.DELETE(path_loader_call_n_log||'/'||ext_file_name||'.dmp');
    --удалим архивы старше 5 дней
    del_res := PKG_TRF_FILEAPI.DELETE(path_loader_call_n_log||'/ext_loader_call_n_log_'||to_char(sysdate - 5, 'yyyy_mm_dd')||'.7z');
  end if;
  
    
  ext_file_name := 'ext_beeline_soap_api_log_'||to_char(sysdate, 'yyyy_mm_dd');
  
  ssql:='  CREATE TABLE ext_beeline_soap_api_log
    ORGANIZATION EXTERNAL
    (
    TYPE ORACLE_DATAPUMP
    DEFAULT DIRECTORY soapapi_backup
    LOCATION ('''||ext_file_name||'.dmp'')
    )
    AS SELECT bsal_id, soap_request, t.soap_answer.getclobval() soap_answer, insert_date, phone, account_id, load_type FROM beeline_soap_api_log t';
  execute immediate ssql;  

  arch_res := nvl(pack7z(path_ext_beeline_soap_api_log||'/'||ext_file_name||'.dmp',
                         path_ext_beeline_soap_api_log||'/'||ext_file_name||'.7z'), '0');
  if arch_res = '0' then
    TRANC_DROP_TABLE ('beeline_soap_api_log');
    del_res := PKG_TRF_FILEAPI.DELETE(path_ext_beeline_soap_api_log||'/'||ext_file_name||'.dmp');
    --удалим архивы старше 5 дней
    del_res := PKG_TRF_FILEAPI.DELETE(path_ext_beeline_soap_api_log||'/ext_beeline_soap_api_log_'||to_char(sysdate - 5, 'yyyy_mm_dd')||'.7z');
  end if;


  insert into loader_call_n_log  (select * from temp_loader_call_n_log t );

  commit;
  
  TRANC_DROP_TABLE ('temp_loader_call_n_log');
  

end;