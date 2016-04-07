BEGIN
  SYS.DBMS_SCHEDULER.CREATE_JOB
    (
       job_name        => 'LONTANA.J_SIM_GET_ALL_BALANCE'
      ,start_date      => SYSDATE
      ,repeat_interval => 'FREQ=HOURLY; INTERVAL=8'
      ,end_date        => NULL
      ,job_class       => 'DEFAULT_JOB_CLASS'
      ,job_type        => 'PLSQL_BLOCK'
      ,job_action      => 'BEGIN LONTANA.LOADER4_PCKG.SIM_GET_ALL_BALANCE; END;'
      ,comments        => 'Полная проверка балансов через Сервис-Гид'
    );
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE
    ( name      => 'LONTANA.J_SIM_GET_ALL_BALANCE'
     ,attribute => 'RESTARTABLE'
     ,value     => FALSE);
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE_NULL
    ( name      => 'LONTANA.J_SIM_GET_ALL_BALANCE'
     ,attribute => 'MAX_FAILURES');
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE_NULL
    ( name      => 'LONTANA.J_SIM_GET_ALL_BALANCE'
     ,attribute => 'MAX_RUNS');
  BEGIN
    SYS.DBMS_SCHEDULER.SET_ATTRIBUTE
      ( name      => 'LONTANA.J_SIM_GET_ALL_BALANCE'
       ,attribute => 'STOP_ON_WINDOW_CLOSE'
       ,value     => FALSE);
  EXCEPTION
    -- could fail if program is of type EXECUTABLE...
    WHEN OTHERS THEN
      NULL;
  END;
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE
    ( name      => 'LONTANA.J_SIM_GET_ALL_BALANCE'
     ,attribute => 'JOB_PRIORITY'
     ,value     => 3);
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE_NULL
    ( name      => 'LONTANA.J_SIM_GET_ALL_BALANCE'
     ,attribute => 'SCHEDULE_LIMIT');
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE
    ( name      => 'LONTANA.J_SIM_GET_ALL_BALANCE'
     ,attribute => 'AUTO_DROP'
     ,value     => FALSE);

  SYS.DBMS_SCHEDULER.ENABLE
    (name                  => 'LONTANA.J_SIM_GET_ALL_BALANCE');
END;
/