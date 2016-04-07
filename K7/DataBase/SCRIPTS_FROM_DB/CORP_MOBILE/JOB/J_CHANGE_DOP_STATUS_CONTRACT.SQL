
  
BEGIN 
dbms_scheduler.create_job('"J_CHANGE_DOP_STATUS_CONTRACT"',
job_type=>'PLSQL_BLOCK', job_action=>
'BEGIN 
    STOP_JOB_PCKG.CHECK_WORK_JOB;
    CORP_MOBILE.CHANGE_CONTRACT_DOP_STATUS; 
END;'
, number_of_arguments=>0,
start_date=>TO_TIMESTAMP_TZ('28-OCT-2014 09.51.16.000000000 AM +04:00','DD-MON-RRRR HH.MI.SSXFF AM TZR','NLS_DATE_LANGUAGE=english'), repeat_interval=> 
'FREQ=MINUTELY; INTERVAL=5'
, end_date=>NULL,
job_class=>'"DEFAULT_JOB_CLASS"', enabled=>FALSE, auto_drop=>FALSE,comments=>
'Изменение доп статуса договора "Предпродажная подготовка"'
);
dbms_scheduler.enable('"J_CHANGE_DOP_STATUS_CONTRACT"');
COMMIT; 
END; 
