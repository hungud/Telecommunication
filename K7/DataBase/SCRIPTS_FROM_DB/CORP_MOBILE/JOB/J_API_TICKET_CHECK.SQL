
  
BEGIN 
dbms_scheduler.create_job('"J_API_TICKET_CHECK"',
job_type=>'PLSQL_BLOCK', job_action=>
'begin 
    STOP_JOB_PCKG.CHECK_WORK_JOB;
    API_CHECK_TICKETS; 
end;'
, number_of_arguments=>0,
start_date=>TO_TIMESTAMP_TZ('30-NOV-2013 07.15.00.000000000 PM +04:00','DD-MON-RRRR HH.MI.SSXFF AM TZR','NLS_DATE_LANGUAGE=english'), repeat_interval=> 
'FREQ=MINUTELY; INTERVAL=20'
, end_date=>NULL,
job_class=>'"DEFAULT_JOB_CLASS"', enabled=>FALSE, auto_drop=>FALSE,comments=>
'проверяет статус заявки'
);
COMMIT; 
END; 
