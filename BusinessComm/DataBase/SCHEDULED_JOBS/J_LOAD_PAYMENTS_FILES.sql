BEGIN
  SYS.DBMS_SCHEDULER.CREATE_JOB
    (
       job_name        => 'J_LOAD_PAYMENTS_FILES'
      ,start_date      => sysdate
      ,repeat_interval => 'Freq=Minutely;Interval=10'
      ,end_date        => NULL
      ,job_class       => 'DEFAULT_JOB_CLASS'
      ,job_type        => 'PLSQL_BLOCK'
      ,job_action      => 'begin
                             STOP_JOB_PCKG.CHECK_WORK_JOB;
                             LOAD_PAYMENTS_FILES;
                           end;'
      ,comments        => 'Загрузка данных из файлов платежей'
    );
END;
/
