
  
BEGIN 
dbms_scheduler.create_job('"J_TEST_TASKS_SMS"',
job_type=>'PLSQL_BLOCK', job_action=>
'BEGIN 
  STOP_JOB_PCKG.CHECK_WORK_JOB;
  CORP_MOBILE.TEST_TASKS_SMS;
END;  '
, number_of_arguments=>0,
start_date=>TO_TIMESTAMP_TZ('29-MAY-2015 01.29.16.150000000 PM +03:00','DD-MON-RRRR HH.MI.SSXFF AM TZR','NLS_DATE_LANGUAGE=english'), repeat_interval=> 
'FREQ=MINUTELY;INTERVAL=1'
, end_date=>NULL,
job_class=>'"DEFAULT_JOB_CLASS"', enabled=>FALSE, auto_drop=>FALSE,comments=>
' Высылает оповещение о добавлении/отключении услуги'
);
dbms_scheduler.enable('"J_TEST_TASKS_SMS"');
COMMIT; 
END; 
