--#if isclient("CORP_MOBILE") or isclient("GSM_CORP") then

--#if not TableExists("BLOCK_TYPES") then
create table BLOCK_TYPES
(
  block_type_id   INTEGER not null,
  block_type_name VARCHAR2(30 CHAR)
);
--#end if

--#if GetTableComment("BLOCK_TYPES")<>"Виды блокировок" then
-- Add comments to the table 
comment on table BLOCK_TYPES
  is 'Виды блокировок';
--#end if

--#if GetColumnComment("BLOCK_TYPES.BLOCK_TYPE_ID")<>"Код" then
-- Add comments to the columns 
comment on column BLOCK_TYPES.block_type_id
  is 'Код';
--#end if

--#if GetColumnComment("BLOCK_TYPES.BLOCK_TYPE_NAME")<>"Название" then
comment on column BLOCK_TYPES.block_type_name
  is 'Название';
--#end if

--#if not ConstraintExists("PK_BLOCK_TYPES")
-- Create/Recreate primary, unique and foreign key constraints 
alter table BLOCK_TYPES
  add constraint PK_BLOCK_TYPES primary key (BLOCK_TYPE_ID)
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
--#end if

--#Execute MAIN_SCHEMA=IsClient("")
--#if not GrantExists("BLOCK_TYPES", "ROLE", "UPDATE") then
begin EXECUTE IMMEDIATE 'GRANT ALL ON BLOCK_TYPES TO &MAIN_SCHEMA'||'_ROLE'; end;
--#end if

--#if not GrantExists("BLOCK_TYPES", "ROLE_RO", "SELECT") then
begin EXECUTE IMMEDIATE 'GRANT SELECT ON BLOCK_TYPES TO &MAIN_SCHEMA'||'_ROLE_RO'; end;
--#end if

--#end if
