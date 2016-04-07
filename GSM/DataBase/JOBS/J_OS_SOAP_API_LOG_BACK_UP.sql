BEGIN
  SYS.DBMS_SCHEDULER.CREATE_JOB
    (
       job_name        => 'J_OS_SOAP_API_LOG_BACK_UP'
      ,start_date      => TO_TIMESTAMP_TZ('2015/12/29 14:00:00.000000 +03:00','yyyy/mm/dd hh24:mi:ss.ff tzr')
      ,repeat_interval => 'FREQ=HOURLY; INTERVAL=1; BYMINUTE=0; bysecond=0'
      ,end_date        => NULL
      ,job_class       => 'DEFAULT_JOB_CLASS'
      ,job_type        => 'PLSQL_BLOCK'
      ,job_action      => 'BEGIN
                             STOP_JOB_PCKG.CHECK_WORK_JOB;
                             P_OS_SOAP_API_LOG_BACK_UP;
                           END;'
      ,comments        => 'Выгрузка данных таблицы BEELINE_SOAP_API_LOG во внешнюю таблицу'
    );
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE
    ( name      => 'J_OS_SOAP_API_LOG_BACK_UP'
     ,attribute => 'RESTARTABLE'
     ,value     => FALSE);
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE
    ( name      => 'J_OS_SOAP_API_LOG_BACK_UP'
     ,attribute => 'LOGGING_LEVEL'
     ,value     => SYS.DBMS_SCHEDULER.LOGGING_OFF);
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE_NULL
    ( name      => 'J_OS_SOAP_API_LOG_BACK_UP'
     ,attribute => 'MAX_FAILURES');
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE_NULL
    ( name      => 'J_OS_SOAP_API_LOG_BACK_UP'
     ,attribute => 'MAX_RUNS');
  BEGIN
    SYS.DBMS_SCHEDULER.SET_ATTRIBUTE
      ( name      => 'J_OS_SOAP_API_LOG_BACK_UP'
       ,attribute => 'STOP_ON_WINDOW_CLOSE'
       ,value     => FALSE);
  EXCEPTION
    -- could fail if program is of type EXECUTABLE...
    WHEN OTHERS THEN
      NULL;
  END;
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE
    ( name      => 'J_OS_SOAP_API_LOG_BACK_UP'
     ,attribute => 'JOB_PRIORITY'
     ,value     => 3);
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE_NULL
    ( name      => 'J_OS_SOAP_API_LOG_BACK_UP'
     ,attribute => 'SCHEDULE_LIMIT');
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE
    ( name      => 'J_OS_SOAP_API_LOG_BACK_UP'
     ,attribute => 'AUTO_DROP'
     ,value     => FALSE);
END;