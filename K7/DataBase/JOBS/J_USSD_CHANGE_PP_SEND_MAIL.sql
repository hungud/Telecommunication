BEGIN
  SYS.DBMS_SCHEDULER.CREATE_JOB
    (
       job_name        => 'J_USSD_CHANGE_PP_SEND_MAIL'
      ,start_date      => SYSDATE
      ,repeat_interval => 'FREQ=MINUTELY;INTERVAL=30'
      ,end_date        => NULL
      ,job_type        => 'PLSQL_BLOCK'
      ,job_action      => 'BEGIN 
                             STOP_JOB_PCKG.CHECK_WORK_JOB;
                             P_USSD_CHANGE_PP_SEND_MAIL; 
                           END;'
      ,comments        => 'Отправка письма с заявками на смену тарифного плана, полученых по USSD'
    );
  SYS.DBMS_SCHEDULER.ENABLE
    (name                  => 'J_USSD_CHANGE_PP_SEND_MAIL');
END;
/
