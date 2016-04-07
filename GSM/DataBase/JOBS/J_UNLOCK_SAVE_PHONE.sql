BEGIN
  SYS.DBMS_SCHEDULER.CREATE_JOB
    (
       job_name        => 'J_UNLOCK_SAVE_PHONE'
      ,start_date      => TO_TIMESTAMP_TZ('2015/11/11 12:00:00.000000 +04:00','yyyy/mm/dd hh24:mi:ss.ff tzh:tzm')
      ,repeat_interval => 'FREQ=MINUTELY; INTERVAL=10'
      ,end_date        => NULL
      ,job_class       => 'DEFAULT_JOB_CLASS'
      ,job_type        => 'PLSQL_BLOCK'
      ,job_action      => 'BEGIN 
  STOP_JOB_PCKG.CHECK_WORK_JOB;
  UNLOCK_SAVE_PHONE;
END; '
      ,comments        => '–азблокировка номеров из сохранени€'
    );
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE
    ( name      => 'J_UNLOCK_SAVE_PHONE'
     ,attribute => 'RESTARTABLE'
     ,value     => FALSE);
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE
    ( name      => 'J_UNLOCK_SAVE_PHONE'
     ,attribute => 'LOGGING_LEVEL'
     ,value     => SYS.DBMS_SCHEDULER.LOGGING_OFF);
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE_NULL
    ( name      => 'J_UNLOCK_SAVE_PHONE'
     ,attribute => 'MAX_FAILURES');
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE_NULL
    ( name      => 'J_UNLOCK_SAVE_PHONE'
     ,attribute => 'MAX_RUNS');
  BEGIN
    SYS.DBMS_SCHEDULER.SET_ATTRIBUTE
      ( name      => 'J_UNLOCK_SAVE_PHONE'
       ,attribute => 'STOP_ON_WINDOW_CLOSE'
       ,value     => FALSE);
  EXCEPTION
    -- could fail if program is of type EXECUTABLE...
    WHEN OTHERS THEN
      NULL;
  END;
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE
    ( name      => 'J_UNLOCK_SAVE_PHONE'
     ,attribute => 'JOB_PRIORITY'
     ,value     => 3);
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE_NULL
    ( name      => 'J_UNLOCK_SAVE_PHONE'
     ,attribute => 'SCHEDULE_LIMIT');
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE
    ( name      => 'J_UNLOCK_SAVE_PHONE'
     ,attribute => 'AUTO_DROP'
     ,value     => FALSE);
END;
/
