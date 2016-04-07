-- Create table
create table HOT_BILLING_FILES(
  file_name  VARCHAR2(50),
  load_sdate DATE,
  load_edate DATE,
  hbf_id     INTEGER primary key,
  FILE_SIZE INTEGER,
  ROW_COUNT INTEGER,
  DATE_INSERT_FILE_NAME date,
  DEL_ROW_COUNT INTEGER,
  LOAD_COUNT INTEGER,
  DATE_START DATE,
  DATE_END DATE,
  COUNT_LOADING INTEGER,
  FILE_SIZE_BYTE INTEGER,
  FILE_ROW_COUNT INTEGER,
  ERROR_ROW_COUNT INTEGER,
  YEAR_MONTH INTEGER
);

COMMENT ON COLUMN HOT_BILLING_FILES.FILE_SIZE IS 'Размер файла в байтах';
COMMENT ON COLUMN HOT_BILLING_FILES.ROW_COUNT IS 'Количество строк в файле';
COMMENT ON COLUMN HOT_BILLING_FILES.FILE_NAME IS 'Имя файла';
COMMENT ON COLUMN HOT_BILLING_FILES.LOAD_SDATE IS 'Дата-время начала загрузки файла'; 
COMMENT ON COLUMN HOT_BILLING_FILES.LOAD_EDATE IS 'Дата-время окончания загрузки файла';
COMMENT ON COLUMN HOT_BILLING_FILES.HBF_ID IS 'ID загруженного файла'; 
COMMENT ON COLUMN HOT_BILLING_FILES.DATE_INSERT_FILE_NAME IS 'Дата/время вставки имени файла в табличку';
COMMENT ON COLUMN HOT_BILLING_FILES.DEL_ROW_COUNT Is 'Количество удаленных(некорректных) строк в файле';
COMMENT ON COLUMN HOT_BILLING_FILES.LOAD_COUNT IS 'Количество попыток загрузки файла в базу';
COMMENT ON COLUMN HOT_BILLING_FILES.DATE_START IS 'Количество попыток загрузки файла в базу';
COMMENT ON COLUMN HOT_BILLING_FILES.DATE_END IS 'Количество попыток загрузки файла в базу';
COMMENT ON COLUMN HOT_BILLING_FILES.COUNT_LOADING IS 'Количество попыток загрузки файла в базу';
COMMENT ON COLUMN HOT_BILLING_FILES.FILE_SIZE_BYTE IS 'Размер файла в байтах';
COMMENT ON COLUMN HOT_BILLING_FILES.FILE_ROW_COUNT IS 'Количество строк в файле';
COMMENT ON COLUMN HOT_BILLING_FILES.ERROR_ROW_COUNT IS 'Количество строк в файле';
COMMENT ON COLUMN HOT_BILLING_FILES.YEAR_MONTH IS 'Месяц к которому относится файл';

CREATE OR REPLACE TRIGGER TI_Hot_Billing_Files
--#Version=2
--v.2 Афросин Добавил DATE_INSERT_FILE_NAME
  BEFORE INSERT ON Hot_Billing_Files FOR EACH ROW
BEGIN
    :NEW.hbf_id := S_NEW_HBF_ID.Nextval;
    :NEW.DATE_INSERT_FILE_NAME := SYSDATE;
  BEGIN
    :NEW.YEAR_MONTH:=TO_NUMBER(SUBSTR(:NEW.FILE_NAME, 11, 6));
  EXCEPTION
    WHEN OTHERS THEN
      :NEW.YEAR_MONTH:=NULL;
  END;  
END;
/

-- Grant/Revoke object privileges 
grant select, insert, update, delete on HOT_BILLING_FILES to CORP_MOBILE_ROLE;
grant select on HOT_BILLING_FILES to CORP_MOBILE_ROLE_RO;