BEGIN
  SYS.DBMS_SCHEDULER.CREATE_JOB
    (
       job_name        => 'J_UPDATE_REGION_BY_PHONE'
      ,start_date      => sysdate
      ,repeat_interval => 'Freq=HOURLY;Interval=6'
      ,end_date        => NULL
      ,job_class       => 'DEFAULT_JOB_CLASS'
      ,job_type        => 'PLSQL_BLOCK'
      ,job_action      => 'begin
                             STOP_JOB_PCKG.CHECK_WORK_JOB;
                             UPDATE_REGION_BY_PHONE;
                           end;'
      ,comments        => 'Обновление региона по телефонному номеру'
    );
END;
/
