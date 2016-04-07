--connect corp_mobile/hivxHD2gpHJX@K7;
connect corp_mobile/hivxHD2gpHJX@(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(HOST=localhost)(PORT=1521))(CONNECT_DATA=(SERVICE_NAME=K7)));

declare
  vCount integer;
begin
  -- проверяем на наличие исключения в таблице на остановку джобов
  select count(*) into vCount from
    STOP_JOB_EXCEPTION
  where
    upper(NAME_STOP_JOB) = 'J_OS_LOGGER_BACK_UP';
   
  if nvl(vCount, 0) = 0 then
    INSERT INTO STOP_JOB_EXCEPTION (NAME_STOP_JOB)
    VALUES ('J_OS_LOGGER_BACK_UP');
    
    COMMIT;
  end if;
  --стопаем джобы
  STOP_JOB_PCKG.STOP_JOB (2);
  execute immediate 'TRUNCATE TABLE BEELINE_SOAP_API_LOG';  
  execute immediate 'ALTER TABLE BEELINE_SOAP_API_LOG ENABLE ROW MOVEMENT';
  execute immediate 'ALTER TABLE BEELINE_SOAP_API_LOG SHRINK SPACE CASCADE';

end;
/
truncate table loader_call_n_log;
insert into loader_call_n_log  (select * from temp_loader_call_n_log t );
commit;
truncate table temp_loader_call_n_log;
exit;