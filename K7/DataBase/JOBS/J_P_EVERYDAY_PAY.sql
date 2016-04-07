BEGIN
  SYS.DBMS_SCHEDULER.DROP_JOB
    (job_name  => 'CORP_MOBILE.J_P_EVERYDAY_PAY');
END;
/

BEGIN
  SYS.DBMS_SCHEDULER.CREATE_JOB
    (
       job_name        => 'CORP_MOBILE.J_P_EVERYDAY_PAY'
      ,start_date      => TO_TIMESTAMP_TZ('2014/04/17 00:05:00.000000 +04:00','yyyy/mm/dd hh24:mi:ss.ff tzr')
      ,repeat_interval => 'Freq=Daily;Interval=1'
      ,end_date        => NULL
      ,job_class       => 'DEFAULT_JOB_CLASS'
      ,job_type        => 'PLSQL_BLOCK'
      ,job_action      => 'begin
STOP_JOB_PCKG.CHECK_WORK_JOB;
    p_everyday_pay;
end;'
      ,comments        => NULL
    );
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE
    ( name      => 'CORP_MOBILE.J_P_EVERYDAY_PAY'
     ,attribute => 'RESTARTABLE'
     ,value     => FALSE);
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE
    ( name      => 'CORP_MOBILE.J_P_EVERYDAY_PAY'
     ,attribute => 'LOGGING_LEVEL'
     ,value     => SYS.DBMS_SCHEDULER.LOGGING_OFF);
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE_NULL
    ( name      => 'CORP_MOBILE.J_P_EVERYDAY_PAY'
     ,attribute => 'MAX_FAILURES');
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE_NULL
    ( name      => 'CORP_MOBILE.J_P_EVERYDAY_PAY'
     ,attribute => 'MAX_RUNS');
  BEGIN
    SYS.DBMS_SCHEDULER.SET_ATTRIBUTE
      ( name      => 'CORP_MOBILE.J_P_EVERYDAY_PAY'
       ,attribute => 'STOP_ON_WINDOW_CLOSE'
       ,value     => FALSE);
  EXCEPTION
    -- could fail if program is of type EXECUTABLE...
    WHEN OTHERS THEN
      NULL;
  END;
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE
    ( name      => 'CORP_MOBILE.J_P_EVERYDAY_PAY'
     ,attribute => 'JOB_PRIORITY'
     ,value     => 3);
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE_NULL
    ( name      => 'CORP_MOBILE.J_P_EVERYDAY_PAY'
     ,attribute => 'SCHEDULE_LIMIT');
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE
    ( name      => 'CORP_MOBILE.J_P_EVERYDAY_PAY'
     ,attribute => 'AUTO_DROP'
     ,value     => FALSE);

  SYS.DBMS_SCHEDULER.ENABLE
    (name                  => 'CORP_MOBILE.J_P_EVERYDAY_PAY');
END;
/
