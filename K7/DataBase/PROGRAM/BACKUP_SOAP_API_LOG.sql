BEGIN
  SYS.DBMS_SCHEDULER.CREATE_PROGRAM
    (
      program_name         => 'BACKUP_SOAP_API_LOG'
     ,program_type         => 'EXECUTABLE'
     ,program_action       => 'C:\WINDOWS\SYSTEM32\CMD.EXE /c D:\Tarifer\Backup\loader_call_n_log\ext_k7_loaders_soap_api.bat'
     ,number_of_arguments  => 0
     ,enabled              => FALSE
     ,comments             => 'Архивирование логов BEELINE_SOAP_API'
    );

  SYS.DBMS_SCHEDULER.ENABLE
    (name                  => 'BACKUP_SOAP_API_LOG');
END;