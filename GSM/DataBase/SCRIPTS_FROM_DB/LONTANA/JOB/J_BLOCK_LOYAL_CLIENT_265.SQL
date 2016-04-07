
  
BEGIN 
dbms_scheduler.create_job('"J_BLOCK_LOYAL_CLIENT_265"',
job_type=>'PLSQL_BLOCK', job_action=>
'BEGIN 
STOP_JOB_PCKG.CHECK_WORK_JOB;
BLOCK_LOYAL_WITH_0_BALANCE2(265); 
END;'
, number_of_arguments=>0,
start_date=>TO_TIMESTAMP_TZ('11-FEB-2014 11.25.21.000000000 AM +04:00','DD-MON-RRRR HH.MI.SSXFF AM TZR','NLS_DATE_LANGUAGE=english'), repeat_interval=> 
'FREQ=MINUTELY; INTERVAL=10'
, end_date=>NULL,
job_class=>'"DEFAULT_JOB_CLASS"', enabled=>FALSE, auto_drop=>TRUE,comments=>
'Лояльная блокировка клиента ID 265'
);
COMMIT; 
END; 
