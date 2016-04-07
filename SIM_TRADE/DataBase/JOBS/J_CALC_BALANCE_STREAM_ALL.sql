DECLARE
I INTEGER;
BEGIN
  FOR I IN 1..TRUNC(TO_NUMBER(MS_PARAMS.GET_PARAM_VALUE('CALC_BALANCE_STREAM_COUNT'))) 
  LOOP
    SYS.DBMS_SCHEDULER.DROP_JOB
      (job_name  => 'CORP_MOBILE.J_CALC_BALANCE_STREAM_'||TO_CHAR(I));
  END LOOP;
END;
/

DECLARE
I INTEGER;
BEGIN
  FOR I IN 1..TRUNC(TO_NUMBER(MS_PARAMS.GET_PARAM_VALUE('CALC_BALANCE_STREAM_COUNT'))) 
  LOOP
    SYS.DBMS_SCHEDULER.CREATE_JOB
      (
         job_name        => 'CORP_MOBILE.J_CALC_BALANCE_STREAM_'||TO_CHAR(I)
        ,start_date      => TO_TIMESTAMP_TZ('2013/07/22 13:00:00.000000 +04:00','yyyy/mm/dd hh24:mi:ss.ff tzh:tzm')
        ,repeat_interval => 'FREQ=MINUTELY; INTERVAL=1'
        ,end_date        => NULL
        ,job_class       => 'DEFAULT_JOB_CLASS'
        ,job_type        => 'PLSQL_BLOCK'
        ,job_action      => 'BEGIN CORP_MOBILE.CALC_BALANCE_STREAM('||TO_CHAR(I)||'); END;'
        ,comments        => 'Потоки пересчета баланса'
      );
    SYS.DBMS_SCHEDULER.SET_ATTRIBUTE
      ( name      => 'CORP_MOBILE.J_CALC_BALANCE_STREAM_'||TO_CHAR(I)
       ,attribute => 'RESTARTABLE'
       ,value     => FALSE);
    SYS.DBMS_SCHEDULER.SET_ATTRIBUTE
      ( name      => 'CORP_MOBILE.J_CALC_BALANCE_STREAM_'||TO_CHAR(I)
       ,attribute => 'LOGGING_LEVEL'
       ,value     => SYS.DBMS_SCHEDULER.LOGGING_OFF);
    SYS.DBMS_SCHEDULER.SET_ATTRIBUTE_NULL
      ( name      => 'CORP_MOBILE.J_CALC_BALANCE_STREAM_'||TO_CHAR(I)
       ,attribute => 'MAX_FAILURES');
    SYS.DBMS_SCHEDULER.SET_ATTRIBUTE_NULL
      ( name      => 'CORP_MOBILE.J_CALC_BALANCE_STREAM_'||TO_CHAR(I)
       ,attribute => 'MAX_RUNS');
    BEGIN
      SYS.DBMS_SCHEDULER.SET_ATTRIBUTE
        ( name      => 'CORP_MOBILE.J_CALC_BALANCE_STREAM_'||TO_CHAR(I)
         ,attribute => 'STOP_ON_WINDOW_CLOSE'
         ,value     => FALSE);
    EXCEPTION
      -- could fail if program is of type EXECUTABLE...
      WHEN OTHERS THEN
        NULL;
    END;
    SYS.DBMS_SCHEDULER.SET_ATTRIBUTE
      ( name      => 'CORP_MOBILE.J_CALC_BALANCE_STREAM_'||TO_CHAR(I)
       ,attribute => 'JOB_PRIORITY'
       ,value     => 3);
    SYS.DBMS_SCHEDULER.SET_ATTRIBUTE_NULL
      ( name      => 'CORP_MOBILE.J_CALC_BALANCE_STREAM_'||TO_CHAR(I)
       ,attribute => 'SCHEDULE_LIMIT');
    SYS.DBMS_SCHEDULER.SET_ATTRIBUTE
      ( name      => 'CORP_MOBILE.J_CALC_BALANCE_STREAM_'||TO_CHAR(I)
       ,attribute => 'AUTO_DROP'
       ,value     => FALSE);

    SYS.DBMS_SCHEDULER.ENABLE
      (name                  => 'CORP_MOBILE.J_CALC_BALANCE_STREAM_'||TO_CHAR(I));
  END LOOP;
END;
/
