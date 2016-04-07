BEGIN
  SYS.DBMS_SCHEDULER.CREATE_JOB(
       job_name        => 'J_DELAYED_ON_OFF_TARIFF_OPTION'
      ,start_date      => SYSDATE
      ,repeat_interval => 'FREQ=MINUTELY; INTERVAL=1; BYSECOND=0'
      ,end_date        => NULL
      ,job_class       => 'DEFAULT_JOB_CLASS'
      ,job_type        => 'PLSQL_BLOCK'
      ,job_action      => 'BEGIN 
                             STOP_JOB_PCKG.CHECK_WORK_JOB;
                             TURN_ON_OFF_TARIFF_OPTIONS; 
                           END;'
      ,comments        => 'Подключение/отключение услуг через ДЖОБ в тарифере будущей датой.'
    );
END;
/