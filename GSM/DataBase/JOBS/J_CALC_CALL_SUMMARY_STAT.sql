<<<<<<< .mine
BEGIN
  SYS.DBMS_SCHEDULER.DROP_JOB
    (job_name  => 'J_CALC_CALL_SUMMARY_STAT');
END;
/

BEGIN
  SYS.DBMS_SCHEDULER.CREATE_JOB
    (
       job_name        => 'J_CALC_CALL_SUMMARY_STAT'    
      ,start_date      => TO_TIMESTAMP_TZ('2015/03/06 20:00:00.000000 +03:00','yyyy/mm/dd hh24:mi:ss.ff tzr')
      ,repeat_interval => 'FREQ=MONTHLY; INTERVAL=1;BYMONTHDAY=5; byhour=0;byminute=0;bysecond=0'
      ,end_date        => NULL
      ,job_class       => 'DEFAULT_JOB_CLASS'
      ,job_type        => 'PLSQL_BLOCK'
      ,job_action      => '
      begin   
        STOP_JOB_PCKG.CHECK_WORK_JOB;        
        CALC_CALL_SUMMARY_STAT ( TO_NUMBER( TO_CHAR( ADD_MONTHS( TRUNC(SYSDATE,''MM''), 0-to_number( ms_params.GET_PARAM_VALUE(''MONTH_OFFSET_MONITOR_OUTGOING_CALLS'' )
                                                                                                   )
                                                               ) 
                                                     ,''YYYYMM'' 
                                                   )
                                          )
                               , 1
                               );
      end;'
      ,comments        => '—читаем сводную статистику по номерам дл€ отчета по исход€щей голосовой св€зи'
    );
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE
    ( name      => 'J_CALC_CALL_SUMMARY_STAT'
     ,attribute => 'RESTARTABLE'
     ,value     => FALSE);
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE
    ( name      => 'J_CALC_CALL_SUMMARY_STAT'
     ,attribute => 'LOGGING_LEVEL'
     ,value     => SYS.DBMS_SCHEDULER.LOGGING_OFF);
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE_NULL
    ( name      => 'J_CALC_CALL_SUMMARY_STAT'
     ,attribute => 'MAX_FAILURES');
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE_NULL
    ( name      => 'J_CALC_CALL_SUMMARY_STAT'
     ,attribute => 'MAX_RUNS');
  BEGIN
    SYS.DBMS_SCHEDULER.SET_ATTRIBUTE
      ( name      => 'J_CALC_CALL_SUMMARY_STAT'
       ,attribute => 'STOP_ON_WINDOW_CLOSE'
       ,value     => FALSE);
  EXCEPTION
    -- could fail if program is of type EXECUTABLE...
    WHEN OTHERS THEN
      NULL;
  END;
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE
    ( name      => 'J_CALC_CALL_SUMMARY_STAT'
     ,attribute => 'JOB_PRIORITY'
     ,value     => 3);
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE_NULL
    ( name      => 'J_CALC_CALL_SUMMARY_STAT'
     ,attribute => 'SCHEDULE_LIMIT');
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE
    ( name      => 'J_CALC_CALL_SUMMARY_STAT'
     ,attribute => 'AUTO_DROP'
     ,value     => FALSE);

  SYS.DBMS_SCHEDULER.ENABLE
    (name                  => 'J_CALC_CALL_SUMMARY_STAT');
END;
/
=======
BEGIN
  SYS.DBMS_SCHEDULER.DROP_JOB
    (job_name  => 'J_CALC_CALL_SUMMARY_STAT');
END;
/

BEGIN
  SYS.DBMS_SCHEDULER.CREATE_JOB
    (
       job_name        => 'J_CALC_CALL_SUMMARY_STAT'
      ,start_date      => TO_TIMESTAMP_TZ('2015/03/06 20:00:00.000000 +04:00','yyyy/mm/dd hh24:mi:ss.ff tzr')
      ,repeat_interval => 'FREQ=MONTHLY; INTERVAL=1;BYMONTHDAY=5; byhour=0;byminute=0;bysecond=0'
      ,end_date        => NULL
      ,job_class       => 'DEFAULT_JOB_CLASS'
      ,job_type        => 'PLSQL_BLOCK'
      ,job_action      => 'begin   
STOP_JOB_PCKG.CHECK_WORK_JOB;
CALC_CALL_SUMMARY_STAT(TO_NUMBER(TO_CHAR(ADD_MONTHS(TRUNC(SYSDATE,''MM''),-1), ''YYYYMM'')), 1); 
end;'
      ,comments        => '—читаем сводную статистику по номерам дл€ отчета'
    );
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE
    ( name      => 'J_CALC_CALL_SUMMARY_STAT'
     ,attribute => 'RESTARTABLE'
     ,value     => FALSE);
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE
    ( name      => 'J_CALC_CALL_SUMMARY_STAT'
     ,attribute => 'LOGGING_LEVEL'
     ,value     => SYS.DBMS_SCHEDULER.LOGGING_OFF);
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE_NULL
    ( name      => 'J_CALC_CALL_SUMMARY_STAT'
     ,attribute => 'MAX_FAILURES');
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE_NULL
    ( name      => 'J_CALC_CALL_SUMMARY_STAT'
     ,attribute => 'MAX_RUNS');
  BEGIN
    SYS.DBMS_SCHEDULER.SET_ATTRIBUTE
      ( name      => 'J_CALC_CALL_SUMMARY_STAT'
       ,attribute => 'STOP_ON_WINDOW_CLOSE'
       ,value     => FALSE);
  EXCEPTION
    -- could fail if program is of type EXECUTABLE...
    WHEN OTHERS THEN
      NULL;
  END;
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE
    ( name      => 'J_CALC_CALL_SUMMARY_STAT'
     ,attribute => 'JOB_PRIORITY'
     ,value     => 3);
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE_NULL
    ( name      => 'J_CALC_CALL_SUMMARY_STAT'
     ,attribute => 'SCHEDULE_LIMIT');
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE
    ( name      => 'J_CALC_CALL_SUMMARY_STAT'
     ,attribute => 'AUTO_DROP'
     ,value     => FALSE);

  SYS.DBMS_SCHEDULER.ENABLE
    (name                  => 'J_CALC_CALL_SUMMARY_STAT');
END;
/
>>>>>>> .r6944
