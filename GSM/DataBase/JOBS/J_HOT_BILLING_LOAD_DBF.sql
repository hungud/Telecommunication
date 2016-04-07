BEGIN

  SYS.DBMS_SCHEDULER.CREATE_JOB
    (
       job_name        => 'J_HOT_BILLING_LOAD_DBF'
      ,start_date      => TO_TIMESTAMP_TZ('2012/10/08 16:08:12.000000 +04:00','yyyy/mm/dd hh24:mi:ss.ff tzr')
      ,repeat_interval => 'FREQ=MINUTELY; INTERVAL=1'
      ,end_date        => NULL
      ,job_class       => 'DEFAULT_JOB_CLASS'
      ,job_type        => 'PLSQL_BLOCK'
      ,job_action      => 'BEGIN
    STOP_JOB_PCKG.CHECK_WORK_JOB;
    HOT_BILLING_LOAD_DBF;
END;'
      ,comments        => 'Горячий биллинг загрузки dbf '
    );

  SYS.DBMS_SCHEDULER.ENABLE
    (name                  => 'J_HOT_BILLING_LOAD_DBF');
END;
/
