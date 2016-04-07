BEGIN
  SYS.DBMS_SCHEDULER.CREATE_JOB
    (
       job_name        => 'J_CLOSE_ALIEN_OPTS_PREV_MONTH'
      ,start_date      => TO_TIMESTAMP_TZ('2016/02/01 02:00:00.000000 +03:00','yyyy/mm/dd hh24:mi:ss.ff tzr')
      ,repeat_interval => 'FREQ=MONTHLY; INTERVAL=1; BYMONTHDAY=1; BYHOUR=2; BYMINUTE=0; BYSECOND=0'
      ,end_date        => NULL
      ,job_class       => 'DEFAULT_JOB_CLASS'
      ,job_type        => 'PLSQL_BLOCK'
      ,job_action      => 'BEGIN
                             STOP_JOB_PCKG.CHECK_WORK_JOB;
                             CLOSE_ALIEN_OPTS_PREV_MONTH;
                           END;'
      ,comments        => 'Закрытие чужих подключений предыдущего месяца'
    );
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE
    ( name      => 'J_CLOSE_ALIEN_OPTS_PREV_MONTH'
     ,attribute => 'RESTARTABLE'
     ,value     => FALSE);
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE
    ( name      => 'J_CLOSE_ALIEN_OPTS_PREV_MONTH'
     ,attribute => 'LOGGING_LEVEL'
     ,value     => SYS.DBMS_SCHEDULER.LOGGING_OFF);
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE_NULL
    ( name      => 'J_CLOSE_ALIEN_OPTS_PREV_MONTH'
     ,attribute => 'MAX_FAILURES');
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE_NULL
    ( name      => 'J_CLOSE_ALIEN_OPTS_PREV_MONTH'
     ,attribute => 'MAX_RUNS');
  BEGIN
    SYS.DBMS_SCHEDULER.SET_ATTRIBUTE
      ( name      => 'J_CLOSE_ALIEN_OPTS_PREV_MONTH'
       ,attribute => 'STOP_ON_WINDOW_CLOSE'
       ,value     => FALSE);
  EXCEPTION
    -- could fail if program is of type EXECUTABLE...
    WHEN OTHERS THEN
      NULL;
  END;
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE
    ( name      => 'J_CLOSE_ALIEN_OPTS_PREV_MONTH'
     ,attribute => 'JOB_PRIORITY'
     ,value     => 3);
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE_NULL
    ( name      => 'J_CLOSE_ALIEN_OPTS_PREV_MONTH'
     ,attribute => 'SCHEDULE_LIMIT');
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE
    ( name      => 'J_CLOSE_ALIEN_OPTS_PREV_MONTH'
     ,attribute => 'AUTO_DROP'
     ,value     => FALSE);
END;