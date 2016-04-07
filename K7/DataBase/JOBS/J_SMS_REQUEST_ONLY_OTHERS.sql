BEGIN
  SYS.DBMS_SCHEDULER.CREATE_JOB
    (
       job_name        => 'J_SMS_REQUEST_ONLY_OTHERS'
      ,start_date      => TO_TIMESTAMP_TZ('2014/02/19 00:00:00.000000 +04:00','yyyy/mm/dd hh24:mi:ss.ff tzr')
      ,repeat_interval => 'Freq=Secondly;Interval=20'
      ,end_date        => NULL
      ,job_class       => 'DEFAULT_JOB_CLASS'
      ,job_type        => 'PLSQL_BLOCK'
      ,job_action      => 'begin 
                            STOP_JOB_PCKG.CHECK_WORK_JOB;
                            CORP_MOBILE.SMS_REQUEST(2); 
                           end;'
      ,comments        => 'Проверка состояния смс, переданных на шлюз(status_code <> 99)'
    );
 
END;
/
