declare
  c_MAX_ST CONSTANT INTEGER := 10;
BEGIN
  for i in 0..c_MAX_ST-1
  loop
    SYS.DBMS_SCHEDULER.CREATE_JOB
      (
         job_name        => 'J_HOT_BILLING_SAVE_CALL1_ST'||i
        ,start_date      => sysdate
        ,repeat_interval => 'Freq=Minutely;Interval=1'
        ,end_date        => NULL
        ,job_class       => 'DEFAULT_JOB_CLASS'
        ,job_type        => 'PLSQL_BLOCK'
        ,job_action      => 'begin 
                                STOP_JOB_PCKG.CHECK_WORK_JOB;
                                HOT_BILLING_SAVE_CALL('||i||', '||c_MAX_ST||'); 
                            end;'
        ,comments        => 'Загрузка горячего биллинга в CALL_MM_YYYY поток '||(i+1)
      );
    end loop;
end;    