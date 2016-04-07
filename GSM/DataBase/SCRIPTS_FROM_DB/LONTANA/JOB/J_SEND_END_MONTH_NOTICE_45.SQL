
  
BEGIN 
dbms_scheduler.create_job('"J_SEND_END_MONTH_NOTICE_45"',
job_type=>'PLSQL_BLOCK', job_action=>
'BEGIN 
STOP_JOB_PCKG.CHECK_WORK_JOB;
SEND_SMS_NOTICE_END_MONTH2(45); 
END;'
, number_of_arguments=>0,
start_date=>TO_TIMESTAMP_TZ('03-SEP-2015 12.06.24.000000000 PM +03:00','DD-MON-RRRR HH.MI.SSXFF AM TZR','NLS_DATE_LANGUAGE=english'), repeat_interval=> 
'FREQ = MINUTELY; INTERVAL = 60'
, end_date=>NULL,
job_class=>'"DEFAULT_JOB_CLASS"', enabled=>FALSE, auto_drop=>TRUE,comments=>
'Рассылка уведомлений о нехватке денег для абонентской платы счета 45'
);
dbms_scheduler.enable('"J_SEND_END_MONTH_NOTICE_45"');
COMMIT; 
END; 
