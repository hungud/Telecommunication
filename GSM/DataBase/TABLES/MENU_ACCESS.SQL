--#if not TableExists("MENU_ACCESS") then
-- Овсянников Лев. 15.10.2013 Справочник видимости меню.
CREATE TABLE MENU_ACCESS
(
  MENU_NAME VARCHAR2(100 CHAR),
  ACTIONLIST_NAME VARCHAR2(100 CHAR),
  IS_VISIBLE int,
  USER_NAME VARCHAR2(50 CHAR),
  RIGHTS_TYPE INT,
  CHECK_ALLOW_ACCOUNT INT
);

--#end if

--#if GetTableComment("MENU_ACCESS")<>"Справочник видимости меню" then
comment on table MENU_ACCESS
  is 'Справочник видимости меню';
--#end if

--#Execute MAIN_SCHEMA=IsClient("")
--#if not GrantExists("MENU_ACCESS", "ROLE", "UPDATE") then
begin EXECUTE IMMEDIATE 'GRANT ALL ON MENU_ACCESS TO &MAIN_SCHEMA'||'_ROLE'; end;
--#end if

--#if not GrantExists("MENU_ACCESS", "ROLE_RO", "SELECT") then
begin EXECUTE IMMEDIATE 'GRANT SELECT ON MENU_ACCESS TO &MAIN_SCHEMA'||'_ROLE_RO'; end;
--#end if

