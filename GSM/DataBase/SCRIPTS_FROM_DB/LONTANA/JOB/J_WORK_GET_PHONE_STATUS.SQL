
  
BEGIN 
dbms_scheduler.create_job('"J_WORK_GET_PHONE_STATUS"',
job_type=>'PLSQL_BLOCK', job_action=>
'BEGIN
 STOP_JOB_PCKG.CHECK_WORK_JOB;
 LONTANA.LOADER4_PCKG_ENQUEUE.WORK_GET_PHONE_STATUS; 
END;'
, number_of_arguments=>0,
start_date=>TO_TIMESTAMP_TZ('27-JUN-2012 07.31.21.000000000 PM +04:00','DD-MON-RRRR HH.MI.SSXFF AM TZR','NLS_DATE_LANGUAGE=english'), repeat_interval=> 
'FREQ=MINUTELY; INTERVAL=3'
, end_date=>NULL,
job_class=>'"DEFAULT_JOB_CLASS"', enabled=>FALSE, auto_drop=>FALSE,comments=>
'Обработка очереди заданий WORK_GET_PHONE_STATUS'
);
dbms_scheduler.enable('"J_WORK_GET_PHONE_STATUS"');
COMMIT; 
END; 
