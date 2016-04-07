BEGIN
  SYS.DBMS_SCHEDULER.CREATE_JOB
    (
       job_name        => 'J_TARIFER_MONTH_BILL_CREATE'
      ,start_date      => sysdate
      ,repeat_interval => 'FREQ=MONTHLY; INTERVAL=1; BYMONTHDAY=6; BYHOUR=5; BYMINUTE=0; BYSECOND=0'
      ,end_date        => NULL
      ,job_class       => 'DEFAULT_JOB_CLASS'
      ,job_type        => 'PLSQL_BLOCK'
      ,job_action      => 'BEGIN 
                            --STOP_JOB_PCKG.CHECK_WORK_JOB;
                            TARIFER_MONTH_BILL_CREATE; 
                           END;'
      ,comments        => 'Создание счетов тарифера'
    );
end;    
