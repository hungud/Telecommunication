
  CREATE OR REPLACE PROCEDURE "CORP_MOBILE"."COPY_SCHEMA" (
  SOURCE_SCHEME IN VARCHAR2,
  DEST_SCHEME IN VARCHAR2
  ) IS

 TYPE T_OBJNAME IS TABLE OF VARCHAR2(128);
 OBJ1 T_OBJNAME;
 indx VARCHAR2(128);
 str clob;
 str1 clob;
 str2 clob;
 tempStr varchar(250);
 vID_DATABASE NUMBER(38);
-- SOURCE_SCHEME VARCHAR2(100);
 --DEST_SCHEME VARCHAR2(100);
 cnt int;
 cnt1 int;
 pos1 int;
 ISUSEREXISTS int;
 TEMPPAS varchar2(50);
 vDATABASE_LINK VARCHAR2(50);
begin
  temppas:='dawsLpQ14UWL';
/*  IF ISTEST IS NULL THEN
   vISTEST:=0;
  ELSE
   vISTEST:=ISTEST;
  END IF; 
 */
 
--sys.dbms_utility.exec_ddl_statement@GSM('
 -- создание пользователя
/*  BEGIN
    EXECUTE IMMEDIATE 'DROP USER '||DEST_SCHEME ||' CASCADE';
  EXCEPTION
    WHEN OTHERS THEN NULL;  
  END; */ 
  ISUSEREXISTS:=0;
  BEGIN
   SELECT 1 INTO ISUSEREXISTS FROM DBA_USERS WHERE USERNAME=DEST_SCHEME;
  EXCEPTION
   WHEN NO_DATA_FOUND THEN ISUSEREXISTS:=0; 
  END;  
  IF ISUSEREXISTS=1 THEN
    RAISE_APPLICATION_ERROR(-20001, 'Такая схема уже существует. Задайте другое значение имени схемы.');  
  END IF;

  BEGIN
   tempstr:='CREATE USER '||DEST_SCHEME||' IDENTIFIED BY '||temppas;
    EXECUTE IMMEDIATE tempstr;
  EXCEPTION
    WHEN NO_DATA_FOUND THEN     RAISE_APPLICATION_ERROR(-20001, 'Ошибка при создании новой схемы.');
  END; 
  BEGIN 
   EXECUTE IMMEDIATE 'GRANT CREATE SESSION TO '||DEST_SCHEME;
   EXECUTE IMMEDIATE 'GRANT CREATE PROCEDURE TO '||DEST_SCHEME;
   EXECUTE IMMEDIATE 'GRANT CREATE VIEW TO '||DEST_SCHEME;
   EXECUTE IMMEDIATE 'GRANT DEBUG ANY PROCEDURE, DEBUG CONNECT SESSION TO '||DEST_SCHEME;
   EXECUTE IMMEDIATE 'GRANT EXECUTE ON SYS.UTL_HTTP TO '||DEST_SCHEME;
   EXECUTE IMMEDIATE 'GRANT EXECUTE ON SYS.UTL_SMTP TO '||DEST_SCHEME;
   execute immediate 'GRANT EXECUTE ON SYS.DBMS_LOCK TO '||DEST_SCHEME;  
   execute immediate 'GRANT EXECUTE ON SYS.UTL_TCP TO '||DEST_SCHEME;  
   execute immediate 'CREATE PUBLIC SYNONYM '||DEST_SCHEME||'.DBA_SCHEDULER_JOBS FOR SYS.DBA_SCHEDULER_JOBS';
  EXCEPTION 
   WHEN OTHERS THEN NULL;
  END;
  -- создание синонимов
  dbms_output.put_line('-----Начало создания синонимов и грантов на таблицы.');
--  execute immediate 'select ''CREATE OR REPLACE SYNONYM '||DEST_SCHEME||'.''||OBJECT_NAME ||'' FOR ''||OBJECT_NAME||'''' from dba_objects where OBJECT_TYPE=''TABLE'' AND OWNER='''||SOURCE_SCHEME||'''' bulk collect INTO OBJ1;
  execute immediate 'select OBJECT_NAME from dba_objects where (OBJECT_TYPE=''TABLE'' OR OBJECT_TYPE=''SEQUENCE'') AND OWNER='''||SOURCE_SCHEME||'''' bulk collect INTO OBJ1;
 
  --dbms_output.put_line('select ''CREATE OR REPLACE SYNONYM '||DEST_SCHEME||'.''||OBJECT_NAME ||'' FOR ''||OBJECT_NAME||'';'' from dba_objects where OBJECT_TYPE=''TABLE'' AND OWNER=''CORP_MOBILE''');
  cnt:=0;
  FOR A IN 1..OBJ1.LAST LOOP
    BEGIN
     tempstr:='CREATE OR REPLACE SYNONYM '||DEST_SCHEME||'.'|| OBJ1(A) ||' FOR '||OBJ1(A)||'';
     EXECUTE IMMEDIATE tempstr;
     tempstr:='GRANT SELECT ON '||SOURCE_SCHEME||'.'||OBJ1(A)||' TO '||DEST_SCHEME;    
     EXECUTE IMMEDIATE tempstr;
     tempstr:='GRANT DELETE, INSERT, SELECT, UPDATE ON '||SOURCE_SCHEME||'.'||OBJ1(A)||' TO '||DEST_SCHEME;    
     EXECUTE IMMEDIATE tempstr;
     cnt:=cnt+1;
    EXCEPTION
     WHEN OTHERS THEN
           DBMS_OUTPUT.PUT_LINE(tempstr);
    END;  
  END LOOP;
  dbms_output.put_line('-----Окончено создание таблиц и синонимов. Всего -'||cnt);

  dbms_output.put_line('-----Начало создания View');
  cnt:=0;
  execute immediate 'select OBJECT_NAME from dba_objects where OBJECT_TYPE=''VIEW'' AND OWNER='''||SOURCE_SCHEME||'''' bulk collect INTO OBJ1;
  FOR A IN 1..OBJ1.LAST LOOP
    BEGIN
        str:=dbms_metadata.get_ddl('VIEW',OBJ1(A));
        str:=replace(str,' "'||SOURCE_SCHEME||'".', ' "'||DEST_SCHEME||'".');
        execute immediate str; 
        cnt:=cnt+1;
     --EXECUTE IMMEDIATE OBJ1(A);
    EXCEPTION
     WHEN OTHERS THEN
           DBMS_OUTPUT.PUT_LINE('Ошибка создания view: '||OBJ1(A)||' - '||SQLERRM);
    END;  
  END LOOP;
  dbms_output.put_line('-----Окончено создание view. Всего -'||cnt);

  
  dbms_output.put_line('-----Начало создания процедур');
  cnt:=0;
  execute immediate 'select OBJECT_NAME from dba_objects where OBJECT_TYPE=''PROCEDURE'' AND OWNER='''||SOURCE_SCHEME||'''' bulk collect INTO OBJ1;
  FOR A IN 1..OBJ1.LAST LOOP
    BEGIN
        str:=dbms_metadata.get_ddl('PROCEDURE',OBJ1(A));
        str:=replace(str,' "'||SOURCE_SCHEME||'".', ' "'||DEST_SCHEME||'".');
        execute immediate str; 
        cnt:=cnt+1;
     --EXECUTE IMMEDIATE OBJ1(A);
    EXCEPTION
     WHEN OTHERS THEN
           DBMS_OUTPUT.PUT_LINE('Ошибка создания процедуры: '||OBJ1(A)||' - '||SQLERRM);
    END;  
  END LOOP;
  dbms_output.put_line('-----Окончено создание процедур. Всего -'||cnt);

  dbms_output.put_line('-----Начало создания функций');
  cnt:=0;
  execute immediate 'select OBJECT_NAME from dba_objects where OBJECT_TYPE=''FUNCTION'' AND OWNER='''||SOURCE_SCHEME||'''' bulk collect INTO OBJ1;
  FOR A IN 1..OBJ1.LAST LOOP
    BEGIN
        str:=dbms_metadata.get_ddl('FUNCTION',OBJ1(A));
        str:=replace(str,' "'||SOURCE_SCHEME||'".', ' "'||DEST_SCHEME||'".');
        execute immediate str; 
        cnt:=cnt+1;
     --EXECUTE IMMEDIATE OBJ1(A);
    EXCEPTION
     WHEN OTHERS THEN
           DBMS_OUTPUT.PUT_LINE('Ошибка создания функции: '||OBJ1(A)||' - '||SQLERRM);
    END;  
  END LOOP;
  dbms_output.put_line('-----Окончено создание функций. Всего -'||cnt);

  dbms_output.put_line('-----Начало создания пакетов');
  cnt:=0;
  execute immediate 'select OBJECT_NAME from dba_objects where OBJECT_TYPE=''PACKAGE'' AND OWNER='''||SOURCE_SCHEME||'''' bulk collect INTO OBJ1;
  FOR A IN 1..OBJ1.LAST LOOP
    BEGIN
        str:=dbms_metadata.get_ddl('PACKAGE',OBJ1(A));
        --str1:=substr(dbms_metadata.get_ddl('PACKAGE BODY',OBJ1(A)),1,100000);
        --select substr(dbms_metadata.get_ddl('PACKAGE BODY',OBJ1(A)),1,100000) into str1 from dual;
        str:=replace(str,' "'||SOURCE_SCHEME||'".', ' "'||DEST_SCHEME||'".');
        pos1:=DBMS_LOB.INSTR(str,'CREATE OR REPLACE PACKAGE BODY');
        --DBMS_OUTPUT.PUT_LINE(pos1);
        IF POS1<>0 THEN
         dbms_lob.createtemporary(str1,false);
         DBMS_LOB.COPY(str1,str,pos1-1);
         dbms_lob.createtemporary(str2,false);
         DBMS_LOB.COPY(str2,str,100000, 1,pos1);
         execute immediate str1; 
         execute immediate str2; 
        ELSE
         execute immediate str; 
        END IF; 
        --str:=replace(str,'CREATE OR REPLACE PACKAGE BODY', chr(13)||chr(10)||'/'||chr(13)||chr(10)||'CREATE OR REPLACE PACKAGE BODY');
        
        --str:=str||chr(13)||chr(10)||'/'||chr(13)||chr(10)|| str1||chr(13)||chr(10)||'/';
        --DBMS_OUTPUT.PUT_LINE(str1);
        --exit;
        
        cnt:=cnt+1;
     --EXECUTE IMMEDIATE OBJ1(A);
    EXCEPTION
     WHEN OTHERS THEN
           DBMS_OUTPUT.PUT_LINE('Ошибка создания пакета: '||OBJ1(A)||' - '||SQLERRM);
    END;  
  END LOOP;
  dbms_output.put_line('-----Окончено создание пакета. Всего -'||cnt);
  



  dbms_output.put_line('-----Начало создания типов');
  cnt:=0;
  execute immediate 'select OBJECT_NAME from dba_objects where OBJECT_TYPE=''TYPE'' AND OWNER='''||SOURCE_SCHEME||'''' bulk collect INTO OBJ1;
  FOR A IN 1..OBJ1.LAST LOOP
    BEGIN
        str:=dbms_metadata.get_ddl('TYPE',OBJ1(A));
        str:=replace(str,' "'||SOURCE_SCHEME||'".', ' "'||DEST_SCHEME||'".');
        execute immediate str; 
        cnt:=cnt+1;
     --EXECUTE IMMEDIATE OBJ1(A);
    EXCEPTION
     WHEN OTHERS THEN
           DBMS_OUTPUT.PUT_LINE('Ошибка создания типа: '||OBJ1(A)||' - '||SQLERRM);
    END;  
  END LOOP;
  dbms_output.put_line('-----Окончено создание типов. Всего -'||cnt);
  
  
  SYS.UTL_RECOMP.RECOMP_PARALLEL (4, DEST_SCHEME);
  INSERT INTO DATABASE_COPIES (SCHEMA_NAME) VALUES (DEST_SCHEME) RETURNING ID_DATABASE INTO vID_DATABASE;
  COMMIT; 
  -- создание job  
  SYS.DBMS_SCHEDULER.CREATE_JOB
    (
       job_name        => 'J_CS'||DEST_SCHEME
      ,start_date      => NULL
      ,repeat_interval => 'FREQ=YEARLY;INTERVAL=1'
      ,end_date        => NULL
      ,job_class       => 'DEFAULT_JOB_CLASS'
      ,job_type        => 'PLSQL_BLOCK'
      ,job_action      => 'BEGIN COMPARE_BALANCES ('||vID_DATABASE||'); END;'
      ,comments        => NULL
    );
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE
    ( name      => 'J_CS'||DEST_SCHEME
     ,attribute => 'RESTARTABLE'
     ,value     => FALSE);
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE
    ( name      => 'J_CS'||DEST_SCHEME
     ,attribute => 'LOGGING_LEVEL'
     ,value     => SYS.DBMS_SCHEDULER.LOGGING_OFF);
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE_NULL
    ( name      => 'J_CS'||DEST_SCHEME
     ,attribute => 'MAX_FAILURES');
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE_NULL
    ( name      => 'J_CS'||DEST_SCHEME
     ,attribute => 'MAX_RUNS');
  BEGIN
    SYS.DBMS_SCHEDULER.SET_ATTRIBUTE
      ( name      => 'J_CS'||DEST_SCHEME
       ,attribute => 'STOP_ON_WINDOW_CLOSE'
       ,value     => FALSE);
  EXCEPTION
    -- could fail if program is of type EXECUTABLE...
    WHEN OTHERS THEN
      NULL;
  END;
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE
    ( name      => 'J_CS'||DEST_SCHEME
     ,attribute => 'JOB_PRIORITY'
     ,value     => 3);
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE_NULL
    ( name      => 'J_CS'||DEST_SCHEME
     ,attribute => 'SCHEDULE_LIMIT');
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE
    ( name      => 'J_CS'||DEST_SCHEME
     ,attribute => 'AUTO_DROP'
     ,value     => FALSE);

  -- окончание создания job  
end;