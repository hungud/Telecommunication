BEGIN
  SYS.DBMS_SCHEDULER.CREATE_JOB
    (
       job_name        => 'J_LOAD_SEND_NEW_CONTR_BY_URL'
      ,start_date      => SYSDATE
      ,repeat_interval => 'FREQ=MINUTELY;INTERVAL=15'
      ,end_date        => NULL
      ,job_type        => 'PLSQL_BLOCK'
      ,job_action      => 'BEGIN
STOP_JOB_PCKG.CHECK_WORK_JOB;
 LOAD_SEND_NEW_CONTRACTS_BY_UTL; END;'
      ,comments        => 'Загрузка новых контрактов по ссылке, и отправка отчета о загрузке по email'
    );
  SYS.DBMS_SCHEDULER.ENABLE
    (name                  => 'J_LOAD_SEND_NEW_CONTR_BY_URL');
END;
/
