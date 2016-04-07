
  
BEGIN 
dbms_scheduler.create_job('"J_CSLONTANA_C20150327"',
job_type=>'PLSQL_BLOCK', job_action=>
'BEGIN 
STOP_JOB_PCKG.CHECK_WORK_JOB;
COMPARE_BALANCES (40); 
END;'
, number_of_arguments=>0,
start_date=>NULL, repeat_interval=> 
'FREQ=YEARLY;INTERVAL=1'
, end_date=>NULL,
job_class=>'"DEFAULT_JOB_CLASS"', enabled=>FALSE, auto_drop=>FALSE,comments=>
NULL
);
COMMIT; 
END; 
