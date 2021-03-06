BEGIN
  SYS.DBMS_SCHEDULER.DROP_JOB
    (job_name  => 'J_USSD_TIMEOUT');
END;
/

BEGIN
  SYS.DBMS_SCHEDULER.CREATE_JOB
    (
       job_name        => 'J_USSD_TIMEOUT'
      ,start_date      => TO_TIMESTAMP_TZ('2012/05/23 21:52:41.000000 +04:00','yyyy/mm/dd hh24:mi:ss.ff tzr')
      ,repeat_interval => 'FREQ=MINUTELY; INTERVAL=1'
      ,end_date        => NULL
      ,job_class       => 'DEFAULT_JOB_CLASS'
      ,job_type        => 'PLSQL_BLOCK'
      ,job_action      => 'begin
STOP_JOB_PCKG.CHECK_WORK_JOB;
USSD_TIMEOUT;
end;'
      ,comments        => 'USSD_TIMEOUT'
    );
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE
    ( name      => 'J_USSD_TIMEOUT'
     ,attribute => 'RESTARTABLE'
     ,value     => FALSE);
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE
    ( name      => 'J_USSD_TIMEOUT'
     ,attribute => 'LOGGING_LEVEL'
     ,value     => SYS.DBMS_SCHEDULER.LOGGING_OFF);
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE_NULL
    ( name      => 'J_USSD_TIMEOUT'
     ,attribute => 'MAX_FAILURES');
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE_NULL
    ( name      => 'J_USSD_TIMEOUT'
     ,attribute => 'MAX_RUNS');
  BEGIN
    SYS.DBMS_SCHEDULER.SET_ATTRIBUTE
      ( name      => 'J_USSD_TIMEOUT'
       ,attribute => 'STOP_ON_WINDOW_CLOSE'
       ,value     => FALSE);
  EXCEPTION
    -- could fail if program is of type EXECUTABLE...
    WHEN OTHERS THEN
      NULL;
  END;
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE
    ( name      => 'J_USSD_TIMEOUT'
     ,attribute => 'JOB_PRIORITY'
     ,value     => 3);
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE_NULL
    ( name      => 'J_USSD_TIMEOUT'
     ,attribute => 'SCHEDULE_LIMIT');
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE
    ( name      => 'J_USSD_TIMEOUT'
     ,attribute => 'AUTO_DROP'
     ,value     => FALSE);

  SYS.DBMS_SCHEDULER.ENABLE
    (name                  => 'J_USSD_TIMEOUT');
END;
/
