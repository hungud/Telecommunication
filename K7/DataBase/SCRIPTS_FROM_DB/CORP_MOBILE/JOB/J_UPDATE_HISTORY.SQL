
  
BEGIN 
dbms_scheduler.create_job('"J_UPDATE_HISTORY"',
job_type=>'PLSQL_BLOCK', job_action=>
'BEGIN 
STOP_JOB_PCKG.CHECK_WORK_JOB;
SET_PHONE_HISTORY;
 END;'
, number_of_arguments=>0,
start_date=>TO_TIMESTAMP_TZ('24-JAN-2015 01.12.06.000000000 AM +04:00','DD-MON-RRRR HH.MI.SSXFF AM TZR','NLS_DATE_LANGUAGE=english'), repeat_interval=> 
'FREQ=MINUTELY; INTERVAL=1; BYSECOND=0'
, end_date=>NULL,
job_class=>'"DEFAULT_JOB_CLASS"', enabled=>FALSE, auto_drop=>FALSE,comments=>
'сОХРАНЕНИЕ ИСТОРИИ СТАТУСОВ'
);
dbms_scheduler.enable('"J_UPDATE_HISTORY"');
COMMIT; 
END; 
