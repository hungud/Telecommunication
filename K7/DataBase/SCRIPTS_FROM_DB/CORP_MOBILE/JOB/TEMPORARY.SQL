
  
BEGIN 
dbms_scheduler.create_job('"TEMPORARY"',
job_type=>'PLSQL_BLOCK', job_action=>
'BEGIN 
STOP_JOB_PCKG.CHECK_WORK_JOB;
CORP_MOBILE.LOADER2_PCKG.LOAD_REPORT_DATA(68); 
END;'
, number_of_arguments=>0,
start_date=>TO_TIMESTAMP_TZ('28-FEB-2013 12.00.00.000000000 AM +04:00','DD-MON-RRRR HH.MI.SSXFF AM TZR','NLS_DATE_LANGUAGE=english'), repeat_interval=> 
'Freq=Minutely;Interval=15'
, end_date=>TO_TIMESTAMP_TZ('29-MAR-2013 12.00.00.000000000 AM +04:00','DD-MON-RRRR HH.MI.SSXFF AM TZR','NLS_DATE_LANGUAGE=english'),
job_class=>'"DEFAULT_JOB_CLASS"', enabled=>FALSE, auto_drop=>FALSE,comments=>
NULL
);
COMMIT; 
END; 
