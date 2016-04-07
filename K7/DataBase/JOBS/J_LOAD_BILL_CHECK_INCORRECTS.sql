BEGIN
  SYS.DBMS_SCHEDULER.CREATE_JOB
    (
       job_name        => 'J_LOAD_BILL_CHECK_INCORRECTS'
      ,start_date      => SYSDATE
      ,repeat_interval => 'FREQ=MINUTELY; INTERVAL=1'
      ,end_date        => NULL
      ,job_class       => 'DEFAULT_JOB_CLASS'
      ,job_type        => 'PLSQL_BLOCK'
      ,job_action      => 'BEGIN
STOP_JOB_PCKG.CHECK_WORK_JOB;
CHECK_INCORRECT_FINANCE_BILLS; END;'
      ,comments        => 'Загрузка счетов из "Фин Инфо"'
    );
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE
    ( name      => 'J_LOAD_BILL_CHECK_INCORRECTS'
     ,attribute => 'RESTARTABLE'
     ,value     => FALSE);
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE_NULL
    ( name      => 'J_LOAD_BILL_CHECK_INCORRECTS'
     ,attribute => 'MAX_FAILURES');
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE_NULL
    ( name      => 'J_LOAD_BILL_CHECK_INCORRECTS'
     ,attribute => 'MAX_RUNS');
  BEGIN
    SYS.DBMS_SCHEDULER.SET_ATTRIBUTE
      ( name      => 'J_LOAD_BILL_CHECK_INCORRECTS'
       ,attribute => 'STOP_ON_WINDOW_CLOSE'
       ,value     => FALSE);
  EXCEPTION
    -- could fail if program is of type EXECUTABLE...
    WHEN OTHERS THEN
      NULL;
  END;
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE
    ( name      => 'J_LOAD_BILL_CHECK_INCORRECTS'
     ,attribute => 'JOB_PRIORITY'
     ,value     => 3);
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE_NULL
    ( name      => 'J_LOAD_BILL_CHECK_INCORRECTS'
     ,attribute => 'SCHEDULE_LIMIT');
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE
    ( name      => 'J_LOAD_BILL_CHECK_INCORRECTS'
     ,attribute => 'AUTO_DROP'
     ,value     => FALSE);
  SYS.DBMS_SCHEDULER.ENABLE
    (name                  => 'J_LOAD_BILL_CHECK_INCORRECTS');
END;
/