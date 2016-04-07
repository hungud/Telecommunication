BEGIN
  SYS.DBMS_SCHEDULER.DROP_JOB
    (job_name  => 'LONTANA.J_SEND_SMS_NOTIFY_BILLS');
END;
/

BEGIN
  SYS.DBMS_SCHEDULER.CREATE_JOB
    (
       job_name        => 'LONTANA.J_SEND_SMS_NOTIFY_BILLS'
      ,start_date      => NULL
      ,repeat_interval => 'FREQ=HOURLY;INTERVAL=1'
      ,end_date        => NULL
      ,job_class       => 'DEFAULT_JOB_CLASS'
      ,job_type        => 'STORED_PROCEDURE'
      ,job_action      => 'CHECK_NEW_BILLS_MEGAFON'
      ,comments        => NULL
    );
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE
    ( name      => 'LONTANA.J_SEND_SMS_NOTIFY_BILLS'
     ,attribute => 'RESTARTABLE'
     ,value     => FALSE);
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE
    ( name      => 'LONTANA.J_SEND_SMS_NOTIFY_BILLS'
     ,attribute => 'LOGGING_LEVEL'
     ,value     => SYS.DBMS_SCHEDULER.LOGGING_OFF);
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE_NULL
    ( name      => 'LONTANA.J_SEND_SMS_NOTIFY_BILLS'
     ,attribute => 'MAX_FAILURES');
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE_NULL
    ( name      => 'LONTANA.J_SEND_SMS_NOTIFY_BILLS'
     ,attribute => 'MAX_RUNS');
  BEGIN
    SYS.DBMS_SCHEDULER.SET_ATTRIBUTE
      ( name      => 'LONTANA.J_SEND_SMS_NOTIFY_BILLS'
       ,attribute => 'STOP_ON_WINDOW_CLOSE'
       ,value     => FALSE);
  EXCEPTION
    -- could fail if program is of type EXECUTABLE...
    WHEN OTHERS THEN
      NULL;
  END;
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE
    ( name      => 'LONTANA.J_SEND_SMS_NOTIFY_BILLS'
     ,attribute => 'JOB_PRIORITY'
     ,value     => 3);
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE_NULL
    ( name      => 'LONTANA.J_SEND_SMS_NOTIFY_BILLS'
     ,attribute => 'SCHEDULE_LIMIT');
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE
    ( name      => 'LONTANA.J_SEND_SMS_NOTIFY_BILLS'
     ,attribute => 'AUTO_DROP'
     ,value     => FALSE);
END;
/
