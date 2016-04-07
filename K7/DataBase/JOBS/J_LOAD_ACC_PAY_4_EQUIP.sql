BEGIN
  SYS.DBMS_SCHEDULER.DROP_JOB
    (job_name  => 'CORP_MOBILE.J_LOAD_ACC_PAY_4_EQUIP');
END;
/

BEGIN
  SYS.DBMS_SCHEDULER.CREATE_JOB
    (
       job_name        => 'CORP_MOBILE.J_LOAD_ACC_PAY_4_EQUIP'
      ,start_date      => TO_TIMESTAMP_TZ('2014/12/04 11:00:00.000000 +04:00','yyyy/mm/dd hh24:mi:ss.ff tzr')
      ,repeat_interval => 'Freq=Daily;Interval=1;ByHour=11;ByMinute=00'
      ,end_date        => NULL
      ,job_class       => 'DEFAULT_JOB_CLASS'
      ,job_type        => 'PLSQL_BLOCK'
      ,job_action      => 'begin 
  STOP_JOB_PCKG.CHECK_WORK_JOB;
    LOAD_ACC_PAYMENTS_4_EQUIPMENTS;
end;'
      ,comments        => '«агрузка счетов оплаты за оборудование'
    );
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE
    ( name      => 'CORP_MOBILE.J_LOAD_ACC_PAY_4_EQUIP'
     ,attribute => 'RESTARTABLE'
     ,value     => FALSE);
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE
    ( name      => 'CORP_MOBILE.J_LOAD_ACC_PAY_4_EQUIP'
     ,attribute => 'LOGGING_LEVEL'
     ,value     => SYS.DBMS_SCHEDULER.LOGGING_OFF);
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE_NULL
    ( name      => 'CORP_MOBILE.J_LOAD_ACC_PAY_4_EQUIP'
     ,attribute => 'MAX_FAILURES');
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE_NULL
    ( name      => 'CORP_MOBILE.J_LOAD_ACC_PAY_4_EQUIP'
     ,attribute => 'MAX_RUNS');
  BEGIN
    SYS.DBMS_SCHEDULER.SET_ATTRIBUTE
      ( name      => 'CORP_MOBILE.J_LOAD_ACC_PAY_4_EQUIP'
       ,attribute => 'STOP_ON_WINDOW_CLOSE'
       ,value     => FALSE);
  EXCEPTION
    -- could fail if program is of type EXECUTABLE...
    WHEN OTHERS THEN
      NULL;
  END;
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE
    ( name      => 'CORP_MOBILE.J_LOAD_ACC_PAY_4_EQUIP'
     ,attribute => 'JOB_PRIORITY'
     ,value     => 3);
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE_NULL
    ( name      => 'CORP_MOBILE.J_LOAD_ACC_PAY_4_EQUIP'
     ,attribute => 'SCHEDULE_LIMIT');
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE
    ( name      => 'CORP_MOBILE.J_LOAD_ACC_PAY_4_EQUIP'
     ,attribute => 'AUTO_DROP'
     ,value     => FALSE);

  SYS.DBMS_SCHEDULER.ENABLE
    (name                  => 'CORP_MOBILE.J_LOAD_ACC_PAY_4_EQUIP');
END;
/
