
  
BEGIN 
dbms_scheduler.create_job('"J_DAYLY_ROUTINE_JOBS_TWICE"',
job_type=>'PLSQL_BLOCK', job_action=>
'BEGIN
    STOP_JOB_PCKG.CHECK_WORK_JOB;
    CORP_MOBILE.DAYLY_ROUTINE_JOBS_TWICE;
END;'
, number_of_arguments=>0,
start_date=>TO_TIMESTAMP_TZ('01-MAR-2016 11.20.21.729000000 PM +03:00','DD-MON-RRRR HH.MI.SSXFF AM TZR','NLS_DATE_LANGUAGE=english'), repeat_interval=> 
'FREQ=HOURLY;INTERVAL=12;BYMINUTE=0;BYSECOND=0'
, end_date=>NULL,
job_class=>'"DEFAULT_JOB_CLASS"', enabled=>FALSE, auto_drop=>FALSE,comments=>
'Снятие ручной блокировки, с контрактов, у которых истек срок ручной блокировки '
);
dbms_scheduler.enable('"J_DAYLY_ROUTINE_JOBS_TWICE"');
COMMIT; 
END; 
