
  
BEGIN 
dbms_scheduler.create_job('"J_CALC_CALL_SUMMARY"',
job_type=>'PLSQL_BLOCK', job_action=>
'begin   
    STOP_JOB_PCKG.CHECK_WORK_JOB;
    CALC_CALL_SUMMARY(TO_NUMBER(TO_CHAR(ADD_MONTHS(TRUNC(SYSDATE,''MM''),-1), ''YYYYMM'')), 1); 
end;'
, number_of_arguments=>0,
start_date=>TO_TIMESTAMP_TZ('23-OCT-2014 06.15.20.372000000 PM +04:00','DD-MON-RRRR HH.MI.SSXFF AM TZR','NLS_DATE_LANGUAGE=english'), repeat_interval=> 
'FREQ=MONTHLY; INTERVAL=1;BYMONTHDAY=10; byhour=0;byminute=0;bysecond=0'
, end_date=>NULL,
job_class=>'"DEFAULT_JOB_CLASS"', enabled=>FALSE, auto_drop=>FALSE,comments=>
'Считаем сводную статистику по номерам для отчета "Анализ базы номеров(отток\подключения)"'
);
dbms_scheduler.enable('"J_CALC_CALL_SUMMARY"');
COMMIT; 
END; 
