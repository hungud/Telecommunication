BEGIN
  SYS.DBMS_SCHEDULER.CREATE_JOB
    (
       job_name        => 'J_CALC_BALANCE'
      ,start_date      => sysdate
      ,repeat_interval => 'Freq=MINUTELY;Interval=10'
      ,end_date        => NULL
      ,job_class       => 'DEFAULT_JOB_CLASS'
      ,job_type        => 'PLSQL_BLOCK'
      ,job_action      => 'BEGIN
                             STOP_JOB_PCKG.CHECK_WORK_JOB;
                             CALC_BALANCE;
                           END;'
      ,comments        => 'Джоб для пересчета баланса пользователей'
    );
end;    