--шедулер для оповещения о печальках
 begin
      DBMS_SCHEDULER.CREATE_JOB(
      job_name   => 'SMS_ERROR_NOTICE_JOB',
      job_type   => 'PLSQL_BLOCK',
      job_action => 'BEGIN 
						STOP_JOB_PCKG.CHECK_WORK_JOB; 
						SMS_SYSTEM_ERROR_NOTICE; 
					END;',
      start_date => SYSDATE+1/1440,
      repeat_interval => 'FREQ = MINUTELY; INTERVAL = 10',
      enabled    => TRUE
      );
end;  