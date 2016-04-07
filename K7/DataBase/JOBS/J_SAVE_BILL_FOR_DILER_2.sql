BEGIN
  SYS.DBMS_SCHEDULER.DROP_JOB
    (job_name  => 'J_SAVE_BILL_FOR_DILER_2');
END;
/

BEGIN
  SYS.DBMS_SCHEDULER.CREATE_JOB
    (
       job_name        => 'J_SAVE_BILL_FOR_DILER_2'
      ,start_date      => TO_TIMESTAMP_TZ('2014/04/24 12:19:12.000000 +04:00','yyyy/mm/dd hh24:mi:ss.ff tzr')
      ,repeat_interval => 'FREQ=MONTHLY; INTERVAL=10'
      ,end_date        => NULL
      ,job_class       => 'DEFAULT_JOB_CLASS'
      ,job_type        => 'PLSQL_BLOCK'
      ,job_action      => 'BEGIN 
  --STOP_JOB_PCKG.CHECK_WORK_JOB;
  SAVE_BILL_FOR_DILER(201409); 
  /*SAVE_BILL_FOR_DILER(to_number(to_char(add_months(sysdate, -1), ''yyyymm'')));*/ 
END;'
      ,comments        => '2й поток для подсчета дилер вознаграждения'
    );
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE
    ( name      => 'J_SAVE_BILL_FOR_DILER_2'
     ,attribute => 'RESTARTABLE'
     ,value     => FALSE);
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE
    ( name      => 'J_SAVE_BILL_FOR_DILER_2'
     ,attribute => 'LOGGING_LEVEL'
     ,value     => SYS.DBMS_SCHEDULER.LOGGING_OFF);
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE_NULL
    ( name      => 'J_SAVE_BILL_FOR_DILER_2'
     ,attribute => 'MAX_FAILURES');
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE_NULL
    ( name      => 'J_SAVE_BILL_FOR_DILER_2'
     ,attribute => 'MAX_RUNS');
  BEGIN
    SYS.DBMS_SCHEDULER.SET_ATTRIBUTE
      ( name      => 'J_SAVE_BILL_FOR_DILER_2'
       ,attribute => 'STOP_ON_WINDOW_CLOSE'
       ,value     => FALSE);
  EXCEPTION
    -- could fail if program is of type EXECUTABLE...
    WHEN OTHERS THEN
      NULL;
  END;
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE
    ( name      => 'J_SAVE_BILL_FOR_DILER_2'
     ,attribute => 'JOB_PRIORITY'
     ,value     => 3);
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE_NULL
    ( name      => 'J_SAVE_BILL_FOR_DILER_2'
     ,attribute => 'SCHEDULE_LIMIT');
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE
    ( name      => 'J_SAVE_BILL_FOR_DILER_2'
     ,attribute => 'AUTO_DROP'
     ,value     => FALSE);

  SYS.DBMS_SCHEDULER.ENABLE
    (name                  => 'J_SAVE_BILL_FOR_DILER_2');
END;
/
