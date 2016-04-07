ALTER TABLE IVIDEON.ACTIVE_TYPE
 DROP PRIMARY KEY CASCADE;

DROP TABLE IVIDEON.ACTIVE_TYPE CASCADE CONSTRAINTS;

CREATE TABLE IVIDEON.ACTIVE_TYPE
(
  ACTIVE_TYPE_ID  INTEGER                       NOT NULL,
  ACTIVE_NAME     VARCHAR2(30 BYTE)             NOT NULL
)
TABLESPACE USERS
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

COMMENT ON TABLE IVIDEON.ACTIVE_TYPE IS 'Типы статуса';

COMMENT ON COLUMN IVIDEON.ACTIVE_TYPE.ACTIVE_TYPE_ID IS 'Идентификатор статуса';

COMMENT ON COLUMN IVIDEON.ACTIVE_TYPE.ACTIVE_NAME IS 'Название статуса';



--  There is no statement for index IVIDEON.SYS_C0019573.
--  The object is created when the parent object is created.

ALTER TABLE IVIDEON.ACTIVE_TYPE ADD (
  PRIMARY KEY
  (ACTIVE_TYPE_ID)
  USING INDEX
    TABLESPACE USERS
    PCTFREE    10
    INITRANS   2
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
  ENABLE VALIDATE);
