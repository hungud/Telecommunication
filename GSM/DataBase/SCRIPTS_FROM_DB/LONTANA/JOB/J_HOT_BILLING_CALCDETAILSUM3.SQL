
  
BEGIN 
dbms_scheduler.create_job('"J_HOT_BILLING_CALCDETAILSUM3"',
job_type=>'PLSQL_BLOCK', job_action=>
'begin
    STOP_JOB_PCKG.CHECK_WORK_JOB;
    HOT_BILLING_CALCDETAILSUMS(2,6);
  end;'
, number_of_arguments=>0,
start_date=>TO_TIMESTAMP_TZ('22-OCT-2013 12.00.00.000000000 AM +04:00','DD-MON-RRRR HH.MI.SSXFF AM TZR','NLS_DATE_LANGUAGE=english'), repeat_interval=> 
'Freq=Secondly;Interval=5'
, end_date=>NULL,
job_class=>'"DEFAULT_JOB_CLASS"', enabled=>FALSE, auto_drop=>FALSE,comments=>
'Горячий биллинг сумм по детализации'
);
COMMIT; 
END; 
