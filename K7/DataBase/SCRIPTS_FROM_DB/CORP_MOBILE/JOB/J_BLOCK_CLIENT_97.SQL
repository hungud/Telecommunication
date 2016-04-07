
  
BEGIN 
dbms_scheduler.create_job('"J_BLOCK_CLIENT_97"',
job_type=>'PLSQL_BLOCK', job_action=>
'BEGIN 
    STOP_JOB_PCKG.CHECK_WORK_JOB;
    BLOCK_CLIENT_WTH_0_BAL2(97); 
END;'
, number_of_arguments=>0,
start_date=>TO_TIMESTAMP_TZ('16-OCT-2013 05.26.45.000000000 PM +04:00','DD-MON-RRRR HH.MI.SSXFF AM TZR','NLS_DATE_LANGUAGE=english'), repeat_interval=> 
'FREQ = MINUTELY; INTERVAL = 15'
, end_date=>NULL,
job_class=>'"DEFAULT_JOB_CLASS"', enabled=>FALSE, auto_drop=>TRUE,comments=>
NULL
);
dbms_scheduler.enable('"J_BLOCK_CLIENT_97"');
COMMIT; 
END; 
