BEGIN
  SYS.DBMS_SCHEDULER.CREATE_JOB
    (
       job_name        => 'J_HOT_BILLING_SORTING_CALLS'
      ,start_date      => SYSDATE
      ,repeat_interval => 'FREQ=SECONDLY; INTERVAL=10'
      ,end_date        => NULL
      ,job_class       => 'DEFAULT_JOB_CLASS'
      ,job_type        => 'PLSQL_BLOCK'
      ,job_action      => 'BEGIN 
                             STOP_JOB_PCKG.CHECK_WORK_JOB;
                             HOT_BILLING_PCKG_KOK.LOAD_HOT_BILLING(0);
                           END;'
      ,comments        => '—ортировка звонков гор€чего биллинга'
    );

  SYS.DBMS_SCHEDULER.ENABLE
    (name                  => 'J_HOT_BILLING_SORTING_CALLS');
END;
/
