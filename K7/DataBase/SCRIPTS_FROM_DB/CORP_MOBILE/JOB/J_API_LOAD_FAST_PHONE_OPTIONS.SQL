
  
BEGIN 
dbms_scheduler.create_job('"J_API_LOAD_FAST_PHONE_OPTIONS"',
job_type=>'PLSQL_BLOCK', job_action=>
'BEGIN 
    STOP_JOB_PCKG.CHECK_WORK_JOB;
    API_LOAD_FAST_PHONE_OPTIONS; 
END;'
, number_of_arguments=>0,
start_date=>TO_TIMESTAMP_TZ('23-JUL-2014 09.54.17.000000000 AM +04:00','DD-MON-RRRR HH.MI.SSXFF AM TZR','NLS_DATE_LANGUAGE=english'), repeat_interval=> 
'FREQ=MINUTELY; INTERVAL=15; BYSECOND=0'
, end_date=>NULL,
job_class=>'"DEFAULT_JOB_CLASS"', enabled=>FALSE, auto_drop=>FALSE,comments=>
'Очередь быстрого получения списка услуг по АПИ'
);
dbms_scheduler.enable('"J_API_LOAD_FAST_PHONE_OPTIONS"');
COMMIT; 
END; 
