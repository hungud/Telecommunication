BEGIN
  SYS.DBMS_SCHEDULER.CREATE_JOB
    (
       job_name        => 'J_GET_DBF_VIRT_ACCOUNT'
      ,start_date      => sysdate
      ,repeat_interval => 'FREQ=MINUTELY;INTERVAL=10'
      ,end_date        => NULL
      ,job_class       => 'DEFAULT_JOB_CLASS'
      ,job_type        => 'PLSQL_BLOCK'
      ,job_action      => 'begin
                             STOP_JOB_PCKG.CHECK_WORK_JOB;
                             virt_account_temp_load_dbf;
                             end;'
      ,comments        => '«агрузка данных из DBF файлов во временную таблицу VIRT_ACCOUNT_TEMP (первый парсер данных)'
    );
end;
/