
  
BEGIN 
dbms_scheduler.create_job('"J_SEND_END_MOBTH_NOTICE"',
job_type=>'PLSQL_BLOCK', job_action=>
'begin 
  STOP_JOB_PCKG.CHECK_WORK_JOB;
  LONTANA.SEND_SMS_NOTICE_END_MONTH;
end;  '
, number_of_arguments=>0,
start_date=>TO_TIMESTAMP_TZ('29-JUL-2011 12.45.14.000000000 PM +04:00','DD-MON-RRRR HH.MI.SSXFF AM TZR','NLS_DATE_LANGUAGE=english'), repeat_interval=> 
'FREQ=HOURLY; INTERVAL=1'
, end_date=>NULL,
job_class=>'"DEFAULT_JOB_CLASS"', enabled=>FALSE, auto_drop=>FALSE,comments=>
'Рассылка уведомлений о нехватке денег для абонентской платы'
);
COMMIT; 
END; 
