BEGIN
  SYS.DBMS_SCHEDULER.DROP_JOB
    (job_name  => 'J_SEND_MAIL_PHONE_FOR_SAVE3');
END;
/

BEGIN
  SYS.DBMS_SCHEDULER.CREATE_JOB
    (
       job_name        => 'J_SEND_MAIL_PHONE_FOR_SAVE3'
      ,start_date      => TO_TIMESTAMP_TZ('2013/09/04 00:00:00.000000 +04:00','yyyy/mm/dd hh24:mi:ss.ff tzr')
      ,repeat_interval => 'Freq=Hourly;Interval=1;ByHour=09, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20'
      ,end_date        => NULL
      ,job_class       => 'DEFAULT_JOB_CLASS'
      ,job_type        => 'PLSQL_BLOCK'
      ,job_action      => 'begin
  STOP_JOB_PCKG.CHECK_WORK_JOB;
  SEND_MAIL_PHONE_FOR_UNBL_SAVE3;
end;'
      ,comments        => 'Отправка отчета на блокировку на сохранение '
    );
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE
    ( name      => 'J_SEND_MAIL_PHONE_FOR_SAVE3'
     ,attribute => 'RESTARTABLE'
     ,value     => FALSE);
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE
    ( name      => 'J_SEND_MAIL_PHONE_FOR_SAVE3'
     ,attribute => 'LOGGING_LEVEL'
     ,value     => SYS.DBMS_SCHEDULER.LOGGING_OFF);
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE_NULL
    ( name      => 'J_SEND_MAIL_PHONE_FOR_SAVE3'
     ,attribute => 'MAX_FAILURES');
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE_NULL
    ( name      => 'J_SEND_MAIL_PHONE_FOR_SAVE3'
     ,attribute => 'MAX_RUNS');
  BEGIN
    SYS.DBMS_SCHEDULER.SET_ATTRIBUTE
      ( name      => 'J_SEND_MAIL_PHONE_FOR_SAVE3'
       ,attribute => 'STOP_ON_WINDOW_CLOSE'
       ,value     => FALSE);
  EXCEPTION
    -- could fail if program is of type EXECUTABLE...
    WHEN OTHERS THEN
      NULL;
  END;
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE
    ( name      => 'J_SEND_MAIL_PHONE_FOR_SAVE3'
     ,attribute => 'JOB_PRIORITY'
     ,value     => 3);
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE_NULL
    ( name      => 'J_SEND_MAIL_PHONE_FOR_SAVE3'
     ,attribute => 'SCHEDULE_LIMIT');
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE
    ( name      => 'J_SEND_MAIL_PHONE_FOR_SAVE3'
     ,attribute => 'AUTO_DROP'
     ,value     => FALSE);

  SYS.DBMS_SCHEDULER.ENABLE
    (name                  => 'J_SEND_MAIL_PHONE_FOR_SAVE3');
END;
/
