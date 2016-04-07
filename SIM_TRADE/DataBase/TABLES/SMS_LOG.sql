CREATE TABLE SMS_LOG
(
  PHONE                    VARCHAR2(11 BYTE),
  MESSAGE                  VARCHAR2(2000 BYTE),
  SMS_ID                   INTEGER,
  SUBMITION_DATE           DATE,
  SEND_DATE                DATE,
  LAST_STATUS_CHANGE_DATE  DATE,
  STATUS                   VARCHAR2(200 BYTE),
  STATUS_CODE              INTEGER,
  SLERROR_CODE             INTEGER,
  SLERROR                  VARCHAR2(200 BYTE),
  INSERT_DATE              DATE,
  REQ_COUNT                INTEGER,
  DATE_START               DATE,
  SMS_SENDER_NAME          VARCHAR2(20 BYTE)
)
TABLESPACE USERS
RESULT_CACHE (MODE DEFAULT)
PCTUSED    0
PCTFREE    10
INITRANS   1
MAXTRANS   255
STORAGE    (
            INITIAL          64K
            NEXT             8K
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

COMMENT ON COLUMN SMS_LOG.SMS_SENDER_NAME IS '��� �����������, ������������� � ���� "�� ����" ��� �������� ���, ������� �� ������� SMS_SENDER_NAME';



CREATE INDEX SMS_LOG$PHONE#SDATE$IDX ON SMS_LOG
(PHONE, SEND_DATE)
LOGGING
TABLESPACE USERS
PCTFREE    10
INITRANS   2
MAXTRANS   255
STORAGE    (
            INITIAL          10M
            NEXT             10M
            MAXSIZE          UNLIMITED
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
            FLASH_CACHE      DEFAULT
            CELL_FLASH_CACHE DEFAULT
           )
NOPARALLEL;


CREATE OR REPLACE TRIGGER TI_SMS_log
--#Version=1
  BEFORE INSERT ON SMS_log FOR EACH ROW
BEGIN
    :NEW.Insert_Date:=sysdate;
END;
/


GRANT DELETE, INSERT, SELECT, UPDATE ON SMS_LOG TO CORP_MOBILE_ROLE;

GRANT SELECT ON SMS_LOG TO CORP_MOBILE_ROLE_RO;
