CREATE OR REPLACE DIRECTORY DIR_BILL_FOR_1C AS 'D:\Tarifer\DB\FOR_1C\';

begin
	dbms_java.grant_permission( 'BUSINESS_COMM', 'SYS:java.io.FilePermission', 'D:\Tarifer\DB\FOR_1C\*', 'read,write,delete');
	commit;
end;