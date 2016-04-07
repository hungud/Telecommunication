BEGIN
  SYS.DBMS_SCHEDULER.CREATE_PROGRAM
    (
      program_name         => 'BACKUP_SOAP_API_LOG'
     ,program_type         => 'EXECUTABLE'
     ,program_action       => 'C:\WINDOWS\SYSTEM32\CMD.EXE /c D:\Tarifer\Svc\archiv_soap_api_log.bat'
     ,number_of_arguments  => 0
     ,enabled              => FALSE
     ,comments             => 'Архивирование логов BEELINE_SOAP_API'
    );

  SYS.DBMS_SCHEDULER.ENABLE
    (name                  => 'BACKUP_SOAP_API_LOG');
END;