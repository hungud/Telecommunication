
  
BEGIN 
dbms_scheduler.create_job('"J_LOAD_PHONE_OPTIONS_1"',
job_type=>'PLSQL_BLOCK', job_action=>
'BEGIN 
    STOP_JOB_PCKG.CHECK_WORK_JOB;
    loader_call_pckg_n.LOAD_PHONES_OPTIONS(1); 
END;'
, number_of_arguments=>0,
start_date=>TO_TIMESTAMP_TZ('16-AUG-2011 03.03.13.000000000 PM +04:00','DD-MON-RRRR HH.MI.SSXFF AM TZR','NLS_DATE_LANGUAGE=english'), repeat_interval=> 
'FREQ=HOURLY; INTERVAL=12'
, end_date=>NULL,
job_class=>'"DEFAULT_JOB_CLASS"', enabled=>FALSE, auto_drop=>FALSE,comments=>
'Загрузка списков подключенных опций ID 11 '
);
dbms_scheduler.enable('"J_LOAD_PHONE_OPTIONS_1"');
COMMIT; 
END; 
