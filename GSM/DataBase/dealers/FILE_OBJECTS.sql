DROP TABLE FILE_OBJECTS CASCADE CONSTRAINTS;

CREATE TABLE FILE_OBJECTS
(
  NAME          VARCHAR2(256 BYTE)              NOT NULL,
  MIME_TYPE     VARCHAR2(128 BYTE),
  DOC_SIZE      NUMBER,
  DAD_CHARSET   VARCHAR2(128 BYTE),
  LAST_UPDATED  DATE,
  CONTENT_TYPE  VARCHAR2(128 BYTE),
  BLOB_CONTENT  BLOB
)
LOB (BLOB_CONTENT) STORE AS (
  TABLESPACE  USERS
  ENABLE      STORAGE IN ROW
  CHUNK       8192
  RETENTION
  NOCACHE
  LOGGING
      STORAGE    (
                  INITIAL          64K
                  NEXT             1M
                  MINEXTENTS       1
                  MAXEXTENTS       UNLIMITED
                  PCTINCREASE      0
                  BUFFER_POOL      DEFAULT
                  FLASH_CACHE      DEFAULT
                  CELL_FLASH_CACHE DEFAULT
                 ))
TABLESPACE USERS
RESULT_CACHE (MODE DEFAULT)
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
            FLASH_CACHE      DEFAULT
            CELL_FLASH_CACHE DEFAULT
           )
LOGGING 
NOCOMPRESS 
NOCACHE
NOPARALLEL
MONITORING;


--  There is no statement for index WWW_DEALER.SYS_C0011993.
--  The object is created when the parent object is created.

ALTER TABLE FILE_OBJECTS ADD (
  UNIQUE (NAME)
  USING INDEX
    TABLESPACE USERS
    PCTFREE    10
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                PCTINCREASE      0
                BUFFER_POOL      DEFAULT
                FLASH_CACHE      DEFAULT
                CELL_FLASH_CACHE DEFAULT
               )
  ENABLE VALIDATE);
