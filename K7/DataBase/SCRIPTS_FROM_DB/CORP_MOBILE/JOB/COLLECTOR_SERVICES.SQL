
  
BEGIN 
dbms_scheduler.create_job('"COLLECTOR_SERVICES"',
job_type=>'PLSQL_BLOCK', job_action=>
'Declare
result varchar2(1000);
BEGIN 
  STOP_JOB_PCKG.CHECK_WORK_JOB;
  for c in (select account_id from accounts where is_collector=1) loop
    result:=CORP_MOBILE.beeline_api_pckg.Collect_account_phone_opts (c.account_id);
  end loop;
END; '
, number_of_arguments=>0,
start_date=>TO_TIMESTAMP_TZ('18-OCT-2013 02.00.00.000000000 AM +04:00','DD-MON-RRRR HH.MI.SSXFF AM TZR','NLS_DATE_LANGUAGE=english'), repeat_interval=> 
'FREQ=HOURLY; INTERVAL=8; BYMINUTE=0; bysecond=0'
, end_date=>NULL,
job_class=>'"DEFAULT_JOB_CLASS"', enabled=>FALSE, auto_drop=>FALSE,comments=>
'Опции коллекторов через API'
);
COMMIT; 
END; 
