BEGIN
  SYS.DBMS_SCHEDULER.DROP_JOB
    (job_name  => 'J_NOTICE_PHONES_NO_CONTRACTS');
END;
/

BEGIN
  SYS.DBMS_SCHEDULER.CREATE_JOB
    (
       job_name        => 'J_NOTICE_PHONES_NO_CONTRACTS'
      ,start_date      => TO_TIMESTAMP_TZ('2012/11/13 17:22:21.000000 +04:00','yyyy/mm/dd hh24:mi:ss.ff tzr')
      ,repeat_interval => 'FREQ=MINUTELY; INTERVAL=5'
      ,end_date        => NULL
      ,job_class       => 'DEFAULT_JOB_CLASS'
      ,job_type        => 'PLSQL_BLOCK'
      ,job_action      => 'BEGIN   
    STOP_JOB_PCKG.CHECK_WORK_JOB;
    NOTICE_PHONE_WITHOUT_CONTRACTS; 
END;'
      ,comments        => 'ÏÐÅÄ Î ÍÎÌÅÐÀÕ ÁÅÇ ÄÎÃÎÂÎÐÎÂ'
    );
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE
    ( name      => 'J_NOTICE_PHONES_NO_CONTRACTS'
     ,attribute => 'RESTARTABLE'
     ,value     => FALSE);
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE
    ( name      => 'J_NOTICE_PHONES_NO_CONTRACTS'
     ,attribute => 'LOGGING_LEVEL'
     ,value     => SYS.DBMS_SCHEDULER.LOGGING_OFF);
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE_NULL
    ( name      => 'J_NOTICE_PHONES_NO_CONTRACTS'
     ,attribute => 'MAX_FAILURES');
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE_NULL
    ( name      => 'J_NOTICE_PHONES_NO_CONTRACTS'
     ,attribute => 'MAX_RUNS');
  BEGIN
    SYS.DBMS_SCHEDULER.SET_ATTRIBUTE
      ( name      => 'J_NOTICE_PHONES_NO_CONTRACTS'
       ,attribute => 'STOP_ON_WINDOW_CLOSE'
       ,value     => FALSE);
  EXCEPTION
    -- could fail if program is of type EXECUTABLE...
    WHEN OTHERS THEN
      NULL;
  END;
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE
    ( name      => 'J_NOTICE_PHONES_NO_CONTRACTS'
     ,attribute => 'JOB_PRIORITY'
     ,value     => 3);
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE_NULL
    ( name      => 'J_NOTICE_PHONES_NO_CONTRACTS'
     ,attribute => 'SCHEDULE_LIMIT');
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE
    ( name      => 'J_NOTICE_PHONES_NO_CONTRACTS'
     ,attribute => 'AUTO_DROP'
     ,value     => FALSE);

  SYS.DBMS_SCHEDULER.ENABLE
    (name                  => 'J_NOTICE_PHONES_NO_CONTRACTS');
END;
/
