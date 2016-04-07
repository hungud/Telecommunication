BEGIN
  SYS.DBMS_SCHEDULER.CREATE_JOB
    (
       job_name        => 'J_GPRS_CHECK_FLOW_1_TURN_ON'
      ,start_date      => NULL
      ,repeat_interval => 'FREQ=DAILY;BYMONTHDAY=1;BYHOUR=5;BYMINUTE=45;BYSECOND=0'
      ,end_date        => NULL
      ,job_class       => 'DEFAULT_JOB_CLASS'
      ,job_type        => 'PLSQL_BLOCK'
      ,job_action      => 'dbms_scheduler.enable(''J_GPRS_CHECK_FLOW_1'');'
      ,comments        => NULL
    );
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE
    ( name      => 'J_GPRS_CHECK_FLOW_1_TURN_ON'
     ,attribute => 'RESTARTABLE'
     ,value     => FALSE);
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE
    ( name      => 'J_GPRS_CHECK_FLOW_1_TURN_ON'
     ,attribute => 'LOGGING_LEVEL'
     ,value     => SYS.DBMS_SCHEDULER.LOGGING_OFF);
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE_NULL
    ( name      => 'J_GPRS_CHECK_FLOW_1_TURN_ON'
     ,attribute => 'MAX_FAILURES');
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE_NULL
    ( name      => 'J_GPRS_CHECK_FLOW_1_TURN_ON'
     ,attribute => 'MAX_RUNS');
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE
    ( name      => 'J_GPRS_CHECK_FLOW_1_TURN_ON'
     ,attribute => 'STOP_ON_WINDOW_CLOSE'
     ,value     => FALSE);
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE
    ( name      => 'J_GPRS_CHECK_FLOW_1_TURN_ON'
     ,attribute => 'JOB_PRIORITY'
     ,value     => 3);
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE_NULL
    ( name      => 'J_GPRS_CHECK_FLOW_1_TURN_ON'
     ,attribute => 'SCHEDULE_LIMIT');
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE
    ( name      => 'J_GPRS_CHECK_FLOW_1_TURN_ON'
     ,attribute => 'AUTO_DROP'
     ,value     => FALSE);
END;
/
