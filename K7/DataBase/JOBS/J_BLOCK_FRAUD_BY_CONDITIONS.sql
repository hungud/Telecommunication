BEGIN
  SYS.DBMS_SCHEDULER.CREATE_JOB
    (
       job_name        => 'J_BLOCK_FRAUD_BY_CONDITIONS'
      ,start_date      => sysdate
      ,repeat_interval => 'Freq=Minutely;Interval=10'
      ,end_date        => NULL
      ,job_class       => 'DEFAULT_JOB_CLASS'
      ,job_type        => 'PLSQL_BLOCK'
      ,job_action      => 'begin
                            STOP_JOB_PCKG.CHECK_WORK_JOB;
                            
                            BLOCK_FRAUD_BY_CONDITIONS;
                          end;'
      ,comments        => 'Проставляем номмерам доп статус "ФРОД" и блокируем номера'
    );

  SYS.DBMS_SCHEDULER.ENABLE
    (name                  => 'J_BLOCK_FRAUD_BY_CONDITIONS');
END;
/
