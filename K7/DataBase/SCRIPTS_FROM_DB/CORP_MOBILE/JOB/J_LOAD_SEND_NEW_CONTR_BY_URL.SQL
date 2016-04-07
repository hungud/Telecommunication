
  
BEGIN 
dbms_scheduler.create_job('"J_LOAD_SEND_NEW_CONTR_BY_URL"',
job_type=>'PLSQL_BLOCK', job_action=>
'BEGIN 
    STOP_JOB_PCKG.CHECK_WORK_JOB;
    LOAD_SEND_NEW_CONTRACTS_BY_UTL; 
END;'
, number_of_arguments=>0,
start_date=>TO_TIMESTAMP_TZ('04-MAR-2015 11.26.16.000000000 AM +04:00','DD-MON-RRRR HH.MI.SSXFF AM TZR','NLS_DATE_LANGUAGE=english'), repeat_interval=> 
'FREQ=MINUTELY;INTERVAL=15'
, end_date=>NULL,
job_class=>'"DEFAULT_JOB_CLASS"', enabled=>FALSE, auto_drop=>TRUE,comments=>
'Загрузка новых контрактов по ссылке, и отправка отчета о загрузке по email'
);
dbms_scheduler.enable('"J_LOAD_SEND_NEW_CONTR_BY_URL"');
COMMIT; 
END; 
