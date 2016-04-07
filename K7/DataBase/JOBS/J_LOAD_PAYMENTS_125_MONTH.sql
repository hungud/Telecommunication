BEGIN
  SYS.DBMS_SCHEDULER.CREATE_JOB
    (
       job_name        => 'J_LOAD_PAYMENTS_125_MONTH'
      ,start_date      => SYSDATE
      ,repeat_interval => 'FREQ=DAILY;INTERVAL=1;BYHOUR=6;BYMINUTE=0;BYSECOND=0'
      ,end_date        => NULL
      ,job_class       => 'DEFAULT_JOB_CLASS'
      ,job_type        => 'PLSQL_BLOCK'
      ,job_action      => 'BEGIN 
                            STOP_JOB_PCKG.CHECK_WORK_JOB;
                            loader_call_pckg_n.LOAD_ACCOUNT_PAYMENTS(125,30); 
                          END;'
      ,comments        => 'Загрузка платежей счета 125 (месяц)'
    );
END;
/
