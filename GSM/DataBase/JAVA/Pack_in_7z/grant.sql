begin
-- create directory PDFDIR as 'c:\tmp\_27_12_2014\arc' ;
-- commit;
-- grant ALL on directory PDFDIR to PUBLIC;
-- GRANT READ, WRITE ON DIRECTORY PDFDIR TO SYSTEM;

-- select * from dba_java_policy where type_schema='LONTANA'

-- dbms_java.revoke_permission ('USER1','java.io.FilePermission','d:\temp\','read,write');

-- !!! Œ¡ﬂ«¿“≈À‹ÕŒ œ≈–≈«¿…“» ¬ Œ–¿ À 

  dbms_java.grant_permission('LONTANA','SYS:java.io.FilePermission','<<ALL FILES>>','read,write,execute,delete');

  dbms_java.grant_permission('LONTANA','SYS:java.io.FilePermission','c:\tmp\22_12_2014_last','read,write,delete');
  dbms_java.grant_permission('LONTANA','SYS:java.io.FilePermission','c:\tmp\22_12_2014_last\-','read,write,delete');
  dbms_java.grant_permission('LONTANA','SYS:java.io.FilePermission','c:\tmp\22_12_2014_last\*','read,write,delete');
  commit;
  
end;

