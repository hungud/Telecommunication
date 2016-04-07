
  
BEGIN 
dbms_scheduler.create_job('"J_GPRS_CHECK_FLOW_1_TURN_OFF"',
job_type=>'PLSQL_BLOCK', job_action=>
'BEGIN  
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
, number_of_arguments=>0,
start_date=>TO_TIMESTAMP_TZ('26-FEB-2015 02.54.33.886000000 PM +03:00','DD-MON-RRRR HH.MI.SSXFF AM TZR','NLS_DATE_LANGUAGE=english'), repeat_interval=> 
'FREQ=MONTHLY;BYMONTHDAY=-1;BYHOUR=19;BYMINUTE=3;BYSECOND=0'
, end_date=>NULL,
job_class=>'"DEFAULT_JOB_CLASS"', enabled=>FALSE, auto_drop=>FALSE,comments=>
NULL
);
dbms_scheduler.enable('"J_GPRS_CHECK_FLOW_1_TURN_OFF"');
COMMIT; 
END; 
