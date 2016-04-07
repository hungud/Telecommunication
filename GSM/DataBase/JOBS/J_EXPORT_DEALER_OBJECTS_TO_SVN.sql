BEGIN
  SYS.DBMS_SCHEDULER.DROP_JOB
    (job_name  => 'J_EXPORT_DEALER_OBJECTS_TO_SVN');
END;
/

BEGIN
  SYS.DBMS_SCHEDULER.CREATE_JOB
    (
       job_name        => 'J_EXPORT_DEALER_OBJECTS_TO_SVN'
      ,start_date      => TO_TIMESTAMP_TZ('2013/12/16 17:37:25.496000 +04:00','yyyy/mm/dd hh24:mi:ss.ff tzr')
      ,repeat_interval => 'FREQ=HOURLY;INTERVAL=1;BYMINUTE=0;BYSECOND=0'
      ,end_date        => NULL
      ,job_class       => 'DEFAULT_JOB_CLASS'
      ,job_type        => 'PLSQL_BLOCK'
      ,job_action      => 'BEGIN    
  STOP_JOB_PCKG.CHECK_WORK_JOB;                              
  -- be sure to substitute in actual values
  -- where the parameter names are!
   LONTANA.EXPORTOBJECTSTODISK
         (''WWW_DEALER'',
                    ''D:\Tarifer\VersionControl\Database\DEALER'');                                                  
 END;
                           '
      ,comments        => 'Экспорт объектов в svn'
    );
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE
    ( name      => 'J_EXPORT_DEALER_OBJECTS_TO_SVN'
     ,attribute => 'RESTARTABLE'
     ,value     => FALSE);
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE
    ( name      => 'J_EXPORT_DEALER_OBJECTS_TO_SVN'
     ,attribute => 'LOGGING_LEVEL'
     ,value     => SYS.DBMS_SCHEDULER.LOGGING_OFF);
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE_NULL
    ( name      => 'J_EXPORT_DEALER_OBJECTS_TO_SVN'
     ,attribute => 'MAX_FAILURES');
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE_NULL
    ( name      => 'J_EXPORT_DEALER_OBJECTS_TO_SVN'
     ,attribute => 'MAX_RUNS');
  BEGIN
    SYS.DBMS_SCHEDULER.SET_ATTRIBUTE
      ( name      => 'J_EXPORT_DEALER_OBJECTS_TO_SVN'
       ,attribute => 'STOP_ON_WINDOW_CLOSE'
       ,value     => FALSE);
  EXCEPTION
    -- could fail if program is of type EXECUTABLE...
    WHEN OTHERS THEN
      NULL;
  END;
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE
    ( name      => 'J_EXPORT_DEALER_OBJECTS_TO_SVN'
     ,attribute => 'JOB_PRIORITY'
     ,value     => 3);
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE_NULL
    ( name      => 'J_EXPORT_DEALER_OBJECTS_TO_SVN'
     ,attribute => 'SCHEDULE_LIMIT');
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE
    ( name      => 'J_EXPORT_DEALER_OBJECTS_TO_SVN'
     ,attribute => 'AUTO_DROP'
     ,value     => TRUE);
END;
/
