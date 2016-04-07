
  CREATE OR REPLACE FUNCTION "CORP_MOBILE"."CREATE_EXT_TABLE_FOR_CALLS" 
   RETURN VARCHAR2
AS
   --
   --#Version=2
   --
   --22.09.2014 - переделал процедуру CREATE_EXT_TABLE_FOR_CALLS на функцию, функция возвращает строки для бат файла для запуска программы 
   --создание внешнишних таблиц для CALLS старше 3-х месяцев
   PROG_EXPORT_CALLS_TO_TEXT_DIR   VARCHAR2 (1000);
   CALLSMM                         VARCHAR2 (1000);
   CONNECT_STR                     VARCHAR2 (1000);
   USED_SCHEMA_NAME                VARCHAR2 (1000);
   Res                             VARCHAR2 (1000);
   PROG_NAME                       VARCHAR2 (21) := 'ExportCallsToText.exe';
-- := 'CORP_MOBILE/7cJMw95wpLi8@192.168.1.11:1521:orcl';
BEGIN
   Res := ' ';

   
   --  Создаем внешние таблицы для невыгруженных таблиц базы
       for rec in (
               select substr(year_month, 5, 2)||'_'|| substr(year_month, 1, 4) TableName from HOT_BILLING_MONTH
                   where db = 1
               and year_month <= to_char(add_months(sysdate, -3), 'yyyymm')  and
               exists (select 1 from USER_TABLES
               where table_name = 'CALL_'|| substr(year_month, 5, 2)||'_'|| substr(year_month, 1, 4))
               and not exists (select 1 from USER_TABLES
               where table_name = 'EXT_CALL_'|| substr(year_month, 5, 2)||'_'|| substr(year_month, 1, 4))
               )
        loop
           EXECUTE IMMEDIATE
            'CREATE TABLE ext_CALL_'||rec.TableName||'
                           ORGANIZATION EXTERNAL
                           (
                       TYPE ORACLE_DATAPUMP
                       DEFAULT DIRECTORY DATA_PUMP_DETAIL
                       LOCATION (''CALL_'||rec.TableName||'.dmp'')
                       )
                       AS SELECT * FROM CALL_'||rec.TableName;
        end loop;

   -- Считаем и пишем количество строк в выгруженной таблице и таблице из которой выгружали
       for rec in (
               select substr(year_month, 5, 2)||'_'|| substr(year_month, 1, 4) TableName, year_month  from HOT_BILLING_MONTH
                   where db = 1
               and year_month <= to_char(add_months(sysdate, -3), 'yyyymm')  and
               exists (select 1 from USER_TABLES
               where table_name = 'CALL_'|| substr(year_month, 5, 2)||'_'|| substr(year_month, 1, 4))
               and exists (select 1 from USER_TABLES
               where table_name = 'EXT_CALL_'|| substr(year_month, 5, 2)||'_'|| substr(year_month, 1, 4))
               )
        loop
           EXECUTE IMMEDIATE
            'UPDATE HOT_BILLING_MONTH
             set
               COUNT_IN_CALL = (select count(*) from CALL_'||rec.TableName||'),
               COUNT_IN_EXT_CALL = (select count(*) from EXT_CALL_'||rec.TableName||')
             where DB = 1 and YEAR_MONTH =' ||rec.year_month;
        end loop;
        commit;
   
   SELECT directory_path
     INTO CALLSMM
     FROM all_directories
    WHERE directory_name = 'CALLSMM';

   SELECT directory_path
     INTO PROG_EXPORT_CALLS_TO_TEXT_DIR
     FROM all_directories
    WHERE directory_name = 'PROG_EXPORT_CALLS_TO_TEXT_DIR';

   SELECT SYS_CONTEXT ('userenv', 'CURRENT_SCHEMA')
     INTO USED_SCHEMA_NAME
     FROM DUAL;

   --     'CORP_MOBILE/7cJMw95wpLi8@192.168.1.11:1521:orcl';

   SELECT    LOADER_DB_USER_NAME
          || '/'
          || LOADER_DB_PASSWORD
          || '@'
          || REPLACE (LOADER_DB_CONNECTION, '/', ':')
     INTO CONNECT_STR
     FROM LOADER_SETTINGS;

   --  выгружаем на диск данные для удачно выгруженных таблиц
   FOR rec
      IN (SELECT    SUBSTR (year_month, 5, 2)
                 || '_'
                 || SUBSTR (year_month, 1, 4)
                    MONTH_YEAR,
                    SUBSTR (year_month, 1, 4)
                 || '_'
                 || SUBSTR (year_month, 5, 2)
                    year_month
            FROM HOT_BILLING_MONTH
           WHERE     db = 1
                 AND COUNT_IN_CALL = COUNT_IN_EXT_CALL
                 AND year_month <=
                        TO_CHAR (ADD_MONTHS (SYSDATE, -3), 'yyyymm')
                 AND EXISTS
                        (SELECT 1
                           FROM USER_TABLES
                          WHERE table_name =
                                      'CALL_'
                                   || SUBSTR (year_month, 5, 2)
                                   || '_'
                                   || SUBSTR (year_month, 1, 4))
                 AND EXISTS
                        (SELECT 1
                           FROM USER_TABLES
                          WHERE table_name =
                                      'EXT_CALL_'
                                   || SUBSTR (year_month, 5, 2)
                                   || '_'
                                   || SUBSTR (year_month, 1, 4)))
   LOOP
      --        \\10.176.1.10\share_ditrade\Tarifer\SiteRobotService\ExportCallsToText\ExportCallsToText.exe corp_mobile/hivxHD2gpHJX@109.95.211.33:1521:K7 05_2014 \\10.176.1.10\share_ditrade\Tarifer\DB\2014_05 CORP_MOBILE


      Res :=
            Res
         || PROG_EXPORT_CALLS_TO_TEXT_DIR
         || PROG_NAME
         || ' '
         || CONNECT_STR
         || ' '
         || rec.MONTH_YEAR
         || ' '
         || CALLSMM
         || rec.year_month
         || ' '
         || USED_SCHEMA_NAME
         || CHR (13)
         || CHR (10);
   --      EXPORT_CALLS_TO_TEXT (PROG_EXPORT_CALLS_TO_TEXT_DIR, rec.MONTH_YEAR, CALLSMM || rec.year_month, CONNECT_STR, USED_SCHEMA_NAME);
   END LOOP;

   RETURN Res;
END;