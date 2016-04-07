
  
BEGIN 
dbms_scheduler.create_job('"J_P_EVERYDAY_PAY"',
job_type=>'PLSQL_BLOCK', job_action=>
'begin
      STOP_JOB_PCKG.CHECK_WORK_JOB;
      p_everyday_pay;
end;'
, number_of_arguments=>0,
start_date=>TO_TIMESTAMP_TZ('17-APR-2014 12.05.00.000000000 AM +04:00','DD-MON-RRRR HH.MI.SSXFF AM TZR','NLS_DATE_LANGUAGE=english'), repeat_interval=> 
'Freq=Daily;Interval=1;BYHOUR=1;BYMINUTE=5;BYSECOND=0'
, end_date=>NULL,
job_class=>'"DEFAULT_JOB_CLASS"', enabled=>FALSE, auto_drop=>FALSE,comments=>
'Добавление номера в очередь на персечет баланса'
);
dbms_scheduler.enable('"J_P_EVERYDAY_PAY"');
COMMIT; 
END; 
