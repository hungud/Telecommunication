
  
BEGIN 
dbms_scheduler.create_job('"J_SEND_SMS_NOTICE_MN_UNLIM"',
job_type=>'PLSQL_BLOCK', job_action=>
'BEGIN
  STOP_JOB_PCKG.CHECK_WORK_JOB;
  SEND_SMS_NOTICE_MN_UNLIM;
END;  '
, number_of_arguments=>0,
start_date=>TO_TIMESTAMP_TZ('04-MAY-2012 10.13.41.000000000 PM +04:00','DD-MON-RRRR HH.MI.SSXFF AM TZR','NLS_DATE_LANGUAGE=english'), repeat_interval=> 
'FREQ=MINUTELY; INTERVAL=5'
, end_date=>NULL,
job_class=>'"DEFAULT_JOB_CLASS"', enabled=>FALSE, auto_drop=>FALSE,comments=>
'SEND SMS NOTICE MN UNLIM'
);
dbms_scheduler.enable('"J_SEND_SMS_NOTICE_MN_UNLIM"');
COMMIT; 
END; 
