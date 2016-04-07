
  
BEGIN 
dbms_scheduler.create_job('"J_SEND_MAIL_PHONE_FOR_BLSV3"',
job_type=>'PLSQL_BLOCK', job_action=>
'begin 
  STOP_JOB_PCKG.CHECK_WORK_JOB;
  SEND_MAIL_PHONE_FOR_BL_SAVE3; 
end;'
, number_of_arguments=>0,
start_date=>TO_TIMESTAMP_TZ('05-SEP-2013 12.00.00.000000000 AM +04:00','DD-MON-RRRR HH.MI.SSXFF AM TZR','NLS_DATE_LANGUAGE=english'), repeat_interval=> 
'Freq=Daily;Interval=1;ByHour=09, 15'
, end_date=>NULL,
job_class=>'"DEFAULT_JOB_CLASS"', enabled=>FALSE, auto_drop=>FALSE,comments=>
'Отправка отчета на разблокировку на сохранение '
);
dbms_scheduler.enable('"J_SEND_MAIL_PHONE_FOR_BLSV3"');
COMMIT; 
END; 
