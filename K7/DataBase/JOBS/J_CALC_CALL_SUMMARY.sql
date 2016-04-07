BEGIN
  SYS.DBMS_SCHEDULER.DROP_JOB
    (job_name  => 'J_CALC_CALL_SUMMARY');
END;
/

BEGIN
  SYS.DBMS_SCHEDULER.CREATE_JOB
    (
       job_name        => 'J_CALC_CALL_SUMMARY'
      ,start_date      => TO_TIMESTAMP_TZ('2014/10/23 18:15:20.372000 +04:00','yyyy/mm/dd hh24:mi:ss.ff tzr')
      ,repeat_interval => 'FREQ=MONTHLY; INTERVAL=1;BYMONTHDAY=10; byhour=0;byminute=0;bysecond=0'
      ,end_date        => NULL
      ,job_class       => 'DEFAULT_JOB_CLASS'
      ,job_type        => 'PLSQL_BLOCK'
      ,job_action      => 'begin   
    STOP_JOB_PCKG.CHECK_WORK_JOB;
    CALC_CALL_SUMMARY(TO_NUMBER(TO_CHAR(ADD_MONTHS(TRUNC(SYSDATE,''MM''),-1), ''YYYYMM'')), 1); 
end;'
      ,comments        => 'Считаем сводную статистику по номерам для отчета "Анализ базы номеров(отток\подключения)"'
    );
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE
    ( name      => 'J_CALC_CALL_SUMMARY'
     ,attribute => 'RESTARTABLE'
     ,value     => FALSE);
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE
    ( name      => 'J_CALC_CALL_SUMMARY'
     ,attribute => 'LOGGING_LEVEL'
     ,value     => SYS.DBMS_SCHEDULER.LOGGING_OFF);
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE_NULL
    ( name      => 'J_CALC_CALL_SUMMARY'
     ,attribute => 'MAX_FAILURES');
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE_NULL
    ( name      => 'J_CALC_CALL_SUMMARY'
     ,attribute => 'MAX_RUNS');
  BEGIN
    SYS.DBMS_SCHEDULER.SET_ATTRIBUTE
      ( name      => 'J_CALC_CALL_SUMMARY'
       ,attribute => 'STOP_ON_WINDOW_CLOSE'
       ,value     => FALSE);
  EXCEPTION
    -- could fail if program is of type EXECUTABLE...
    WHEN OTHERS THEN
      NULL;
  END;
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE
    ( name      => 'J_CALC_CALL_SUMMARY'
     ,attribute => 'JOB_PRIORITY'
     ,value     => 3);
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE_NULL
    ( name      => 'J_CALC_CALL_SUMMARY'
     ,attribute => 'SCHEDULE_LIMIT');
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE
    ( name      => 'J_CALC_CALL_SUMMARY'
     ,attribute => 'AUTO_DROP'
     ,value     => FALSE);

  SYS.DBMS_SCHEDULER.ENABLE
    (name                  => 'J_CALC_CALL_SUMMARY');
END;
/
