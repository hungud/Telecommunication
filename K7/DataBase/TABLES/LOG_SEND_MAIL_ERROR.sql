--#if not TableExists("LOG_SEND_MAIL_ERROR") then
CREATE TABLE LOG_SEND_MAIL_ERROR
(
  DATE_SEND     DATE,
  NOTE          VARCHAR2(100 CHAR)
);
--#end if

--#Execute MAIN_SCHEMA=IsClient("")
--#if not GrantExists("LOG_SEND_MAIL_ERROR", "ROLE", "SELECT") then
begin EXECUTE IMMEDIATE 'GRANT ALL ON LOG_SEND_MAIL_ERROR TO &MAIN_SCHEMA'||'_ROLE'; end;
--#end if

--#if not GrantExists("LOG_SEND_MAIL_ERROR", "ROLE_RO", "SELECT") then
begin EXECUTE IMMEDIATE 'GRANT SELECT ON LOG_SEND_MAIL_ERROR TO &MAIN_SCHEMA'||'_ROLE_RO'; end;
--#end if

--#if not GrantExists("LOG_SEND_MAIL_ERROR", "ROLE_RO", "INSERT") then
begin EXECUTE IMMEDIATE 'GRANT INSERT ON LOG_SEND_MAIL_ERROR TO &MAIN_SCHEMA'||'_ROLE_RO'; end;
--#end if

