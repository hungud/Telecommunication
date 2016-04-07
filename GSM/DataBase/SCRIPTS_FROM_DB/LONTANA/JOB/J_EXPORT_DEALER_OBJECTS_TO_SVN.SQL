
  
BEGIN 
dbms_scheduler.create_job('"J_EXPORT_DEALER_OBJECTS_TO_SVN"',
job_type=>'PLSQL_BLOCK', job_action=>
'BEGIN    
  STOP_JOB_PCKG.CHECK_WORK_JOB;                              
  -- be sure to substitute in actual values
  -- where the parameter names are!
   LONTANA.EXPORTOBJECTSTODISK
         (''WWW_DEALER'',
                    ''D:\Tarifer\VersionControl\Database\DEALER'');                                                  
 END;
                           '
, number_of_arguments=>0,
start_date=>TO_TIMESTAMP_TZ('16-DEC-2013 05.37.25.496000000 PM +04:00','DD-MON-RRRR HH.MI.SSXFF AM TZR','NLS_DATE_LANGUAGE=english'), repeat_interval=> 
'FREQ=HOURLY;INTERVAL=1;BYMINUTE=0;BYSECOND=0'
, end_date=>NULL,
job_class=>'"DEFAULT_JOB_CLASS"', enabled=>FALSE, auto_drop=>TRUE,comments=>
'Экспорт объектов в svn'
);
COMMIT; 
END; 
