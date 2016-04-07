BEGIN
  SYS.DBMS_SCHEDULER.CREATE_JOB
    (
       job_name        => 'J_EXPORT_OBJECTS_TO_SVN'
      ,start_date      => sysdate
      ,repeat_interval => 'FREQ=HOURLY;INTERVAL=1;BYMINUTE=0;BYSECOND=0'
      ,end_date        => NULL
      ,job_class       => 'DEFAULT_JOB_CLASS'
      ,job_type        => 'PLSQL_BLOCK'
      ,job_action      => 'BEGIN
   STOP_JOB_PCKG.CHECK_WORK_JOB;
                            LONTANA.EXPORTOBJECTSTODISK
                              (''LONTANA'',
                                MS_CONSTANTS.GET_CONSTANT_VALUE(''EXPORT_OBJECTS_TO_SVN_PATH'')
                              );
                          END;'
      ,comments        => 'Экспорт объектов в SVN '
    );
end;    