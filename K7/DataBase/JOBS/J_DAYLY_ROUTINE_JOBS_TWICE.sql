BEGIN
  SYS.DBMS_SCHEDULER.DROP_JOB
    (job_name  => 'J_DAYLY_ROUTINE_JOBS_TWICE');
END;
/

BEGIN
  SYS.DBMS_SCHEDULER.CREATE_JOB
    (
       job_name        => 'J_DAYLY_ROUTINE_JOBS_TWICE'
      ,start_date      => TO_TIMESTAMP_TZ('2015/04/03 11:38:37.869000 +03:00','yyyy/mm/dd hh24:mi:ss.ff tzr')
      ,repeat_interval => 'FREQ=HOURLY;INTERVAL=12;BYMINUTE=0;BYSECOND=0'
      ,end_date        => NULL
      ,job_class       => 'DEFAULT_JOB_CLASS'
      ,job_type        => 'PLSQL_BLOCK'
      ,job_action      => 'BEGIN
    STOP_JOB_PCKG.CHECK_WORK_JOB;
    CORP_MOBILE.DAYLY_ROUTINE_JOBS_TWICE;
END;'
      ,comments        => 'Снятие ручной блокировки, с контрактов, у которых истек срок ручной блокировки '
    );
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE
    ( name      => 'J_DAYLY_ROUTINE_JOBS_TWICE'
     ,attribute => 'RESTARTABLE'
     ,value     => FALSE);
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE
    ( name      => 'J_DAYLY_ROUTINE_JOBS_TWICE'
     ,attribute => 'LOGGING_LEVEL'
     ,value     => SYS.DBMS_SCHEDULER.LOGGING_OFF);
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE_NULL
    ( name      => 'J_DAYLY_ROUTINE_JOBS_TWICE'
     ,attribute => 'MAX_FAILURES');
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE_NULL
    ( name      => 'J_DAYLY_ROUTINE_JOBS_TWICE'
     ,attribute => 'MAX_RUNS');
  BEGIN
    SYS.DBMS_SCHEDULER.SET_ATTRIBUTE
      ( name      => 'J_DAYLY_ROUTINE_JOBS_TWICE'
       ,attribute => 'STOP_ON_WINDOW_CLOSE'
       ,value     => FALSE);
  EXCEPTION
    -- could fail if program is of type EXECUTABLE...
    WHEN OTHERS THEN
      NULL;
  END;
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE
    ( name      => 'J_DAYLY_ROUTINE_JOBS_TWICE'
     ,attribute => 'JOB_PRIORITY'
     ,value     => 3);
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE_NULL
    ( name      => 'J_DAYLY_ROUTINE_JOBS_TWICE'
     ,attribute => 'SCHEDULE_LIMIT');
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE
    ( name      => 'J_DAYLY_ROUTINE_JOBS_TWICE'
     ,attribute => 'AUTO_DROP'
     ,value     => FALSE);

  SYS.DBMS_SCHEDULER.ENABLE
    (name                  => 'J_DAYLY_ROUTINE_JOBS_TWICE');
END;
/
