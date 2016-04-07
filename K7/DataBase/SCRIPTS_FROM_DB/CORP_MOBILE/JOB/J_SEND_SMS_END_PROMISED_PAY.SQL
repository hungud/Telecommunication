
  
BEGIN 
dbms_scheduler.create_job('"J_SEND_SMS_END_PROMISED_PAY"',
job_type=>'PLSQL_BLOCK', job_action=>
'begin
  STOP_JOB_PCKG.CHECK_WORK_JOB;
  SEND_SMS_END_PROMISED_PAY;
end;'
, number_of_arguments=>0,
start_date=>TO_TIMESTAMP_TZ('29-MAY-2015 01.29.15.166000000 PM +03:00','DD-MON-RRRR HH.MI.SSXFF AM TZR','NLS_DATE_LANGUAGE=english'), repeat_interval=> 
'FREQ=HOURLY;INTERVAL=1;'
, end_date=>NULL,
job_class=>'"DEFAULT_JOB_CLASS"', enabled=>FALSE, auto_drop=>TRUE,comments=>
'Рассылка смс с предупреждением об окончании обещанного платежа.'
);
dbms_scheduler.enable('"J_SEND_SMS_END_PROMISED_PAY"');
COMMIT; 
END; 
