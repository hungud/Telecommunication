
  DECLARE 
   STATUS NUMBER; 
 BEGIN
   STATUS := DBMS_JAVA.START_IMPORT('testngtasks', 0,30,0,3,93,0);
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
   STATUS := DBMS_JAVA.IMPORT_RAW_CHUNK(HEXTORAW('746573746E677461736B73'), 11);
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
   STATUS := DBMS_JAVA.IMPORT_RAW_CHUNK(HEXTORAW('746573746E673D6F72672E746573746E672E546573744E47416E745461736B0A6A756E69742D636F6E7665727465723D6F72672E746573746E672E4A556E6974436F6E7665727465725461736B0A'), 78);
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