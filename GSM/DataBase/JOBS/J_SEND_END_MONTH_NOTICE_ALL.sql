DECLARE
I INTEGER := 0;
BEGIN
  for rec in(
    select * from accounts)
  loop
 -- i:=0; -- 04.08.2015 Соколов интервал между джобами 20 минут
  SYS.DBMS_SCHEDULER.CREATE_JOB
    (
       job_name        => 'J_SEND_END_MONTH_NOTICE_'||rec.ACCOUNT_ID
      ,start_date      =>  sysdate + i*1/24/60
      ,repeat_interval => 'FREQ = MINUTELY; INTERVAL = 60'
      ,end_date        => NULL
      ,job_class       => 'DEFAULT_JOB_CLASS'
      ,job_type        => 'PLSQL_BLOCK'
      ,job_action      => 'BEGIN 
STOP_JOB_PCKG.CHECK_WORK_JOB;
SEND_SMS_NOTICE_END_MONTH2('||rec.ACCOUNT_ID||'); 
END;'
      ,comments        => 'Рассылка уведомлений о нехватке денег для абонентской платы счета '||rec.ACCOUNT_ID
    );
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE
    ( name      => 'J_SEND_END_MONTH_NOTICE_'||rec.ACCOUNT_ID
     ,attribute => 'RESTARTABLE'
     ,value     => FALSE);
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE
    ( name      => 'J_SEND_END_MONTH_NOTICE_'||rec.ACCOUNT_ID
     ,attribute => 'LOGGING_LEVEL'
     ,value     => SYS.DBMS_SCHEDULER.LOGGING_OFF);
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE_NULL
    ( name      => 'J_SEND_END_MONTH_NOTICE_'||rec.ACCOUNT_ID
     ,attribute => 'MAX_FAILURES');
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE_NULL
    ( name      => 'J_SEND_END_MONTH_NOTICE_'||rec.ACCOUNT_ID
     ,attribute => 'MAX_RUNS');
  i:=i+20; -- 04.08.2015 Соколов интервал между джобами 20 минут
  BEGIN
    SYS.DBMS_SCHEDULER.SET_ATTRIBUTE
      ( name      => 'J_SEND_END_MONTH_NOTICE_'||rec.ACCOUNT_ID
       ,attribute => 'STOP_ON_WINDOW_CLOSE'
       ,value     => FALSE);
  EXCEPTION
    -- could fail if program is of type EXECUTABLE...
    WHEN OTHERS THEN
      NULL;
  END;
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE
    ( name      => 'J_SEND_END_MONTH_NOTICE_'||rec.ACCOUNT_ID
     ,attribute => 'JOB_PRIORITY'
     ,value     => 3);
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE_NULL
    ( name      => 'J_SEND_END_MONTH_NOTICE_'||rec.ACCOUNT_ID
     ,attribute => 'SCHEDULE_LIMIT');
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE
    ( name      => 'J_SEND_END_MONTH_NOTICE_'||rec.ACCOUNT_ID
     ,attribute => 'AUTO_DROP'
     ,value     => TRUE);

  SYS.DBMS_SCHEDULER.ENABLE
    (name                  => 'J_SEND_END_MONTH_NOTICE_'||rec.ACCOUNT_ID);
  end loop;
END;
/
