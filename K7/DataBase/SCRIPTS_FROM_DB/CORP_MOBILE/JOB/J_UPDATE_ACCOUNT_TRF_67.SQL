
  
BEGIN 
dbms_scheduler.create_job('"J_UPDATE_ACCOUNT_TRF_67"',
job_type=>'PLSQL_BLOCK', job_action=>
'BEGIN
STOP_JOB_PCKG.CHECK_WORK_JOB;
loader_call_pckg_n.update_account_tariffs(67);
END;'
, number_of_arguments=>0,
start_date=>TO_TIMESTAMP_TZ('24-MAR-2014 12.00.00.000000000 AM +04:00','DD-MON-RRRR HH.MI.SSXFF AM TZR','NLS_DATE_LANGUAGE=english'), repeat_interval=> 
'FREQ=DAILY;INTERVAL=7'
, end_date=>NULL,
job_class=>'"DEFAULT_JOB_CLASS"', enabled=>FALSE, auto_drop=>FALSE,comments=>
'Загрузка тарифов и кодов для справочника db_loader_account_tariffs'
);
dbms_scheduler.enable('"J_UPDATE_ACCOUNT_TRF_67"');
COMMIT; 
END; 
