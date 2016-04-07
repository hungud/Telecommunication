
  
BEGIN 
dbms_scheduler.create_job('"J_MAIL_REQ_QUERY"',
job_type=>'PLSQL_BLOCK', job_action=>
'BEGIN 
    STOP_JOB_PCKG.CHECK_WORK_JOB;
    MAIL_REQ_QUERY; 
END;'
, number_of_arguments=>0,
start_date=>TO_TIMESTAMP_TZ('11-FEB-2014 12.00.00.000000000 AM +04:00','DD-MON-RRRR HH.MI.SSXFF AM TZR','NLS_DATE_LANGUAGE=english'), repeat_interval=> 
'Freq=Minutely;Interval=5'
, end_date=>NULL,
job_class=>'"DEFAULT_JOB_CLASS"', enabled=>FALSE, auto_drop=>FALSE,comments=>
'рассылка писем на e-mail'
);
dbms_scheduler.enable('"J_MAIL_REQ_QUERY"');
COMMIT; 
END; 
