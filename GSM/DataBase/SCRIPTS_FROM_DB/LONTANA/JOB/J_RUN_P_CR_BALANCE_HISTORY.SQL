
  
BEGIN 
dbms_scheduler.create_job('"J_RUN_P_CR_BALANCE_HISTORY"',
job_type=>'PLSQL_BLOCK', job_action=>
'begin
 STOP_JOB_PCKG.CHECK_WORK_JOB;
--пересчёт баланса
 p_cr_balance_hist;
end;'
, number_of_arguments=>0,
start_date=>TO_TIMESTAMP_TZ('22-FEB-2013 02.00.00.000000000 AM +04:00','DD-MON-RRRR HH.MI.SSXFF AM TZR','NLS_DATE_LANGUAGE=english'), repeat_interval=> 
'Freq=Daily;Interval=1'
, end_date=>NULL,
job_class=>'"DEFAULT_JOB_CLASS"', enabled=>FALSE, auto_drop=>FALSE,comments=>
'Пересчет баланса'
);
dbms_scheduler.enable('"J_RUN_P_CR_BALANCE_HISTORY"');
COMMIT; 
END; 
