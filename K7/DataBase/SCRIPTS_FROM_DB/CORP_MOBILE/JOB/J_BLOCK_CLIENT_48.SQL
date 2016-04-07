
  
BEGIN 
dbms_scheduler.create_job('"J_BLOCK_CLIENT_48"',
job_type=>'PLSQL_BLOCK', job_action=>
'BEGIN 
    STOP_JOB_PCKG.CHECK_WORK_JOB;
    CORP_MOBILE.BLOCK_CLIENT_WTH_0_BAL2(48); 
END;'
, number_of_arguments=>0,
start_date=>TO_TIMESTAMP_TZ('23-MAR-2012 03.29.03.000000000 PM +04:00','DD-MON-RRRR HH.MI.SSXFF AM TZR','NLS_DATE_LANGUAGE=english'), repeat_interval=> 
'FREQ=MINUTELY; INTERVAL=10'
, end_date=>NULL,
job_class=>'"DEFAULT_JOB_CLASS"', enabled=>FALSE, auto_drop=>FALSE,comments=>
'Блокировка клиентов с балансом меньше 0 счета 48'
);
dbms_scheduler.enable('"J_BLOCK_CLIENT_48"');
COMMIT; 
END; 
