
  
BEGIN 
dbms_scheduler.create_job('"J_KILL_HANGED_JOBS"',
job_type=>'PLSQL_BLOCK', job_action=>
'begin 
  LONTANA.KILL_HANGED_JOBS;
end;  '
, number_of_arguments=>0,
start_date=>TO_TIMESTAMP_TZ('03-FEB-2014 11.55.05.210000000 AM +04:00','DD-MON-RRRR HH.MI.SSXFF AM TZR','NLS_DATE_LANGUAGE=english'), repeat_interval=> 
'FREQ=MINUTELY;INTERVAL=5'
, end_date=>NULL,
job_class=>'"DEFAULT_JOB_CLASS"', enabled=>FALSE, auto_drop=>FALSE,comments=>
'Удаление висящих JOBS'
);
dbms_scheduler.enable('"J_KILL_HANGED_JOBS"');
COMMIT; 
END; 
