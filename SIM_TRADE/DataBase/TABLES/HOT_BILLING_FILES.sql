-- Create table
create table HOT_BILLING_FILES
(
  file_name  VARCHAR2(50),
  load_sdate DATE,
  load_edate DATE,
  hbf_id     INTEGER not null
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64
    next 8
    minextents 1
    maxextents unlimited
  );
-- Create/Recreate primary, unique and foreign key constraints 
alter table HOT_BILLING_FILES
  add primary key (HBF_ID)
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
grant select, insert, update, delete on HOT_BILLING_FILES to CORP_MOBILE_ROLE;
grant select on HOT_BILLING_FILES to CORP_MOBILE_ROLE_RO;


Alter table HOT_BILLING_FILES add FILE_SIZE INTEGER;
Alter table HOT_BILLING_FILES add ROW_COUNT INTEGER;

COMMENT ON COLUMN HOT_BILLING_FILES.FILE_SIZE IS 'Размер файла в байтах';
COMMENT ON COLUMN HOT_BILLING_FILES.ROW_COUNT IS 'Количество строк в файле';

COMMENT ON COLUMN HOT_BILLING_FILES.FILE_NAME IS 'Имя файла';
COMMENT ON COLUMN HOT_BILLING_FILES.LOAD_SDATE IS 'Дата-время начала загрузки файла'; 
COMMENT ON COLUMN HOT_BILLING_FILES.LOAD_EDATE IS 'Дата-время окончания загрузки файла';
COMMENT ON COLUMN HOT_BILLING_FILES.HBF_ID IS 'ID загруженного файла'; 


Alter table HOT_BILLING_FILES add DATE_INSERT_FILE_NAME date;
COMMENT ON COLUMN HOT_BILLING_FILES.DATE_INSERT_FILE_NAME IS 'Дата/время вставки имени файла в табличку';

CREATE OR REPLACE TRIGGER TI_Hot_Billing_Files
--#Version=2
--v.2 Афросин Добавил DATE_INSERT_FILE_NAME
  BEFORE INSERT ON Hot_Billing_Files FOR EACH ROW
BEGIN
    :NEW.hbf_id := S_NEW_HBF_ID.Nextval;
    :NEW.DATE_INSERT_FILE_NAME := SYSDATE;
END;
/

alter table HOT_BILLING_FILES
add DEL_ROW_COUNT INTEGER;

COMMENT ON COLUMN HOT_BILLING_FILES.DEL_ROW_COUNT Is 'Количество удаленных(некорректных) строк в файле';