
  
BEGIN 
dbms_scheduler.create_job('"J_TEMP_PLSQL_BLOCK"',
job_type=>'PLSQL_BLOCK', job_action=>
'BEGIN 
--ADD_COLLECTOR_CALLS(201411); 
--RESTORE_LOG_API_STATUS4;
--CREAR_HISTORY_DUPLICSTES;
--CALLS_STAT_RECALC(201512);
p_test_afr;
END;'
, number_of_arguments=>0,
start_date=>TO_TIMESTAMP_TZ('07-OCT-2014 12.19.12.000000000 PM +04:00','DD-MON-RRRR HH.MI.SSXFF AM TZR','NLS_DATE_LANGUAGE=english'), repeat_interval=> 
'FREQ=hourLY; INTERVAL=1'
, end_date=>NULL,
job_class=>'"DEFAULT_JOB_CLASS"', enabled=>FALSE, auto_drop=>FALSE,comments=>
'Джоб для запуска фоновых заданий'
);
COMMIT; 
END; 
