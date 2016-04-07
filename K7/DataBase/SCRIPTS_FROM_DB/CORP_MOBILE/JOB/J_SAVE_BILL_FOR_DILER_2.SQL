
  
BEGIN 
dbms_scheduler.create_job('"J_SAVE_BILL_FOR_DILER_2"',
job_type=>'PLSQL_BLOCK', job_action=>
'BEGIN 
  --STOP_JOB_PCKG.CHECK_WORK_JOB;
  SAVE_BILL_FOR_DILER(201409); 
  /*SAVE_BILL_FOR_DILER(to_number(to_char(add_months(sysdate, -1), ''yyyymm'')));*/ 
END;'
, number_of_arguments=>0,
start_date=>TO_TIMESTAMP_TZ('24-APR-2014 12.19.12.000000000 PM +04:00','DD-MON-RRRR HH.MI.SSXFF AM TZR','NLS_DATE_LANGUAGE=english'), repeat_interval=> 
'FREQ=MONTHLY; INTERVAL=10'
, end_date=>NULL,
job_class=>'"DEFAULT_JOB_CLASS"', enabled=>FALSE, auto_drop=>FALSE,comments=>
'2й поток для подсчета дилер вознаграждения'
);
dbms_scheduler.enable('"J_SAVE_BILL_FOR_DILER_2"');
COMMIT; 
END; 
