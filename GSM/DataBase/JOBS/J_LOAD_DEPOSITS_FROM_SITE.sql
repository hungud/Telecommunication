BEGIN
  SYS.DBMS_SCHEDULER.CREATE_JOB
    (
       job_name        => 'J_LOAD_DEPOSITS_FROM_SITE'
      ,start_date      => TO_TIMESTAMP_TZ('2015/03/24 09:00:00.000000 +04:00','yyyy/mm/dd hh24:mi:ss.ff tzr')
      ,repeat_interval => 'FREQ=DAILY;INTERVAL=1'
      ,end_date        => NULL
      ,job_class       => 'DEFAULT_JOB_CLASS'
      ,job_type        => 'PLSQL_BLOCK'
      ,job_action      => 'BEGIN 
STOP_JOB_PCKG.CHECK_WORK_JOB;
LOAD_DEPOSITS_FROM_SITE;END;'
      ,comments        => 'Загрузка информации о гарантийных взносах с сайта Билайна'
    );
END;    