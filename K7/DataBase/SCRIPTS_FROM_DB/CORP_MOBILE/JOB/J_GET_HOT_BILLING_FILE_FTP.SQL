
  
BEGIN 
dbms_scheduler.create_job('"J_GET_HOT_BILLING_FILE_FTP"',
job_type=>'PLSQL_BLOCK', job_action=>
'begin
    STOP_JOB_PCKG.CHECK_WORK_JOB;
    GET_FILE_FROM_FTP;
end;'
, number_of_arguments=>0,
start_date=>TO_TIMESTAMP_TZ('12-DEC-2014 08.37.16.669000000 AM +03:00','DD-MON-RRRR HH.MI.SSXFF AM TZR','NLS_DATE_LANGUAGE=english'), repeat_interval=> 
'FREQ=SECONDLY;INTERVAL=5'
, end_date=>NULL,
job_class=>'"DEFAULT_JOB_CLASS"', enabled=>FALSE, auto_drop=>TRUE,comments=>
'Получение файлов горячего биллинга с FTP'
);
dbms_scheduler.enable('"J_GET_HOT_BILLING_FILE_FTP"');
COMMIT; 
END; 
