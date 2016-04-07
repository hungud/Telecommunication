BEGIN
  for rec in(
    select * from accounts)
  loop
  SYS.DBMS_SCHEDULER.CREATE_JOB
    (
       job_name        => 'J_UNBLOCK_CLIENT_'||rec.ACCOUNT_ID
      ,start_date      => SYSDATE
      ,repeat_interval => 'FREQ=MINUTELY; INTERVAL=10'
      ,end_date        => NULL
      ,job_class       => 'DEFAULT_JOB_CLASS'
      ,job_type        => 'PLSQL_BLOCK'
      ,job_action      => 'BEGIN CORP_MOBILE.UNBLOCK_CLIENT_WTH_PLUS_BAL2('||rec.ACCOUNT_ID||'); END;'
      ,comments        => '–азблокировка клиентов с балансом больше 0'
    );
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE
    ( name      => 'J_UNBLOCK_CLIENT_'||rec.ACCOUNT_ID
     ,attribute => 'RESTARTABLE'
     ,value     => FALSE);
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE_NULL
    ( name      => 'J_UNBLOCK_CLIENT_'||rec.ACCOUNT_ID
     ,attribute => 'MAX_FAILURES');
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE_NULL
    ( name      => 'J_UNBLOCK_CLIENT_'||rec.ACCOUNT_ID
     ,attribute => 'MAX_RUNS');
  BEGIN
    SYS.DBMS_SCHEDULER.SET_ATTRIBUTE
      ( name      => 'J_UNBLOCK_CLIENT_'||rec.ACCOUNT_ID
       ,attribute => 'STOP_ON_WINDOW_CLOSE'
       ,value     => FALSE);
  EXCEPTION
    -- could fail if program is of type EXECUTABLE...
    WHEN OTHERS THEN
      NULL;
  END;
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE
    ( name      => 'J_UNBLOCK_CLIENT_'||rec.ACCOUNT_ID
     ,attribute => 'JOB_PRIORITY'
     ,value     => 3);
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE_NULL
    ( name      => 'J_UNBLOCK_CLIENT_'||rec.ACCOUNT_ID
     ,attribute => 'SCHEDULE_LIMIT');
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE
    ( name      => 'J_UNBLOCK_CLIENT_'||rec.ACCOUNT_ID
     ,attribute => 'AUTO_DROP'
     ,value     => FALSE);

  SYS.DBMS_SCHEDULER.ENABLE
    (name                  => 'J_UNBLOCK_CLIENT_'||rec.ACCOUNT_ID);
  end loop;  
END;
/