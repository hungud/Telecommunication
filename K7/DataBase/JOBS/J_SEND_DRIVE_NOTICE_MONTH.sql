BEGIN
  SYS.DBMS_SCHEDULER.CREATE_JOB(
       job_name        => 'J_SEND_DRIVE_NOTICE_MONTH'
      ,start_date      => SYSDATE
      ,repeat_interval => 'FREQ=DAILY; INTERVAL=1; BYHOUR=12; BYMINUTE=0; BYSECOND=0'
      ,end_date        => NULL
      ,job_class       => 'DEFAULT_JOB_CLASS'
      ,job_type        => 'PLSQL_BLOCK'
      ,job_action      => 'BEGIN 
    --STOP_JOB_PCKG.CHECK_WORK_JOB;
    SEND_DRIVE_NOTICE_MONTH; 
END;'
      ,comments        => 'Извещение Драйвов о след месяце'
    );
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE
    ( name      => 'J_SEND_DRIVE_NOTICE_MONTH'
     ,attribute => 'RESTARTABLE'
     ,value     => FALSE);
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE_NULL
    ( name      => 'J_SEND_DRIVE_NOTICE_MONTH'
     ,attribute => 'MAX_FAILURES');
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE_NULL
    ( name      => 'J_SEND_DRIVE_NOTICE_MONTH'
     ,attribute => 'MAX_RUNS');
  BEGIN
    SYS.DBMS_SCHEDULER.SET_ATTRIBUTE
      ( name      => 'J_SEND_DRIVE_NOTICE_MONTH'
       ,attribute => 'STOP_ON_WINDOW_CLOSE'
       ,value     => FALSE);
  EXCEPTION
    -- could fail if program is of type EXECUTABLE...
    WHEN OTHERS THEN
      NULL;
  END;
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE
    ( name      => 'J_SEND_DRIVE_NOTICE_MONTH'
     ,attribute => 'JOB_PRIORITY'
     ,value     => 3);
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE_NULL
    ( name      => 'J_SEND_DRIVE_NOTICE_MONTH'
     ,attribute => 'SCHEDULE_LIMIT');
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE
    ( name      => 'J_SEND_DRIVE_NOTICE_MONTH'
     ,attribute => 'AUTO_DROP'
     ,value     => FALSE);

  SYS.DBMS_SCHEDULER.ENABLE(name  => 'J_SEND_DRIVE_NOTICE_MONTH');
END;
/