--#if not TableExists("SEND_SMS_CHANGE_TARIFF_LOG") then
create table SEND_SMS_CHANGE_TARIFF_LOG
(
   phone_number   VARCHAR2(10 CHAR),
   tariff_code	  VARCHAR2(30 CHAR),
   change_date	  DATE,
   send_date_time DATE,
   error_text	  VARCHAR2(200 CHAR)
);
comment on table SEND_SMS_CHANGE_TARIFF_LOG is 'кНЦ НРОПЮБЙХ SMS Н ЯЛЕМЕ РЮПХТМНЦН ОКЮМЮ';
--#end if

--#if GetColumnComment("SEND_SMS_CHANGE_TARIFF_LOG.phone_number") <> "мнлеп рекетнмю" then
comment on column SEND_SMS_CHANGE_TARIFF_LOG.phone_number is 'мнлеп рекетнмю';
--#end if
--#if GetColumnComment("SEND_SMS_CHANGE_TARIFF_LOG.tariff_code") <> "йнд рюпхтмнцн окюмю" then
comment on column SEND_SMS_CHANGE_TARIFF_LOG.tariff_code is 'йнд рюпхтмнцн окюмю';
--#end if
--#if GetColumnComment("SEND_SMS_CHANGE_TARIFF_LOG.change_date") <> "дюрю ялемш" then
comment on column SEND_SMS_CHANGE_TARIFF_LOG.change_date is 'дюрю ялемш';
--#end if
--#if GetColumnComment("SEND_SMS_CHANGE_TARIFF_LOG.send_date_time") <> "дюрю пюяяшкйх" then
comment on column SEND_SMS_CHANGE_TARIFF_LOG.send_date_time is 'дюрю пюяяшкйх';
--#end if
--#if GetColumnComment("SEND_SMS__CHANGE_TARIFF_LOG.error_text") <> "рейяр ньхайх" then
comment on column SEND_SMS_CHANGE_TARIFF_LOG.error_text is 'рейяр ньхайх';
--#end if

create index I_SEND_SMS_CHNG_TAR_LOG_PHONE on SEND_SMS_CHANGE_TARIFF_LOG(PHONE_NUMBER);