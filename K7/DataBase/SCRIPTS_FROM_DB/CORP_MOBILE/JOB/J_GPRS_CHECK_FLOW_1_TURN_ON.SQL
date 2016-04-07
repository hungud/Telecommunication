
  
BEGIN 
dbms_scheduler.create_job('"J_GPRS_CHECK_FLOW_1_TURN_ON"',
job_type=>'PLSQL_BLOCK', job_action=>
'BEGIN
    STOP_JOB_PCKG.CHECK_WORK_JOB;
    beeline_rest_api_pckg.gprs_init_new_month; -- Инициализация нового месяца -- перенос данных прошедшего месяца в архив.
    dbms_scheduler.enable(''J_GPRS_CHECK_FLOW_1'');
    dbms_scheduler.enable(''J_GPRS_CHECK_FLOW_2'');
    dbms_scheduler.enable(''J_GPRS_CHECK_FLOW_3'');
    dbms_scheduler.enable(''J_GPRS_CHECK_FLOW_4'');
    dbms_scheduler.enable(''J_GPRS_CHECK_FLOW_5'');   
    dbms_scheduler.enable(''J_GPRS_CHECK_FLOW_6'');
    dbms_scheduler.enable(''J_GPRS_CHECK_FLOW_7'');
    dbms_scheduler.enable(''J_GPRS_CHECK_FLOW_8'');
    dbms_scheduler.enable(''J_GPRS_CHECK_FLOW_9'');
    dbms_scheduler.enable(''J_GPRS_CHECK_FLOW_10'');
END;'
, number_of_arguments=>0,
start_date=>TO_TIMESTAMP_TZ('01-MAR-2016 11.20.23.354000000 PM +03:00','DD-MON-RRRR HH.MI.SSXFF AM TZR','NLS_DATE_LANGUAGE=english'), repeat_interval=> 
'FREQ=DAILY;BYMONTHDAY=1;BYHOUR=1;BYMINUTE=05;BYSECOND=0'
, end_date=>NULL,
job_class=>'"DEFAULT_JOB_CLASS"', enabled=>FALSE, auto_drop=>FALSE,comments=>
NULL
);
dbms_scheduler.enable('"J_GPRS_CHECK_FLOW_1_TURN_ON"');
COMMIT; 
END; 
