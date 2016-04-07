
  
BEGIN 
dbms_scheduler.create_job('"J_SEND_SMS_NOTIFY_BILLS"',
job_type=>'PLSQL_BLOCK', job_action=>
'begin 
STOP_JOB_PCKG.CHECK_WORK_JOB;
CHECK_NEW_BILLS_MEGAFON;
end;'
, number_of_arguments=>0,
start_date=>TO_TIMESTAMP_TZ('22-MAR-2016 03.15.58.880000000 PM +03:00','DD-MON-RRRR HH.MI.SSXFF AM TZR','NLS_DATE_LANGUAGE=english'), repeat_interval=> 
'FREQ=HOURLY;INTERVAL=1'
, end_date=>NULL,
job_class=>'"DEFAULT_JOB_CLASS"', enabled=>FALSE, auto_drop=>FALSE,comments=>
'Отправки СМС с сообщением о балансе'
);
dbms_scheduler.enable('"J_SEND_SMS_NOTIFY_BILLS"');
COMMIT; 
END; 
