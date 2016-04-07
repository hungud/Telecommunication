
  
BEGIN 
dbms_scheduler.create_job('"J_EXPRESS_UNLOCK"',
job_type=>'PLSQL_BLOCK', job_action=>
'BEGIN 
    STOP_JOB_PCKG.CHECK_WORK_JOB;
    beeline_api_pckg.UNLOCK_PHONES; 
END; '
, number_of_arguments=>0,
start_date=>TO_TIMESTAMP_TZ('18-NOV-2013 08.30.00.000000000 PM +04:00','DD-MON-RRRR HH.MI.SSXFF AM TZR','NLS_DATE_LANGUAGE=english'), repeat_interval=> 
'FREQ=MINUTELY; INTERVAL=3'
, end_date=>NULL,
job_class=>'"DEFAULT_JOB_CLASS"', enabled=>FALSE, auto_drop=>FALSE,comments=>
'<быстрая разблокировка клиентов'
);
COMMIT; 
END; 
