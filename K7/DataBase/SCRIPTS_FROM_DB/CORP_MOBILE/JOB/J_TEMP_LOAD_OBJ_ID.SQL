
  
BEGIN 
dbms_scheduler.create_job('"J_TEMP_LOAD_OBJ_ID"',
job_type=>'PLSQL_BLOCK', job_action=>
'begin
  STOP_JOB_PCKG.CHECK_WORK_JOB;
  for c in (select acc.account_id from accounts acc where (acc.is_collector is null or acc.is_collector=0) and acc.account_id  in (51,49,95,72,98,73)) loop
      loader_call_pckg_n.load_obj_id(c.account_id);
  end loop;   
  
end;'
, number_of_arguments=>0,
start_date=>TO_TIMESTAMP_TZ('26-FEB-2014 03.20.10.056000000 PM +04:00','DD-MON-RRRR HH.MI.SSXFF AM TZR','NLS_DATE_LANGUAGE=english'), repeat_interval=> 
'FREQ=DAILY;BYMONTHDAY=1'
, end_date=>NULL,
job_class=>'"DEFAULT_JOB_CLASS"', enabled=>FALSE, auto_drop=>FALSE,comments=>
'Загрузка OBG_ID по счету '
);
COMMIT; 
END; 
