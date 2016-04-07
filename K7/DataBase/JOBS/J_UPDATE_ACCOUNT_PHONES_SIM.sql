BEGIN
  SYS.DBMS_SCHEDULER.DROP_JOB
    (job_name  => 'J_UPDATE_ACCOUNT_PHONES_SIM');
END;
/

BEGIN
  SYS.DBMS_SCHEDULER.CREATE_JOB
    (
       job_name        => 'J_UPDATE_ACCOUNT_PHONES_SIM'
      ,start_date      => TO_TIMESTAMP_TZ('2015/03/03 15:00:00.000000 +04:00','yyyy/mm/dd hh24:mi:ss.ff tzr')
      ,repeat_interval => 'Freq=WEEKLY;Interval=1;ByHour=15;ByMinute=00'
      ,end_date        => NULL
      ,job_class       => 'DEFAULT_JOB_CLASS'
      ,job_type        => 'PLSQL_BLOCK'
      ,job_action      => 'begin
  STOP_JOB_PCKG.CHECK_WORK_JOB;
  UPDATE_ACCOUNT_PHONES_SIM;          
end;'
      ,comments        => NULL
    );
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE
    ( name      => 'J_UPDATE_ACCOUNT_PHONES_SIM'
     ,attribute => 'RESTARTABLE'
     ,value     => FALSE);
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE
    ( name      => 'J_UPDATE_ACCOUNT_PHONES_SIM'
     ,attribute => 'LOGGING_LEVEL'
     ,value     => SYS.DBMS_SCHEDULER.LOGGING_OFF);
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE_NULL
    ( name      => 'J_UPDATE_ACCOUNT_PHONES_SIM'
     ,attribute => 'MAX_FAILURES');
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE_NULL
    ( name      => 'J_UPDATE_ACCOUNT_PHONES_SIM'
     ,attribute => 'MAX_RUNS');
  BEGIN
    SYS.DBMS_SCHEDULER.SET_ATTRIBUTE
      ( name      => 'J_UPDATE_ACCOUNT_PHONES_SIM'
       ,attribute => 'STOP_ON_WINDOW_CLOSE'
       ,value     => FALSE);
  EXCEPTION
    -- could fail if program is of type EXECUTABLE...
    WHEN OTHERS THEN
      NULL;
  END;
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE
    ( name      => 'J_UPDATE_ACCOUNT_PHONES_SIM'
     ,attribute => 'JOB_PRIORITY'
     ,value     => 3);
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE_NULL
    ( name      => 'J_UPDATE_ACCOUNT_PHONES_SIM'
     ,attribute => 'SCHEDULE_LIMIT');
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE
    ( name      => 'J_UPDATE_ACCOUNT_PHONES_SIM'
     ,attribute => 'AUTO_DROP'
     ,value     => FALSE);

  SYS.DBMS_SCHEDULER.ENABLE
    (name                  => 'J_UPDATE_ACCOUNT_PHONES_SIM');
END;
/
