-- Create table
create table TELETIE_PAY_LOG
(
  phonenr     VARCHAR2(11),
  amount      NUMBER,
  numpay      VARCHAR2(30),
  ssign       VARCHAR2(4000),
  http_answer VARCHAR2(2000),
  res         VARCHAR2(2000),
  date_insert DATE
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 16
    next 8
    minextents 1
    maxextents unlimited
  );
-- Grant/Revoke object privileges 
grant select, insert, update, delete on TELETIE_PAY_LOG to CORP_MOBILE_COPY;
grant select, insert, update, delete on TELETIE_PAY_LOG to CORP_MOBILE_COPY_ST1;
grant select, insert, update, delete on TELETIE_PAY_LOG to CORP_MOBILE_COPY_TEST;
grant select, insert, update, delete on TELETIE_PAY_LOG to CORP_MOBILE_COPY2;
grant select, insert, update, delete on TELETIE_PAY_LOG to CORP_MOBILE_COPY3;
grant select, insert, update, delete on TELETIE_PAY_LOG to CORP_MOBILE_COPY4;
grant select, insert, update, delete on TELETIE_PAY_LOG to CORP_MOBILE_ROLE;
grant select on TELETIE_PAY_LOG to CORP_MOBILE_ROLE_RO;
-- Add/modify columns 
alter table TELETIE_PAY_LOG add sms_send number(1);
-- Add comments to the table 
comment on table TELETIE_PAY_LOG
  is 'Ћог платежей  телета€';
-- Add comments to the columns 
comment on column TELETIE_PAY_LOG.sms_send
  is 'отправка смс - null - не отправлена, 0 - просрочена, 1 - отправлено.';
-- Create/Recreate indexes 
create index NK_TELETIE_PHONE_PAY_N on TELETIE_PAY_LOG (phonenr, numpay);
create index NK_TELETIE_PAY_SMS on TELETIE_PAY_LOG (sms_send);



CREATE OR REPLACE TRIGGER TI_TELETIE_PAY_LOG
  BEFORE INSERT ON  TELETIE_PAY_LOG FOR EACH ROW
--#Version=1
BEGIN
     :NEW.date_insert := sysdate;
END;

ALTER TABLE TELETIE_PAY_LOG ADD IS_MOBI_PAY INTEGER;
COMMENT ON COLUMN TELETIE_PAY_LOG.IS_MOBI_PAY IS 'Признак списания по мобиденьгам';