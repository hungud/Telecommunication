CREATE OR REPLACE DIRECTORY 
DIR_VIRT_ACCOUNT_FILES_NEW AS 
'D:\Tarifer\DB\VIRT_ACCOUNT\NEW\';
begin
	dbms_java.grant_permission( 'BUSINESS_COMM', 'SYS:java.io.FilePermission', 'D:\Tarifer\DB\VIRT_ACCOUNT\NEW\*', 'read,write,delete');
	commit;
end;