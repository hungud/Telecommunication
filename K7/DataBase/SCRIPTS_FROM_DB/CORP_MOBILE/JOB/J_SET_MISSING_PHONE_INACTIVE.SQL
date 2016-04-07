
  
BEGIN 
dbms_scheduler.create_job('"J_SET_MISSING_PHONE_INACTIVE"',
job_type=>'PLSQL_BLOCK', job_action=>
'BEGIN 
  STOP_JOB_PCKG.CHECK_WORK_JOB;
  SET_MISSING_PHONE_INACTIVE; 
END;'
, number_of_arguments=>0,
start_date=>TO_TIMESTAMP_TZ('03-FEB-2015 11.57.40.000000000 AM +04:00','DD-MON-RRRR HH.MI.SSXFF AM TZR','NLS_DATE_LANGUAGE=english'), repeat_interval=> 
'FREQ=DAILY; INTERVAL=1; BYHOUR=23; BYMINUTE=0; BYSECOND=0'
, end_date=>NULL,
job_class=>'"DEFAULT_JOB_CLASS"', enabled=>FALSE, auto_drop=>FALSE,comments=>
'Очередь отсечения активности номеров покинувших л/с'
);
dbms_scheduler.enable('"J_SET_MISSING_PHONE_INACTIVE"');
COMMIT; 
END; 
