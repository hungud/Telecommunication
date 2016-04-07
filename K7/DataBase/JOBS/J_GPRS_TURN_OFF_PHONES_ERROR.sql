BEGIN
  SYS.DBMS_SCHEDULER.CREATE_JOB
    (
       job_name        => 'J_GPRS_TURN_OFF_PHONES_ERROR'
      ,start_date      => TO_TIMESTAMP_TZ('2016/01/31 15:26:46.000000 +03:00','yyyy/mm/dd hh24:mi:ss.ff tzr')
      ,repeat_interval => 'FREQ=MINUTELY; INTERVAL=10'
      ,end_date        => NULL
      ,job_class       => 'DEFAULT_JOB_CLASS'
      ,job_type        => 'PLSQL_BLOCK'
      ,job_action      => 'BEGIN 
    STOP_JOB_PCKG.CHECK_WORK_JOB;
    GPRS_TURN_OFF_PHONES_ERROR;
END;'
      ,comments        => 'Механизм отключения интернет-опций в конце мнсяца на активных номерах, по которым были ошибки отключения'
    );
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE
    ( name      => 'J_GPRS_TURN_OFF_PHONES_ERROR'
     ,attribute => 'RESTARTABLE'
     ,value     => FALSE);
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE
    ( name      => 'J_GPRS_TURN_OFF_PHONES_ERROR'
     ,attribute => 'LOGGING_LEVEL'
     ,value     => SYS.DBMS_SCHEDULER.LOGGING_OFF);
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE_NULL
    ( name      => 'J_GPRS_TURN_OFF_PHONES_ERROR'
     ,attribute => 'MAX_FAILURES');
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE_NULL
    ( name      => 'J_GPRS_TURN_OFF_PHONES_ERROR'
     ,attribute => 'MAX_RUNS');
  BEGIN
    SYS.DBMS_SCHEDULER.SET_ATTRIBUTE
      ( name      => 'J_GPRS_TURN_OFF_PHONES_ERROR'
       ,attribute => 'STOP_ON_WINDOW_CLOSE'
       ,value     => FALSE);
  EXCEPTION
    -- could fail if program is of type EXECUTABLE...
    WHEN OTHERS THEN
      NULL;
  END;
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE
    ( name      => 'J_GPRS_TURN_OFF_PHONES_ERROR'
     ,attribute => 'JOB_PRIORITY'
     ,value     => 3);
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE_NULL
    ( name      => 'J_GPRS_TURN_OFF_PHONES_ERROR'
     ,attribute => 'SCHEDULE_LIMIT');
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE
    ( name      => 'J_GPRS_TURN_OFF_PHONES_ERROR'
     ,attribute => 'AUTO_DROP'
     ,value     => FALSE);
END;