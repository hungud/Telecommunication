BEGIN
  SYS.DBMS_SCHEDULER.DROP_JOB
    (job_name  => 'J_TEMP_PLSQL_BLOCK');
END;
/

BEGIN
  SYS.DBMS_SCHEDULER.CREATE_JOB
    (
       job_name        => 'J_TEMP_PLSQL_BLOCK'
      ,start_date      => TO_TIMESTAMP_TZ('2014/10/07 12:19:12.000000 +04:00','yyyy/mm/dd hh24:mi:ss.ff tzr')
      ,repeat_interval => 'FREQ=MONTHLY; INTERVAL=10'
      ,end_date        => NULL
      ,job_class       => 'DEFAULT_JOB_CLASS'
      ,job_type        => 'PLSQL_BLOCK'
      ,job_action      => '--BEGIN ADD_COLLECTOR_CALLS(201411); END;
BEGIN
--TARIFER_BILL_CREATE_ALL_BILLS(201501); 
STOP_JOB_PCKG.CHECK_WORK_JOB;
CALC_BALANCE_ROWS_ALL;
--temp_proc_cr1;
--RESTORE_LOG_API_STATUS4;
--BLOCK_CLIENT_WTH_0_BAL2_DESC(93); 
END;'
      ,comments        => 'Джоб для запуска фоновых заданий'
    );
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE
    ( name      => 'J_TEMP_PLSQL_BLOCK'
     ,attribute => 'RESTARTABLE'
     ,value     => FALSE);
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE
    ( name      => 'J_TEMP_PLSQL_BLOCK'
     ,attribute => 'LOGGING_LEVEL'
     ,value     => SYS.DBMS_SCHEDULER.LOGGING_OFF);
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE_NULL
    ( name      => 'J_TEMP_PLSQL_BLOCK'
     ,attribute => 'MAX_FAILURES');
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE_NULL
    ( name      => 'J_TEMP_PLSQL_BLOCK'
     ,attribute => 'MAX_RUNS');
  BEGIN
    SYS.DBMS_SCHEDULER.SET_ATTRIBUTE
      ( name      => 'J_TEMP_PLSQL_BLOCK'
       ,attribute => 'STOP_ON_WINDOW_CLOSE'
       ,value     => FALSE);
  EXCEPTION
    -- could fail if program is of type EXECUTABLE...
    WHEN OTHERS THEN
      NULL;
  END;
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE
    ( name      => 'J_TEMP_PLSQL_BLOCK'
     ,attribute => 'JOB_PRIORITY'
     ,value     => 3);
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE_NULL
    ( name      => 'J_TEMP_PLSQL_BLOCK'
     ,attribute => 'SCHEDULE_LIMIT');
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE
    ( name      => 'J_TEMP_PLSQL_BLOCK'
     ,attribute => 'AUTO_DROP'
     ,value     => FALSE);
END;
/
