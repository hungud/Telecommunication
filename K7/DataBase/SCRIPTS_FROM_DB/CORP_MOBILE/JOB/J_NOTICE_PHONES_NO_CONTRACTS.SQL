
  
BEGIN 
dbms_scheduler.create_job('"J_NOTICE_PHONES_NO_CONTRACTS"',
job_type=>'PLSQL_BLOCK', job_action=>
'BEGIN   
    STOP_JOB_PCKG.CHECK_WORK_JOB;
    NOTICE_PHONE_WITHOUT_CONTRACTS; 
END;'
, number_of_arguments=>0,
start_date=>TO_TIMESTAMP_TZ('13-NOV-2012 05.22.21.000000000 PM +04:00','DD-MON-RRRR HH.MI.SSXFF AM TZR','NLS_DATE_LANGUAGE=english'), repeat_interval=> 
'FREQ=MINUTELY; INTERVAL=5'
, end_date=>NULL,
job_class=>'"DEFAULT_JOB_CLASS"', enabled=>FALSE, auto_drop=>FALSE,comments=>
'ПРЕД О НОМЕРАХ БЕЗ ДОГОВОРОВ'
);
dbms_scheduler.enable('"J_NOTICE_PHONES_NO_CONTRACTS"');
COMMIT; 
END; 
