
  
BEGIN 
dbms_scheduler.create_job('"J_LOAD_OBJ_ID_285"',
job_type=>'PLSQL_BLOCK', job_action=>
'BEGIN 
STOP_JOB_PCKG.CHECK_WORK_JOB;
LOADER_CALL_PCKG_N.LOAD_OBJ_ID(285);
END;'
, number_of_arguments=>0,
start_date=>TO_TIMESTAMP_TZ('14-OCT-2014 01.12.38.000000000 PM +04:00','DD-MON-RRRR HH.MI.SSXFF AM TZR','NLS_DATE_LANGUAGE=english'), repeat_interval=> 
'FREQ = DAILY; INTERVAL = 7'
, end_date=>NULL,
job_class=>'"DEFAULT_JOB_CLASS"', enabled=>FALSE, auto_drop=>TRUE,comments=>
'Загрузка OBG_ID по счету 285'
);
dbms_scheduler.enable('"J_LOAD_OBJ_ID_285"');
COMMIT; 
END; 
