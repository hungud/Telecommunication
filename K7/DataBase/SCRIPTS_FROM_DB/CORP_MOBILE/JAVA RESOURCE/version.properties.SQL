
  DECLARE 
   STATUS NUMBER; 
 BEGIN
   STATUS := DBMS_JAVA.START_IMPORT('version.properties', 0,30,0,3,38,0);
   IF STATUS !=0 THEN 
     IF STATUS > 0 THEN STATUS := -STATUS; END IF; 
     execute immediate 
     'declare an exception; pragma exception_init(an, '
     || status || '); ' || 'begin raise an; end;'; 
   END IF; 
 
  END;
DECLARE 
   STATUS NUMBER; 
 BEGIN
   STATUS := DBMS_JAVA.IMPORT_RAW_CHUNK(HEXTORAW('00000000'), 4);
   IF STATUS !=0 THEN 
     IF STATUS > 0 THEN STATUS := -STATUS; END IF; 
     execute immediate 
     'declare an exception; pragma exception_init(an, '
     || status || '); ' || 'begin raise an; end;'; 
   END IF; 
  END;
DECLARE 
   STATUS NUMBER; 
 BEGIN
   STATUS := DBMS_JAVA.IMPORT_RAW_CHUNK(HEXTORAW('76657273696F6E2E70726F70657274696573'), 18);
   IF STATUS !=0 THEN 
     IF STATUS > 0 THEN STATUS := -STATUS; END IF; 
     execute immediate 
     'declare an exception; pragma exception_init(an, '
     || status || '); ' || 'begin raise an; end;'; 
   END IF; 
  END;
DECLARE 
   STATUS NUMBER; 
 BEGIN
   STATUS := DBMS_JAVA.IMPORT_RAW_CHUNK(HEXTORAW('76657273696F6E3D3230303330353330'), 16);
   IF STATUS !=0 THEN 
     IF STATUS > 0 THEN STATUS := -STATUS; END IF; 
     execute immediate 
     'declare an exception; pragma exception_init(an, '
     || status || '); ' || 'begin raise an; end;'; 
   END IF; 
  END;
DECLARE 
   STATUS NUMBER; 
 BEGIN
   STATUS := DBMS_JAVA.END_IMPORT();
   IF STATUS !=0 THEN 
     IF STATUS > 0 THEN STATUS := -STATUS; END IF; 
     execute immediate 
     'declare an exception; pragma exception_init(an, '
     || status || '); ' || 'begin raise an; end;'; 
   END IF; 
 
  END;