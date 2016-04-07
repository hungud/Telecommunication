
  
BEGIN 
dbms_scheduler.create_job('"J_SEND_SMS_CHANGE_TARIFF_LOG"',
job_type=>'PLSQL_BLOCK', job_action=>
'BEGIN 
  STOP_JOB_PCKG.CHECK_WORK_JOB;
  SENDSMS_WHEN_CHANGE_TARIFF;
END;'
, number_of_arguments=>0,
start_date=>TO_TIMESTAMP_TZ('30-MAR-2014 11.42.05.000000000 AM +04:00','DD-MON-RRRR HH.MI.SSXFF AM TZR','NLS_DATE_LANGUAGE=english'), repeat_interval=> 
'FREQ = MINUTELY; INTERVAL = 10'
, end_date=>NULL,
job_class=>'"DEFAULT_JOB_CLASS"', enabled=>FALSE, auto_drop=>TRUE,comments=>
'Отправка СМС при смене тарифного плана'
);
dbms_scheduler.enable('"J_SEND_SMS_CHANGE_TARIFF_LOG"');
COMMIT; 
END; 
