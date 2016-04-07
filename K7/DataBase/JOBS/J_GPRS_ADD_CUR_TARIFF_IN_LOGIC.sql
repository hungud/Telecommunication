BEGIN
  SYS.DBMS_SCHEDULER.CREATE_JOB
    (
       job_name        => 'J_GPRS_ADD_CUR_TARIFF_IN_LOGIC'
      ,start_date      => TO_TIMESTAMP_TZ('2015/10/08 09:00:00.000000 +03:00','yyyy/mm/dd hh24:mi:ss.ff tzr')
      ,repeat_interval => 'FREQ=MINUTELY; INTERVAL=30;'
      ,end_date        => NULL
      ,job_class       => 'DEFAULT_JOB_CLASS'
      ,job_type        => 'PLSQL_BLOCK'
      ,job_action      => 'BEGIN
                             STOP_JOB_PCKG.CHECK_WORK_JOB;
                             GPRS_ADD_CUR_TARIFF_IN_LOGIC;      
                           END;'
      ,comments        => 'Добавляет для номеров с автоподключением пакетов при смене тп текущий тп в историю автоподключения интернет-опций'
    );
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE
    ( name      => 'J_GPRS_ADD_CUR_TARIFF_IN_LOGIC'
     ,attribute => 'RESTARTABLE'
     ,value     => FALSE);
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE
    ( name      => 'J_GPRS_ADD_CUR_TARIFF_IN_LOGIC'
     ,attribute => 'LOGGING_LEVEL'
     ,value     => SYS.DBMS_SCHEDULER.LOGGING_OFF);
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE_NULL
    ( name      => 'J_GPRS_ADD_CUR_TARIFF_IN_LOGIC'
     ,attribute => 'MAX_FAILURES');
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE_NULL
    ( name      => 'J_GPRS_ADD_CUR_TARIFF_IN_LOGIC'
     ,attribute => 'MAX_RUNS');
  BEGIN
    SYS.DBMS_SCHEDULER.SET_ATTRIBUTE
      ( name      => 'J_GPRS_ADD_CUR_TARIFF_IN_LOGIC'
       ,attribute => 'STOP_ON_WINDOW_CLOSE'
       ,value     => FALSE);
  EXCEPTION
    -- could fail if program is of type EXECUTABLE...
    WHEN OTHERS THEN
      NULL;
  END;
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE
    ( name      => 'J_GPRS_ADD_CUR_TARIFF_IN_LOGIC'
     ,attribute => 'JOB_PRIORITY'
     ,value     => 3);
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE_NULL
    ( name      => 'J_GPRS_ADD_CUR_TARIFF_IN_LOGIC'
     ,attribute => 'SCHEDULE_LIMIT');
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE
    ( name      => 'J_GPRS_ADD_CUR_TARIFF_IN_LOGIC'
     ,attribute => 'AUTO_DROP'
     ,value     => FALSE);
END;