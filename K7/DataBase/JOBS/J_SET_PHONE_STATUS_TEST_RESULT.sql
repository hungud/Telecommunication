BEGIN
  SYS.DBMS_SCHEDULER.CREATE_JOB(
       job_name        => 'J_SET_PHONE_STATUS_TEST_RESULT'
      ,start_date      => sysdate
      ,repeat_interval => 'FREQ=MINUTELY; INTERVAL=6'
      ,end_date        => NULL
      ,job_class       => 'DEFAULT_JOB_CLASS'
      ,job_type        => 'PLSQL_BLOCK'
      ,job_action      => 'BEGIN 
                             STOP_JOB_PCKG.CHECK_WORK_JOB;
                             SET_PHONE_STATUS_TEST_RESULT; 
                           END;'
      ,comments        => 'Тест на получение статусов телефонов'
    );
   SYS.DBMS_SCHEDULER.ENABLE(name  => 'J_SET_PHONE_STATUS_TEST_RESULT');
END;
/