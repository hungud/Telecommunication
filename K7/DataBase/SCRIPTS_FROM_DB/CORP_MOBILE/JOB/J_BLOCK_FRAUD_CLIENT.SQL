
  
BEGIN 
dbms_scheduler.create_job('"J_BLOCK_FRAUD_CLIENT"',
job_type=>'PLSQL_BLOCK', job_action=>
'BEGIN
    STOP_JOB_PCKG.CHECK_WORK_JOB;
    BLOCK_FRAUD_CLIENT;
END;'
, number_of_arguments=>0,
start_date=>TO_TIMESTAMP_TZ('10-MAY-2012 09.25.55.000000000 PM +04:00','DD-MON-RRRR HH.MI.SSXFF AM TZR','NLS_DATE_LANGUAGE=english'), repeat_interval=> 
'FREQ=MINUTELY; INTERVAL=10'
, end_date=>NULL,
job_class=>'"DEFAULT_JOB_CLASS"', enabled=>FALSE, auto_drop=>FALSE,comments=>
'Блокировка мошенников'
);
dbms_scheduler.enable('"J_BLOCK_FRAUD_CLIENT"');
COMMIT; 
END; 
