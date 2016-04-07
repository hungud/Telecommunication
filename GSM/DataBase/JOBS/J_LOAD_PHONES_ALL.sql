BEGIN
  for rec in(
    select * from accounts)
  loop
  SYS.DBMS_SCHEDULER.CREATE_JOB
    (
       job_name        => 'J_LOAD_PHONES_'||rec.ACCOUNT_ID
      ,start_date      => TO_TIMESTAMP_TZ('2014/03/24 00:00:00.000000 +04:00','yyyy/mm/dd hh24:mi:ss.ff tzr')
      ,repeat_interval => 'FREQ=MINUTELY;INTERVAL=10'
      ,end_date        => NULL
      ,job_class       => 'DEFAULT_JOB_CLASS'
      ,job_type        => 'PLSQL_BLOCK'
      ,job_action      => 'BEGIN
STOP_JOB_PCKG.CHECK_WORK_JOB;
loader_call_pckg_n.UPDATE_ACCOUNT_PHONES_STATE('||rec.ACCOUNT_ID||');
END;'
      ,comments        => 'Загрузка статуса абонента id '||rec.ACCOUNT_ID
    );
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE
    ( name      => 'J_LOAD_PHONES_'||rec.ACCOUNT_ID
     ,attribute => 'RESTARTABLE'
     ,value     => FALSE);
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE
    ( name      => 'J_LOAD_PHONES_'||rec.ACCOUNT_ID
     ,attribute => 'LOGGING_LEVEL'
     ,value     => SYS.DBMS_SCHEDULER.LOGGING_OFF);
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE_NULL
    ( name      => 'J_LOAD_PHONES_'||rec.ACCOUNT_ID
     ,attribute => 'MAX_FAILURES');
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE_NULL
    ( name      => 'J_LOAD_PHONES_'||rec.ACCOUNT_ID
     ,attribute => 'MAX_RUNS');
  BEGIN
    SYS.DBMS_SCHEDULER.SET_ATTRIBUTE
      ( name      => 'J_LOAD_PHONES_'||rec.ACCOUNT_ID
       ,attribute => 'STOP_ON_WINDOW_CLOSE'
       ,value     => FALSE);
  EXCEPTION
    -- could fail if program is of type EXECUTABLE...
    WHEN OTHERS THEN
      NULL;
  END;
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE
    ( name      => 'J_LOAD_PHONES_'||rec.ACCOUNT_ID
     ,attribute => 'JOB_PRIORITY'
     ,value     => 3);
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE_NULL
    ( name      => 'J_LOAD_PHONES_'||rec.ACCOUNT_ID
     ,attribute => 'SCHEDULE_LIMIT');
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE
    ( name      => 'J_LOAD_PHONES_'||rec.ACCOUNT_ID
     ,attribute => 'AUTO_DROP'
     ,value     => FALSE);

  SYS.DBMS_SCHEDULER.ENABLE
    (name                  => 'J_LOAD_PHONES_'||rec.ACCOUNT_ID);
  end loop;
END;
/
