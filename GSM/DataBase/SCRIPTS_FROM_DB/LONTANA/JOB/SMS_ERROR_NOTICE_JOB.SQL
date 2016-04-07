
  
BEGIN 
dbms_scheduler.create_job('"SMS_ERROR_NOTICE_JOB"',
job_type=>'PLSQL_BLOCK', job_action=>
'BEGIN 
  STOP_JOB_PCKG.CHECK_WORK_JOB;
  SMS_SYSTEM_ERROR_NOTICE; 
END;'
, number_of_arguments=>0,
start_date=>TO_TIMESTAMP_TZ('28-MAR-2013 06.50.30.000000000 PM +04:00','DD-MON-RRRR HH.MI.SSXFF AM TZR','NLS_DATE_LANGUAGE=english'), repeat_interval=> 
'FREQ = MINUTELY; INTERVAL = 10'
, end_date=>NULL,
job_class=>'"DEFAULT_JOB_CLASS"', enabled=>FALSE, auto_drop=>TRUE,comments=>
'Рассылка почтовых сообщений об ошибках'
);
COMMIT; 
END; 
