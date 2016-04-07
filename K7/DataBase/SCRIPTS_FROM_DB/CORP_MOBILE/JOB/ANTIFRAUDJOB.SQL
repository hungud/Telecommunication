
  
BEGIN 
dbms_scheduler.create_job('"ANTIFRAUDJOB"',
job_type=>'EXECUTABLE', job_action=>
'C:\Windows\System32\cmd.exe /C D:\Tarifer\AntiFraudJob\AntiFraudJob.exe > null'
, number_of_arguments=>0,
start_date=>TO_TIMESTAMP_TZ('04-APR-2012 03.49.10.000000000 PM +04:00','DD-MON-RRRR HH.MI.SSXFF AM TZR','NLS_DATE_LANGUAGE=english'), repeat_interval=> 
'FREQ = MINUTELY; INTERVAL = 30'
, end_date=>NULL,
job_class=>'"DEFAULT_JOB_CLASS"', enabled=>FALSE, auto_drop=>FALSE,comments=>
'Проверка детализаий по наличию фрода'
);
COMMIT; 
END; 
