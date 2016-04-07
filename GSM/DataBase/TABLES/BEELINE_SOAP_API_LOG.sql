-- Create table
create table BEELINE_SOAP_API_LOG
(
  bsal_id      INTEGER not null,
  soap_request VARCHAR2(4000),
  soap_answer  XMLTYPE,
  insert_date  DATE,
  phone        VARCHAR2(11),
  account_id   NUMBER(2),
  load_type    NUMBER(3)
)
tablespace TS_ACC_LOADS
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 16K
    next 8K
    minextents 1
    maxextents unlimited
  );
-- Create/Recreate primary, unique and foreign key constraints 
alter table BEELINE_SOAP_API_LOG
  add constraint PK_BSAL primary key (BSAL_ID)
  using index 
  tablespace TS_ACC_LOADS
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 256K
    next 1M
    minextents 1
    maxextents unlimited
  );
  
-- Create/Recreate indexes 
create index I_PHONE_TYPE_ACCOUNT on BEELINE_SOAP_API_LOG (PHONE, ACCOUNT_ID, LOAD_TYPE)
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
  
-- Grant/Revoke object privileges 

grant select, insert, update, delete on BEELINE_SOAP_API_LOG to CORP_MOBILE_ROLE;
grant select on BEELINE_SOAP_API_LOG to CORP_MOBILE_ROLE_RO;
