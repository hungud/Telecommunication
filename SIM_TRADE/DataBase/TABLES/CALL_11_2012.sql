-- Create table
create table CALL_11_2012
(
  subscr_no        VARCHAR2(11),
  start_time       DATE,
  at_ft_code       VARCHAR2(6),
  dbf_id           INTEGER,
  call_cost        NUMBER,
  costnovat        NUMBER,
  dur              NUMBER,
  imei             VARCHAR2(15),
  servicetype      VARCHAR2(1),
  servicedirection NUMBER(1),
  isroaming        VARCHAR2(1),
  roamingzone      VARCHAR2(6),
  call_date        VARCHAR2(10),
  call_time        VARCHAR2(8),
  duration         VARCHAR2(8),
  dialed_dig       VARCHAR2(21),
  at_ft_de         VARCHAR2(240),
  at_ft_desc       VARCHAR2(240),
  calling_no       VARCHAR2(21),
  at_chg_amt       VARCHAR2(14),
  data_vol         VARCHAR2(14),
  cell_id          VARCHAR2(6),
  mn_unlim         NUMBER(1)
)
tablespace CALL_11_2012
  pctfree 10
  pctused 40
  initrans 1
  maxtrans 255
  storage
  (
    initial 16
    next 8
    minextents 1
    maxextents unlimited
    pctincrease 0
  );
-- Create/Recreate indexes 
create index CALL_11_2012$DBF_ID$IDX on CALL_11_2012 (DBF_ID)
  tablespace CALL_11_2012
  compress
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 10M
    next 10M
    minextents 1
    maxextents unlimited
    pctincrease 0
  );
create index CALL_11_2012$SUBSCR#MN$IDX on CALL_11_2012 (SUBSCR_NO, MN_UNLIM)
  tablespace CALL_11_2012
  compress 2
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 10M
    next 10M
    minextents 1
    maxextents unlimited
    pctincrease 0
  );
create index CALL_11_2012$SUBSCR_NO$IDX on CALL_11_2012 (SUBSCR_NO)
  tablespace CALL_11_2012
  compress
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 10M
    next 10M
    minextents 1
    maxextents unlimited
    pctincrease 0
  );
create index CALL_11_2012$SUBSCR#STIME$IDX on CALL_11_2012 (SUBSCR_NO, START_TIME)
  tablespace CALL_11_2012
  compress 1
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 10M
    next 10M
    minextents 1
    maxextents unlimited
    pctincrease 0
  );

CREATE INDEX I_CALL_11_2012$DBF$SUBSCR$COST ON CALL_11_2012 (DBF_ID, SUBSCR_NO, CALL_COST)            
tablespace CALL_11_2012
COMPRESS 1;

-- Create/Recreate primary, unique and foreign key constraints 
alter table CALL_11_2012
  add constraint CALL_11_2012$DBF_ID$F foreign key (DBF_ID)
  references HOT_BILLING_FILES (HBF_ID);
-- Create/Recreate check constraints 
alter table CALL_11_2012
  add constraint CALL_11_2012$START_TIME$N
  check ("START_TIME" IS NOT NULL);
-- Grant/Revoke object privileges 
grant select, update, delete on CALL_11_2012 to CORP_MOBILE_ROLE;
grant select on CALL_11_2012 to CORP_MOBILE_ROLE_RO;
