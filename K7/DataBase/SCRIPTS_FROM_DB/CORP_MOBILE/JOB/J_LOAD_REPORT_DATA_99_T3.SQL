
  
BEGIN 
dbms_scheduler.create_job('"J_LOAD_REPORT_DATA_99_T3"',
job_type=>'PLSQL_BLOCK', job_action=>
'DECLARE
TMP varchar2(1000);
BEGIN
    STOP_JOB_PCKG.CHECK_WORK_JOB;
    TMP:=beeline_api_pckg.account_report_data(99,3);
END;'
, number_of_arguments=>0,
start_date=>TO_TIMESTAMP_TZ('24-MAR-2014 12.00.00.000000000 AM +04:00','DD-MON-RRRR HH.MI.SSXFF AM TZR','NLS_DATE_LANGUAGE=english'), repeat_interval=> 
'FREQ=MINUTELY;INTERVAL=60'
, end_date=>NULL,
job_class=>'"DEFAULT_JOB_CLASS"', enabled=>FALSE, auto_drop=>FALSE,comments=>
'Загрузка отчетов о текущих начислениях ID 99'
);
dbms_scheduler.enable('"J_LOAD_REPORT_DATA_99_T3"');
COMMIT; 
END; 
