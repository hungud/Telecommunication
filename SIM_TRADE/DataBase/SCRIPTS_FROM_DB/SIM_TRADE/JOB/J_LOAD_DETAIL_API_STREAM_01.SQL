
  
BEGIN 
dbms_scheduler.create_job('"J_LOAD_DETAIL_API_STREAM_01"',
job_type=>'PLSQL_BLOCK', job_action=>
'BEGIN 
    STOP_JOB_PCKG.CHECK_WORK_JOB;
    LOAD_DETAILS_FROM_API(1); 
END;'
, number_of_arguments=>0,
start_date=>TO_TIMESTAMP_TZ('10-DEC-2014 04.21.35.000000000 PM +04:00','DD-MON-RRRR HH.MI.SSXFF AM TZR','NLS_DATE_LANGUAGE=english'), repeat_interval=> 
'FREQ = MINUTELY; INTERVAL = 60'
, end_date=>NULL,
job_class=>'"DEFAULT_JOB_CLASS"', enabled=>FALSE, auto_drop=>TRUE,comments=>
'Загрузка детализаций по API'
);
dbms_scheduler.enable('"J_LOAD_DETAIL_API_STREAM_01"');
COMMIT; 
END; 
