BEGIN
  SYS.DBMS_SCHEDULER.CREATE_JOB
    (
       job_name        => 'J_NEW_SMS_REQUEST_STREAM_ONE'
      ,start_date      => TO_TIMESTAMP_TZ('2014/08/11 13:00:00.000000 +04:00','yyyy/mm/dd hh24:mi:ss.ff tzr')
      ,repeat_interval => 'Freq=Secondly;Interval=20'
      ,end_date        => NULL
      ,job_class       => 'DEFAULT_JOB_CLASS'
      ,job_type        => 'PLSQL_BLOCK'
      ,job_action      => 'begin 
 STOP_JOB_PCKG.CHECK_WORK_JOB;
 --SMS_REQUEST(0,1);
 p_test_afr; 
end;'
  ,comments        => '–ассылка  не отосланных смс по таблице SMS_CURRENT в один поток'
    );
end;