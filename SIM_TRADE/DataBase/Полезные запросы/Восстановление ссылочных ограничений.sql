-- Скрипт проверяет базу и вытаскивает недостающие ссылочные ключи

select 'ALTER TABLE '||table_name||' ADD CONSTRAINT FK_'||table_name||'_'||column_name||' FOREIGN KEY('||column_name||') REFERENCES '||primary_table_name||';'
from (
select
--user_tables.*, 
  user_tab_columns.table_name, 
  user_tab_columns.column_name,
  user_constraints.table_name as primary_table_name 
from 
  user_tab_columns,
  user_tables,
  user_constraints, 
  USER_CONS_COLUMNS
where user_constraints.constraint_type='P'
and USER_CONS_COLUMNS.constraint_name=user_constraints.constraint_name
and user_tab_columns.table_name=user_tables.table_name
and user_tables.tablespace_name is not null -- Внешние пропускаем
and user_tab_columns.column_name=USER_CONS_COLUMNS.column_name
and user_tab_columns.table_name <> USER_CONS_COLUMNS.table_name
and USER_CONS_COLUMNS.position=1
and user_tab_columns.column_name <> 'PHONE_NUMBER'
AND NOT EXISTS(
  SELECT * FROM USER_CONS_COLUMNS UCC2
  WHERE UCC2.CONSTRAINT_NAME = USER_CONS_COLUMNS.CONSTRAINT_NAME
  AND UCC2.POSITION=2)
MINUS
SELECT AC.table_name, ACC.column_name, PK.table_name
FROM USER_CONSTRAINTS AC, USER_CONS_COLUMNS ACC,
  user_constraints PK
WHERE (AC.CONSTRAINT_TYPE = 'R')
  AND (AC.CONSTRAINT_NAME = ACC.CONSTRAINT_NAME)
  and PK.CONSTRAINT_NAME=AC.R_CONSTRAINT_NAME
  and pk.constraint_type='P'
);
