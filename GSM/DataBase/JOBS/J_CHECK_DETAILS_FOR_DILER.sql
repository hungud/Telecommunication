BEGIN
  SYS.DBMS_SCHEDULER.DROP_JOB
    (job_name  => 'J_CHECK_DETAILS_FOR_DILER');
END;
/

BEGIN
  SYS.DBMS_SCHEDULER.CREATE_JOB
    (
       job_name        => 'J_CHECK_DETAILS_FOR_DILER'
      ,start_date      => TO_TIMESTAMP_TZ('2012/10/30 02:03:20.000000 +04:00','yyyy/mm/dd hh24:mi:ss.ff tzr')
      ,repeat_interval => 'FREQ=hourLY; INTERVAL=12'
      ,end_date        => NULL
      ,job_class       => 'DEFAULT_JOB_CLASS'
      ,job_type        => 'PLSQL_BLOCK'
      ,job_action      => 'begin
STOP_JOB_PCKG.CHECK_WORK_JOB;
LONTANA.CHECK_ALL_DETAILS2;
end;'
      ,comments        => 'ÏÎÄÑ×ÅÒ ÄÈËÅÐÑÊÈÕ ÇÂÎÍÊÎÂ'
    );
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE
    ( name      => 'J_CHECK_DETAILS_FOR_DILER'
     ,attribute => 'RESTARTABLE'
     ,value     => FALSE);
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE
    ( name      => 'J_CHECK_DETAILS_FOR_DILER'
     ,attribute => 'LOGGING_LEVEL'
     ,value     => SYS.DBMS_SCHEDULER.LOGGING_OFF);
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE_NULL
    ( name      => 'J_CHECK_DETAILS_FOR_DILER'
     ,attribute => 'MAX_FAILURES');
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE_NULL
    ( name      => 'J_CHECK_DETAILS_FOR_DILER'
     ,attribute => 'MAX_RUNS');
  BEGIN
    SYS.DBMS_SCHEDULER.SET_ATTRIBUTE
      ( name      => 'J_CHECK_DETAILS_FOR_DILER'
       ,attribute => 'STOP_ON_WINDOW_CLOSE'
       ,value     => FALSE);
  EXCEPTION
    -- could fail if program is of type EXECUTABLE...
    WHEN OTHERS THEN
      NULL;
  END;
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE
    ( name      => 'J_CHECK_DETAILS_FOR_DILER'
     ,attribute => 'JOB_PRIORITY'
     ,value     => 3);
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE_NULL
    ( name      => 'J_CHECK_DETAILS_FOR_DILER'
     ,attribute => 'SCHEDULE_LIMIT');
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE
    ( name      => 'J_CHECK_DETAILS_FOR_DILER'
     ,attribute => 'AUTO_DROP'
     ,value     => FALSE);

  SYS.DBMS_SCHEDULER.ENABLE
    (name                  => 'J_CHECK_DETAILS_FOR_DILER');
END;
/
