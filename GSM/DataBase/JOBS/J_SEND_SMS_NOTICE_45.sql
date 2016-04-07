BEGIN
  SYS.DBMS_SCHEDULER.CREATE_JOB
    (
       job_name        => 'J_SEND_SMS_NOTICE_45'
      ,start_date      => TO_TIMESTAMP_TZ('2011/09/09 17:35:55.000000 +04:00','yyyy/mm/dd hh24:mi:ss.ff tzr')
      ,repeat_interval => 'FREQ=MINUTELY; INTERVAL=5'
      ,end_date        => NULL
      ,job_class       => 'DEFAULT_JOB_CLASS'
      ,job_type        => 'PLSQL_BLOCK'
      ,job_action      => 'BEGIN SEND_SMS_NOTICE_2(45);END;'
      ,comments        => 'ѕредупреждение клиентов с балансом близким к 0'
    );
END;    