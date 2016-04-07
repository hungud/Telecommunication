-- Create table
--#if not TableExists("ALL_LOAD_TYPES") then
create table ALL_LOAD_TYPES
(
  load_type_id   INTEGER,
  load_type_name VARCHAR2(126 CHAR)
)
--#end if

--#Execute MAIN_SCHEMA=IsClient("")

--#if not GrantExists("ALL_LOAD_TYPES", "ROLE", "SELECT") then
begin EXECUTE IMMEDIATE 'GRANT ALL ON ALL_LOAD_TYPES TO &MAIN_SCHEMA'||'_ROLE'; end;
--#end if

--#if not GrantExists("ALL_LOAD_TYPES", "ROLE_RO", "SELECT") then
begin EXECUTE IMMEDIATE 'GRANT SELECT ON ALL_LOAD_TYPES TO &MAIN_SCHEMA'||'_ROLE_RO'; end;
--#end if
