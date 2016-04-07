
  
BEGIN 
dbms_scheduler.create_job('"J_OS_LOGGER_BACK_UP"',
program_name=>'"BACKUP_LOADER_CALL_N_LOG"',
schedule_name=>'"SHEDULE_BACKUP_DAILY"',
job_class=>'"DEFAULT_JOB_CLASS"', enabled=>FALSE, auto_drop=>TRUE,comments=>
NULL
);
dbms_scheduler.enable('"J_OS_LOGGER_BACK_UP"');
COMMIT; 
END; 
