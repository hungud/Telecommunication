
  
BEGIN 
dbms_scheduler.create_job('"J_TELETIE_PAY_SMS"',
job_type=>'PLSQL_BLOCK', job_action=>
'BEGIN 
  STOP_JOB_PCKG.CHECK_WORK_JOB;
  CORP_MOBILE.P_TELETIE_PAY_SMS; 
END;'
, number_of_arguments=>0,
start_date=>TO_TIMESTAMP_TZ('29-JAN-2014 07.50.00.000000000 PM +04:00','DD-MON-RRRR HH.MI.SSXFF AM TZR','NLS_DATE_LANGUAGE=english'), repeat_interval=> 
'FREQ=MINUTELY; INTERVAL=10'
, end_date=>NULL,
job_class=>'"DEFAULT_JOB_CLASS"', enabled=>FALSE, auto_drop=>FALSE,comments=>
'Отправка уведомлений об оплате TELETIE'
);
dbms_scheduler.enable('"J_TELETIE_PAY_SMS"');
COMMIT; 
END; 
