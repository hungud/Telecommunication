BEGIN
  SYS.DBMS_SCHEDULER.CREATE_JOB
    (
       job_name        => 'J_BLOCK_PHN_CALC_ABON_TP_UNLIM'
      ,start_date      => TO_TIMESTAMP_TZ('2015/07/02 21:00:00.000000 +03:00','yyyy/mm/dd hh24:mi:ss.ff tzr')
      ,repeat_interval => 'FREQ=MINUTELY; INTERVAL=15; BYSECOND=0'
      ,end_date        => NULL
      ,job_class       => 'DEFAULT_JOB_CLASS'
      ,job_type        => 'PLSQL_BLOCK'
      ,job_action      => 'BEGIN
    STOP_JOB_PCKG.CHECK_WORK_JOB;
    BLOCK_PHN_CALC_ABON_TP_UNLIM;
END;'
      ,comments        => NULL
    );
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE
    ( name      => 'J_BLOCK_PHN_CALC_ABON_TP_UNLIM'
     ,attribute => 'RESTARTABLE'
     ,value     => FALSE);
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE
    ( name      => 'J_BLOCK_PHN_CALC_ABON_TP_UNLIM'
     ,attribute => 'LOGGING_LEVEL'
     ,value     => SYS.DBMS_SCHEDULER.LOGGING_OFF);
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE_NULL
    ( name      => 'J_BLOCK_PHN_CALC_ABON_TP_UNLIM'
     ,attribute => 'MAX_FAILURES');
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE_NULL
    ( name      => 'J_BLOCK_PHN_CALC_ABON_TP_UNLIM'
     ,attribute => 'MAX_RUNS');
  BEGIN
    SYS.DBMS_SCHEDULER.SET_ATTRIBUTE
      ( name      => 'J_BLOCK_PHN_CALC_ABON_TP_UNLIM'
       ,attribute => 'STOP_ON_WINDOW_CLOSE'
       ,value     => FALSE);
  EXCEPTION
    -- could fail if program is of type EXECUTABLE...
    WHEN OTHERS THEN
      NULL;
  END;
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE
    ( name      => 'J_BLOCK_PHN_CALC_ABON_TP_UNLIM'
     ,attribute => 'JOB_PRIORITY'
     ,value     => 3);
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE_NULL
    ( name      => 'J_BLOCK_PHN_CALC_ABON_TP_UNLIM'
     ,attribute => 'SCHEDULE_LIMIT');
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE
    ( name      => 'J_BLOCK_PHN_CALC_ABON_TP_UNLIM'
     ,attribute => 'AUTO_DROP'
     ,value     => FALSE);
END;
