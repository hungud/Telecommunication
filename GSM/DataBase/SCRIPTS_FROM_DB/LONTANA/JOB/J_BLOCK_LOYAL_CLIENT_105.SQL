
  
BEGIN 
dbms_scheduler.create_job('"J_BLOCK_LOYAL_CLIENT_105"',
job_type=>'PLSQL_BLOCK', job_action=>
'BEGIN 
STOP_JOB_PCKG.CHECK_WORK_JOB;
BLOCK_LOYAL_WITH_0_BALANCE2(105); 
END;'
, number_of_arguments=>0,
start_date=>TO_TIMESTAMP_TZ('28-DEC-2012 04.54.09.000000000 PM +04:00','DD-MON-RRRR HH.MI.SSXFF AM TZR','NLS_DATE_LANGUAGE=english'), repeat_interval=> 
'FREQ=MINUTELY; INTERVAL=10'
, end_date=>NULL,
job_class=>'"DEFAULT_JOB_CLASS"', enabled=>FALSE, auto_drop=>FALSE,comments=>
'Блокировка лояльных клиентов с балансом меньше 0'
);
COMMIT; 
END; 
