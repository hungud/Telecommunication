create table HOT_BILLING_USM_PHONE
(
  phone_number VARCHAR2(50),
  date_insert  DATE,
  u_month      DATE
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64
    next 1
    minextents 1
    maxextents unlimited
  );
-- Grant/Revoke object privileges 
grant select, update, delete on HOT_BILLING_USM_PHONE to CORP_MOBILE_ROLE;
grant select on HOT_BILLING_USM_PHONE to CORP_MOBILE_ROLE_RO;

CREATE INDEX I_HOT_BILLING_USM_PHONE_MON_PH ON HOT_BILLING_USM_PHONE(U_MONTH, PHONE_NUMBER)
COMPRESS 1;
