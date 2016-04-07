
  
BEGIN 
dbms_scheduler.create_job('"J_GPRS_CHECK_FLOW_1"',
job_type=>'PLSQL_BLOCK', job_action=>
'BEGIN
    STOP_JOB_PCKG.CHECK_WORK_JOB;
--    BEELINE_REST_API_PCKG.gprs_check_phone_all; 
    BEELINE_REST_API_PCKG.gprs_check_phone_flow(0);        
END;
'
, number_of_arguments=>0,
start_date=>TO_TIMESTAMP_TZ('18-APR-2015 09.00.00.000000000 PM +03:00','DD-MON-RRRR HH.MI.SSXFF AM TZR','NLS_DATE_LANGUAGE=english'), repeat_interval=> 
'FREQ=MINUTELY; INTERVAL=10;'
, end_date=>NULL,
job_class=>'"DEFAULT_JOB_CLASS"', enabled=>FALSE, auto_drop=>FALSE,comments=>
'Автоподключение пакетов'
);
dbms_scheduler.enable('"J_GPRS_CHECK_FLOW_1"');
COMMIT; 
END; 
