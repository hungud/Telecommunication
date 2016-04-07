BEGIN
  SYS.DBMS_SCHEDULER.CREATE_JOB
    (
       job_name        => 'J_QUEUE_CHECK_PHONE_STATUS'
      ,start_date      =>   sysdate
      ,repeat_interval => 'FREQ=MINUTELY; INTERVAL=10'
      ,end_date        => NULL
      ,job_class       => 'DEFAULT_JOB_CLASS'
      ,job_type        => 'PLSQL_BLOCK'
      ,job_action      => 'BEGIN 
                            STOP_JOB_PCKG.CHECK_WORK_JOB;
                            CORP_MOBILE.P_QUEUE_CHECK_PHONE_STATUS; 
                          END;'
      ,comments        => 'ѕолучение статусов номеров из очереди QUEUE_CHECK_PHONE_STATUS'
    );
end;    