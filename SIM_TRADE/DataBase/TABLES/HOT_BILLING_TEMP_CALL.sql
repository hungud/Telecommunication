-- Create table
create table HOT_BILLING_TEMP_CALL
(
  subscr_no  VARCHAR2(11),
  ch_seiz_dt VARCHAR2(16),
  at_ft_code VARCHAR2(6),
  at_chg_amt VARCHAR2(14),
  calling_no VARCHAR2(21),
  duration   VARCHAR2(8),
  data_vol   VARCHAR2(14),
  imei       VARCHAR2(15),
  cell_id    VARCHAR2(6),
  dialed_dig VARCHAR2(21),
  at_ft_desc VARCHAR2(100),
  dbf_id     INTEGER
)
tablespace HOT_BILLING
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64
    next 8
    minextents 1
    maxextents unlimited
  )
nologging;
-- Create/Recreate indexes 
create index HB_TEMP_CALL$DBF_ID$IDX on HOT_BILLING_TEMP_CALL (DBF_ID)
  tablespace HOT_BILLING
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 10M
    next 10M
    minextents 1
    maxextents unlimited
  );
create index HB_TEMP_CALL$SUBSCR_NO$IDX on HOT_BILLING_TEMP_CALL (SUBSCR_NO)
  tablespace HOT_BILLING
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 10M
    next 10M
    minextents 1
    maxextents unlimited
  );
-- Create/Recreate primary, unique and foreign key constraints 
alter table HOT_BILLING_TEMP_CALL
  add constraint HOT_BILLING_TEMP_CALL$DBF_ID$F foreign key (DBF_ID)
  references HOT_BILLING_FILES (HBF_ID);
grant select, insert, update, delete on HOT_BILLING_TEMP_CALL to CORP_MOBILE_ROLE;
grant select on HOT_BILLING_TEMP_CALL to CORP_MOBILE_ROLE_RO;
