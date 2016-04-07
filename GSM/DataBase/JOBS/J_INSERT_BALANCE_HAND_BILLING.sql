BEGIN
  SYS.DBMS_SCHEDULER.CREATE_JOB
    (
       job_name        => 'J_INSERT_BALANCE_HAND_BILLING'
      ,start_date      => TO_TIMESTAMP_TZ('2016/03/11 04:00:00.730000 +03:00','yyyy/mm/dd hh24:mi:ss.ff tzr')
      ,repeat_interval => 'FREQ=HOURLY;INTERVAL=4;BYMINUTE=0;BYSECOND=0'
      ,end_date        => NULL
      ,job_class       => 'DEFAULT_JOB_CLASS'
      ,job_type        => 'PLSQL_BLOCK'
      ,job_action      => 'begin
  STOP_JOB_PCKG.CHECK_WORK_JOB;
  INSERT_BALANCE_HAND_BILLING; 
  SEND_SMS_BALANCE_HAND_BILLING;
end;'
      ,comments        => 'Джоб заполняет таблицу BALANCE_HAND_BILLING по которой определяется списание абонентской платы по назначенному биллинг циклу'
    );
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE
    ( name      => 'LONTANA.J_INSERT_BALANCE_HAND_BILLING'
     ,attribute => 'RESTARTABLE'
     ,value     => FALSE);
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE
    ( name      => 'LONTANA.J_INSERT_BALANCE_HAND_BILLING'
     ,attribute => 'LOGGING_LEVEL'
     ,value     => SYS.DBMS_SCHEDULER.LOGGING_OFF);
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE_NULL
    ( name      => 'LONTANA.J_INSERT_BALANCE_HAND_BILLING'
     ,attribute => 'MAX_FAILURES');
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE_NULL
    ( name      => 'LONTANA.J_INSERT_BALANCE_HAND_BILLING'
     ,attribute => 'MAX_RUNS');
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE
    ( name      => 'LONTANA.J_INSERT_BALANCE_HAND_BILLING'
     ,attribute => 'STOP_ON_WINDOW_CLOSE'
     ,value     => FALSE);
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE
    ( name      => 'LONTANA.J_INSERT_BALANCE_HAND_BILLING'
     ,attribute => 'JOB_PRIORITY'
     ,value     => 3);
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE_NULL
    ( name      => 'LONTANA.J_INSERT_BALANCE_HAND_BILLING'
     ,attribute => 'SCHEDULE_LIMIT');
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE
    ( name      => 'LONTANA.J_INSERT_BALANCE_HAND_BILLING'
     ,attribute => 'AUTO_DROP'
     ,value     => FALSE);
END;
/
