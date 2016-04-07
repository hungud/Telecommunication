
  
BEGIN 
dbms_scheduler.create_job('"J_TEMP_PLSQL_BLOCK"',
job_type=>'PLSQL_BLOCK', job_action=>
'BEGIN 
STOP_JOB_PCKG.CHECK_WORK_JOB;
--RESTORE_LOG_API_STATUS;
--afrosin_temp;
P_OS_LOGGER_BACK_UP; 
END;'
, number_of_arguments=>0,
start_date=>TO_TIMESTAMP_TZ('07-OCT-2014 12.19.12.000000000 PM +04:00','DD-MON-RRRR HH.MI.SSXFF AM TZR','NLS_DATE_LANGUAGE=english'), repeat_interval=> 
'FREQ=MONTHLY; INTERVAL=10'
, end_date=>NULL,
job_class=>'"DEFAULT_JOB_CLASS"', enabled=>FALSE, auto_drop=>FALSE,comments=>
'восстанавливаем статусы'
);
COMMIT; 
END; 
