
  CREATE OR REPLACE PROCEDURE "SIM_TRADE"."CREATE_EXT_TABLE_FOR_CALLS" AS
--
--#Version=1
--
--создание внешнишних таблиц для CALLS старше 3-х месяцев
begin
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
end;