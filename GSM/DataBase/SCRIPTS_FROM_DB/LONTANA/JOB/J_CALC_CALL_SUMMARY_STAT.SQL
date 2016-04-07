
  
BEGIN 
dbms_scheduler.create_job('"J_CALC_CALL_SUMMARY_STAT"',
job_type=>'PLSQL_BLOCK', job_action=>
'
      begin   
        STOP_JOB_PCKG.CHECK_WORK_JOB;        
        CALC_CALL_SUMMARY_STAT ( TO_NUMBER( TO_CHAR( ADD_MONTHS( TRUNC(SYSDATE,''MM''), 0-to_number( ms_params.GET_PARAM_VALUE(''MONTH_OFFSET_MONITOR_OUTGOING_CALLS'' )
                                                                                                   )
                                                               ) 
                                                     ,''YYYYMM'' 
                                                   )
                                          )
                               , 1
                               );
      end;'
, number_of_arguments=>0,
start_date=>TO_TIMESTAMP_TZ('06-MAR-2015 08.00.00.000000000 PM +03:00','DD-MON-RRRR HH.MI.SSXFF AM TZR','NLS_DATE_LANGUAGE=english'), repeat_interval=> 
'FREQ=MONTHLY; INTERVAL=1;BYMONTHDAY=5; byhour=0;byminute=0;bysecond=0'
, end_date=>NULL,
job_class=>'"DEFAULT_JOB_CLASS"', enabled=>FALSE, auto_drop=>FALSE,comments=>
'Считаем сводную статистику по номерам для отчета по исходящей голосовой связи'
);
dbms_scheduler.enable('"J_CALC_CALL_SUMMARY_STAT"');
COMMIT; 
END; 
