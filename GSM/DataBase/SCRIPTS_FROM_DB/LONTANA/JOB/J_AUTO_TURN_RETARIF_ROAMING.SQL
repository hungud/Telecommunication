
  
BEGIN 
dbms_scheduler.create_job('"J_AUTO_TURN_RETARIF_ROAMING"',
job_type=>'PLSQL_BLOCK', job_action=>
'BEGIN 
STOP_JOB_PCKG.CHECK_WORK_JOB;
P_AUTO_TURN_RETARIF_ROAMING; 
END;'
, number_of_arguments=>0,
start_date=>TO_TIMESTAMP_TZ('30-DEC-2014 09.06.49.000000000 AM +04:00','DD-MON-RRRR HH.MI.SSXFF AM TZR','NLS_DATE_LANGUAGE=english'), repeat_interval=> 
'FREQ=MINUTELY;INTERVAL=5'
, end_date=>NULL,
job_class=>'"DEFAULT_JOB_CLASS"', enabled=>FALSE, auto_drop=>TRUE,comments=>
'Подключение ретарификации роуминга'
);
dbms_scheduler.enable('"J_AUTO_TURN_RETARIF_ROAMING"');
COMMIT; 
END; 
