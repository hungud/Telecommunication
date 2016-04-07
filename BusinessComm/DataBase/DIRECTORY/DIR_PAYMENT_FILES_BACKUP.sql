CREATE OR REPLACE DIRECTORY 
DIR_PAYMENT_FILES_BACKUP AS 
'D:\Tarifer\DB\PAYMENTS\BACKUP\';

begin
	dbms_java.grant_permission('BUSINESS_COMM', 'SYS:java.io.FilePermission', 'D:\Tarifer\DB\PAYMENTS\BACKUP\*', 'read,write');
	commit;
end;