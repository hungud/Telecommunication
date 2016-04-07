BEGIN
  SYS.DBMS_SCHEDULER.DROP_JOB
    (job_name  => 'J_SEND_MAIL_ACTIVITY_ERR');
END;
/

BEGIN
  SYS.DBMS_SCHEDULER.CREATE_JOB
    (
       job_name        => 'J_SEND_MAIL_ACTIVITY_ERR'
      ,start_date      => TO_TIMESTAMP_TZ('2014/04/22 21:13:55.140000 +04:00','yyyy/mm/dd hh24:mi:ss.ff tzr')
      ,repeat_interval => 'FREQ=MINUTELY;INTERVAL=3'
      ,end_date        => NULL
      ,job_class       => 'DEFAULT_JOB_CLASS'
      ,job_type        => 'PLSQL_BLOCK'
      ,job_action      => 'BEGIN 
  STOP_JOB_PCKG.CHECK_WORK_JOB;
  CORP_MOBILE.SEND_MAIL_NOTICE_BEELINE;
END; '
      ,comments        => 'Шлёт письма на ящик типа SEND_MAIL_NOTICE_BELINE в REPORT_MAIL_RECIPIENTS.
Ошибки из логов по блокам-разблокам и смены SIM за param= ERROR_SUBSCRIBE_CHECK_TIME мин.'
    );
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE
    ( name      => 'J_SEND_MAIL_ACTIVITY_ERR'
     ,attribute => 'RESTARTABLE'
     ,value     => FALSE);
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE
    ( name      => 'J_SEND_MAIL_ACTIVITY_ERR'
     ,attribute => 'LOGGING_LEVEL'
     ,value     => SYS.DBMS_SCHEDULER.LOGGING_OFF);
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE_NULL
    ( name      => 'J_SEND_MAIL_ACTIVITY_ERR'
     ,attribute => 'MAX_FAILURES');
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE_NULL
    ( name      => 'J_SEND_MAIL_ACTIVITY_ERR'
     ,attribute => 'MAX_RUNS');
  BEGIN
    SYS.DBMS_SCHEDULER.SET_ATTRIBUTE
      ( name      => 'J_SEND_MAIL_ACTIVITY_ERR'
       ,attribute => 'STOP_ON_WINDOW_CLOSE'
       ,value     => FALSE);
  EXCEPTION
    -- could fail if program is of type EXECUTABLE...
    WHEN OTHERS THEN
      NULL;
  END;
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE
    ( name      => 'J_SEND_MAIL_ACTIVITY_ERR'
     ,attribute => 'JOB_PRIORITY'
     ,value     => 3);
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE_NULL
    ( name      => 'J_SEND_MAIL_ACTIVITY_ERR'
     ,attribute => 'SCHEDULE_LIMIT');
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE
    ( name      => 'J_SEND_MAIL_ACTIVITY_ERR'
     ,attribute => 'AUTO_DROP'
     ,value     => FALSE);

  SYS.DBMS_SCHEDULER.ENABLE
    (name                  => 'J_SEND_MAIL_ACTIVITY_ERR');
END;
/
