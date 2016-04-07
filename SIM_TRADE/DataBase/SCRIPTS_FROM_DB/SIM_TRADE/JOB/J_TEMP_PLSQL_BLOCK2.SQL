
  
BEGIN 
dbms_scheduler.create_job('"J_TEMP_PLSQL_BLOCK2"',
job_type=>'PLSQL_BLOCK', job_action=>
'BEGIN --RESTORE_LOG_API_STATUS_SORT; 
    STOP_JOB_PCKG.CHECK_WORK_JOB;
    CALC_BALANCE_ROWS_ALL;
END;'
, number_of_arguments=>0,
start_date=>TO_TIMESTAMP_TZ('07-OCT-2014 12.19.12.000000000 PM +04:00','DD-MON-RRRR HH.MI.SSXFF AM TZR','NLS_DATE_LANGUAGE=english'), repeat_interval=> 
'FREQ=hourLY; INTERVAL=1'
, end_date=>NULL,
job_class=>'"DEFAULT_JOB_CLASS"', enabled=>FALSE, auto_drop=>FALSE,comments=>
'Восстановление статусов '
);
COMMIT; 
END; 
