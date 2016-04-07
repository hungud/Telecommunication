
  
BEGIN 
dbms_scheduler.create_job('"J_HOT_BILLING_SAVE_CALL_SITE"',
job_type=>'PLSQL_BLOCK', job_action=>
'begin 
    STOP_JOB_PCKG.CHECK_WORK_JOB;
    hot_billing_PCKG.SAVE_CALL(1,0,1); 
end;'
, number_of_arguments=>0,
start_date=>TO_TIMESTAMP_TZ('20-DEC-2013 12.00.00.000000000 AM +04:00','DD-MON-RRRR HH.MI.SSXFF AM TZR','NLS_DATE_LANGUAGE=english'), repeat_interval=> 
'Freq=Minutely;Interval=1'
, end_date=>NULL,
job_class=>'"DEFAULT_JOB_CLASS"', enabled=>FALSE, auto_drop=>FALSE,comments=>
'hot_billing_save_call_site'
);
COMMIT; 
END; 
