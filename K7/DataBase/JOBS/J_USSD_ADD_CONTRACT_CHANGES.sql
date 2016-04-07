BEGIN
  SYS.DBMS_SCHEDULER.CREATE_JOB(
       job_name        => 'J_USSD_ADD_CONTRACT_CHANGES'
      ,start_date      => SYSDATE
      ,repeat_interval => 'FREQ=MINUTELY; INTERVAL=1; BYSECOND=0'
      ,end_date        => NULL
      ,job_class       => 'DEFAULT_JOB_CLASS'
      ,job_type        => 'PLSQL_BLOCK'
      ,job_action      => 'BEGIN 
                            STOP_JOB_PCKG.CHECK_WORK_JOB;
                            P_USSD_ADD_CONTRACT_CHANGES; 
                          END;'
      ,comments        => 'Создание доп.договора в тарифере, при успешной смене тарифа по USSD'
    );
END;
/