DECLARE
  I INTEGER;
BEGIN
  FOR I IN 0..4 LOOP
  SYS.DBMS_SCHEDULER.CREATE_JOB
    (
       job_name        => 'J_DRAVE_CHECK_STREAM_0'||i
      ,start_date      => TO_TIMESTAMP_TZ('2015/09/04 09:00:00.000000 +03:00','yyyy/mm/dd hh24:mi:ss.ff tzr')
      ,repeat_interval => 'FREQ=HOURLY; INTERVAL=1; BYMINUTE=0; bysecond=0'
      ,end_date        => NULL
      ,job_class       => 'DEFAULT_JOB_CLASS'
      ,job_type        => 'PLSQL_BLOCK'
      ,job_action      => 'BEGIN
                             STOP_JOB_PCKG.CHECK_WORK_JOB;
                             BEELINE_REST_API_PCKG.drave_check_phone_flow('||i||', 5);        
                           END;'
      ,comments        => 'Контроль расхода трафика на номерах с тарифом Драйв. Поток '||i+1
    );
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE
    ( name      => 'J_DRAVE_CHECK_STREAM_0'||i
     ,attribute => 'RESTARTABLE'
     ,value     => FALSE);
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE
    ( name      => 'J_DRAVE_CHECK_STREAM_0'||i
     ,attribute => 'LOGGING_LEVEL'
     ,value     => SYS.DBMS_SCHEDULER.LOGGING_OFF);
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE_NULL
    ( name      => 'J_DRAVE_CHECK_STREAM_0'||i
     ,attribute => 'MAX_FAILURES');
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE_NULL
    ( name      => 'J_DRAVE_CHECK_STREAM_0'||i
     ,attribute => 'MAX_RUNS');
  BEGIN
    SYS.DBMS_SCHEDULER.SET_ATTRIBUTE
      ( name      => 'J_DRAVE_CHECK_STREAM_0'||i
       ,attribute => 'STOP_ON_WINDOW_CLOSE'
       ,value     => FALSE);
  EXCEPTION
    -- could fail if program is of type EXECUTABLE...
    WHEN OTHERS THEN
      NULL;
  END;
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE
    ( name      => 'J_DRAVE_CHECK_STREAM_0'||i
     ,attribute => 'JOB_PRIORITY'
     ,value     => 3);
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE_NULL
    ( name      => 'J_DRAVE_CHECK_STREAM_0'||i
     ,attribute => 'SCHEDULE_LIMIT');
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE
    ( name      => 'J_DRAVE_CHECK_STREAM_0'||i
     ,attribute => 'AUTO_DROP'
     ,value     => FALSE);
  END LOOP;
END;