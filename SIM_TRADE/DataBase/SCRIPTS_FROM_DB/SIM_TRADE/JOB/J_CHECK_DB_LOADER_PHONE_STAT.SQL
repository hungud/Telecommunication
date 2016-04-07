
  
BEGIN 
dbms_scheduler.create_job('"J_CHECK_DB_LOADER_PHONE_STAT"',
job_type=>'PLSQL_BLOCK', job_action=>
'BEGIN
    STOP_JOB_PCKG.CHECK_WORK_JOB;
    CHECK_DB_LOADER_PHONE_STAT;
END;'
, number_of_arguments=>0,
start_date=>TO_TIMESTAMP_TZ('24-MAR-2015 10.00.00.000000000 AM +04:00','DD-MON-RRRR HH.MI.SSXFF AM TZR','NLS_DATE_LANGUAGE=english'), repeat_interval=> 
'Freq=Daily;Interval=1;ByHour=10;ByMinute=00'
, end_date=>NULL,
job_class=>'"DEFAULT_JOB_CLASS"', enabled=>FALSE, auto_drop=>FALSE,comments=>
'Проверяет суммы начисления в статистике по номеру и сумм начисления в детализации'
);
dbms_scheduler.enable('"J_CHECK_DB_LOADER_PHONE_STAT"');
COMMIT; 
END; 
