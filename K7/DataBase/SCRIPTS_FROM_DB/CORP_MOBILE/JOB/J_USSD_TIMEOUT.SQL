
  
BEGIN 
dbms_scheduler.create_job('"J_USSD_TIMEOUT"',
job_type=>'PLSQL_BLOCK', job_action=>
'begin
STOP_JOB_PCKG.CHECK_WORK_JOB;
USSD_TIMEOUT;
end;'
, number_of_arguments=>0,
start_date=>TO_TIMESTAMP_TZ('23-MAY-2012 09.52.41.000000000 PM +04:00','DD-MON-RRRR HH.MI.SSXFF AM TZR','NLS_DATE_LANGUAGE=english'), repeat_interval=> 
'FREQ=MINUTELY; INTERVAL=1'
, end_date=>NULL,
job_class=>'"DEFAULT_JOB_CLASS"', enabled=>FALSE, auto_drop=>FALSE,comments=>
'USSD_TIMEOUT'
);
dbms_scheduler.enable('"J_USSD_TIMEOUT"');
COMMIT; 
END; 
