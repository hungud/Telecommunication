
  
BEGIN 
dbms_scheduler.create_job('"J_CREATE_EXT_TABLE_FOR_CALLS"',
job_type=>'PLSQL_BLOCK', job_action=>
'begin
    STOP_JOB_PCKG.CHECK_WORK_JOB;
    CREATE_EXT_TABLE_FOR_CALLS;
end;'
, number_of_arguments=>0,
start_date=>NULL, repeat_interval=> 
'FREQ=DAILY;BYMONTHDAY=10'
, end_date=>NULL,
job_class=>'"DEFAULT_JOB_CLASS"', enabled=>FALSE, auto_drop=>FALSE,comments=>
'Выгрузка во внешние файлы таблиц, которые старше 3-х месяцев'
);
COMMIT; 
END; 
