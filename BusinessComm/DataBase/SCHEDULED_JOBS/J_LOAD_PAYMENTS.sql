BEGIN
  SYS.DBMS_SCHEDULER.CREATE_JOB
    (
       job_name        => 'J_LOAD_PAYMENTS'
      ,start_date      => sysdate
      ,repeat_interval => 'FREQ=MINUTELY;INTERVAL=10'
      ,end_date        => NULL
      ,job_class       => 'DEFAULT_JOB_CLASS'
      ,job_type        => 'PLSQL_BLOCK'
      ,job_action      => 'begin
                            STOP_JOB_PCKG.CHECK_WORK_JOB;
                            LOAD_PAYMENTS;
                           end;'
      ,comments        => 'Загрузка платежей с сайта'
    );

END;
/
