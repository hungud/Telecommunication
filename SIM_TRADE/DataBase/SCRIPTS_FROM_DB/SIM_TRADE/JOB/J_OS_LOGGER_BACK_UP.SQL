
  
BEGIN 
dbms_scheduler.create_job('"J_OS_LOGGER_BACK_UP"',
job_type=>'PLSQL_BLOCK', job_action=>
'begin
    STOP_JOB_PCKG.CHECK_WORK_JOB;
    P_OS_LOGGER_BACK_UP;
end;'
, number_of_arguments=>0,
start_date=>TO_TIMESTAMP_TZ('17-NOV-2013 01.00.00.000000000 AM +04:00','DD-MON-RRRR HH.MI.SSXFF AM TZR','NLS_DATE_LANGUAGE=english'), repeat_interval=> 
'FREQ=DAILY'
, end_date=>NULL,
job_class=>'"DEFAULT_JOB_CLASS"', enabled=>FALSE, auto_drop=>FALSE,comments=>
'Выгрузка табилиц loader_call_n_log и BEELINE_SOAP_API_LOG во внешние таблицы'
);
dbms_scheduler.enable('"J_OS_LOGGER_BACK_UP"');
COMMIT; 
END; 
