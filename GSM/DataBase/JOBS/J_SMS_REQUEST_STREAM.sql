BEGIN
  SYS.DBMS_SCHEDULER.CREATE_JOB
    (
       job_name        => 'J_SMS_REQUEST_STREAM_00'
      ,start_date      => TO_TIMESTAMP_TZ('2014/08/11 13:00:00.000000 +04:00','yyyy/mm/dd hh24:mi:ss.ff tzr')
      ,repeat_interval => 'Freq=Secondly;Interval=20'
      ,end_date        => NULL
      ,job_class       => 'DEFAULT_JOB_CLASS'
      ,job_type        => 'PLSQL_BLOCK'
      ,job_action      => 'begin  STOP_JOB_PCKG.CHECK_WORK_JOB;
SMS_REQUEST(0); end;'
      ,comments        => 'Рассылка смс по таблице SMS_CURRENT поток 0'
    );

    SYS.DBMS_SCHEDULER.CREATE_JOB
    (
       job_name        => 'J_SMS_REQUEST_STREAM_01'
      ,start_date      => TO_TIMESTAMP_TZ('2014/08/11 13:00:00.000000 +04:00','yyyy/mm/dd hh24:mi:ss.ff tzr')
      ,repeat_interval => 'Freq=Secondly;Interval=20'
      ,end_date        => NULL
      ,job_class       => 'DEFAULT_JOB_CLASS'
      ,job_type        => 'PLSQL_BLOCK'
      ,job_action      => 'begin  STOP_JOB_PCKG.CHECK_WORK_JOB; SMS_REQUEST(1); end;'
      ,comments        => 'Рассылка смс по таблице SMS_CURRENT поток 1'
    );
    SYS.DBMS_SCHEDULER.CREATE_JOB
    (
       job_name        => 'J_SMS_REQUEST_STREAM_02'
      ,start_date      => TO_TIMESTAMP_TZ('2014/08/11 13:00:00.000000 +04:00','yyyy/mm/dd hh24:mi:ss.ff tzr')
      ,repeat_interval => 'Freq=Secondly;Interval=20'
      ,end_date        => NULL
      ,job_class       => 'DEFAULT_JOB_CLASS'
      ,job_type        => 'PLSQL_BLOCK'
      ,job_action      => 'begin  STOP_JOB_PCKG.CHECK_WORK_JOB; SMS_REQUEST(2); end;'
      ,comments        => 'Рассылка смс по таблице SMS_CURRENT поток 2'
    );
    SYS.DBMS_SCHEDULER.CREATE_JOB
    (
       job_name        => 'J_SMS_REQUEST_STREAM_03'
      ,start_date      => TO_TIMESTAMP_TZ('2014/08/11 13:00:00.000000 +04:00','yyyy/mm/dd hh24:mi:ss.ff tzr')
      ,repeat_interval => 'Freq=Secondly;Interval=20'
      ,end_date        => NULL
      ,job_class       => 'DEFAULT_JOB_CLASS'
      ,job_type        => 'PLSQL_BLOCK'
      ,job_action      => 'begin   STOP_JOB_PCKG.CHECK_WORK_JOB; SMS_REQUEST(3); end;'
      ,comments        => 'Рассылка смс по таблице SMS_CURRENT поток 3'
    );
        SYS.DBMS_SCHEDULER.CREATE_JOB
    (
       job_name        => 'J_SMS_REQUEST_STREAM_04'
      ,start_date      => TO_TIMESTAMP_TZ('2014/08/11 13:00:00.000000 +04:00','yyyy/mm/dd hh24:mi:ss.ff tzr')
      ,repeat_interval => 'Freq=Secondly;Interval=20'
      ,end_date        => NULL
      ,job_class       => 'DEFAULT_JOB_CLASS'
      ,job_type        => 'PLSQL_BLOCK'
      ,job_action      => 'begin  STOP_JOB_PCKG.CHECK_WORK_JOB;  SMS_REQUEST(4); end;'
      ,comments        => 'Рассылка смс по таблице SMS_CURRENT поток 4'
    );
        SYS.DBMS_SCHEDULER.CREATE_JOB
    (
       job_name        => 'J_SMS_REQUEST_STREAM_05'
      ,start_date      => TO_TIMESTAMP_TZ('2014/08/11 13:00:00.000000 +04:00','yyyy/mm/dd hh24:mi:ss.ff tzr')
      ,repeat_interval => 'Freq=Secondly;Interval=20'
      ,end_date        => NULL
      ,job_class       => 'DEFAULT_JOB_CLASS'
      ,job_type        => 'PLSQL_BLOCK'
      ,job_action      => 'begin  STOP_JOB_PCKG.CHECK_WORK_JOB;  SMS_REQUEST(5); end;'
      ,comments        => 'Рассылка смс по таблице SMS_CURRENT поток 5'
    );
        SYS.DBMS_SCHEDULER.CREATE_JOB
    (
       job_name        => 'J_SMS_REQUEST_STREAM_06'
      ,start_date      => TO_TIMESTAMP_TZ('2014/08/11 13:00:00.000000 +04:00','yyyy/mm/dd hh24:mi:ss.ff tzr')
      ,repeat_interval => 'Freq=Secondly;Interval=20'
      ,end_date        => NULL
      ,job_class       => 'DEFAULT_JOB_CLASS'
      ,job_type        => 'PLSQL_BLOCK'
      ,job_action      => 'begin  STOP_JOB_PCKG.CHECK_WORK_JOB;  SMS_REQUEST(6); end;'
      ,comments        => 'Рассылка смс по таблице SMS_CURRENT поток 6'
    );
        SYS.DBMS_SCHEDULER.CREATE_JOB
    (
       job_name        => 'J_SMS_REQUEST_STREAM_07'
      ,start_date      => TO_TIMESTAMP_TZ('2014/08/11 13:00:00.000000 +04:00','yyyy/mm/dd hh24:mi:ss.ff tzr')
      ,repeat_interval => 'Freq=Secondly;Interval=20'
      ,end_date        => NULL
      ,job_class       => 'DEFAULT_JOB_CLASS'
      ,job_type        => 'PLSQL_BLOCK'
      ,job_action      => 'begin  STOP_JOB_PCKG.CHECK_WORK_JOB;  SMS_REQUEST(7); end;'
      ,comments        => 'Рассылка смс по таблице SMS_CURRENT поток 7'
    );
        SYS.DBMS_SCHEDULER.CREATE_JOB
    (
       job_name        => 'J_SMS_REQUEST_STREAM_08'
      ,start_date      => TO_TIMESTAMP_TZ('2014/08/11 13:00:00.000000 +04:00','yyyy/mm/dd hh24:mi:ss.ff tzr')
      ,repeat_interval => 'Freq=Secondly;Interval=20'
      ,end_date        => NULL
      ,job_class       => 'DEFAULT_JOB_CLASS'
      ,job_type        => 'PLSQL_BLOCK'
      ,job_action      => 'begin  STOP_JOB_PCKG.CHECK_WORK_JOB;  SMS_REQUEST(8); end;'
      ,comments        => 'Рассылка смс по таблице SMS_CURRENT поток 8'
    );
        SYS.DBMS_SCHEDULER.CREATE_JOB
    (
       job_name        => 'J_SMS_REQUEST_STREAM_09'
      ,start_date      => TO_TIMESTAMP_TZ('2014/08/11 13:00:00.000000 +04:00','yyyy/mm/dd hh24:mi:ss.ff tzr')
      ,repeat_interval => 'Freq=Secondly;Interval=20'
      ,end_date        => NULL
      ,job_class       => 'DEFAULT_JOB_CLASS'
      ,job_type        => 'PLSQL_BLOCK'
      ,job_action      => 'begin  STOP_JOB_PCKG.CHECK_WORK_JOB;  SMS_REQUEST(9); end;'
      ,comments        => 'Рассылка смс по таблице SMS_CURRENT поток 9'
    );
end;
/
