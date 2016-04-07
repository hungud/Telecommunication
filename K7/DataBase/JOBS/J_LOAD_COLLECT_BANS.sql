begin
  SYS.DBMS_SCHEDULER.CREATE_JOB
    (
       job_name        => 'J_LOAD_COLLECT_BANS'
      ,start_date      => sysdate
      ,repeat_interval => 'FREQ=MINUTELY;INTERVAL=20;'
      ,end_date        => NULL
      ,job_class       => 'DEFAULT_JOB_CLASS'
      ,job_type        => 'PLSQL_BLOCK'
      ,job_action      => '
                          BEGIN
                            STOP_JOB_PCKG.CHECK_WORK_JOB;
                            P_LOAD_COLLECT_BANS;
                          END;
                          '
      ,comments        => 'Загрузка подбанов для коллекторских счетов'
    );
end;
