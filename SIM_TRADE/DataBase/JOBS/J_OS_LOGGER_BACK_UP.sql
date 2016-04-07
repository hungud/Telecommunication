 begin
-- v.2 Афросин 05.02.2015 Переделал джоб на работу с процедурой
--шедулер выгрузки таблиц с логами на диск
 
 
 SYS.DBMS_SCHEDULER.CREATE_JOB
    (
       job_name        => 'J_OS_LOGGER_BACK_UP'
      ,start_date      => TO_TIMESTAMP_TZ('2013/11/17 01:00:00.000000 +04:00','yyyy/mm/dd hh24:mi:ss.ff tzr')
      ,repeat_interval => 'FREQ=DAILY'
      ,end_date        => NULL
      ,job_class       => 'DEFAULT_JOB_CLASS'
      ,job_type        => 'PLSQL_BLOCK'
      ,job_action      => 'begin
							STOP_JOB_PCKG.CHECK_WORK_JOB;
							P_OS_LOGGER_BACK_UP;
						   end;'
      ,comments        => 'Выгрузка табилиц loader_call_n_log и BEELINE_SOAP_API_LOG во внешние таблицы'
    );

end;  