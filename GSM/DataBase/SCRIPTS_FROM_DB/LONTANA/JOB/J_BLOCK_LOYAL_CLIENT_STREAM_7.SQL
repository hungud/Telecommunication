
  
BEGIN 
dbms_scheduler.create_job('"J_BLOCK_LOYAL_CLIENT_STREAM_7"',
job_type=>'PLSQL_BLOCK', job_action=>
'BEGIN 
STOP_JOB_PCKG.CHECK_WORK_JOB;
BLOCK_LOYAL_WITH_0_BALANCE3(10, 7); 
END;'
, number_of_arguments=>0,
start_date=>TO_TIMESTAMP_TZ('21-JAN-2015 03.50.58.000000000 PM +04:00','DD-MON-RRRR HH.MI.SSXFF AM TZR','NLS_DATE_LANGUAGE=english'), repeat_interval=> 
'FREQ=MINUTELY; INTERVAL=5'
, end_date=>NULL,
job_class=>'"DEFAULT_JOB_CLASS"', enabled=>FALSE, auto_drop=>FALSE,comments=>
'Блокировка лояльных клиентов с балансом меньше 0'
);
dbms_scheduler.enable('"J_BLOCK_LOYAL_CLIENT_STREAM_7"');
COMMIT; 
END; 
