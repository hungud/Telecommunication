
  
BEGIN 
dbms_scheduler.create_job('"J_CSCORP_MOBILE_C20150303"',
job_type=>'PLSQL_BLOCK', job_action=>
'BEGIN COMPARE_BALANCES (79); END;'
, number_of_arguments=>0,
start_date=>NULL, repeat_interval=> 
'FREQ=YEARLY;INTERVAL=1'
, end_date=>NULL,
job_class=>'"DEFAULT_JOB_CLASS"', enabled=>FALSE, auto_drop=>FALSE,comments=>
NULL
);
COMMIT; 
END; 
