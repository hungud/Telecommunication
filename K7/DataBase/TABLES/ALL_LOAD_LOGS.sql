-- Create table
--#if not TableExists("ALL_LOAD_LOGS") then
create table ALL_LOAD_LOGS
(
  load_log_id          INTEGER,
  email                VARCHAR2(32),
  load_date_time       DATE,
  is_success           NUMBER(1),
  error_text           VARCHAR2(2000 CHAR),
  account_load_type_id INTEGER,
  beeline_rn           VARCHAR2(30)
)
--#end if

-- Add comments to the table 
--#if GetTableComment("ALL_LOAD_LOGS")<>"Журнал общих загрузок информации с сайта оператора" then
comment on table ALL_LOAD_LOGS
  is 'Журнал общих загрузок информации с сайта оператора';
--#end if

-- Add comments to the columns 
--#if GetTableComment("ALL_LOAD_LOGS.load_log_id")<>"Первичный ключ" then
comment on column ALL_LOAD_LOGS.load_log_id
  is 'Код записи (Первичный ключ)';
--#end if

--#if GetTableComment("ALL_LOAD_LOGS.email")<>"E-mail получателя отчета" then
comment on column ALL_LOAD_LOGS.email
  is 'E-mail получателя отчета';
--#end if

--#if GetTableComment("ALL_LOAD_LOGS.load_date_time")<>"Дата и время загрузки" then
comment on column ALL_LOAD_LOGS.load_date_time
  is 'Дата и время загрузки';
--#end if

--#if GetTableComment("ALL_LOAD_LOGS.is_success")<>"Признак успешной загрузки (1 - успешно, 0 - ошибка)" then
comment on column ALL_LOAD_LOGS.is_success
  is 'Признак успешной загрузки (1 - успешно, 0 - ошибка)';
--#end if

--#if GetTableComment("ALL_LOAD_LOGS.error_text")<>"Текст ошибки или успешности отправки" then
comment on column ALL_LOAD_LOGS.error_text
  is 'Текст ошибки или успешности отправки';
--#end if

--#if GetTableComment("ALL_LOAD_LOGS.beeline_rn")<>"Код отчета Билайн" then
comment on column ALL_LOAD_LOGS.beeline_rn
  is 'Код отчета Билайн';
--#end if


--#Execute MAIN_SCHEMA=IsClient("")

--#if not GrantExists("ALL_LOAD_LOGS", "ROLE", "SELECT") then
begin EXECUTE IMMEDIATE 'GRANT ALL ON ALL_LOAD_LOGS TO &MAIN_SCHEMA'||'_ROLE'; end;
--#end if

--#if not GrantExists("ALL_LOAD_LOGS", "ROLE_RO", "SELECT") then
begin EXECUTE IMMEDIATE 'GRANT SELECT ON ALL_LOAD_LOGS TO &MAIN_SCHEMA'||'_ROLE_RO'; end;
--#end if
