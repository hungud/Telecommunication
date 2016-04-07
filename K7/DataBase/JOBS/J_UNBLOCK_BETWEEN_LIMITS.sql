BEGIN
  SYS.DBMS_SCHEDULER.CREATE_JOB(
       job_name        => 'J_UNBLOCK_BETWEEN_LIMITS'
      ,start_date      => SYSDATE
      ,repeat_interval => 'FREQ=MINUTELY; INTERVAL=5; BYSECOND=0'
      ,end_date        => NULL
      ,job_class       => 'DEFAULT_JOB_CLASS'
      ,job_type        => 'PLSQL_BLOCK'
      ,job_action      => 'BEGIN 
    STOP_JOB_PCKG.CHECK_WORK_JOB;
    UNBLOCK_BETWEEN_LIMITS; 
END;'
      ,comments        => 'Разблокировка номеров с балансом между блоком и разблоком'
    );
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE
    ( name      => 'J_UNBLOCK_BETWEEN_LIMITS'
     ,attribute => 'RESTARTABLE'
     ,value     => FALSE);
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE_NULL
    ( name      => 'J_UNBLOCK_BETWEEN_LIMITS'
     ,attribute => 'MAX_FAILURES');
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE_NULL
    ( name      => 'J_UNBLOCK_BETWEEN_LIMITS'
     ,attribute => 'MAX_RUNS');
  BEGIN
    SYS.DBMS_SCHEDULER.SET_ATTRIBUTE
      ( name      => 'J_UNBLOCK_BETWEEN_LIMITS'
       ,attribute => 'STOP_ON_WINDOW_CLOSE'
       ,value     => FALSE);
  EXCEPTION
    -- could fail if program is of type EXECUTABLE...
    WHEN OTHERS THEN
      NULL;
  END;
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE
    ( name      => 'J_UNBLOCK_BETWEEN_LIMITS'
     ,attribute => 'JOB_PRIORITY'
     ,value     => 3);
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE_NULL
    ( name      => 'J_UNBLOCK_BETWEEN_LIMITS'
     ,attribute => 'SCHEDULE_LIMIT');
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE
    ( name      => 'J_UNBLOCK_BETWEEN_LIMITS'
     ,attribute => 'AUTO_DROP'
     ,value     => FALSE);

  SYS.DBMS_SCHEDULER.ENABLE(name  => 'J_UNBLOCK_BETWEEN_LIMITS');
END;
/