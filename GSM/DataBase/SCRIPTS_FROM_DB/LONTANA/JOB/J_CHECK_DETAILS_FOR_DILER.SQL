
  
BEGIN 
dbms_scheduler.create_job('"J_CHECK_DETAILS_FOR_DILER"',
job_type=>'PLSQL_BLOCK', job_action=>
'begin
STOP_JOB_PCKG.CHECK_WORK_JOB;
LONTANA.CHECK_ALL_DETAILS2;
end;'
, number_of_arguments=>0,
start_date=>TO_TIMESTAMP_TZ('30-OCT-2012 02.03.20.000000000 AM +04:00','DD-MON-RRRR HH.MI.SSXFF AM TZR','NLS_DATE_LANGUAGE=english'), repeat_interval=> 
'FREQ=hourLY; INTERVAL=12'
, end_date=>NULL,
job_class=>'"DEFAULT_JOB_CLASS"', enabled=>FALSE, auto_drop=>FALSE,comments=>
'ПОДСЧЕТ ДИЛЕРСКИХ ЗВОНКОВ'
);
dbms_scheduler.enable('"J_CHECK_DETAILS_FOR_DILER"');
COMMIT; 
END; 
