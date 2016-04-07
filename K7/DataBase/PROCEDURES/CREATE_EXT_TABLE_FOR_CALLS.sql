CREATE OR REPLACE PROCEDURE CREATE_EXT_TABLE_FOR_CALLS AS
--
--#Version=1
--
--создание внешнишних таблиц дл€ CALLS старше 3-х мес€цев
PROG_EXPORT_CALLS_TO_TEXT_DIR varchar2(1000);
CALLSMM varchar2(1000);
CONNECT_STR VARCHAR2(1000);
USED_SCHEMA_NAME VARCHAR2(1000);
-- := 'CORP_MOBILE/7cJMw95wpLi8@192.168.1.11:1521:orcl';
begin
    
--  —оздаем внешние таблицы дл€ невыгруженных таблиц базы  
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
     
-- —читаем и пишем количество строк в выгруженной таблице и таблице из которой выгружали
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

     SELECT directory_path into CALLSMM FROM all_directories where directory_name='CALLSMM';
     SELECT directory_path into PROG_EXPORT_CALLS_TO_TEXT_DIR FROM all_directories where directory_name='PROG_EXPORT_CALLS_TO_TEXT_DIR';
     SELECT sys_context('userenv', 'CURRENT_SCHEMA') into USED_SCHEMA_NAME from dual;
--     'CORP_MOBILE/7cJMw95wpLi8@192.168.1.11:1521:orcl';
 
     SELECT LOADER_DB_USER_NAME||'/'||LOADER_DB_PASSWORD||'@'|| REPLACE(LOADER_DB_CONNECTION, '/', ':') into CONNECT_STR from LOADER_SETTINGS;
     
--  выгружаем на диск данные дл€ удачно выгруженных таблиц  
     for rec in ( select substr(year_month, 5, 2)||'_'|| substr(year_month, 1, 4) MONTH_YEAR, substr(year_month, 1, 4)||'_'|| substr(year_month, 5, 2) year_month  from HOT_BILLING_MONTH
                where db = 1
            and COUNT_IN_CALL = COUNT_IN_EXT_CALL
            and year_month <= to_char(add_months(sysdate, -3), 'yyyymm')  and
            exists (select 1 from USER_TABLES
            where table_name = 'CALL_'|| substr(year_month, 5, 2)||'_'|| substr(year_month, 1, 4))
            and exists (select 1 from USER_TABLES
            where table_name = 'EXT_CALL_'|| substr(year_month, 5, 2)||'_'|| substr(year_month, 1, 4)))
    loop
      EXPORT_CALLS_TO_TEXT (PROG_EXPORT_CALLS_TO_TEXT_DIR, rec.MONTH_YEAR, CALLSMM || rec.year_month, CONNECT_STR, USED_SCHEMA_NAME);
    end loop;
     
end;