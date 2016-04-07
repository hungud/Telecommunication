
  
BEGIN 
dbms_scheduler.create_job('"J_HOT_BILLING_LOAD_LOGGER"',
job_type=>'PLSQL_BLOCK', job_action=>
'BEGIN  
--
--#Version=1
--
--v.1 09.10.2014 Афросин - Добавил джоб
--
    STOP_JOB_PCKG.CHECK_WORK_JOB;
    HOT_BILLING_DBF_LOADED_LOGGER(MS_PARAMS.GET_PARAM_VALUE(''HOT_BILL_NEW_DBF_FILE_PATH''));    
END;'
, number_of_arguments=>0,
start_date=>TO_TIMESTAMP_TZ('08-OCT-2014 05.46.04.000000000 PM +04:00','DD-MON-RRRR HH.MI.SSXFF AM TZR','NLS_DATE_LANGUAGE=english'), repeat_interval=> 
'FREQ = secondLY; INTERVAL = 5'
, end_date=>NULL,
job_class=>'"DEFAULT_JOB_CLASS"', enabled=>FALSE, auto_drop=>TRUE,comments=>
'загрузка наименований файлов горячего биллинга в базу'
);
dbms_scheduler.enable('"J_HOT_BILLING_LOAD_LOGGER"');
COMMIT; 
END; 
