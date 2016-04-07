CREATE OR REPLACE DIRECTORY 
DIR_PAYMENT_FILES_NEW AS 
'D:\Tarifer\DB\PAYMENTS\NEW\';
begin
	dbms_java.grant_permission( 'BUSINESS_COMM', 'SYS:java.io.FilePermission', 'D:\Tarifer\DB\PAYMENTS\NEW\*', 'read,write,delete');
	commit;
end;