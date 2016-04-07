CREATE OR REPLACE PROCEDURE CORP_MOBILE.REBUILD_INDEX_TABLE_CALL AS
--
--#Version=1
-- #2890 Kochnev E 25.05.2015
--перестройка индексов для таблиц CALL_MM_YYYY,где MM - месяц, YYYY- год.
--Ребилдить индексы на таблицах CALL за текущий и предыдущий месяца.

 USED_SCHEMA_NAME VARCHAR2(100);
 IND_CNT Integer;
begin

  SELECT sys_context('userenv', 'CURRENT_SCHEMA') into USED_SCHEMA_NAME from dual;


SELECT count(i.index_name) into IND_CNT FROM SYS.ALL_INDEXES i where i.owner = Upper(USED_SCHEMA_NAME) 
    and  i.table_name like (
      select T.TABLE_NAME from all_tables t where owner = Upper(USED_SCHEMA_NAME)
      and ( ( T.TABLE_NAME like 'CALL_'||(select to_char(sysdate,'MM') from dual)||'_'||(select to_char(sysdate,'YYYY') from dual))
      or (T.TABLE_NAME like 'CALL_'||(select to_char(add_months(sysdate,-1),'MM') from dual)||'_'||(select to_char(add_months(sysdate,-1),'YYYY') from dual))));

   STOP_JOB_PCKG.STOP_JOB(IND_CNT*2);

  for cur in ( 
    SELECT i.index_name FROM SYS.ALL_INDEXES i where i.owner = Upper(USED_SCHEMA_NAME) 
    and  i.table_name like (
      select T.TABLE_NAME from all_tables t where owner = Upper(USED_SCHEMA_NAME)
      and ( ( T.TABLE_NAME like 'CALL_'||(select to_char(sysdate,'MM') from dual)||'_'||(select to_char(sysdate,'YYYY') from dual))
      or (T.TABLE_NAME like 'CALL_'||(select to_char(add_months(sysdate,-1),'MM') from dual)||'_'||(select to_char(add_months(sysdate,-1),'YYYY') from dual))))
             ) 
             loop
               EXECUTE IMMEDIATE
                'ALTER INDEX ' ||cur.index_name|| ' REBUILD PCTFREE 10 STORAGE(INITIAL 10M NEXT 10M)';
             end loop;

   -- commit; 
end;
/