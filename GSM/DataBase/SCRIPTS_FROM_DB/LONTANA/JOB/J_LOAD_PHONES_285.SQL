
  
BEGIN 
dbms_scheduler.create_job('"J_LOAD_PHONES_285"',
job_type=>'PLSQL_BLOCK', job_action=>
'BEGIN 
  STOP_JOB_PCKG.CHECK_WORK_JOB;
  loader_call_pckg_n.UPDATE_ACCOUNT_PHONES_STATE(285); 
END;'
, number_of_arguments=>0,
start_date=>TO_TIMESTAMP_TZ('13-OCT-2014 04.54.10.000000000 PM +04:00','DD-MON-RRRR HH.MI.SSXFF AM TZR','NLS_DATE_LANGUAGE=english'), repeat_interval=> 
'FREQ = MINUTELY; INTERVAL = 5'
, end_date=>NULL,
job_class=>'"DEFAULT_JOB_CLASS"', enabled=>FALSE, auto_drop=>TRUE,comments=>
'Загрузка статуса абонента id 285'
);
dbms_scheduler.enable('"J_LOAD_PHONES_285"');
COMMIT; 
END; 
