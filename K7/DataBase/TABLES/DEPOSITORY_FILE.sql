CREATE TABLE DEPOSITORY_FILE
(
  FILE_NAME  VARCHAR2(50 CHAR),
  NOTE       VARCHAR2(300 CHAR),
  FILE_CLB   BLOB
)
LOB (FILE_CLB) STORE AS (
  TABLESPACE USERS
  ENABLE       STORAGE IN ROW
  CHUNK       8192
  RETENTION
  NOCACHE
  LOGGING
  INDEX       (
        TABLESPACE USERS
        STORAGE    (
                    INITIAL          64K
                    NEXT             1M
                    MINEXTENTS       1
                    MAXEXTENTS       UNLIMITED
                    PCTINCREASE      0
                    BUFFER_POOL      DEFAULT
                   ))
      STORAGE    (
                  INITIAL          64K
                  NEXT             1M
                  MINEXTENTS       1
                  MAXEXTENTS       UNLIMITED
                  PCTINCREASE      0
                  BUFFER_POOL      DEFAULT
                 ))
TABLESPACE USERS
PCTUSED    0
PCTFREE    10
INITRANS   1
MAXTRANS   255
STORAGE    (
            INITIAL          64K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           )
LOGGING 
NOCOMPRESS 
NOCACHE
NOPARALLEL
MONITORING;

COMMENT ON TABLE DEPOSITORY_FILE IS 'Хранилище файлов';

COMMENT ON COLUMN DEPOSITORY_FILE.FILE_NAME IS 'Имя файла';

COMMENT ON COLUMN DEPOSITORY_FILE.NOTE IS 'Примечание';

COMMENT ON COLUMN DEPOSITORY_FILE.FILE_CLB IS 'Файл';

ALTER TABLE DEPOSITORY_FILE ADD DATE_LAST_UPDATED  DATE;

COMMENT ON COLUMN DEPOSITORY_FILE.DATE_LAST_UPDATED IS 'Дата/время последней редакции записи';

GRANT SELECT ON DEPOSITORY_FILE TO CORP_MOBILE_ROLE;

GRANT SELECT ON DEPOSITORY_FILE TO CORP_MOBILE_ROLE_RO;