BEGIN
  SYS.DBMS_SCHEDULER.CREATE_JOB
    (
       job_name        => 'J_SEND_SMS_NOTICE_MN_UNLIM'
      ,start_date      => SYSDATE
      ,repeat_interval => 'FREQ=MINUTELY; INTERVAL=5'
      ,end_date        => NULL
      ,job_class       => 'DEFAULT_JOB_CLASS'
      ,job_type        => 'STORED_PROCEDURE'
       ,job_action      => 'BEGIN
  STOP_JOB_PCKG.CHECK_WORK_JOB;
  SEND_SMS_NOTICE_MN_UNLIM;
END;  '
      ,comments        => 'SEND SMS NOTICE MN UNLIM'
    );
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE
    ( name      => 'J_SEND_SMS_NOTICE_MN_UNLIM'
     ,attribute => 'RESTARTABLE'
     ,value     => FALSE);
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE_NULL
    ( name      => 'J_SEND_SMS_NOTICE_MN_UNLIM'
     ,attribute => 'MAX_FAILURES');
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE_NULL
    ( name      => 'J_SEND_SMS_NOTICE_MN_UNLIM'
     ,attribute => 'MAX_RUNS');
  BEGIN
    SYS.DBMS_SCHEDULER.SET_ATTRIBUTE
      ( name      => 'J_SEND_SMS_NOTICE_MN_UNLIM'
       ,attribute => 'STOP_ON_WINDOW_CLOSE'
       ,value     => FALSE);
  EXCEPTION
    -- could fail if program is of type EXECUTABLE...
    WHEN OTHERS THEN
      NULL;
  END;
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE
    ( name      => 'J_SEND_SMS_NOTICE_MN_UNLIM'
     ,attribute => 'JOB_PRIORITY'
     ,value     => 3);
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE_NULL
    ( name      => 'J_SEND_SMS_NOTICE_MN_UNLIM'
     ,attribute => 'SCHEDULE_LIMIT');
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE
    ( name      => 'J_SEND_SMS_NOTICE_MN_UNLIM'
     ,attribute => 'AUTO_DROP'
     ,value     => FALSE);

  SYS.DBMS_SCHEDULER.ENABLE
    (name                  => 'J_SEND_SMS_NOTICE_MN_UNLIM');
END;
/
