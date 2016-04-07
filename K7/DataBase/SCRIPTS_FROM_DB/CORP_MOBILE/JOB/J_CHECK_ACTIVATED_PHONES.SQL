
  
BEGIN 
dbms_scheduler.create_job('"J_CHECK_ACTIVATED_PHONES"',
job_type=>'PLSQL_BLOCK', job_action=>
'BEGIN
    STOP_JOB_PCKG.CHECK_WORK_JOB;
    CheckActivatedPhones( p_check_single_phone => 0 );
END;
'
, number_of_arguments=>0,
start_date=>TO_TIMESTAMP_TZ('24-OCT-2014 03.29.13.000000000 PM +04:00','DD-MON-RRRR HH.MI.SSXFF AM TZR','NLS_DATE_LANGUAGE=english'), repeat_interval=> 
'FREQ=MINUTELY; INTERVAL=1'
, end_date=>NULL,
job_class=>'"DEFAULT_JOB_CLASS"', enabled=>FALSE, auto_drop=>FALSE,comments=>
'Проверяет активацию номера (первые действия: вызовы, USSD-запросы и т.п.) и в случае обнаружения событий отправляет SMS'
);
dbms_scheduler.enable('"J_CHECK_ACTIVATED_PHONES"');
COMMIT; 
END; 
