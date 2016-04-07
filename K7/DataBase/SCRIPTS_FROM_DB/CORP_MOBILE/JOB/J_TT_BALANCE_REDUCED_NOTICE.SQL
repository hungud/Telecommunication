
  
BEGIN 
dbms_scheduler.create_job('"J_TT_BALANCE_REDUCED_NOTICE"',
job_type=>'PLSQL_BLOCK', job_action=>
'BEGIN 
  STOP_JOB_PCKG.CHECK_WORK_JOB;
  TT_BALANCE_REDUCED_PCKG.SEND_NOTICES; 
END;'
, number_of_arguments=>0,
start_date=>TO_TIMESTAMP_TZ('04-JUN-2014 09.48.54.000000000 AM +04:00','DD-MON-RRRR HH.MI.SSXFF AM TZR','NLS_DATE_LANGUAGE=english'), repeat_interval=> 
'FREQ = MINUTELY; INTERVAL = 1'
, end_date=>NULL,
job_class=>'"DEFAULT_JOB_CLASS"', enabled=>FALSE, auto_drop=>TRUE,comments=>
' Рассылка смс с оповещением о балансе'
);
dbms_scheduler.enable('"J_TT_BALANCE_REDUCED_NOTICE"');
COMMIT; 
END; 
