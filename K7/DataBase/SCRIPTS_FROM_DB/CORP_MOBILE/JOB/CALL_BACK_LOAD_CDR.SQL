
  
BEGIN 
dbms_scheduler.create_job('"CALL_BACK_LOAD_CDR"',
job_type=>'PLSQL_BLOCK', job_action=>
'begin
  STOP_JOB_PCKG.CHECK_WORK_JOB;
  -- Call the procedure
  load_cdr_call;
end;'
, number_of_arguments=>0,
start_date=>TO_TIMESTAMP_TZ('20-MAR-2014 12.00.00.000000000 AM +04:00','DD-MON-RRRR HH.MI.SSXFF AM TZR','NLS_DATE_LANGUAGE=english'), repeat_interval=> 
'Freq=Minutely;Interval=10'
, end_date=>NULL,
job_class=>'"DEFAULT_JOB_CLASS"', enabled=>FALSE, auto_drop=>FALSE,comments=>
'Сбор информации о звонках типа CALL_BACK '
);
dbms_scheduler.enable('"CALL_BACK_LOAD_CDR"');
COMMIT; 
END; 
