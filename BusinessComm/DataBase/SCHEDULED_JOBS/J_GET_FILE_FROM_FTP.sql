BEGIN
  SYS.DBMS_SCHEDULER.CREATE_JOB
    (
       job_name        => 'J_GET_FILE_FROM_FTP'
      ,start_date      => sysdate
      ,repeat_interval => 'Freq=Minutely;Interval=10'
      ,end_date        => NULL
      ,job_class       => 'DEFAULT_JOB_CLASS'
      ,job_type        => 'PLSQL_BLOCK'
      ,job_action      => 'begin
                             STOP_JOB_PCKG.CHECK_WORK_JOB;
                             GET_FILE_FROM_FTP;
                           end;'
      ,comments        => 'Загрузка файлов платежей с FTP'
    );
END;
/
