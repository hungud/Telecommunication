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

CREATE OR REPLACE TRIGGER TI_BSAL
--#Version=2
--
--v.2 юТПНЯХМ 07.05.2015 ДНАЮБХК ДНАЮБКЕМХЕ Б ADD_PHONE_FOR_CHECK_STATUS
--
--
  BEFORE INSERT ON BEELINE_SOAP_API_LOG FOR EACH ROW
BEGIN
    IF NVL(:NEW.BSAL_ID, 0) = 0 then
      :NEW.BSAL_ID :=  S_BSAL_ID.NEXTVAL;
    END IF;
    :NEW.insert_date := SYSDATE;
--  еякх мнлеп ме осярни х гюъбйю мю акнйхпнбйс хкх пюгакнйхпнбйс мнлепю, рн днаюбкъел мнлеп б нвепедэ мю намнбкемхе ярюрсяю  
    IF NVL(:NEW.PHONE, '0') <> '0' AND :NEW.LOAD_TYPE IN (9, 10) THEN
      ADD_PHONE_FOR_CHECK_STATUS (:NEW.PHONE);
    END IF; 
END;
/
alter table BEELINE_SOAP_API_LOG move tablespace TS_BEELINE_SOAP_API_LOG;

alter table BEELINE_SOAP_API_LOG move lob (SOAP_ANSWER) store as (tablespace TS_BEELINE_SOAP_API_LOG);

Alter index PK_BSAL rebuild TABLESPACE TS_BEELINE_SOAP_API_LOG;

Alter index I_PHONE_TYPE_ACCOUNT rebuild TABLESPACE TS_BEELINE_SOAP_API_LOG;
