BEGIN
  SYS.DBMS_SCHEDULER.DROP_JOB
    (job_name  => 'J_COLLECT_CHECK_STATUS');
END;
/

BEGIN
  SYS.DBMS_SCHEDULER.CREATE_JOB
    (
       job_name        => 'J_COLLECT_CHECK_STATUS'
      ,start_date      => TO_TIMESTAMP_TZ('2014/04/17 22:21:24.407000 +04:00','yyyy/mm/dd hh24:mi:ss.ff tzr')
      ,repeat_interval => 'FREQ=MINUTELY;INTERVAL=7'
      ,end_date        => NULL
      ,job_class       => 'DEFAULT_JOB_CLASS'
      ,job_type        => 'PLSQL_BLOCK'
      ,job_action      => 'declare
tmp varchar(500);
begin 
STOP_JOB_PCKG.CHECK_WORK_JOB;
for c in (select t.phone_number from v_collect_check_status t) loop
tmp:=beeline_api_pckg.phone_status(c.phone_number);
end loop;
end;'
      ,comments        => 'Обновляет статусы недавно разблоченных, заблоченных номеров коллектора.'
    );
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE
    ( name      => 'J_COLLECT_CHECK_STATUS'
     ,attribute => 'RESTARTABLE'
     ,value     => FALSE);
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE
    ( name      => 'J_COLLECT_CHECK_STATUS'
     ,attribute => 'LOGGING_LEVEL'
     ,value     => SYS.DBMS_SCHEDULER.LOGGING_OFF);
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE_NULL
    ( name      => 'J_COLLECT_CHECK_STATUS'
     ,attribute => 'MAX_FAILURES');
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE_NULL
    ( name      => 'J_COLLECT_CHECK_STATUS'
     ,attribute => 'MAX_RUNS');
  BEGIN
    SYS.DBMS_SCHEDULER.SET_ATTRIBUTE
      ( name      => 'J_COLLECT_CHECK_STATUS'
       ,attribute => 'STOP_ON_WINDOW_CLOSE'
       ,value     => FALSE);
  EXCEPTION
    -- could fail if program is of type EXECUTABLE...
    WHEN OTHERS THEN
      NULL;
  END;
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE
    ( name      => 'J_COLLECT_CHECK_STATUS'
     ,attribute => 'JOB_PRIORITY'
     ,value     => 3);
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE_NULL
    ( name      => 'J_COLLECT_CHECK_STATUS'
     ,attribute => 'SCHEDULE_LIMIT');
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE
    ( name      => 'J_COLLECT_CHECK_STATUS'
     ,attribute => 'AUTO_DROP'
     ,value     => FALSE);

  SYS.DBMS_SCHEDULER.ENABLE
    (name                  => 'J_COLLECT_CHECK_STATUS');
END;
/
BEGIN
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE
    ( name      => 'CORP_MOBILE.J_COLLECT_CHECK_STATUS'
     ,attribute => 'JOB_ACTION'
     ,value     => 'declare
  tmp varchar(500);
begin 
  STOP_JOB_PCKG.CHECK_WORK_JOB;
  for c in (
            select t.phone_number from v_collect_check_status t
           )
  loop
    begin
      tmp := beeline_api_pckg.phone_status(c.phone_number);
    exception
      when others then
        null;
    end;
  end loop;
end;');
END;
/
BEGIN
  SYS.DBMS_SCHEDULER.ENABLE
    (name => 'CORP_MOBILE.J_COLLECT_CHECK_STATUS');
END;
/