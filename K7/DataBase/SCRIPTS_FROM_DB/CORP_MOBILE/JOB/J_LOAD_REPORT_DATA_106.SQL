
  
BEGIN 
dbms_scheduler.create_job('"J_LOAD_REPORT_DATA_106"',
job_type=>'PLSQL_BLOCK', job_action=>
'BEGIN 
STOP_JOB_PCKG.CHECK_WORK_JOB;
loader_call_pckg_n.LOAD_REPORT_DATA(106); 
END;'
, number_of_arguments=>0,
start_date=>TO_TIMESTAMP_TZ('30-JUN-2014 05.12.29.000000000 PM +04:00','DD-MON-RRRR HH.MI.SSXFF AM TZR','NLS_DATE_LANGUAGE=english'), repeat_interval=> 
'FREQ = MINUTELY; INTERVAL = 15'
, end_date=>NULL,
job_class=>'"DEFAULT_JOB_CLASS"', enabled=>FALSE, auto_drop=>TRUE,comments=>
NULL
);
dbms_scheduler.enable('"J_LOAD_REPORT_DATA_106"');
COMMIT; 
END; 
