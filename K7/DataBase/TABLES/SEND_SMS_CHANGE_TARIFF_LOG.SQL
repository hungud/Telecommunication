--#if not TableExists("SEND_SMS_CHANGE_TARIFF_LOG") then
create table SEND_SMS_CHANGE_TARIFF_LOG
(
   phone_number   VARCHAR2(10 CHAR),
   tariff_code	  VARCHAR2(30 CHAR),
   change_date	  DATE,
   send_date_time DATE,
   error_text	  VARCHAR2(200 CHAR)
);
comment on table SEND_SMS_CHANGE_TARIFF_LOG is '��� �������� SMS � ����� ��������� �����';
--#end if

--#if GetColumnComment("SEND_SMS_CHANGE_TARIFF_LOG.phone_number") <> "����� ��������" then
comment on column SEND_SMS_CHANGE_TARIFF_LOG.phone_number is '����� ��������';
--#end if
--#if GetColumnComment("SEND_SMS_CHANGE_TARIFF_LOG.tariff_code") <> "��� ��������� �����" then
comment on column SEND_SMS_CHANGE_TARIFF_LOG.tariff_code is '��� ��������� �����';
--#end if
--#if GetColumnComment("SEND_SMS_CHANGE_TARIFF_LOG.change_date") <> "���� �����" then
comment on column SEND_SMS_CHANGE_TARIFF_LOG.change_date is '���� �����';
--#end if
--#if GetColumnComment("SEND_SMS_CHANGE_TARIFF_LOG.send_date_time") <> "���� ��������" then
comment on column SEND_SMS_CHANGE_TARIFF_LOG.send_date_time is '���� ��������';
--#end if
--#if GetColumnComment("SEND_SMS__CHANGE_TARIFF_LOG.error_text") <> "����� ������" then
comment on column SEND_SMS_CHANGE_TARIFF_LOG.error_text is '����� ������';
--#end if

create index I_SEND_SMS_CHNG_TAR_LOG_PHONE on SEND_SMS_CHANGE_TARIFF_LOG(PHONE_NUMBER);