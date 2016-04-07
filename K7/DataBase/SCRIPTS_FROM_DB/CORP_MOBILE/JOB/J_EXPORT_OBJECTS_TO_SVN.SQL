
  
BEGIN 
dbms_scheduler.create_job('"J_EXPORT_OBJECTS_TO_SVN"',
job_type=>'PLSQL_BLOCK', job_action=>
'BEGIN
    STOP_JOB_PCKG.CHECK_WORK_JOB; 
    CORP_MOBILE.EXPORTOBJECTSTODISK
                              (''CORP_MOBILE'',
                                MS_CONSTANTS.GET_CONSTANT_VALUE(''EXPORT_OBJECTS_TO_SVN_PATH'')
                              );
END;'
, number_of_arguments=>0,
start_date=>TO_TIMESTAMP_TZ('27-MAR-2015 02.40.43.000000000 PM +04:00','DD-MON-RRRR HH.MI.SSXFF AM TZR','NLS_DATE_LANGUAGE=english'), repeat_interval=> 
'FREQ=HOURLY;INTERVAL=1;BYMINUTE=0;BYSECOND=0'
, end_date=>NULL,
job_class=>'"DEFAULT_JOB_CLASS"', enabled=>FALSE, auto_drop=>TRUE,comments=>
'Экспорт объектов в SVN '
);
dbms_scheduler.enable('"J_EXPORT_OBJECTS_TO_SVN"');
COMMIT; 
END; 
