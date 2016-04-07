--#if not TableExists("CONTRACT_GROUPS") then
CREATE TABLE CONTRACT_GROUPS
(
 GROUP_ID INTEGER NOT NULL,
 GROUP_NAME VARCHAR2(220 CHAR) 
);
--#end if

--#Execute MAIN_SCHEMA=IsClient("")

--#if not GrantExists("CONTRACT_GROUPS", "ROLE", "SELECT") then
begin EXECUTE IMMEDIATE 'GRANT ALL ON CONTRACT_GROUPS TO &MAIN_SCHEMA'||'_ROLE'; end;
--#end if

--#if not GrantExists("CONTRACT_GROUPS", "ROLE_RO", "SELECT") then
begin EXECUTE IMMEDIATE 'GRANT SELECT ON CONTRACT_GROUPS TO &MAIN_SCHEMA'||'_ROLE_RO'; end;
--#end if

--#if not ObjectExists("S_NEW_CONTRACT_GROUP_ID")
CREATE SEQUENCE S_NEW_CONTRACT_GROUP_ID
START WITH 101 MAXVALUE 999999999999999999999999999
MINVALUE 1
NOCYCLE
CACHE 20
NOORDER;
--#end if

--#if not GrantExists("S_NEW_CONTRACT_GROUP_ID", "ROLE", "SELECT") then
begin EXECUTE IMMEDIATE 'GRANT SELECT ON S_NEW_CONTRACT_GROUP_ID TO &MAIN_SCHEMA'||'_ROLE'; end;
--#end if

--#if not GrantExists("S_NEW_CONTRACT_GROUP_ID", "ROLE_RO", "SELECT") then
begin EXECUTE IMMEDIATE 'GRANT SELECT ON S_NEW_CONTRACT_GROUP_ID TO &MAIN_SCHEMA'||'_ROLE_RO'; end;
--#end if

--#if GetColumnSize("CONTRACT_GROUPS.GROUP_NAME") < 220 then
ALTER TABLE CONTRACT_GROUPS
MODIFY GROUP_NAME VARCHAR2(220);
--#end if

--#if not ColumnExists("CONTRACT_GROUPS.paramussd_gr_bal") then
ALTER TABLE CONTRACT_GROUPS ADD paramussd_gr_bal NUMBER(1);
--#end if

--#if GetColumnComment("CONTRACT_GROUPS.paramussd_gr_bal") <> "Параметр:  Возвращать по ussd баланс группы" then
COMMENT ON COLUMN CONTRACT_GROUPS.paramussd_gr_bal IS 'Параметр:  Возвращать по ussd баланс группы';
--#end if

--#if not ColumnExists("CONTRACT_GROUPS.PARAMPDF_CONTACTS") then
ALTER TABLE CONTRACT_GROUPS ADD PARAMPDF_CONTACTS VARCHAR2(600);
--#end if

--#if GetColumnComment("CONTRACT_GROUPS.PARAMPDF_CONTACTS") <> "Параметр: Контактные данные для отчета PDF" then
COMMENT ON COLUMN CONTRACT_GROUPS.PARAMPDF_CONTACTS IS 'Параметр: Контактные данные для отчета PDF';
--#end if

--#if not ColumnExists("CONTRACT_GROUPS.PARAMPDF_BANKDET") then
ALTER TABLE CONTRACT_GROUPS ADD PARAMPDF_BANKDET VARCHAR2(600);
--#end if

--#if GetColumnComment("CONTRACT_GROUPS.PARAMPDF_BANKDET") <> "Параметр: Банковские реквизиты для отчета PDF" then
COMMENT ON COLUMN CONTRACT_GROUPS.PARAMPDF_BANKDET IS 'Пареметр: Банковские реквизиты для отчета PDF';
--#end if

--#if not ColumnExists("CONTRACT_GROUPS.PARAMPDF_LOGO") then
ALTER TABLE CONTRACT_GROUPS ADD PARAMPDF_LOGO BLOB;
--#end if

--#if GetColumnComment("CONTRACT_GROUPS.PARAMPDF_LOGO") <> "Пареметр: Логотип для отчета PDF" then
COMMENT ON COLUMN CONTRACT_GROUPS.PARAMPDF_LOGO IS 'Пареметр: Логотип для отчета PDF';
--#end if

--#if not ColumnExists("CONTRACT_GROUPS.PARAMDET_MAIL") then
ALTER TABLE CONTRACT_GROUPS ADD PARAMDET_MAIL VARCHAR2(100);
--#end if

--#if GetColumnComment("CONTRACT_GROUPS.PARAMDET_MAIL") <> "Параметр: Адрес почты для отправки детализации" then
COMMENT ON COLUMN CONTRACT_GROUPS.PARAMDET_MAIL IS 'Параметр: Адрес почты для отправки детализации';
--#end if

 --#if not ColumnExists("CONTRACT_GROUPS.hand_block_date_end") then
 -- Add/modify columns 
alter table CONTRACT_GROUPS add hand_block_date_end date;
-- Add comments to the columns 
comment on column CONTRACT_GROUPS.hand_block_date_end
  is 'Параметр: Ручная блокировка для всей группы - дата окончания';
--#end if 

--#if not ObjectExists("PK_CONTRACT_GROUPS_GROUP_ID") then
ALTER TABLE CONTRACT_GROUPS
 ADD CONSTRAINT PK_CONTRACT_GROUPS_GROUP_ID
  PRIMARY KEY (GROUP_ID);
-- #end if  