begin
  dbms_java.grant_permission('WWW_DEALER','SYS:java.io.FilePermission','d:\tarifer\1c_for_unpack','read,write,delete');
  dbms_java.grant_permission('WWW_DEALER','SYS:java.io.FilePermission','d:\tarifer\1c_for_unpack\-','read,write,delete');
  dbms_java.grant_permission('WWW_DEALER','SYS:java.io.FilePermission','d:\tarifer\1c_for_unpack\*','read,write,delete');
  commit;
end;