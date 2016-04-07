BEGIN
  SYS.DBMS_SCHEDULER.CREATE_JOB
    (
       job_name        => 'J_PARSE_BILLS'
      ,start_date      => sysdate
      ,repeat_interval => 'Freq=Minutely;Interval=10'
      ,end_date        => NULL
      ,job_class       => 'DEFAULT_JOB_CLASS'
      ,job_type        => 'PLSQL_BLOCK'
      ,job_action      => 'begin
                             STOP_JOB_PCKG.CHECK_WORK_JOB;
                             P_PARSE_BILLS;
                           end;'
      ,comments        => 'Разбор файлов после парсера'
    );
END;
/
