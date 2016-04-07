BEGIN
  SYS.DBMS_SCHEDULER.CREATE_JOB
    (
       job_name        => 'J_GET_STATUS_SMS_ONE_STREAM'
      ,start_date      => TO_TIMESTAMP_TZ('2014/08/11 13:00:00.000000 +04:00','yyyy/mm/dd hh24:mi:ss.ff tzr')
      ,repeat_interval => 'Freq=Secondly;Interval=20'
      ,end_date        => NULL
      ,job_class       => 'DEFAULT_JOB_CLASS'
      ,job_type        => 'PLSQL_BLOCK'
      ,job_action      => 'begin 
 STOP_JOB_PCKG.CHECK_WORK_JOB;
 SMS_REQUEST(0,2); 
end;'
      ,comments        => 'Получение статусов смс в один поток'
    );
end;    