
  
BEGIN 
dbms_scheduler.create_job('"J_LOAD_PHONE_OPTIONS_119"',
job_type=>'PLSQL_BLOCK', job_action=>
'BEGIN 
    STOP_JOB_PCKG.CHECK_WORK_JOB;
    loader_call_pckg_n.LOAD_PHONES_OPTIONS(119); 
END;'
, number_of_arguments=>0,
start_date=>TO_TIMESTAMP_TZ('02-AUG-2014 03.51.11.000000000 PM +04:00','DD-MON-RRRR HH.MI.SSXFF AM TZR','NLS_DATE_LANGUAGE=english'), repeat_interval=> 
'FREQ = HOURLY; INTERVAL = 12'
, end_date=>NULL,
job_class=>'"DEFAULT_JOB_CLASS"', enabled=>FALSE, auto_drop=>TRUE,comments=>
'Загрузка списков подключенных опций ID 119'
);
dbms_scheduler.enable('"J_LOAD_PHONE_OPTIONS_119"');
COMMIT; 
END; 
