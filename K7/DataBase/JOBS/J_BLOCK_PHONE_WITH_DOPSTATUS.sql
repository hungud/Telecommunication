-- v1 - 31.01.2015 - Алексеев. Добавил JOB Блокировка номеров с доп. статусом
BEGIN
  SYS.DBMS_SCHEDULER.CREATE_JOB
    (
       job_name        => 'CORP_MOBILE.J_BLOCK_PHONE_WITH_DOPSTATUS'
      ,start_date      => TO_TIMESTAMP_TZ('2015/03/31 13:00:00.000000 +04:00','yyyy/mm/dd hh24:mi:ss.ff tzr')
      ,repeat_interval => 'FREQ=MINUTELY; INTERVAL=10'
      ,end_date        => NULL
      ,job_class       => 'DEFAULT_JOB_CLASS'
      ,job_type        => 'PLSQL_BLOCK'
      ,job_action      => 'BEGIN
      ,job_action      => 'begin 
  STOP_JOB_PCKG.CHECK_WORK_JOB;

  BLOCK_PHONE_WITH_DOPSTATUS;
END;'
      ,comments        => 'Блокировка номеров с доп. статусом'
    );
END;