BEGIN
  SYS.DBMS_SCHEDULER.CREATE_JOB
    (
       job_name        => 'J_UNBLOCK_CLIENT_WTH_PLUS_BAL'
      ,start_date      => TO_TIMESTAMP_TZ('2011/09/09 17:31:15.000000 +04:00','yyyy/mm/dd hh24:mi:ss.ff tzr')
      ,repeat_interval => 'FREQ=MINUTELY; INTERVAL=5'
      ,end_date        => NULL
      ,job_class       => 'DEFAULT_JOB_CLASS'
      ,job_type        => 'PLSQL_BLOCK'
      ,job_action      => 'BEGIN
							STOP_JOB_PCKG.CHECK_WORK_JOB;
							UNBLOCK_CLIENT_WTH_PLUS_BAL;
						   END;'
      ,comments        => 'ђазблокировка клиентов с балансом больше 0'
    );
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE
    ( name      => 'J_UNBLOCK_CLIENT_WTH_PLUS_BAL'
     ,attribute => 'RESTARTABLE'
     ,value     => FALSE);
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE
    ( name      => 'J_UNBLOCK_CLIENT_WTH_PLUS_BAL'
     ,attribute => 'LOGGING_LEVEL'
     ,value     => SYS.DBMS_SCHEDULER.LOGGING_OFF);
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE_NULL
    ( name      => 'J_UNBLOCK_CLIENT_WTH_PLUS_BAL'
     ,attribute => 'MAX_FAILURES');
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE_NULL
    ( name      => 'J_UNBLOCK_CLIENT_WTH_PLUS_BAL'
     ,attribute => 'MAX_RUNS');
  BEGIN
    SYS.DBMS_SCHEDULER.SET_ATTRIBUTE
      ( name      => 'J_UNBLOCK_CLIENT_WTH_PLUS_BAL'
       ,attribute => 'STOP_ON_WINDOW_CLOSE'
       ,value     => FALSE);
  EXCEPTION
    -- could fail if program is of type EXECUTABLE...
    WHEN OTHERS THEN
      NULL;
  END;
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE
    ( name      => 'J_UNBLOCK_CLIENT_WTH_PLUS_BAL'
     ,attribute => 'JOB_PRIORITY'
     ,value     => 3);
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE_NULL
    ( name      => 'J_UNBLOCK_CLIENT_WTH_PLUS_BAL'
     ,attribute => 'SCHEDULE_LIMIT');
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE
    ( name      => 'J_UNBLOCK_CLIENT_WTH_PLUS_BAL'
     ,attribute => 'AUTO_DROP'
     ,value     => FALSE);

  SYS.DBMS_SCHEDULER.ENABLE
    (name                  => 'J_UNBLOCK_CLIENT_WTH_PLUS_BAL');
END;
/
