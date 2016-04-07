BEGIN
  SYS.DBMS_SCHEDULER.DROP_JOB
    (job_name  => 'COLLECTOR_SERVICES');
END;
/

BEGIN
  SYS.DBMS_SCHEDULER.CREATE_JOB
    (
       job_name        => 'COLLECTOR_SERVICES'
      ,start_date      => TO_TIMESTAMP_TZ('2013/10/18 04:00:00.000000 +04:00','yyyy/mm/dd hh24:mi:ss.ff tzr')
      ,repeat_interval => 'FREQ=HOURLY; INTERVAL=12'
      ,end_date        => NULL
      ,job_class       => 'DEFAULT_JOB_CLASS'
      ,job_type        => 'PLSQL_BLOCK'
      ,job_action      => 'Declare
result varchar2(1000);
BEGIN 
  STOP_JOB_PCKG.CHECK_WORK_JOB;
  for c in (select account_id from accounts where is_collector=1) loop
    result:=CORP_MOBILE.beeline_api_pckg.Collect_account_phone_opts (c.account_id);
  end loop;
END; '
      ,comments        => 'Опции коллекторов через API'
    );
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE
    ( name      => 'COLLECTOR_SERVICES'
     ,attribute => 'RESTARTABLE'
     ,value     => FALSE);
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE
    ( name      => 'COLLECTOR_SERVICES'
     ,attribute => 'LOGGING_LEVEL'
     ,value     => SYS.DBMS_SCHEDULER.LOGGING_OFF);
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE_NULL
    ( name      => 'COLLECTOR_SERVICES'
     ,attribute => 'MAX_FAILURES');
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE_NULL
    ( name      => 'COLLECTOR_SERVICES'
     ,attribute => 'MAX_RUNS');
  BEGIN
    SYS.DBMS_SCHEDULER.SET_ATTRIBUTE
      ( name      => 'COLLECTOR_SERVICES'
       ,attribute => 'STOP_ON_WINDOW_CLOSE'
       ,value     => FALSE);
  EXCEPTION
    -- could fail if program is of type EXECUTABLE...
    WHEN OTHERS THEN
      NULL;
  END;
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE
    ( name      => 'COLLECTOR_SERVICES'
     ,attribute => 'JOB_PRIORITY'
     ,value     => 3);
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE_NULL
    ( name      => 'COLLECTOR_SERVICES'
     ,attribute => 'SCHEDULE_LIMIT');
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE
    ( name      => 'COLLECTOR_SERVICES'
     ,attribute => 'AUTO_DROP'
     ,value     => FALSE);

  SYS.DBMS_SCHEDULER.ENABLE
    (name                  => 'COLLECTOR_SERVICES');
END;
/
