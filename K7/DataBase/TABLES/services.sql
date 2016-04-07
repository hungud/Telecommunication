create table SERVICES
(
  feature_co VARCHAR2(10),
  feature_de VARCHAR2(200),
  descriptio VARCHAR2(100),
  not_use_for_calc number(1)
);
-- Grant/Revoke object privileges 
grant select, insert, update, delete on SERVICES to CORP_MOBILE_COPY;
grant select, insert, update, delete on SERVICES to CORP_MOBILE_ROLE;
grant select on SERVICES to CORP_MOBILE_ROLE_RO;