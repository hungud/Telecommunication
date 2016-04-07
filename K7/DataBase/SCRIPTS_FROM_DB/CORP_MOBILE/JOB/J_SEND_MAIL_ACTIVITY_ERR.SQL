
  
BEGIN 
dbms_scheduler.create_job('"J_SEND_MAIL_ACTIVITY_ERR"',
job_type=>'PLSQL_BLOCK', job_action=>
'BEGIN 
  STOP_JOB_PCKG.CHECK_WORK_JOB;
  CORP_MOBILE.SEND_MAIL_NOTICE_BEELINE;
END; '
, number_of_arguments=>0,
start_date=>TO_TIMESTAMP_TZ('22-APR-2014 09.13.55.140000000 PM +04:00','DD-MON-RRRR HH.MI.SSXFF AM TZR','NLS_DATE_LANGUAGE=english'), repeat_interval=> 
'FREQ=MINUTELY;INTERVAL=3'
, end_date=>NULL,
job_class=>'"DEFAULT_JOB_CLASS"', enabled=>FALSE, auto_drop=>FALSE,comments=>
'Шлёт письма на ящик типа SEND_MAIL_NOTICE_BELINE в REPORT_MAIL_RECIPIENTS.

Ошибки из логов по блокам-разблокам и смены SIM за param= ERROR_SUBSCRIBE_CHECK_TIME мин.'
);
dbms_scheduler.enable('"J_SEND_MAIL_ACTIVITY_ERR"');
COMMIT; 
END; 
