
  
BEGIN 
dbms_scheduler.create_job('"J_LOAD_BILL_CHECK_INCORRECTS"',
job_type=>'PLSQL_BLOCK', job_action=>
'BEGIN 
STOP_JOB_PCKG.CHECK_WORK_JOB;
CHECK_INCORRECT_FINANCE_BILLS; 
END;'
, number_of_arguments=>0,
start_date=>TO_TIMESTAMP_TZ('10-OCT-2012 10.24.36.000000000 PM +04:00','DD-MON-RRRR HH.MI.SSXFF AM TZR','NLS_DATE_LANGUAGE=english'), repeat_interval=> 
'FREQ=MINUTELY; INTERVAL=1'
, end_date=>NULL,
job_class=>'"DEFAULT_JOB_CLASS"', enabled=>FALSE, auto_drop=>FALSE,comments=>
'Загрузка счетов из "Фин Инфо"'
);
dbms_scheduler.enable('"J_LOAD_BILL_CHECK_INCORRECTS"');
COMMIT; 
END; 
