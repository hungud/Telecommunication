BEGIN
  SYS.DBMS_SCHEDULER.CREATE_JOB
    (
       job_name        => 'LONTANA.J_SEND_SMS_VIP'
      ,start_date      => TO_TIMESTAMP_TZ('2016/03/02 14:12:40.375000 +03:00','yyyy/mm/dd hh24:mi:ss.ff tzr')
      ,repeat_interval => 'FREQ=DAILY;INTERVAL=1'
      ,end_date        => NULL
      ,job_class       => 'DEFAULT_JOB_CLASS'
      ,job_type        => 'PLSQL_BLOCK'
      ,job_action      => 'begin
 STOP_JOB_PCKG.CHECK_WORK_JOB;
 SEND_SMS_PHONE_CONTRACT_VIP;
end;'
      ,comments        => 'Запуск проверки новых номеров на их входимость в ВИП группу. Новым номерам отправляется информационное СМС'
    );
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE
    ( name      => 'LONTANA.J_SEND_SMS_VIP'
     ,attribute => 'RESTARTABLE'
     ,value     => FALSE);
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE
    ( name      => 'LONTANA.J_SEND_SMS_VIP'
     ,attribute => 'LOGGING_LEVEL'
     ,value     => SYS.DBMS_SCHEDULER.LOGGING_OFF);
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE_NULL
    ( name      => 'LONTANA.J_SEND_SMS_VIP'
     ,attribute => 'MAX_FAILURES');
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE_NULL
    ( name      => 'LONTANA.J_SEND_SMS_VIP'
     ,attribute => 'MAX_RUNS');
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE
    ( name      => 'LONTANA.J_SEND_SMS_VIP'
     ,attribute => 'STOP_ON_WINDOW_CLOSE'
     ,value     => FALSE);
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE
    ( name      => 'LONTANA.J_SEND_SMS_VIP'
     ,attribute => 'JOB_PRIORITY'
     ,value     => 3);
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE_NULL
    ( name      => 'LONTANA.J_SEND_SMS_VIP'
     ,attribute => 'SCHEDULE_LIMIT');
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE
    ( name      => 'LONTANA.J_SEND_SMS_VIP'
     ,attribute => 'AUTO_DROP'
     ,value     => FALSE);
END;
/
