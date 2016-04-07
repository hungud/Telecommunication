
  
BEGIN 
dbms_scheduler.create_job('"J_RECALC_CUR_TARIF"',
job_type=>'PLSQL_BLOCK', job_action=>
'BEGIN
  STOP_JOB_PCKG.CHECK_WORK_JOB;
-- be sure to substitute in actual values
-- where the parameter names are!
  CORP_MOBILE.RECALC_PHONE_TARIF;
END;'
, number_of_arguments=>0,
start_date=>NULL, repeat_interval=> 
'FREQ=MINUTELY; INTERVAL=5'
, end_date=>NULL,
job_class=>'"DEFAULT_JOB_CLASS"', enabled=>FALSE, auto_drop=>FALSE,comments=>
NULL
);
COMMIT; 
END; 
