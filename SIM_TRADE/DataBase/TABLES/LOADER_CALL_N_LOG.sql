-- Create table
create table LOADER_CALL_N_LOG
(
  account_id  NUMBER not null,
  load_date   DATE not null,
  file_name   VARCHAR2(50) not null,
  file_body   BLOB,
  report_type NUMBER
);
-- Add comments to the table 
comment on table LOADER_CALL_N_LOG
  is 'Сохранение Blob полей с выгрузками';
-- Create/Recreate primary, unique and foreign key constraints 
alter table LOADER_CALL_N_LOG
  add constraint PK_LOADER_CALL_N_LOG primary key (ACCOUNT_ID, LOAD_DATE, FILE_NAME)
  using index 
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
grant select, insert, update, delete, alter on LOADER_CALL_N_LOG to CORP_MOBILE_ROLE;
grant select, insert, update, delete, alter on LOADER_CALL_N_LOG to CORP_MOBILE_ROLE_RO;
