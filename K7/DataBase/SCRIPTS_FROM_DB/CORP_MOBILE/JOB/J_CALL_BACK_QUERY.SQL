
  
BEGIN 
dbms_scheduler.create_job('"J_CALL_BACK_QUERY"',
job_type=>'PLSQL_BLOCK', job_action=>
'BEGIN
    STOP_JOB_PCKG.CHECK_WORK_JOB;
    CALL_BACK_QUERY;
END;'
, number_of_arguments=>0,
start_date=>TO_TIMESTAMP_TZ('22-NOV-2012 01.35.39.000000000 PM +04:00','DD-MON-RRRR HH.MI.SSXFF AM TZR','NLS_DATE_LANGUAGE=english'), repeat_interval=> 
'FREQ=SECONDLY; INTERVAL=5'
, end_date=>NULL,
job_class=>'"DEFAULT_JOB_CLASS"', enabled=>FALSE, auto_drop=>FALSE,comments=>
'Очередь для запросов на сайт партнера через CALL_BACK '
);
dbms_scheduler.enable('"J_CALL_BACK_QUERY"');
COMMIT; 
END; 
