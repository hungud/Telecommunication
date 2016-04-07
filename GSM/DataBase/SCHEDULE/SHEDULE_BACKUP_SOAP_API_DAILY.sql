BEGIN
  SYS.DBMS_SCHEDULER.CREATE_SCHEDULE
    (
      schedule_name    => 'SHEDULE_BACKUP_SOAP_API_DAILY'
     ,start_date       => TO_TIMESTAMP_TZ('2015/12/30 00:00:50.000000 +03:00','yyyy/mm/dd hh24:mi:ss.ff tzr')
     ,repeat_interval  => 'FREQ=DAILY'
     ,end_date         => NULL
     ,comments         => 'Ежедневно в 00:50 по MSK'
    );
END;