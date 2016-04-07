echo on
set nls_lang=russian_russia.CL8MSWIN1251
SET CURDATE=%date%
rem DAY=ВЧЕРАШНИЙ ДЕНЬ
SET /a DAY=%date:~0,2%-1
sqlplus /nolog @D:\Tarifer\Backup\loader_call_n_log\ext_prefix.sql > D:\Tarifer\Backup\loader_call_n_log\prefix.log
sqlplus /nolog @D:\Tarifer\Backup\loader_call_n_log\ext_export.sql > D:\Tarifer\Backup\loader_call_n_log\export.log
rem expdp corp_mobile/hivxHD2gpHJX@109.95.210.5/K7 tables=loader_call_n_log directory=datapump_dir dumpfile=loader_call_n_log.dmp logfile=loader_call_n_log.log
"C:\Program Files\7-Zip\7z.exe" a -t7z E:\Backup\loader_call_n\ext_loader_call_n_log_%CURDATE%.7z E:\Backup\loader_call_n\ext_loader_call_n_log.dmp
del E:\Backup\loader_call_n\ext_%DAY%_loader_call_n_log.dmp /q
move E:\Backup\loader_call_n\ext_loader_call_n_log.dmp E:\Backup\loader_call_n\ext_%DAY%_loader_call_n_log.dmp
"C:\Program Files\7-Zip\7z.exe" a -t7z E:\Backup\soap_api\ext_beeline_soap_api_log_%CURDATE%.7z E:\Backup\soap_api\ext_beeline_soap_api_log.dmp
del E:\Backup\soap_api\ext_%DAY%_beeline_soap_api_log.dmp /q  
move E:\Backup\soap_api\ext_beeline_soap_api_log.dmp E:\Backup\soap_api\ext_%DAY%_beeline_soap_api_log.dmp
sqlplus /nolog @D:\Tarifer\Backup\loader_call_n_log\ext_postfix.sql > D:\Tarifer\Backup\loader_call_n_log\postfix.log

rem ---удаляем логи подключения к базе данных
del E:\Backup\soap_api\*.log /q  
del E:\Backup\loader_call_n\*.log /q