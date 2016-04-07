
  
BEGIN 
dbms_scheduler.create_job('"J_UNBLOCK_CLIENT_95"',
job_type=>'PLSQL_BLOCK', job_action=>
'BEGIN 
STOP_JOB_PCKG.CHECK_WORK_JOB;
UNBLOCK_CLIENT_WTH_PLUS_BAL2(95);
 END;'
, number_of_arguments=>0,
start_date=>TO_TIMESTAMP_TZ('13-AUG-2013 03.25.32.000000000 PM +04:00','DD-MON-RRRR HH.MI.SSXFF AM TZR','NLS_DATE_LANGUAGE=english'), repeat_interval=> 
'FREQ = MINUTELY; INTERVAL = 15'
, end_date=>NULL,
job_class=>'"DEFAULT_JOB_CLASS"', enabled=>FALSE, auto_drop=>TRUE,comments=>
' Разблокировка клиентов с балансом больше 0 счета 95'
);
dbms_scheduler.enable('"J_UNBLOCK_CLIENT_95"');
COMMIT; 
END; 
