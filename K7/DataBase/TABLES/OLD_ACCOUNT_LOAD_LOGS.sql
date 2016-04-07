CREATE TABLE OLD_ACCOUNT_LOAD_LOGS
(
  ACCOUNT_LOAD_LOG_ID   INTEGER,
  ACCOUNT_ID            INTEGER,
  LOAD_DATE_TIME        DATE,
  IS_SUCCESS            NUMBER(1),
  ERROR_TEXT            VARCHAR2(2000 CHAR),
  ACCOUNT_LOAD_TYPE_ID  INTEGER,
  BEELINE_RN            VARCHAR2(30 BYTE),
  BAN                   INTEGER
)
TABLESPACE TS_LOGS
RESULT_CACHE (MODE DEFAULT)
PCTUSED    0
PCTFREE    10
INITRANS   1
MAXTRANS   255
STORAGE    (
            INITIAL          64K
            NEXT             1M
            MAXSIZE          UNLIMITED
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