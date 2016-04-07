
  
BEGIN 
dbms_scheduler.create_job('"J_LOAD_PHONES_COLLECT_T2"',
job_type=>'PLSQL_BLOCK', job_action=>
'declare
Result varchar2(500);
BEGIN
STOP_JOB_PCKG.CHECK_WORK_JOB;
result:=beeline_api_pckg.collect_account_phone_status(2,20);
END;'
, number_of_arguments=>0,
start_date=>TO_TIMESTAMP_TZ('24-MAR-2014 12.00.00.000000000 AM +04:00','DD-MON-RRRR HH.MI.SSXFF AM TZR','NLS_DATE_LANGUAGE=english'), repeat_interval=> 
'FREQ=MINUTELY;INTERVAL=20'
, end_date=>NULL,
job_class=>'"DEFAULT_JOB_CLASS"', enabled=>FALSE, auto_drop=>FALSE,comments=>
'Статусы коллекторских л\с'
);
dbms_scheduler.enable('"J_LOAD_PHONES_COLLECT_T2"');
COMMIT; 
END; 
