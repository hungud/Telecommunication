-- v1 - 31.01.2015 - Алексеев, Матюнин. Добавили JOB Смена доп. статуса для номеров с отсутствующей активностью на "блок по неактивности"
BEGIN
  SYS.DBMS_SCHEDULER.CREATE_JOB
    (
       job_name        => 'CORP_MOBILE.J_SET_DOP_STATUS_INACTIVE_PHN'
      ,start_date      => TO_TIMESTAMP_TZ('2015/04/02 18:00:00.000000 +04:00','yyyy/mm/dd hh24:mi:ss.ff tzr')
      ,repeat_interval => 'FREQ=DAILY; INTERVAL=1;ByHour=18;ByMinute=00'
      ,end_date        => NULL
      ,job_class       => 'DEFAULT_JOB_CLASS'
      ,job_type        => 'PLSQL_BLOCK'
      ,job_action      => 'BEGIN
  STOP_JOB_PCKG.CHECK_WORK_JOB;
  SET_DOP_STATUS_INACTIVE_PHONE;
END;'
      ,comments        => 'Смена доп. статуса для номеров с отсутствующей активностью на "блок по неактивности" '
    );
END;