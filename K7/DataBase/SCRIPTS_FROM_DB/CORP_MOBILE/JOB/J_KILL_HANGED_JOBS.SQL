
  
BEGIN 
dbms_scheduler.create_job('"J_KILL_HANGED_JOBS"',
job_type=>'PLSQL_BLOCK', job_action=>
'BEGIN
    STOP_JOB_PCKG.CHECK_WORK_JOB;
    CORP_MOBILE.KILL_HANGED_JOBS;
END;'
, number_of_arguments=>0,
start_date=>TO_TIMESTAMP_TZ('13-JAN-2014 10.33.05.210000000 AM +04:00','DD-MON-RRRR HH.MI.SSXFF AM TZR','NLS_DATE_LANGUAGE=english'), repeat_interval=> 
'FREQ=MINUTELY;INTERVAL=5'
, end_date=>NULL,
job_class=>'"DEFAULT_JOB_CLASS"', enabled=>FALSE, auto_drop=>FALSE,comments=>
'Убивает висящие JOB'
);
dbms_scheduler.enable('"J_KILL_HANGED_JOBS"');
COMMIT; 
END; 
