-- Create table
--
--#Version=1
--
create table HOT_BILLING_MONTH
(
  year_month INTEGER,
  db         NUMBER(1),
  COUNT_IN_CALL      INTEGER,
  COUNT_IN_EXT_CALL  INTEGER
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64
    next 1
    minextents 1
    maxextents unlimited
  );

COMMENT ON TABLE HOT_BILLING_MONTH IS 'Информация о выгруженных таблицах из базы в файлы';

COMMENT ON COLUMN HOT_BILLING_MONTH.YEAR_MONTH IS 'Период';

COMMENT ON COLUMN HOT_BILLING_MONTH.DB IS 'Статус выгрузки 0 - выгружено; 1 - не выгружено из базы';

COMMENT ON COLUMN HOT_BILLING_MONTH.COUNT_IN_CALL IS 'Количество строк в таблице EXT_CALL_YEAR_MONTH';  
-- Grant/Revoke object privileges 
grant select, insert, update, delete on HOT_BILLING_MONTH to CORP_MOBILE_ROLE;
