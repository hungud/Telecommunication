BEGIN
  SYS.DBMS_SCHEDULER.CREATE_JOB
    (
       job_name        => 'J_DRAVE_INIT_NEW_MONTH'
      ,start_date      => TO_TIMESTAMP_TZ('2015/10/01 01:10:00.000000 +03:00','yyyy/mm/dd hh24:mi:ss.ff tzr')
      ,repeat_interval => 'FREQ=DAILY;BYMONTHDAY=1;BYHOUR=1;BYMINUTE=10;BYSECOND=0'
      ,end_date        => NULL
      ,job_class       => 'DEFAULT_JOB_CLASS'
      ,job_type        => 'PLSQL_BLOCK'
      ,job_action      => 'BEGIN  
                             STOP_JOB_PCKG.CHECK_WORK_JOB;   
  
                             --останавливаем механизмы контроля расхода тарфика на номерах с тарифом Драйв
                             dbms_scheduler.disable(name=>''''J_DRAVE_CHECK_STREAM_00'''',force=>true);
                             dbms_scheduler.disable(name=>''''J_DRAVE_CHECK_STREAM_01'''',force=>true);
                             dbms_scheduler.disable(name=>''''J_DRAVE_CHECK_STREAM_02'''',force=>true);
                             dbms_scheduler.disable(name=>''''J_DRAVE_CHECK_STREAM_03'''',force=>true);
                             dbms_scheduler.disable(name=>''''J_DRAVE_CHECK_STREAM_04'''',force=>true);
                             begin
                               dbms_scheduler.stop_job(job_name=>''''J_DRAVE_CHECK_STREAM_00'''',force=>true);
                               dbms_scheduler.stop_job(job_name=>''''J_DRAVE_CHECK_STREAM_01'''',force=>true);
                               dbms_scheduler.stop_job(job_name=>''''J_DRAVE_CHECK_STREAM_02'''',force=>true);
                               dbms_scheduler.stop_job(job_name=>''''J_DRAVE_CHECK_STREAM_03'''',force=>true);
                               dbms_scheduler.stop_job(job_name=>''''J_DRAVE_CHECK_STREAM_04'''',force=>true);
                             exception
                               when others then 
                                 null;
                             end;            
  
                             -- Инициализация нового месяца -- перенос данных прошедшего месяца в архив.  
                             beeline_rest_api_pckg.drave_init_new_month;   
  
                             --запускаем механизмы контроля расхода тарфика на номерах с тарифом Драйв
                             dbms_scheduler.enable(''''J_DRAVE_CHECK_STREAM_00'''');
                             dbms_scheduler.enable(''''J_DRAVE_CHECK_STREAM_01'''');
                             dbms_scheduler.enable(''''J_DRAVE_CHECK_STREAM_02'''');
                             dbms_scheduler.enable(''''J_DRAVE_CHECK_STREAM_03'''');
                             dbms_scheduler.enable(''''J_DRAVE_CHECK_STREAM_04'''');
                           END;'
      ,comments        => 'Инициализация нового месяца, перенос данных по расходу трафика по номероам с тарифом Драйв прошедшего месяца в архив.'
    );
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE
    ( name      => 'J_DRAVE_INIT_NEW_MONTH'
     ,attribute => 'RESTARTABLE'
     ,value     => FALSE);
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE
    ( name      => 'J_DRAVE_INIT_NEW_MONTH'
     ,attribute => 'LOGGING_LEVEL'
     ,value     => SYS.DBMS_SCHEDULER.LOGGING_OFF);
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE_NULL
    ( name      => 'J_DRAVE_INIT_NEW_MONTH'
     ,attribute => 'MAX_FAILURES');
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE_NULL
    ( name      => 'J_DRAVE_INIT_NEW_MONTH'
     ,attribute => 'MAX_RUNS');
  BEGIN
    SYS.DBMS_SCHEDULER.SET_ATTRIBUTE
      ( name      => 'J_DRAVE_INIT_NEW_MONTH'
       ,attribute => 'STOP_ON_WINDOW_CLOSE'
       ,value     => FALSE);
  EXCEPTION
    -- could fail if program is of type EXECUTABLE...
    WHEN OTHERS THEN
      NULL;
  END;
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE
    ( name      => 'J_DRAVE_INIT_NEW_MONTH'
     ,attribute => 'JOB_PRIORITY'
     ,value     => 3);
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE_NULL
    ( name      => 'J_DRAVE_INIT_NEW_MONTH'
     ,attribute => 'SCHEDULE_LIMIT');
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE
    ( name      => 'J_DRAVE_INIT_NEW_MONTH'
     ,attribute => 'AUTO_DROP'
     ,value     => FALSE);
END;