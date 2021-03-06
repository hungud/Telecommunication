
  
BEGIN 
dbms_scheduler.create_job('"J_SEND_END_MONTH_NOTICE_285"',
job_type=>'PLSQL_BLOCK', job_action=>
'BEGIN 
STOP_JOB_PCKG.CHECK_WORK_JOB;
SEND_SMS_NOTICE_END_MONTH2(285); 
END;'
, number_of_arguments=>0,
start_date=>TO_TIMESTAMP_TZ('03-SEP-2015 11.06.24.000000000 AM +03:00','DD-MON-RRRR HH.MI.SSXFF AM TZR','NLS_DATE_LANGUAGE=english'), repeat_interval=> 
'FREQ = MINUTELY; INTERVAL = 60'
, end_date=>NULL,
job_class=>'"DEFAULT_JOB_CLASS"', enabled=>FALSE, auto_drop=>TRUE,comments=>
'Рассылка уведомлений о нехватке денег для абонентской платы счета 285'
);
dbms_scheduler.enable('"J_SEND_END_MONTH_NOTICE_285"');
COMMIT; 
END; 
