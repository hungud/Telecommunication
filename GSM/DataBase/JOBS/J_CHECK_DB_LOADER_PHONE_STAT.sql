--v2. Алексеев. Изменил плановое выполнение в каждые 3 дня
-- v1 - 21.01.2015 - Бакунов Константин (Добавил в базу Алексеев)
BEGIN
  SYS.DBMS_SCHEDULER.CREATE_JOB
    (
       job_name        => 'J_CHECK_DB_LOADER_PHONE_STAT'
      ,start_date      => TO_TIMESTAMP_TZ('2015/01/22 10:00:00.000000 +04:00','yyyy/mm/dd hh24:mi:ss.ff tzr')
      ,repeat_interval => 'Freq=Daily;Interval=3;ByHour=10;ByMinute=00'
      ,end_date        => NULL
      ,job_class       => 'DEFAULT_JOB_CLASS'
      ,job_type        => 'PLSQL_BLOCK'
      ,job_action      => 'BEGIN
  STOP_JOB_PCKG.CHECK_WORK_JOB;
  CHECK_DB_LOADER_PHONE_STAT;
END;'
      ,comments        => 'Проверяет суммы начисления в статистике по номеру и сумм начисления в детализации'
    );
END;