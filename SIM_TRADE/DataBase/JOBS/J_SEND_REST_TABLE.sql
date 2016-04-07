begin
  SYS.DBMS_SCHEDULER.CREATE_JOB
    (
       job_name        => 'CORP_MOBILE.J_SEND_REST_TABLE'
      ,start_date      => NULL
      ,repeat_interval => 'FREQ=MINUTELY;INTERVAL=1;'
      ,end_date        => NULL
      ,job_class       => 'DEFAULT_JOB_CLASS'
      ,job_type        => 'PLSQL_BLOCK'
      ,job_action      => 'begin
                             SEND_REST_TABLE;
                           end;'
      ,comments        => 'Рассылка смс с информацией об остатках по пакетам.'
    );
end;