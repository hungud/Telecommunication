BEGIN
  SYS.DBMS_SCHEDULER.CREATE_JOB
    (
       job_name        => 'J_GPRS_CHECK_FLOW_1_TURN_OFF'
      ,start_date      => TO_TIMESTAMP_TZ('2015/02/26 14:54:33.886000 +03:00','yyyy/mm/dd hh24:mi:ss.ff tzr')
      ,repeat_interval => 'FREQ=MONTHLY;BYMONTHDAY=-1;BYHOUR=19;BYMINUTE=3;BYSECOND=0'
      ,end_date        => NULL
      ,job_class       => 'DEFAULT_JOB_CLASS'
      ,job_type        => 'PLSQL_BLOCK'
      ,job_action      => 'BEGIN  
  STOP_JOB_PCKG.CHECK_WORK_JOB;
  
  dbms_scheduler.disable(name=>''J_GPRS_CHECK_FLOW_1'',force=>true);
  dbms_scheduler.disable(name=>''J_GPRS_CHECK_FLOW_2'',force=>true);
  dbms_scheduler.disable(name=>''J_GPRS_CHECK_FLOW_3'',force=>true);
  dbms_scheduler.disable(name=>''J_GPRS_CHECK_FLOW_4'',force=>true);
  dbms_scheduler.disable(name=>''J_GPRS_CHECK_FLOW_5'',force=>true); 
  dbms_scheduler.disable(name=>''J_GPRS_CHECK_FLOW_6'',force=>true);     
  dbms_scheduler.disable(name=>''J_GPRS_CHECK_FLOW_7'',force=>true);      
  dbms_scheduler.disable(name=>''J_GPRS_CHECK_FLOW_8'',force=>true);
  dbms_scheduler.disable(name=>''J_GPRS_CHECK_FLOW_9'',force=>true); 
  dbms_scheduler.disable(name=>''J_GPRS_CHECK_FLOW_10'',force=>true);
  begin
   dbms_scheduler.stop_job(job_name=>''J_GPRS_CHECK_FLOW_1'',force=>true);
   dbms_scheduler.stop_job(job_name=>''J_GPRS_CHECK_FLOW_2'',force=>true);
   dbms_scheduler.stop_job(job_name=>''J_GPRS_CHECK_FLOW_3'',force=>true);
   dbms_scheduler.stop_job(job_name=>''J_GPRS_CHECK_FLOW_4'',force=>true);
   dbms_scheduler.stop_job(job_name=>''J_GPRS_CHECK_FLOW_5'',force=>true);         
   dbms_scheduler.stop_job(job_name=>''J_GPRS_CHECK_FLOW_6'',force=>true); 
   dbms_scheduler.stop_job(job_name=>''J_GPRS_CHECK_FLOW_7'',force=>true);   
   dbms_scheduler.stop_job(job_name=>''J_GPRS_CHECK_FLOW_8'',force=>true); 
   dbms_scheduler.stop_job(job_name=>''J_GPRS_CHECK_FLOW_9'',force=>true);    
   dbms_scheduler.stop_job(job_name=>''J_GPRS_CHECK_FLOW_10'',force=>true);
  exception
    when others then 
      null;
  end;
  beeline_rest_api_pckg.gprs_opts_turn_off_all_phones(0, 5); -- Отключить все доп.опции, кроме тарифного плана, на всех номерах  - поток 1
END;
    '
      ,comments        => NULL
    );
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE
    ( name      => 'J_GPRS_CHECK_FLOW_1_TURN_OFF'
     ,attribute => 'RESTARTABLE'
     ,value     => FALSE);
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE
    ( name      => 'J_GPRS_CHECK_FLOW_1_TURN_OFF'
     ,attribute => 'LOGGING_LEVEL'
     ,value     => SYS.DBMS_SCHEDULER.LOGGING_OFF);
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE_NULL
    ( name      => 'J_GPRS_CHECK_FLOW_1_TURN_OFF'
     ,attribute => 'MAX_FAILURES');
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE_NULL
    ( name      => 'J_GPRS_CHECK_FLOW_1_TURN_OFF'
     ,attribute => 'MAX_RUNS');
  BEGIN
    SYS.DBMS_SCHEDULER.SET_ATTRIBUTE
      ( name      => 'J_GPRS_CHECK_FLOW_1_TURN_OFF'
       ,attribute => 'STOP_ON_WINDOW_CLOSE'
       ,value     => FALSE);
  EXCEPTION
    -- could fail if program is of type EXECUTABLE...
    WHEN OTHERS THEN
      NULL;
  END;
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE
    ( name      => 'J_GPRS_CHECK_FLOW_1_TURN_OFF'
     ,attribute => 'JOB_PRIORITY'
     ,value     => 3);
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE_NULL
    ( name      => 'J_GPRS_CHECK_FLOW_1_TURN_OFF'
     ,attribute => 'SCHEDULE_LIMIT');
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE
    ( name      => 'J_GPRS_CHECK_FLOW_1_TURN_OFF'
     ,attribute => 'AUTO_DROP'
     ,value     => FALSE);

  SYS.DBMS_SCHEDULER.ENABLE
    (name                  => 'J_GPRS_CHECK_FLOW_1_TURN_OFF');
END;
