
  
BEGIN 
dbms_scheduler.create_job('"J_LOAD_BEELINE_BILLS_145"',
job_type=>'PLSQL_BLOCK', job_action=>
'BEGIN
STOP_JOB_PCKG.CHECK_WORK_JOB;
P_LOAD_BEELINE_BILLS(145);
END;'
, number_of_arguments=>0,
start_date=>TO_TIMESTAMP_TZ('24-MAR-2014 12.00.00.000000000 AM +04:00','DD-MON-RRRR HH.MI.SSXFF AM TZR','NLS_DATE_LANGUAGE=english'), repeat_interval=> 
'FREQ=HOURLY;INTERVAL=1'
, end_date=>NULL,
job_class=>'"DEFAULT_JOB_CLASS"', enabled=>FALSE, auto_drop=>FALSE,comments=>
'Загрузка счетов билайн ACCOUNT_ID 145'
);
dbms_scheduler.enable('"J_LOAD_BEELINE_BILLS_145"');
COMMIT; 
END; 
