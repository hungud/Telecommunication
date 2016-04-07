BEGIN
FOR i  IN  1 .. 2 LOOP
  SYS.DBMS_SCHEDULER.CREATE_JOB
    (
       job_name        => 'J_HOT_BILLING_CALCDETAILSUM'||i
      ,start_date      => TO_TIMESTAMP_TZ('2012/10/28 20:44:42.000000 +04:00','yyyy/mm/dd hh24:mi:ss.ff tzr')
      ,repeat_interval => 'FREQ=SECONDLY; INTERVAL=5'
      ,end_date        => NULL
      ,job_class       => 'DEFAULT_JOB_CLASS'
      ,job_type        => 'PLSQL_BLOCK'
      ,job_action      => 'begin
							STOP_JOB_PCKG.CHECK_WORK_JOB;
							HOT_BILLING_CALCDETAILSUMS(0,'||i||');
						   end;'
      ,comments        => 'Горячий биллинг сумм по детализации'
    );
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE
    ( name      => 'J_HOT_BILLING_CALCDETAILSUM'||i
     ,attribute => 'RESTARTABLE'
     ,value     => FALSE);
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE
    ( name      => 'J_HOT_BILLING_CALCDETAILSUM'||i
     ,attribute => 'LOGGING_LEVEL'
     ,value     => SYS.DBMS_SCHEDULER.LOGGING_OFF);
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE_NULL
    ( name      => 'J_HOT_BILLING_CALCDETAILSUM'||i
     ,attribute => 'MAX_FAILURES');
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE_NULL
    ( name      => 'J_HOT_BILLING_CALCDETAILSUM'||i
     ,attribute => 'MAX_RUNS');
  BEGIN
    SYS.DBMS_SCHEDULER.SET_ATTRIBUTE
      ( name      => 'J_HOT_BILLING_CALCDETAILSUM'||i
       ,attribute => 'STOP_ON_WINDOW_CLOSE'
       ,value     => FALSE);
  EXCEPTION
    -- could fail if program is of type EXECUTABLE...
    WHEN OTHERS THEN
      NULL;
  END;
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE
    ( name      => 'J_HOT_BILLING_CALCDETAILSUM'||i
     ,attribute => 'JOB_PRIORITY'
     ,value     => 3);
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE_NULL
    ( name      => 'J_HOT_BILLING_CALCDETAILSUM'||i
     ,attribute => 'SCHEDULE_LIMIT');
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE
    ( name      => 'J_HOT_BILLING_CALCDETAILSUM'||i
     ,attribute => 'AUTO_DROP'
     ,value     => TRUE);

  SYS.DBMS_SCHEDULER.ENABLE
    (name                  => 'J_HOT_BILLING_CALCDETAILSUM'||i);
END LOOP;
END;
/
