
  
BEGIN 
dbms_scheduler.create_job('"J_CALC_BALANCE_STREAM_3"',
job_type=>'PLSQL_BLOCK', job_action=>
'BEGIN 
    STOP_JOB_PCKG.CHECK_WORK_JOB;
    CORP_MOBILE.CALC_BALANCE_STREAM(3); 
END;'
, number_of_arguments=>0,
start_date=>TO_TIMESTAMP_TZ('22-JUL-2013 01.00.00.000000000 PM +04:00','DD-MON-RRRR HH.MI.SSXFF AM TZR','NLS_DATE_LANGUAGE=english'), repeat_interval=> 
'FREQ=MINUTELY; INTERVAL=1'
, end_date=>NULL,
job_class=>'"DEFAULT_JOB_CLASS"', enabled=>FALSE, auto_drop=>FALSE,comments=>
'Потоки пересчета баланса'
);
dbms_scheduler.enable('"J_CALC_BALANCE_STREAM_3"');
COMMIT; 
END; 
