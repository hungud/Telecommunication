--#if not TableExists("LOG_WORK_SERVICE") then
--drop table LOG_WORK_SERVICE;  
create table LOG_WORK_SERVICE
(
  SERVICE_NAME    VARCHAR2(64),
  REPORT_TYPE     NUMBER,
  ACCOUNT_ID      INTEGER,
  DATE_TIME       DATE,
  SERVER_TYPE     VARCHAR2(32),
  SERVER_ADDRES   VARCHAR2(64),
  ERR             NUMBER,
  ERR_TEXT        VARCHAR(1028)
);  
--#end if

--#if GetTableComment("LOG_WORK_SERVICE")<>"����������� ������ ��������" then
-- Add comments to the table 
comment on table LOG_WORK_SERVICE
  is '����������� ������ ��������';
--#end if


--#if GetColumnComment("LOG_WORK_SERVICE.ACCOUNT_ID") <> "������������� ��������" then
comment on column LOG_WORK_SERVICE.ACCOUNT_ID
  is '������������� ��������';
--#end if

--#if GetColumnComment("LOG_WORK_SERVICE.DATE_TIME") <> "���� � ����� ������" then
comment on column LOG_WORK_SERVICE.DATE_TIME
  is '���� � ����� ������';
--#end if

--#if GetColumnComment("LOG_WORK_SERVICE.SERVER_ADDRES") <> "����� �������" then
comment on column LOG_WORK_SERVICE.SERVER_ADDRES
  is '����� �������';
--#end if

--#if GetColumnComment("LOG_WORK_SERVICE.ERR") <> "������� ������ 0/1 - ���������� ������ �� �����/ ����������� ������ �� �����" then
comment on column LOG_WORK_SERVICE.ERR
  is '������� ������ 0/1 - ���������� ������ �� �����/ ����������� ������ �� �����';
--#end if

--#if GetColumnComment("LOG_WORK_SERVICE.ERR_TEXT") <> "����� ������ ��� �� �������" then
comment on column LOG_WORK_SERVICE.ERR_TEXT
  is '����� ������ ��� �� �������'; 
--#end if 

--#if not ConstraintExists("FK_LOG_WORK_ACCOUNT_ID") then
alter table LOG_WORK_SERVICE
  add constraint FK_LOG_WORK_ACCOUNT_ID foreign key (ACCOUNT_ID)
  references ACCOUNTS (ACCOUNT_ID) on delete set null;  
--#end if 

--#if ColumnExists("LOG_WORK_SERVICE.SERVICE_NAME") then
ALTER TABLE LOG_WORK_SERVICE DROP COLUMN SERVICE_NAME CASCADE CONSTRAINTS;
--#end if

--#if ColumnExists("LOG_WORK_SERVICE.REPORT_TYPE") then
ALTER TABLE LOG_WORK_SERVICE DROP COLUMN REPORT_TYPE CASCADE CONSTRAINTS;
--#end if

--#if ColumnExists("LOG_WORK_SERVICE.SERVER_TYPE") then
ALTER TABLE LOG_WORK_SERVICE DROP COLUMN SERVER_TYPE CASCADE CONSTRAINTS;
--#end if

--#if not ColumnExists("LOG_WORK_SERVICE.LOG_SPR_ID") then
ALTER TABLE LOG_WORK_SERVICE ADD LOG_SPR_ID NUMBER NOT NULL;
--#end if

--#if not ConstraintExists("FK_LOG_SPR_ID") then
alter table LOG_WORK_SERVICE
  add constraint FK_LOG_SPR_ID foreign key (LOG_SPR_ID)
  references LOG_SPR_WORK_SERVICE (LOG_SPR_ID) on delete set null; 
--#end if 
