
  
BEGIN 
dbms_scheduler.create_job('"J_LOAD_COLLECTOR_BILL"',
job_type=>'PLSQL_BLOCK', job_action=>
'BEGIN 
  -- STOP_JOB_PCKG.CHECK_WORK_JOB;
  LOAD_XML_FILE7; 
  --ADD_COLL_FULL_FIN_BILLS(93); 
END;'
, number_of_arguments=>0,
start_date=>TO_TIMESTAMP_TZ('24-APR-2014 12.19.12.000000000 PM +04:00','DD-MON-RRRR HH.MI.SSXFF AM TZR','NLS_DATE_LANGUAGE=english'), repeat_interval=> 
'FREQ=minuteLY; INTERVAL=10;bysecond=0;'
, end_date=>NULL,
job_class=>'"DEFAULT_JOB_CLASS"', enabled=>FALSE, auto_drop=>FALSE,comments=>
'Подсчет счетов коллектора'
);
COMMIT; 
END; 
