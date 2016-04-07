
  
BEGIN 
dbms_scheduler.create_job('"J_HOT_BILLING_SAVE_CALL"',
job_type=>'PLSQL_BLOCK', job_action=>
'BEGIN
    STOP_JOB_PCKG.CHECK_WORK_JOB;
    hot_billing_save_call1;
END;'
, number_of_arguments=>0,
start_date=>TO_TIMESTAMP_TZ('29-OCT-2012 07.32.00.000000000 PM +04:00','DD-MON-RRRR HH.MI.SSXFF AM TZR','NLS_DATE_LANGUAGE=english'), repeat_interval=> 
'FREQ=MINUTELY; INTERVAL=1'
, end_date=>NULL,
job_class=>'"DEFAULT_JOB_CLASS"', enabled=>FALSE, auto_drop=>FALSE,comments=>
'hot_billing_save_call1'
);
dbms_scheduler.set_attribute('"J_HOT_BILLING_SAVE_CALL"','job_priority',5);
COMMIT; 
END; 
