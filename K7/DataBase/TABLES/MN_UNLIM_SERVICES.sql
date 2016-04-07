create table MN_UNLIM_SERVICES
(
  feature_co     VARCHAR2(10),
  mn_unlim_group NUMBER(1)
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
grant select, insert, update, delete on MN_UNLIM_SERVICES to CORP_MOBILE_ROLE;
grant select on MN_UNLIM_SERVICES to CORP_MOBILE_ROLE_RO;