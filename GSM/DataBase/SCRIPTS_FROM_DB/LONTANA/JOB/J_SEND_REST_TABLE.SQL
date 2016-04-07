
  
BEGIN 
dbms_scheduler.create_job('"J_SEND_REST_TABLE"',
job_type=>'PLSQL_BLOCK', job_action=>
'begin
    STOP_JOB_PCKG.CHECK_WORK_JOB;
    SEND_REST_TABLE;
end;'
, number_of_arguments=>0,
start_date=>TO_TIMESTAMP_TZ('25-NOV-2015 01.27.24.053000000 PM +04:00','DD-MON-RRRR HH.MI.SSXFF AM TZR','NLS_DATE_LANGUAGE=english'), repeat_interval=> 
'FREQ=MINUTELY;INTERVAL=1;'
, end_date=>NULL,
job_class=>'"DEFAULT_JOB_CLASS"', enabled=>FALSE, auto_drop=>TRUE,comments=>
'Рассылка смс с информацией об остатках по пакетам.'
);
dbms_scheduler.enable('"J_SEND_REST_TABLE"');
COMMIT; 
END; 
