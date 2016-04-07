
  
BEGIN 
dbms_scheduler.create_job('"J_REBUILD_ABONENT_ALL_PERIODS"',
job_type=>'PLSQL_BLOCK', job_action=>
'BEGIN 
STOP_JOB_PCKG.CHECK_WORK_JOB;
REBUILD_ABONENT_ALL_PERIODS; 
END;'
, number_of_arguments=>0,
start_date=>TO_TIMESTAMP_TZ('16-DEC-2014 05.07.58.000000000 PM +04:00','DD-MON-RRRR HH.MI.SSXFF AM TZR','NLS_DATE_LANGUAGE=english'), repeat_interval=> 
'FREQ=SECONDLY; INTERVAL=10'
, end_date=>NULL,
job_class=>'"DEFAULT_JOB_CLASS"', enabled=>FALSE, auto_drop=>FALSE,comments=>
'Очередь пересчета периодов абон активности'
);
dbms_scheduler.enable('"J_REBUILD_ABONENT_ALL_PERIODS"');
COMMIT; 
END; 
