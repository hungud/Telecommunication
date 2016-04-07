
  
BEGIN 
dbms_scheduler.create_job('"J_RECALC_CURR_TARIF"',
job_type=>'PLSQL_BLOCK', job_action=>
'BEGIN
STOP_JOB_PCKG.CHECK_WORK_JOB;
-- be sure to substitute in actual values
-- where the parameter names are!
RECALC_PHONE_TARIF;
END;'
, number_of_arguments=>0,
start_date=>TO_TIMESTAMP_TZ('25-JAN-2013 12.36.18.362000000 PM +04:00','DD-MON-RRRR HH.MI.SSXFF AM TZR','NLS_DATE_LANGUAGE=english'), repeat_interval=> 
'FREQ=MINUTELY; INTERVAL=2'
, end_date=>NULL,
job_class=>'"DEFAULT_JOB_CLASS"', enabled=>FALSE, auto_drop=>TRUE,comments=>
'Пересчет текущего тарифа'
);
dbms_scheduler.enable('"J_RECALC_CURR_TARIF"');
COMMIT; 
END; 
