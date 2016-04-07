BEGIN
  SYS.DBMS_SCHEDULER.CREATE_JOB
    (
       job_name        => 'CORP_MOBILE.J_SEND_END_MOBTH_NOTICE'
      ,start_date      => SYSDATE
      ,repeat_interval => 'FREQ=HOURLY; INTERVAL=1'
      ,end_date        => NULL
      ,job_class       => 'DEFAULT_JOB_CLASS'
      ,job_type        => 'STORED_PROCEDURE'
      ,job_action      => 'CORP_MOBILE.SEND_SMS_NOTICE_END_MONTH'
      ,comments        => 'Рассылка уведомлений о нехватке денег для абонентской платы'
    );
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE
    ( name      => 'CORP_MOBILE.J_SEND_END_MOBTH_NOTICE'
     ,attribute => 'RESTARTABLE'
     ,value     => FALSE);
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE_NULL
    ( name      => 'CORP_MOBILE.J_SEND_END_MOBTH_NOTICE'
     ,attribute => 'MAX_FAILURES');
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE_NULL
    ( name      => 'CORP_MOBILE.J_SEND_END_MOBTH_NOTICE'
     ,attribute => 'MAX_RUNS');
  BEGIN
    SYS.DBMS_SCHEDULER.SET_ATTRIBUTE
      ( name      => 'CORP_MOBILE.J_SEND_END_MOBTH_NOTICE'
       ,attribute => 'STOP_ON_WINDOW_CLOSE'
       ,value     => FALSE);
  EXCEPTION
    -- could fail if program is of type EXECUTABLE...
    WHEN OTHERS THEN
      NULL;
  END;
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE
    ( name      => 'CORP_MOBILE.J_SEND_END_MOBTH_NOTICE'
     ,attribute => 'JOB_PRIORITY'
     ,value     => 3);
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE_NULL
    ( name      => 'CORP_MOBILE.J_SEND_END_MOBTH_NOTICE'
     ,attribute => 'SCHEDULE_LIMIT');
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE
    ( name      => 'CORP_MOBILE.J_SEND_END_MOBTH_NOTICE'
     ,attribute => 'AUTO_DROP'
     ,value     => FALSE);

  SYS.DBMS_SCHEDULER.ENABLE
    (name                  => 'CORP_MOBILE.J_SEND_END_MOBTH_NOTICE');
END;
/