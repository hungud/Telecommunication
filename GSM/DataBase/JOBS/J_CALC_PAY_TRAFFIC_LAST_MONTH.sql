--BEGIN
--  SYS.DBMS_SCHEDULER.DROP_JOB
--    (job_name  => 'J_CALC_PAY_TRAFFIC_LAST_MONTH');
--END;
--/

--
-- J_CALC_PAY_TRAFFIC_LAST_MONTH  (Scheduler Job) 
--
BEGIN
  SYS.DBMS_SCHEDULER.CREATE_JOB
    (
       job_name        => 'J_CALC_PAY_TRAFFIC_LAST_MONTH'
      ,start_date      => TO_TIMESTAMP_TZ('2015/12/18 10:00:00.000000 +03:00','yyyy/mm/dd hh24:mi:ss.ff tzr')
      ,repeat_interval => 'FREQ=MONTHLY; INTERVAL=1;BYMONTHDAY=7; byhour=0;byminute=0;bysecond=0'
      ,end_date        => NULL
      ,job_class       => 'DEFAULT_JOB_CLASS'
      ,job_type        => 'PLSQL_BLOCK'
      ,job_action      => '
      begin   
        STOP_JOB_PCKG.CHECK_WORK_JOB;        
        CALC_CALL_STAT_PAY_TRAFFIC ( TO_NUMBER( TO_CHAR( ADD_MONTHS( TRUNC(SYSDATE,''MM''), -1),''YYYYMM'')) , 1 );
      end;'
      ,comments        => 'Считаем статистику по номерам для отчета по платному трафику'
    );
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE
    ( name      => 'J_CALC_PAY_TRAFFIC_LAST_MONTH'
     ,attribute => 'RESTARTABLE'
     ,value     => FALSE);
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE
    ( name      => 'J_CALC_PAY_TRAFFIC_LAST_MONTH'
     ,attribute => 'LOGGING_LEVEL'
     ,value     => SYS.DBMS_SCHEDULER.LOGGING_OFF);
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE_NULL
    ( name      => 'J_CALC_PAY_TRAFFIC_LAST_MONTH'
     ,attribute => 'MAX_FAILURES');
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE_NULL
    ( name      => 'J_CALC_PAY_TRAFFIC_LAST_MONTH'
     ,attribute => 'MAX_RUNS');
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE
    ( name      => 'J_CALC_PAY_TRAFFIC_LAST_MONTH'
     ,attribute => 'STOP_ON_WINDOW_CLOSE'
     ,value     => FALSE);
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE
    ( name      => 'J_CALC_PAY_TRAFFIC_LAST_MONTH'
     ,attribute => 'JOB_PRIORITY'
     ,value     => 3);
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE_NULL
    ( name      => 'J_CALC_PAY_TRAFFIC_LAST_MONTH'
     ,attribute => 'SCHEDULE_LIMIT');
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE
    ( name      => 'J_CALC_PAY_TRAFFIC_LAST_MONTH'
     ,attribute => 'AUTO_DROP'
     ,value     => FALSE);

  SYS.DBMS_SCHEDULER.ENABLE
    (name                  => 'J_CALC_PAY_TRAFFIC_LAST_MONTH');
END;
/
