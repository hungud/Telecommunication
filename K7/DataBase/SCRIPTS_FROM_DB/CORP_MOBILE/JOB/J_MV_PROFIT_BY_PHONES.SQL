
  
BEGIN 
dbms_scheduler.create_job('"J_MV_PROFIT_BY_PHONES"',
job_type=>'PLSQL_BLOCK', job_action=>
'begin
      STOP_JOB_PCKG.CHECK_WORK_JOB;
      dbms_mview.refresh(LIST=>''MV_PROFIT_BY_PHONES_YEAR'', METHOD => ''C'', PARALLELISM=>3);
end;'
, number_of_arguments=>0,
start_date=>TO_TIMESTAMP_TZ('23-OCT-2014 06.15.20.372000000 PM +04:00','DD-MON-RRRR HH.MI.SSXFF AM TZR','NLS_DATE_LANGUAGE=english'), repeat_interval=> 
'FREQ=MONTHLY; INTERVAL=1;BYMONTHDAY=27;byhour=6;byminute=0;bysecond=0'
, end_date=>NULL,
job_class=>'"DEFAULT_JOB_CLASS"', enabled=>FALSE, auto_drop=>FALSE,comments=>
'Обновление материализованного представления MV_PROFIT_BY_PHONES_YEAR'
);
COMMIT; 
END; 
