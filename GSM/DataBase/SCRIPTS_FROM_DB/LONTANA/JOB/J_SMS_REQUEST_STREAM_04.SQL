
  
BEGIN 
dbms_scheduler.create_job('"J_SMS_REQUEST_STREAM_04"',
job_type=>'PLSQL_BLOCK', job_action=>
'begin 
STOP_JOB_PCKG.CHECK_WORK_JOB;
SMS_REQUEST(4); 
end;'
, number_of_arguments=>0,
start_date=>TO_TIMESTAMP_TZ('11-AUG-2014 01.00.00.000000000 PM +04:00','DD-MON-RRRR HH.MI.SSXFF AM TZR','NLS_DATE_LANGUAGE=english'), repeat_interval=> 
'Freq=Secondly;Interval=20'
, end_date=>NULL,
job_class=>'"DEFAULT_JOB_CLASS"', enabled=>FALSE, auto_drop=>TRUE,comments=>
'Рассылка смс по таблице SMS_CURRENT поток 4'
);
COMMIT; 
END; 
