--BEGIN
--  SYS.DBMS_SCHEDULER.DROP_JOB
--    (job_name  => 'J_LOAD_PHONE_OPTIONS_126_0');
--END;
--/

--
-- J_LOAD_PHONE_OPTIONS_126_0  (Scheduler Job) 
--
BEGIN
  SYS.DBMS_SCHEDULER.CREATE_JOB
    (
       job_name        => 'J_LOAD_PHONE_OPTIONS_126_0'
      ,start_date      => TO_TIMESTAMP_TZ('2015/12/16 10:54:00.000000 +03:00','yyyy/mm/dd hh24:mi:ss.ff tzr')
      ,repeat_interval => 'FREQ = HOURLY; INTERVAL = 12'
      ,end_date        => NULL
      ,job_class       => 'DEFAULT_JOB_CLASS'
      ,job_type        => 'PLSQL_BLOCK'
      ,job_action      => 'BEGIN STOP_JOB_PCKG.CHECK_WORK_JOB; loader_call_pckg_n.LOAD_PHONES_OPTIONS(126, 0, 4); END;'
      ,comments        => NULL
    );
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE
    ( name      => 'J_LOAD_PHONE_OPTIONS_126_0'
     ,attribute => 'RESTARTABLE'
     ,value     => FALSE);
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE
    ( name      => 'J_LOAD_PHONE_OPTIONS_126_0'
     ,attribute => 'LOGGING_LEVEL'
     ,value     => SYS.DBMS_SCHEDULER.LOGGING_OFF);
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE_NULL
    ( name      => 'J_LOAD_PHONE_OPTIONS_126_0'
     ,attribute => 'MAX_FAILURES');
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE_NULL
    ( name      => 'J_LOAD_PHONE_OPTIONS_126_0'
     ,attribute => 'MAX_RUNS');
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE
    ( name      => 'J_LOAD_PHONE_OPTIONS_126_0'
     ,attribute => 'STOP_ON_WINDOW_CLOSE'
     ,value     => FALSE);
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE
    ( name      => 'J_LOAD_PHONE_OPTIONS_126_0'
     ,attribute => 'JOB_PRIORITY'
     ,value     => 3);
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE_NULL
    ( name      => 'J_LOAD_PHONE_OPTIONS_126_0'
     ,attribute => 'SCHEDULE_LIMIT');
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE
    ( name      => 'J_LOAD_PHONE_OPTIONS_126_0'
     ,attribute => 'AUTO_DROP'
     ,value     => TRUE);

  SYS.DBMS_SCHEDULER.DISABLE
    (name                  => 'J_LOAD_PHONE_OPTIONS_126_0');
END;
/
