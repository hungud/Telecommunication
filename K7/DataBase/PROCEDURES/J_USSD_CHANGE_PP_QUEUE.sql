BEGIN
  SYS.DBMS_SCHEDULER.CREATE_JOB(
       job_name        => 'J_USSD_CHANGE_PP_QUEUE'
      ,start_date      => SYSDATE
      ,repeat_interval => 'FREQ=MINUTELY; INTERVAL=1; BYSECOND=0'
      ,end_date        => NULL
      ,job_class       => 'DEFAULT_JOB_CLASS'
      ,job_type        => 'PLSQL_BLOCK'
      ,job_action      => 'BEGIN 
                            STOP_JOB_PCKG.CHECK_WORK_JOB;
                            P_USSD_CHANGE_PP_QUEUE; 
                          END;'
      ,comments        => 'Очередь на смену тарифных планов по USSD'
    );
END;
/