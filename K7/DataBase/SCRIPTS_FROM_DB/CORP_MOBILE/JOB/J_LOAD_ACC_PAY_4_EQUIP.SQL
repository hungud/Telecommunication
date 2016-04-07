
  
BEGIN 
dbms_scheduler.create_job('"J_LOAD_ACC_PAY_4_EQUIP"',
job_type=>'PLSQL_BLOCK', job_action=>
'begin   
    STOP_JOB_PCKG.CHECK_WORK_JOB;
    LOAD_ACC_PAYMENTS_4_EQUIPMENTS;
end;'
, number_of_arguments=>0,
start_date=>TO_TIMESTAMP_TZ('04-DEC-2014 11.00.00.000000000 AM +04:00','DD-MON-RRRR HH.MI.SSXFF AM TZR','NLS_DATE_LANGUAGE=english'), repeat_interval=> 
'Freq=Daily;Interval=1;ByHour=11;ByMinute=00'
, end_date=>NULL,
job_class=>'"DEFAULT_JOB_CLASS"', enabled=>FALSE, auto_drop=>FALSE,comments=>
'Загрузка счетов оплаты за оборудование'
);
dbms_scheduler.enable('"J_LOAD_ACC_PAY_4_EQUIP"');
COMMIT; 
END; 
