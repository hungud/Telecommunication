
  
BEGIN 
dbms_scheduler.create_job('"J_MOB_PAY_QUERY"',
job_type=>'PLSQL_BLOCK', job_action=>
'BEGIN
    STOP_JOB_PCKG.CHECK_WORK_JOB;
    MOB_PAY_QUERY;
END; '
, number_of_arguments=>0,
start_date=>NULL, repeat_interval=> 
'FREQ=SECONDLY;INTERVAL=10'
, end_date=>NULL,
job_class=>'"DEFAULT_JOB_CLASS"', enabled=>FALSE, auto_drop=>FALSE,comments=>
'проведение мобильных платежей'
);
COMMIT; 
END; 
