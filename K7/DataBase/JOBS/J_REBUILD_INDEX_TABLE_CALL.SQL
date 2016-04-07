BEGIN
  SYS.DBMS_SCHEDULER.DROP_JOB
    (job_name  => 'CORP_MOBILE.J_REBUILD_INDEX_TABLE_CALL');
END;
/

BEGIN
  SYS.DBMS_SCHEDULER.CREATE_JOB
    (
       job_name        => 'CORP_MOBILE.J_REBUILD_INDEX_TABLE_CALL'
      ,start_date      => TO_TIMESTAMP_TZ('2015/05/25 23:00:00.000000 +04:00','yyyy/mm/dd hh24:mi:ss.ff tzr')
      ,repeat_interval => 'FREQ = HOURLY; INTERVAL = 24'
      ,end_date        => NULL
      ,job_class       => 'DEFAULT_JOB_CLASS'
      ,job_type        => 'PLSQL_BLOCK'
      ,job_action      => 'BEGIN REBUILD_INDEX_TABLE_CALL; END;'
      ,comments        => NULL
    );
 
END;
/
