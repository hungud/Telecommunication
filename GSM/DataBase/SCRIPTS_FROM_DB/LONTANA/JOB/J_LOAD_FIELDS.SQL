
  
BEGIN 
dbms_scheduler.create_job('"J_LOAD_FIELDS"',
job_type=>'PLSQL_BLOCK', job_action=>
'BEGIN 
STOP_JOB_PCKG.CHECK_WORK_JOB;
READ_FIELD_FROM_DETAILS(5); 
END;'
, number_of_arguments=>0,
start_date=>TO_TIMESTAMP_TZ('16-FEB-2012 12.00.40.000000000 AM +04:00','DD-MON-RRRR HH.MI.SSXFF AM TZR','NLS_DATE_LANGUAGE=english'), repeat_interval=> 
'FREQ=DAILY; INTERVAL=1'
, end_date=>NULL,
job_class=>'"DEFAULT_JOB_CLASS"', enabled=>FALSE, auto_drop=>FALSE,comments=>
'Чтение полей детализаций'
);
dbms_scheduler.enable('"J_LOAD_FIELDS"');
COMMIT; 
END; 
