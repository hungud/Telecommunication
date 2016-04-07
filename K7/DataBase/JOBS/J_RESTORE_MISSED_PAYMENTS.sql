BEGIN
  SYS.DBMS_SCHEDULER.DROP_JOB
    (job_name  => 'CORP_MOBILE.J_RESTORE_MISSED_PAYMENTS');
END;
/

BEGIN
  SYS.DBMS_SCHEDULER.CREATE_JOB
    (
       job_name        => 'CORP_MOBILE.J_RESTORE_MISSED_PAYMENTS'
      ,start_date      => TO_TIMESTAMP_TZ('2015/09/03 14:15:00.000000 +03:00','yyyy/mm/dd hh24:mi:ss.ff tzr')
      ,repeat_interval => 'FREQ=HOURLY; INTERVAL=3;'
      ,end_date        => NULL
      ,job_class       => 'DEFAULT_JOB_CLASS'
      ,job_type        => 'PLSQL_BLOCK'
      ,job_action      => 'BEGIN 
    STOP_JOB_PCKG.CHECK_WORK_JOB;  
    RESTORE_MISSED_PAYMENTS; 
END;'
      ,comments        => 'Загрузка платежей'
    );
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE
    ( name      => 'CORP_MOBILE.J_RESTORE_MISSED_PAYMENTS'
     ,attribute => 'RESTARTABLE'
     ,value     => FALSE);
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE
    ( name      => 'CORP_MOBILE.J_RESTORE_MISSED_PAYMENTS'
     ,attribute => 'LOGGING_LEVEL'
     ,value     => SYS.DBMS_SCHEDULER.LOGGING_OFF);
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE_NULL
    ( name      => 'CORP_MOBILE.J_RESTORE_MISSED_PAYMENTS'
     ,attribute => 'MAX_FAILURES');
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE_NULL
    ( name      => 'CORP_MOBILE.J_RESTORE_MISSED_PAYMENTS'
     ,attribute => 'MAX_RUNS');
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE
    ( name      => 'CORP_MOBILE.J_RESTORE_MISSED_PAYMENTS'
     ,attribute => 'STOP_ON_WINDOW_CLOSE'
     ,value     => FALSE);
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE
    ( name      => 'CORP_MOBILE.J_RESTORE_MISSED_PAYMENTS'
     ,attribute => 'JOB_PRIORITY'
     ,value     => 3);
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE_NULL
    ( name      => 'CORP_MOBILE.J_RESTORE_MISSED_PAYMENTS'
     ,attribute => 'SCHEDULE_LIMIT');
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE
    ( name      => 'CORP_MOBILE.J_RESTORE_MISSED_PAYMENTS'
     ,attribute => 'AUTO_DROP'
     ,value     => FALSE);

  SYS.DBMS_SCHEDULER.ENABLE
    (name                  => 'CORP_MOBILE.J_RESTORE_MISSED_PAYMENTS');
END;
/
