DECLARE
I INTEGER;
BEGIN
  FOR I IN 0..3
  LOOP
  SYS.DBMS_SCHEDULER.CREATE_JOB
    (
       job_name        => 'J_REBUILD_STACK_ABON_PERIODS'||i
      ,start_date      => TO_TIMESTAMP_TZ('2014/11/18 09:53:30.000000 +04:00','yyyy/mm/dd hh24:mi:ss.ff tzr')
      ,repeat_interval => 'FREQ=MINUTELY; INTERVAL=1; BYSECOND=0'
      ,end_date        => NULL
      ,job_class       => 'DEFAULT_JOB_CLASS'
      ,job_type        => 'PLSQL_BLOCK'
      ,job_action      => 'BEGIN 
    STOP_JOB_PCKG.CHECK_WORK_JOB;
    REBUILD_STACK_ABONENT_PERIODS('||i||', 4); 
END;'
      ,comments        => 'Очередь обратная, для пересчета периодов абон активности'
    );
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE
    ( name      => 'J_REBUILD_STACK_ABON_PERIODS'||i
     ,attribute => 'RESTARTABLE'
     ,value     => FALSE);
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE
    ( name      => 'J_REBUILD_STACK_ABON_PERIODS'||i
     ,attribute => 'LOGGING_LEVEL'
     ,value     => SYS.DBMS_SCHEDULER.LOGGING_OFF);
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE_NULL
    ( name      => 'J_REBUILD_STACK_ABON_PERIODS'||i
     ,attribute => 'MAX_FAILURES');
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE_NULL
    ( name      => 'J_REBUILD_STACK_ABON_PERIODS'||i
     ,attribute => 'MAX_RUNS');
  BEGIN
    SYS.DBMS_SCHEDULER.SET_ATTRIBUTE
      ( name      => 'J_REBUILD_STACK_ABON_PERIODS'||i
       ,attribute => 'STOP_ON_WINDOW_CLOSE'
       ,value     => FALSE);
  EXCEPTION
    -- could fail if program is of type EXECUTABLE...
    WHEN OTHERS THEN
      NULL;
  END;
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE
    ( name      => 'J_REBUILD_STACK_ABON_PERIODS'||i
     ,attribute => 'JOB_PRIORITY'
     ,value     => 3);
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE_NULL
    ( name      => 'J_REBUILD_STACK_ABON_PERIODS'||i
     ,attribute => 'SCHEDULE_LIMIT');
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE
    ( name      => 'J_REBUILD_STACK_ABON_PERIODS'||i
     ,attribute => 'AUTO_DROP'
     ,value     => FALSE);

  SYS.DBMS_SCHEDULER.ENABLE
    (name                  => 'J_REBUILD_STACK_ABON_PERIODS'||i);

  END LOOP;
END;
/
