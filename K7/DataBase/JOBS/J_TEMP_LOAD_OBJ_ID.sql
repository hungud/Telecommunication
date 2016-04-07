BEGIN
  SYS.DBMS_SCHEDULER.DROP_JOB
    (job_name  => 'J_TEMP_LOAD_OBJ_ID');
END;
/

BEGIN
  SYS.DBMS_SCHEDULER.CREATE_JOB
    (
       job_name        => 'J_TEMP_LOAD_OBJ_ID'
      ,start_date      => TO_TIMESTAMP_TZ('2014/02/26 15:20:10.056000 +04:00','yyyy/mm/dd hh24:mi:ss.ff tzr')
      ,repeat_interval => 'FREQ=DAILY;BYMONTHDAY=1'
      ,end_date        => NULL
      ,job_class       => 'DEFAULT_JOB_CLASS'
      ,job_type        => 'PLSQL_BLOCK'
      ,job_action      => 'begin

  STOP_JOB_PCKG.CHECK_WORK_JOB;
  for c in (select acc.account_id from accounts acc where (acc.is_collector is null or acc.is_collector=0) and acc.account_id  in (51,49,95,72,98,73)) loop
      loader_call_pckg_n.load_obj_id(c.account_id);
  end loop;   
  


end;'
      ,comments        => 'Загрузка OBG_ID по счету '
    );
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE
    ( name      => 'J_TEMP_LOAD_OBJ_ID'
     ,attribute => 'RESTARTABLE'
     ,value     => FALSE);
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE
    ( name      => 'J_TEMP_LOAD_OBJ_ID'
     ,attribute => 'LOGGING_LEVEL'
     ,value     => SYS.DBMS_SCHEDULER.LOGGING_OFF);
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE_NULL
    ( name      => 'J_TEMP_LOAD_OBJ_ID'
     ,attribute => 'MAX_FAILURES');
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE_NULL
    ( name      => 'J_TEMP_LOAD_OBJ_ID'
     ,attribute => 'MAX_RUNS');
  BEGIN
    SYS.DBMS_SCHEDULER.SET_ATTRIBUTE
      ( name      => 'J_TEMP_LOAD_OBJ_ID'
       ,attribute => 'STOP_ON_WINDOW_CLOSE'
       ,value     => FALSE);
  EXCEPTION
    -- could fail if program is of type EXECUTABLE...
    WHEN OTHERS THEN
      NULL;
  END;
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE
    ( name      => 'J_TEMP_LOAD_OBJ_ID'
     ,attribute => 'JOB_PRIORITY'
     ,value     => 3);
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE_NULL
    ( name      => 'J_TEMP_LOAD_OBJ_ID'
     ,attribute => 'SCHEDULE_LIMIT');
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE
    ( name      => 'J_TEMP_LOAD_OBJ_ID'
     ,attribute => 'AUTO_DROP'
     ,value     => FALSE);
END;
/
