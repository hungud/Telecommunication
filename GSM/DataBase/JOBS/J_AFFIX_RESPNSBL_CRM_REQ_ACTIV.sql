BEGIN
  SYS.DBMS_SCHEDULER.CREATE_JOB
    (
       job_name        => 'J_AFFIX_RESPNSBL_CRM_REQ_ACTIV'
      ,start_date      => TO_TIMESTAMP_TZ('2015/12/18 11:35:00.000000 +03:00','yyyy/mm/dd hh24:mi:ss.ff tzr')
      ,repeat_interval => 'FREQ = MINUTELY; INTERVAL = 5'
      ,end_date        => NULL
      ,job_class       => 'DEFAULT_JOB_CLASS'
      ,job_type        => 'PLSQL_BLOCK'
      ,job_action      => 'BEGIN
                             STOP_JOB_PCKG.CHECK_WORK_JOB;
                             AFFIX_RESPNSBL_CRM_REQ_ACT_PHN;
                           END;'
      ,comments        => 'Назначение ответственных по заявкам на активацию номера в CRM, по которым ответственные проставлены не были.'
    );
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE
    ( name      => 'J_AFFIX_RESPNSBL_CRM_REQ_ACTIV'
     ,attribute => 'RESTARTABLE'
     ,value     => FALSE);
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE
    ( name      => 'J_AFFIX_RESPNSBL_CRM_REQ_ACTIV'
     ,attribute => 'LOGGING_LEVEL'
     ,value     => SYS.DBMS_SCHEDULER.LOGGING_OFF);
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE_NULL
    ( name      => 'J_AFFIX_RESPNSBL_CRM_REQ_ACTIV'
     ,attribute => 'MAX_FAILURES');
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE_NULL
    ( name      => 'J_AFFIX_RESPNSBL_CRM_REQ_ACTIV'
     ,attribute => 'MAX_RUNS');
  BEGIN
    SYS.DBMS_SCHEDULER.SET_ATTRIBUTE
      ( name      => 'J_AFFIX_RESPNSBL_CRM_REQ_ACTIV'
       ,attribute => 'STOP_ON_WINDOW_CLOSE'
       ,value     => FALSE);
  EXCEPTION
    -- could fail if program is of type EXECUTABLE...
    WHEN OTHERS THEN
      NULL;
  END;
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE
    ( name      => 'J_AFFIX_RESPNSBL_CRM_REQ_ACTIV'
     ,attribute => 'JOB_PRIORITY'
     ,value     => 3);
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE_NULL
    ( name      => 'J_AFFIX_RESPNSBL_CRM_REQ_ACTIV'
     ,attribute => 'SCHEDULE_LIMIT');
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE
    ( name      => 'J_AFFIX_RESPNSBL_CRM_REQ_ACTIV'
     ,attribute => 'AUTO_DROP'
     ,value     => FALSE);
END;