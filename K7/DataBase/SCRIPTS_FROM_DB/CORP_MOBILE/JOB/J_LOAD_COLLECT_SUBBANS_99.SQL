
  
BEGIN 
dbms_scheduler.create_job('"J_LOAD_COLLECT_SUBBANS_99"',
job_type=>'PLSQL_BLOCK', job_action=>
'declare
result varchar2(500);
BEGIN
STOP_JOB_PCKG.CHECK_WORK_JOB;
result:=beeline_api_pckg.collect_account_bans(99);
END;'
, number_of_arguments=>0,
start_date=>TO_TIMESTAMP_TZ('24-MAR-2014 12.00.00.000000000 AM +04:00','DD-MON-RRRR HH.MI.SSXFF AM TZR','NLS_DATE_LANGUAGE=english'), repeat_interval=> 
'FREQ=MINUTELY;INTERVAL=60'
, end_date=>NULL,
job_class=>'"DEFAULT_JOB_CLASS"', enabled=>FALSE, auto_drop=>FALSE,comments=>
'Получает список подбанов на счете 99  '
);
COMMIT; 
END; 
