BEGIN
  SYS.DBMS_SCHEDULER.CREATE_JOB(
       job_name        => 'J_TARIFER_MONTH_BILL_CREATE'
      ,start_date      => trunc(SYSDATE) + 15/24/60
      ,repeat_interval => 'FREQ=MONTHLY; INTERVAL=1; BYMONTHDAY=6; BYHOUR=9; BYMINUTE=0; BYSECOND=0'
      ,end_date        => NULL
      ,job_class       => 'DEFAULT_JOB_CLASS'
      ,job_type        => 'PLSQL_BLOCK'
      ,job_action      => 'BEGIN 
    --STOP_JOB_PCKG.CHECK_WORK_JOB;
    TARIFER_MONTH_BILL_CREATE; 
END;'
      ,comments        => 'Создание счетов тарифера'
    );
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE
    ( name      => 'J_TARIFER_MONTH_BILL_CREATE'
     ,attribute => 'RESTARTABLE'
     ,value     => FALSE);
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE_NULL
    ( name      => 'J_TARIFER_MONTH_BILL_CREATE'
     ,attribute => 'MAX_FAILURES');
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE_NULL
    ( name      => 'J_TARIFER_MONTH_BILL_CREATE'
     ,attribute => 'MAX_RUNS');
  BEGIN
    SYS.DBMS_SCHEDULER.SET_ATTRIBUTE
      ( name      => 'J_TARIFER_MONTH_BILL_CREATE'
       ,attribute => 'STOP_ON_WINDOW_CLOSE'
       ,value     => FALSE);
  EXCEPTION
    -- could fail if program is of type EXECUTABLE...
    WHEN OTHERS THEN
      NULL;
  END;
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE
    ( name      => 'J_TARIFER_MONTH_BILL_CREATE'
     ,attribute => 'JOB_PRIORITY'
     ,value     => 3);
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE_NULL
    ( name      => 'J_TARIFER_MONTH_BILL_CREATE'
     ,attribute => 'SCHEDULE_LIMIT');
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE
    ( name      => 'J_TARIFER_MONTH_BILL_CREATE'
     ,attribute => 'AUTO_DROP'
     ,value     => FALSE);

  SYS.DBMS_SCHEDULER.ENABLE(name  => 'J_TARIFER_MONTH_BILL_CREATE');
END;
/