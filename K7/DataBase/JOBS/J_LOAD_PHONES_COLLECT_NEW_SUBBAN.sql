begin
  SYS.DBMS_SCHEDULER.CREATE_JOB
    (
       job_name        => 'J_LOAD_PHONES_COLLECT_NEW_SUBBAN'
      ,start_date      => sysdate
      ,repeat_interval => 'FREQ=MINUTELY;INTERVAL=20'
      ,end_date        => NULL
      ,job_class       => 'DEFAULT_JOB_CLASS'
      ,job_type        => 'PLSQL_BLOCK'
      ,job_action      => 'declare
                             Result varchar2(500);
                           BEGIN
                             STOP_JOB_PCKG.CHECK_WORK_JOB;
                             result := beeline_api_pckg.collect_account_phone_status(pLOAD_ONLY_NEW => 1);
                           END;'
      ,comments        => 'Статусы коллекторских л\с по новым подбанам'
    );
end;    