
  
BEGIN 
dbms_scheduler.create_job('"J_BLOCK_CLIENT_12"',
job_type=>'PLSQL_BLOCK', job_action=>
'BEGIN BLOCK_CLIENT_WTH_0_BAL2(12); END;'
, number_of_arguments=>0,
start_date=>TO_TIMESTAMP_TZ('02-FEB-2015 11.03.20.000000000 AM +03:00','DD-MON-RRRR HH.MI.SSXFF AM TZR','NLS_DATE_LANGUAGE=english'), repeat_interval=> 
'FREQ = MINUTELY; INTERVAL = 15'
, end_date=>NULL,
job_class=>'"DEFAULT_JOB_CLASS"', enabled=>FALSE, auto_drop=>TRUE,comments=>
'Блокировка клиента ACCOUNT_ID 12'
);
COMMIT; 
END; 
