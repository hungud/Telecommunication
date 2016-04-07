CREATE OR REPLACE DIRECTORY DIR_BILL_FOR_1C_BACKUP AS 'D:\Tarifer\DB\FOR_1C\BACKUP\';

begin
  dbms_java.grant_permission( 'BUSINESS_COMM', 'SYS:java.io.FilePermission', 'D:\Tarifer\DB\FOR_1C\BACKUP\*', 'read,write,delete');
  commit;
end;
