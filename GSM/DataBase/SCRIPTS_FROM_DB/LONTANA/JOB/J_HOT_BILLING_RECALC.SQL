
  
BEGIN 
dbms_scheduler.create_job('"J_HOT_BILLING_RECALC"',
job_type=>'PLSQL_BLOCK', job_action=>
'begin 
  STOP_JOB_PCKG.CHECK_WORK_JOB;
  CHECK_BILL_ADD_COSTN;
end;  '
, number_of_arguments=>0,
start_date=>TO_TIMESTAMP_TZ('23-JAN-2014 12.00.00.000000000 AM +04:00','DD-MON-RRRR HH.MI.SSXFF AM TZR','NLS_DATE_LANGUAGE=english'), repeat_interval=> 
'Freq=Monthly;Interval=1'
, end_date=>NULL,
job_class=>'"DEFAULT_JOB_CLASS"', enabled=>FALSE, auto_drop=>FALSE,comments=>
'Пересчет горячего биллинга'
);
dbms_scheduler.enable('"J_HOT_BILLING_RECALC"');
COMMIT; 
END; 
