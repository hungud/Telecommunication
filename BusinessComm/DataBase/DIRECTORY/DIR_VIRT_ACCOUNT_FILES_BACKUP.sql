CREATE OR REPLACE DIRECTORY 
DIR_VIRT_ACCOUNT_FILES_BACKUP AS 
'D:\Tarifer\DB\VIRT_ACCOUNT\BACKUP\';
begin
	dbms_java.grant_permission( 'BUSINESS_COMM', 'SYS:java.io.FilePermission', 'D:\Tarifer\DB\VIRT_ACCOUNT\BACKUP\*', 'read,write');
	commit;
end;