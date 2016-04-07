--#if not TableExists("SEND_DETAIL_GROUPS_LOG") then
create table SEND_DETAIL_GROUPS_LOG
(
  group_id		INTEGER,
  year_month		INTEGER,
  send_date_time	DATE,
  error_text		VARCHAR2(2000 CHAR)
);
comment on table SEND_DETAIL_GROUPS_LOG is 'Лог отправки детализаций групп договоров';
--#end if

--#if GetColumnComment("SEND_DETAIL_GROUPS_LOG.group_id") <> "ГРУППА" then
comment on column SEND_DETAIL_GROUPS_LOG.group_id is 'ГРУППА';
--#end if
--#if GetColumnComment("SEND_DETAIL_GROUPS_LOG.year_month") <> "Год и месяц отчётного периода" then
comment on column SEND_DETAIL_GROUPS_LOG.year_month is 'Год и месяц отчётного периода';
--#end if
--#if GetColumnComment("SEND_DETAIL_GROUPS_LOG.send_date_time") <> "ДАТА РАССЫЛКИ" then
comment on column SEND_DETAIL_GROUPS_LOG.send_date_time is 'ДАТА РАССЫЛКИ';
--#end if
--#if GetColumnComment("SEND_DETAIL_GROUPS_LOG.error_text") <> "ТЕКСТ ОШИБКИ" then
comment on column SEND_DETAIL_GROUPS_LOG.error_text is 'ТЕКСТ ОШИБКИ';
--#end if

alter table SEND_DETAIL_GROUPS_LOG add (is_detail number(2) default 0);
COMMENT ON COLUMN SEND_DETAIL_GROUPS_LOG.is_detail IS 'Признак отличия для выделения записей об отправке детализаций (0-детализация/1-баланс)';
