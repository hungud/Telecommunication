BEGIN
  SYS.DBMS_SCHEDULER.CREATE_JOB
    (
       job_name        => 'LONTANA.J_GET_HOT_BILLING_FILE_FTP'
      ,start_date      => NULL
      ,repeat_interval => 'FREQ=MINUTELY;INTERVAL=1'
      ,end_date        => NULL
      ,job_class       => 'DEFAULT_JOB_CLASS'
      ,job_type        => 'PLSQL_BLOCK'
      ,job_action      => 'begin
                            STOP_JOB_PCKG.CHECK_WORK_JOB;
                            GET_FILE_FROM_FTP;
                          end;'
      ,comments        => 'Получение файлов горячего биллинга с FTP'
    );

END;
/