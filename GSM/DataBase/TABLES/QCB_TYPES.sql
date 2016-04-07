CREATE TABLE CORP_MOBILE.QCB_TYPES
(
  QCB_ID  INTEGER                               NOT NULL,
  NAME    VARCHAR2(50 BYTE)                     NOT NULL
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


CREATE UNIQUE INDEX CORP_MOBILE.PK_QCB_TYPES ON CORP_MOBILE.QCB_TYPES
(QCB_ID)
LOGGING
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
NOPARALLEL;


CREATE OR REPLACE TRIGGER CORP_MOBILE.TI_QCB_TYPE
  BEFORE INSERT ON CORP_MOBILE.QCB_TYPES FOR EACH ROW
DECLARE

BEGIN
      :NEW.qcb_ID:= S_QCB_TYPES_NEW.NEXTVAL;
END;
/


ALTER TABLE CORP_MOBILE.QCB_TYPES ADD (
  CONSTRAINT PK_QCB_TYPES
  PRIMARY KEY
  (QCB_ID)
  USING INDEX CORP_MOBILE.PK_QCB_TYPES
  ENABLE VALIDATE);

GRANT SELECT ON CORP_MOBILE.QCB_TYPES TO CORP_MOBILE_ROLE;

GRANT SELECT ON CORP_MOBILE.QCB_TYPES TO CORP_MOBILE_ROLE_RO;