
  
BEGIN 
dbms_scheduler.create_job('"J_BLOCK_DRAVE_INET_PHONES_07"',
job_type=>'PLSQL_BLOCK', job_action=>
'BEGIN 
    STOP_JOB_PCKG.CHECK_WORK_JOB;
    BLOCK_DRAVE_INET_PHONES(7); 
END;'
, number_of_arguments=>0,
start_date=>TO_TIMESTAMP_TZ('31-DEC-2014 02.28.10.000000000 PM +04:00','DD-MON-RRRR HH.MI.SSXFF AM TZR','NLS_DATE_LANGUAGE=english'), repeat_interval=> 
'FREQ=MINUTELY; INTERVAL=10; BYSECOND=0'
, end_date=>NULL,
job_class=>'"DEFAULT_JOB_CLASS"', enabled=>FALSE, auto_drop=>FALSE,comments=>
'Блокировка Драйвов'
);
dbms_scheduler.enable('"J_BLOCK_DRAVE_INET_PHONES_07"');
COMMIT; 
END; 
