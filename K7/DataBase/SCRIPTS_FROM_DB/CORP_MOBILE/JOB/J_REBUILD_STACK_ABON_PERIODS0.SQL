
  
BEGIN 
dbms_scheduler.create_job('"J_REBUILD_STACK_ABON_PERIODS0"',
job_type=>'PLSQL_BLOCK', job_action=>
'BEGIN 
    STOP_JOB_PCKG.CHECK_WORK_JOB;
    REBUILD_STACK_ABONENT_PERIODS(0, 10); 
END;'
, number_of_arguments=>0,
start_date=>TO_TIMESTAMP_TZ('18-NOV-2014 09.53.30.000000000 AM +04:00','DD-MON-RRRR HH.MI.SSXFF AM TZR','NLS_DATE_LANGUAGE=english'), repeat_interval=> 
'FREQ=secondLY; INTERVAL=5'
, end_date=>NULL,
job_class=>'"DEFAULT_JOB_CLASS"', enabled=>FALSE, auto_drop=>FALSE,comments=>
'Очередь обратная, для пересчета периодов абон активности'
);
dbms_scheduler.enable('"J_REBUILD_STACK_ABON_PERIODS0"');
COMMIT; 
END; 
