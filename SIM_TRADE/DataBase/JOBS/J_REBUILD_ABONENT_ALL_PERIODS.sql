BEGIN
  SYS.DBMS_SCHEDULER.CREATE_JOB(
       job_name        => 'J_REBUILD_ABONENT_ALL_PERIODS'
      ,start_date      => SYSDATE
      ,repeat_interval => 'FREQ=MINUTELY; INTERVAL=1; BYSECOND=0'
      ,end_date        => NULL
      ,job_class       => 'DEFAULT_JOB_CLASS'
      ,job_type        => 'PLSQL_BLOCK'
      ,job_action      => 'BEGIN REBUILD_ABONENT_ALL_PERIODS; END;'
      ,comments        => 'ќчередь пересчета периодов абон активности'
    );
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE
    ( name      => 'J_REBUILD_ABONENT_ALL_PERIODS'
     ,attribute => 'RESTARTABLE'
     ,value     => FALSE);
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE_NULL
    ( name      => 'J_REBUILD_ABONENT_ALL_PERIODS'
     ,attribute => 'MAX_FAILURES');
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE_NULL
    ( name      => 'J_REBUILD_ABONENT_ALL_PERIODS'
     ,attribute => 'MAX_RUNS');
  BEGIN
    SYS.DBMS_SCHEDULER.SET_ATTRIBUTE
      ( name      => 'J_REBUILD_ABONENT_ALL_PERIODS'
       ,attribute => 'STOP_ON_WINDOW_CLOSE'
       ,value     => FALSE);
  EXCEPTION
    -- could fail if program is of type EXECUTABLE...
    WHEN OTHERS THEN
      NULL;
  END;
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE
    ( name      => 'J_REBUILD_ABONENT_ALL_PERIODS'
     ,attribute => 'JOB_PRIORITY'
     ,value     => 3);
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE_NULL
    ( name      => 'J_REBUILD_ABONENT_ALL_PERIODS'
     ,attribute => 'SCHEDULE_LIMIT');
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE
    ( name      => 'J_REBUILD_ABONENT_ALL_PERIODS'
     ,attribute => 'AUTO_DROP'
     ,value     => FALSE);

  SYS.DBMS_SCHEDULER.ENABLE(name  => 'J_REBUILD_ABONENT_ALL_PERIODS');
END;
/