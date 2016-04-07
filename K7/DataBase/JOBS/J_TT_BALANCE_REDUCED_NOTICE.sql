BEGIN
  SYS.DBMS_SCHEDULER.DROP_JOB
    (job_name  => 'J_TT_BALANCE_REDUCED_NOTICE');
END;
/

BEGIN
  SYS.DBMS_SCHEDULER.CREATE_JOB
    (
       job_name        => 'J_TT_BALANCE_REDUCED_NOTICE'
      ,start_date      => TO_TIMESTAMP_TZ('2014/06/04 09:48:54.000000 +04:00','yyyy/mm/dd hh24:mi:ss.ff tzr')
      ,repeat_interval => 'FREQ = MINUTELY; INTERVAL = 1'
      ,end_date        => NULL
      ,job_class       => 'DEFAULT_JOB_CLASS'
      ,job_type        => 'PLSQL_BLOCK'
      ,job_action      => 'BEGIN 
  STOP_JOB_PCKG.CHECK_WORK_JOB;
  TT_BALANCE_REDUCED_PCKG.SEND_NOTICES; 
END;'
      ,comments        => ' –ассылка смс с оповещением о балансе'
    );
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE
    ( name      => 'J_TT_BALANCE_REDUCED_NOTICE'
     ,attribute => 'RESTARTABLE'
     ,value     => FALSE);
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE
    ( name      => 'J_TT_BALANCE_REDUCED_NOTICE'
     ,attribute => 'LOGGING_LEVEL'
     ,value     => SYS.DBMS_SCHEDULER.LOGGING_OFF);
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE_NULL
    ( name      => 'J_TT_BALANCE_REDUCED_NOTICE'
     ,attribute => 'MAX_FAILURES');
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE_NULL
    ( name      => 'J_TT_BALANCE_REDUCED_NOTICE'
     ,attribute => 'MAX_RUNS');
  BEGIN
    SYS.DBMS_SCHEDULER.SET_ATTRIBUTE
      ( name      => 'J_TT_BALANCE_REDUCED_NOTICE'
       ,attribute => 'STOP_ON_WINDOW_CLOSE'
       ,value     => FALSE);
  EXCEPTION
    -- could fail if program is of type EXECUTABLE...
    WHEN OTHERS THEN
      NULL;
  END;
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE
    ( name      => 'J_TT_BALANCE_REDUCED_NOTICE'
     ,attribute => 'JOB_PRIORITY'
     ,value     => 3);
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE_NULL
    ( name      => 'J_TT_BALANCE_REDUCED_NOTICE'
     ,attribute => 'SCHEDULE_LIMIT');
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE
    ( name      => 'J_TT_BALANCE_REDUCED_NOTICE'
     ,attribute => 'AUTO_DROP'
     ,value     => TRUE);

  SYS.DBMS_SCHEDULER.ENABLE
    (name                  => 'J_TT_BALANCE_REDUCED_NOTICE');
END;
/
