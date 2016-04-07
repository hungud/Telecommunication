BEGIN
  SYS.DBMS_SCHEDULER.CREATE_JOB(
       job_name        => 'J_BALANCE_ABON_DOP_STATUS'
      ,start_date      => trunc(SYSDATE) + 15/24/60
      ,repeat_interval => 'FREQ=DAILY; INTERVAL=1; BYHOUR=1; BYMINUTE=5; BYSECOND=0'
      ,end_date        => NULL
      ,job_class       => 'DEFAULT_JOB_CLASS'
      ,job_type        => 'PLSQL_BLOCK'
      ,job_action      => 'BEGIN 
  CALC_BALANCE_PCKG.ADD_ABON_DOP_STATUS;
  CALC_BALANCE_PCKG.SAVE_ABON_DOP_STATUS; 
END;'
      ,comments        => 'Извещение Драйвов о след месяце, сохранение списка'
    );
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE
    ( name      => 'J_BALANCE_ABON_DOP_STATUS'
     ,attribute => 'RESTARTABLE'
     ,value     => FALSE);
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE_NULL
    ( name      => 'J_BALANCE_ABON_DOP_STATUS'
     ,attribute => 'MAX_FAILURES');
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE_NULL
    ( name      => 'J_BALANCE_ABON_DOP_STATUS'
     ,attribute => 'MAX_RUNS');
  BEGIN
    SYS.DBMS_SCHEDULER.SET_ATTRIBUTE
      ( name      => 'J_BALANCE_ABON_DOP_STATUS'
       ,attribute => 'STOP_ON_WINDOW_CLOSE'
       ,value     => FALSE);
  EXCEPTION
    -- could fail if program is of type EXECUTABLE...
    WHEN OTHERS THEN
      NULL;
  END;
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE
    ( name      => 'J_BALANCE_ABON_DOP_STATUS'
     ,attribute => 'JOB_PRIORITY'
     ,value     => 3);
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE_NULL
    ( name      => 'J_BALANCE_ABON_DOP_STATUS'
     ,attribute => 'SCHEDULE_LIMIT');
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE
    ( name      => 'J_BALANCE_ABON_DOP_STATUS'
     ,attribute => 'AUTO_DROP'
     ,value     => FALSE);

  SYS.DBMS_SCHEDULER.ENABLE(name  => 'J_BALANCE_ABON_DOP_STATUS');
END;
/