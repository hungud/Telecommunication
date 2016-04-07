
  
BEGIN 
dbms_scheduler.create_job('"J_CLEAR_D_LOG_EXCHANGE"',
job_type=>'PLSQL_BLOCK', job_action=>
'BEGIN
    STOP_JOB_PCKG.CHECK_WORK_JOB;
    WWW_DEALER.CLEAR_D_LOG_EXCHANGE;
END;'
, number_of_arguments=>0,
start_date=>TO_TIMESTAMP_TZ('29-MAY-2015 10.29.12.884000000 AM +03:00','DD-MON-RRRR HH.MI.SSXFF AM TZR','NLS_DATE_LANGUAGE=english'), repeat_interval=> 
'FREQ=DAILY;INTERVAL=1'
, end_date=>NULL,
job_class=>'"DEFAULT_JOB_CLASS"', enabled=>FALSE, auto_drop=>FALSE,comments=>
'Чистка логов  дата которых меньше текущей на 30 дней из WW_DEALER.D_LOG_EXCHANGE'
);
dbms_scheduler.enable('"J_CLEAR_D_LOG_EXCHANGE"');
COMMIT; 
END; 
