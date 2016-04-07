--#if isclient("CORP_MOBILE")
--#if not TableExists("DETAIL_HIDE_PHONES") then
-- Овсянников Лев. 28.08.2013 Справочник исключений просмотра деталки.
CREATE TABLE DETAIL_HIDE_PHONES
(
  PHONE_NUMBER VARCHAR2(10 CHAR),
  TYPE_VISIBILITY int
);

--#end if

--#if GetTableComment("DETAIL_HIDE_PHONES")<>"Справочник исключений просмотра деталки" then
comment on table DETAIL_HIDE_PHONES
  is 'Справочник исключений просмотра деталки';
--#end if

--#if not ConstraintExists("PK_CONTRACTS")
ALTER TABLE DETAIL_HIDE_PHONES ADD (
  CONSTRAINT PK_DETAIL_HIDE_PHONES
 PRIMARY KEY
 (PHONE_NUMBER));
--#end if

--#Execute MAIN_SCHEMA=IsClient("")
--#if not GrantExists("DETAIL_HIDE_PHONES", "ROLE", "UPDATE") then
begin EXECUTE IMMEDIATE 'GRANT ALL ON DETAIL_HIDE_PHONES TO &MAIN_SCHEMA'||'_ROLE'; end;
--#end if

--#if not GrantExists("DETAIL_HIDE_PHONES", "ROLE_RO", "SELECT") then
begin EXECUTE IMMEDIATE 'GRANT SELECT ON DETAIL_HIDE_PHONES TO &MAIN_SCHEMA'||'_ROLE_RO'; end;
--#end if

--#end if
