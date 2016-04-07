
  CREATE OR REPLACE PROCEDURE "CORP_MOBILE"."EXPORTOBJECTSTODISK_AFR" (SOURCE_SCHEME   IN VARCHAR2,
                                                 DIR_NAME        IN VARCHAR2)
IS
--
--Version=2
--
--v.2 Афросин -26.03.2015 - Переделал процедуру 
--
   
   sDEBUGFOLDER      VARCHAR2 (120) := 'D:\Tarifer\VersionControl\Database';
   
   
  procedure ExportDBObject (pObjectTypeChars Varchar2, psDEBUGFOLDER varchar2, pSOURCE_SCHEME varchar2, pOBJECT_TYPE varchar2 DEFAULT  NULL ) as
    tDEBUGFOLDER VARCHAR2(500);
    tObjectTypeChars VARCHAR2(500);
    tSOURCE_SCHEME VARCHAR2(500);
    TYPE T_OBJNAME IS TABLE OF VARCHAR2 (128);
    OBJ1              T_OBJNAME;
    nFLAG             BINARY_INTEGER := 0;
    cnt               INT;
    clob_len          INTEGER;
    str               CLOB;
    tempPath          VARCHAR2 (512);
    kodir             VARCHAR2 (30) := 'UTF-8';
    tOBJECT_TYPE  VARCHAR2(30);
    ISUSEREXISTS      INT;
  begin

    tObjectTypeChars := pObjectTypeChars;
    tDEBUGFOLDER := psDEBUGFOLDER;
    tSOURCE_SCHEME := pSOURCE_SCHEME;
    tOBJECT_TYPE  := nvl(pOBJECT_TYPE, tObjectTypeChars); 
   
    
    ISUSEREXISTS := 0;

    BEGIN
      SELECT 1
        INTO ISUSEREXISTS
        FROM DBA_USERS
       WHERE USERNAME = tSOURCE_SCHEME;
    EXCEPTION
      WHEN NO_DATA_FOUND
      THEN
         ISUSEREXISTS := 0;
    END;

    IF ISUSEREXISTS = 0
    THEN
      RAISE_APPLICATION_ERROR (
         -20001,
         'Такой схемы не существует. Задайте другое значение имени схемы.');
    END IF;

   tDEBUGFOLDER := tDEBUGFOLDER ||'\'||tSOURCE_SCHEME;
   
   DBMS_OUTPUT.put_line (tDEBUGFOLDER);

   nFLAG := PKG_TRF_FILEAPI.mkdirs (tDEBUGFOLDER);

   EXECUTE IMMEDIATE
      'create or replace directory TMPDIR1 as ''' || tDEBUGFOLDER || '''';

   EXECUTE IMMEDIATE 'grant read, write on directory TMPDIR1 to public';
    
    
    
    DBMS_OUTPUT.put_line (
      '-----Начало создания ' || tObjectTypeChars);
    --делаем директорию для View
    nFLAG := PKG_TRF_FILEAPI.mkdirs (tDEBUGFOLDER || '\' || tObjectTypeChars);

    EXECUTE IMMEDIATE
         'create or replace directory TMPDIR1 as '''
      || tDEBUGFOLDER
      || '\'
      || tObjectTypeChars
      || '''';

    EXECUTE IMMEDIATE 'grant read, write on directory TMPDIR1 to public';

    cnt := 0;

    EXECUTE IMMEDIATE
         'select OBJECT_NAME from dba_objects where OBJECT_TYPE='''
      || tObjectTypeChars
      || ''' AND OWNER='''
      || tSOURCE_SCHEME
      || ''''
      BULK COLLECT INTO OBJ1;

    FOR A IN 1 .. OBJ1.LAST
    LOOP
      BEGIN
         str := DBMS_METADATA.get_ddl (tOBJECT_TYPE, OBJ1 (A));
         clob_len := DBMS_LOB.getlength (str);
         tempPath :=
               tDEBUGFOLDER
            || '\'
            || tObjectTypeChars
            || '\'
            || OBJ1 (A)
            || '.SQL';
         SYS.lobutils.CLOB2file (str, tempPath, kodir);
         cnt := cnt + 1;
      EXCEPTION
         WHEN OTHERS
         THEN
            DBMS_OUTPUT.PUT_LINE (
                  'Ошибка создания '
               || tObjectTypeChars
               || ': '
               || OBJ1 (A)
               || ' - '
               || SQLERRM);
      END;
    END LOOP;
    DBMS_OUTPUT.put_line ('-----Окончено создание ' || tObjectTypeChars|| '. Всего -'|| cnt); 
  end;
BEGIN
   IF DIR_NAME IS NOT NULL
   THEN
      sDEBUGFOLDER := DIR_NAME;
   END IF;
   
   ExportDBObject('VIEW', sDEBUGFOLDER, SOURCE_SCHEME);
   ExportDBObject('PROCEDURE', sDEBUGFOLDER, SOURCE_SCHEME);
   ExportDBObject('FUNCTION', sDEBUGFOLDER, SOURCE_SCHEME);
   ExportDBObject('PACKAGE', sDEBUGFOLDER, SOURCE_SCHEME);
   ExportDBObject('TYPE', sDEBUGFOLDER, SOURCE_SCHEME);
   ExportDBObject('JOB', sDEBUGFOLDER, SOURCE_SCHEME, 'PROCOBJ');
   ExportDBObject('TABLE', sDEBUGFOLDER, SOURCE_SCHEME);
   ExportDBObject('QUEUE', sDEBUGFOLDER, SOURCE_SCHEME, 'AQ_QUEUE');
   ExportDBObject('JAVA CLASS', sDEBUGFOLDER, SOURCE_SCHEME, 'JAVA_CLASS');
   ExportDBObject('JAVA SOURCE', sDEBUGFOLDER, SOURCE_SCHEME, 'JAVA_SOURCE');
   ExportDBObject('JAVA RESOURCE', sDEBUGFOLDER, SOURCE_SCHEME, 'JAVA_RESOURCE');
   ExportDBObject('INDEX', sDEBUGFOLDER, SOURCE_SCHEME);
   ExportDBObject('TRIGGER', sDEBUGFOLDER, SOURCE_SCHEME);
   ExportDBObject('SEQUENCE', sDEBUGFOLDER, SOURCE_SCHEME);
   ExportDBObject('MATERIALIZED VIEW', sDEBUGFOLDER, SOURCE_SCHEME, 'MATERIALIZED_VIEW');
   ExportDBObject('LIBRARY', sDEBUGFOLDER, SOURCE_SCHEME);

END;