
  
BEGIN 
dbms_scheduler.create_job('"J_MNP_CUR_TO_HIST"',
job_type=>'PLSQL_BLOCK', job_action=>
'begin 
    STOP_JOB_PCKG.CHECK_WORK_JOB;
    MNP_CUR_TO_HIST; 
end;'
, number_of_arguments=>0,
start_date=>TO_TIMESTAMP_TZ('02-JUL-2014 05.05.00.000000000 AM +04:00','DD-MON-RRRR HH.MI.SSXFF AM TZR','NLS_DATE_LANGUAGE=english'), repeat_interval=> 
'Freq=Daily;Interval=1'
, end_date=>NULL,
job_class=>'"DEFAULT_JOB_CLASS"', enabled=>FALSE, auto_drop=>TRUE,comments=>
'Перенос MNP-номеров в историю, после того как пройдет 3 дня с момента активации основного номера'
);
dbms_scheduler.enable('"J_MNP_CUR_TO_HIST"');
COMMIT; 
END; 
