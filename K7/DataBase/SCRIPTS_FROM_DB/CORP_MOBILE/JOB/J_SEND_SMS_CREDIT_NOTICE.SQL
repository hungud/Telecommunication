
  
BEGIN 
dbms_scheduler.create_job('"J_SEND_SMS_CREDIT_NOTICE"',
job_type=>'PLSQL_BLOCK', job_action=>
'BEGIN 
  STOP_JOB_PCKG.CHECK_WORK_JOB;
  SEND_SMS_CREDIT_NOTICE;
END;  '
, number_of_arguments=>0,
start_date=>TO_TIMESTAMP_TZ('10-APR-2012 06.03.10.000000000 PM +04:00','DD-MON-RRRR HH.MI.SSXFF AM TZR','NLS_DATE_LANGUAGE=english'), repeat_interval=> 
'FREQ=MINUTELY; INTERVAL=15'
, end_date=>NULL,
job_class=>'"DEFAULT_JOB_CLASS"', enabled=>FALSE, auto_drop=>FALSE,comments=>
'Предупреждение кредитных клиентов с балансом близким к 0 о счете'
);
COMMIT; 
END; 
