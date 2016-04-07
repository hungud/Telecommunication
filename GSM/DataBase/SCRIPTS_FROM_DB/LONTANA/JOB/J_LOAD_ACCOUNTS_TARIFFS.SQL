
  
BEGIN 
dbms_scheduler.create_job('"J_LOAD_ACCOUNTS_TARIFFS"',
job_type=>'PLSQL_BLOCK', job_action=>
'begin
  STOP_JOB_PCKG.CHECK_WORK_JOB; 
  for c in (select t.account_id from accounts t where nvl(t.is_collector,0)!=1
      and t.account_id not in (225,165)
      and t.account_id not in (select distinct r.account_id from DB_LOADER_ACCOUNT_TARIFFS r ))
loop
loader_call_pckg_n.update_account_tariffs(c.account_id);
commit;
end loop;
end;'
, number_of_arguments=>0,
start_date=>TO_TIMESTAMP_TZ('29-MAY-2015 10.29.13.853000000 AM +03:00','DD-MON-RRRR HH.MI.SSXFF AM TZR','NLS_DATE_LANGUAGE=english'), repeat_interval=> 
'FREQ=MINUTELY;INTERVAL=60'
, end_date=>NULL,
job_class=>'"DEFAULT_JOB_CLASS"', enabled=>FALSE, auto_drop=>FALSE,comments=>
'Загрузка тарифов абонента'
);
dbms_scheduler.enable('"J_LOAD_ACCOUNTS_TARIFFS"');
COMMIT; 
END; 
