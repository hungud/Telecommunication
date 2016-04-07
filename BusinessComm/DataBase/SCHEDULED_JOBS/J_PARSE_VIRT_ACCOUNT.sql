BEGIN
  SYS.DBMS_SCHEDULER.CREATE_JOB
    (
       job_name        => 'J_PARSE_VIRT_ACCOUNT'
      ,start_date      => sysdate
      ,repeat_interval => 'FREQ=MINUTELY;INTERVAL=10'
      ,end_date        => NULL
      ,job_class       => 'DEFAULT_JOB_CLASS'
      ,job_type        => 'PLSQL_BLOCK'
      ,job_action      => 'begin
                           STOP_JOB_PCKG.CHECK_WORK_JOB;
                           PARSE_VIRT_ACCOUNT_FILES;
                           end;'
      ,comments        => 'Разбор данных из дбф файла с загрузкой в VIRTUAL_ACCOUNTS, PHONES и PHONE_ON_ACCOUNTS'
    );

END;
/
