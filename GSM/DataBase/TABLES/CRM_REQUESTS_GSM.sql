CREATE TABLE CRM_REQUESTS
(
  REQUEST_ID         INTEGER,
  PHONE_NUMBER       VARCHAR2(10 CHAR),
  ID_STATUS_REQUEST  INTEGER                    NOT NULL,
  DATE_CREATED       DATE,
  USER_CREATED       VARCHAR2(30 CHAR),
  USER_LAST_UPDATED  VARCHAR2(30 CHAR),
  DATE_LAST_UPDATED  DATE,
  RESPONSIBLE_USER   VARCHAR2(30 CHAR),
  TYPE_REQUEST_ID    INTEGER                    NOT NULL,
  DOP_CONTACT        VARCHAR2(30 CHAR),
  ATTACHED_FILES     VARCHAR2(4000 CHAR),
  DEADLINE_DATE      DATE,
  OPERATOR           VARCHAR2(50 CHAR),
  TEXT_REQUEST       CLOB
)
LOB (TEXT_REQUEST) STORE AS (
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


CREATE INDEX I_CRM_REQUESTS_DEADLINE_DATE ON CRM_REQUESTS
(DEADLINE_DATE)
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
NOPARALLEL
COMPRESS 1;


CREATE INDEX I_CRM_REQUESTS_PHONE_NUMBER ON CRM_REQUESTS
(PHONE_NUMBER)
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
NOPARALLEL
COMPRESS 1;


CREATE INDEX I_CRM_REQUESTS_TYPE_RESP_USER ON CRM_REQUESTS
(TYPE_REQUEST_ID, RESPONSIBLE_USER)
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
NOPARALLEL
COMPRESS 2;


CREATE UNIQUE INDEX PK_CRM_REQUESTS ON CRM_REQUESTS
(REQUEST_ID)
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


CREATE OR REPLACE TRIGGER TIU_CRM_REQUESTS
BEFORE INSERT OR UPDATE
ON CRM_REQUESTS
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
--
--#Version=1
--
--v.1 ������� 09.10.2014 - ������� :NEW.PHONE_NUMBER is not null �� nvl(:NEW.PHONE_NUMBER, '') <> ''
-- � :NEW.DOP_CONTACT is not null �� nvl(:NEW.DOP_CONTACT, '') <> '
--
DECLARE 
  PRAGMA AUTONOMOUS_TRANSACTION;
  sms varchar2(512);
BEGIN
  IF INSERTING THEN
    IF NVL(:NEW.REQUEST_ID, 0) = 0 then
      :NEW.REQUEST_ID := S_NEW_REQUEST_ID.NEXTVAL;
    END IF;
  END IF;
  IF UPDATING THEN 
    IF (:OLD.ID_STATUS_REQUEST<>:NEW.ID_STATUS_REQUEST) AND (:NEW.ID_STATUS_REQUEST=3) THEN 
      IF :NEW.TYPE_REQUEST_ID <> 8 THEN
        --���������� �� ����� ��������
        IF nvl(:NEW.PHONE_NUMBER, 0) <> 0 THEN 
            sms:=loader3_pckg.SEND_SMS(:NEW.PHONE_NUMBER, null,'���������� ������ �'||:NEW.REQUEST_ID||', �������� ��������������, ����������� �� �������� 8-495-788-79-08');
        END IF; 
        --���� ���. ����� <> ������ ��������, �� ���������� �� ���� ����   
        IF nvl(:NEW.DOP_CONTACT, 0) <> 0 THEN --���� ���. ����� �� ������
            IF nvl(:NEW.DOP_CONTACT, 0) <> nvl(:NEW.PHONE_NUMBER, 0) THEN --���� ���. ����� <> ������ ��������, � ����� ���������� ��� ���� 2 ��� �� ���� �����, � ��� �����������
                sms:=loader3_pckg.SEND_SMS(:NEW.DOP_CONTACT, null,'���������� ������ �'||:NEW.REQUEST_ID||', �������� ��������������, ����������� �� �������� 8-495-788-79-08');
            END IF;
        END IF;  
      ELSE
        --���������� �� �����, �� �������� �������, � ��� ���. �����
        IF nvl(:NEW.DOP_CONTACT, 0) <> 0 THEN --���� ���. ����� �� ������
            sms:=loader3_pckg.SEND_SMS(:NEW.DOP_CONTACT, null,'���������� ������ �'||:NEW.REQUEST_ID||', �������� ��������������, ����������� �� �������� 8-495-788-79-08');
        ELSE --���� ���. ����� ������, �� ���������� �� �����, ������� ������� ��� ����� �������� (���������� ��� � ���� �������)
            IF nvl(:NEW.PHONE_NUMBER, 0) <> 0 THEN 
                sms:=loader3_pckg.SEND_SMS(:NEW.PHONE_NUMBER, null,'���������� ������ �'||:NEW.REQUEST_ID||', �������� ��������������, ����������� �� �������� 8-495-788-79-08');
            END IF; 
        END IF;     
      END IF;
    END IF;
  END IF;
  :NEW.DATE_LAST_UPDATED:=SYSDATE;
END;
/
/


CREATE SYNONYM LONTANA_COPY_K1.CRM_REQUESTS FOR CRM_REQUESTS;


ALTER TABLE CRM_REQUESTS ADD (
  CONSTRAINT PK_CRM_REQUESTS
  PRIMARY KEY
  (REQUEST_ID)
  USING INDEX PK_CRM_REQUESTS
  ENABLE VALIDATE);

ALTER TABLE CRM_REQUESTS ADD (
  CONSTRAINT FK_CRM_TYPE_REQUEST 
  FOREIGN KEY (TYPE_REQUEST_ID) 
  REFERENCES CRM_TYPE_REQUEST (TYPE_REQUEST_ID)
  ENABLE VALIDATE);

GRANT DELETE, INSERT, SELECT, UPDATE ON CRM_REQUESTS TO LONTANA_COPY_K1;

CREATE SYNONYM WWW_DEALER.CRM_REQUESTS FOR LONTANA.CRM_REQUESTS;

GRANT SELECT, INSERT ON LONTANA.CRM_REQUESTS TO WWW_DEALER;


ALTER TABLE CRM_REQUESTS ADD leaving_reason_id INTEGER DEFAULT NULL;

COMMENT ON COLUMN CRM_REQUESTS.leaving_reason_id IS '��� ������� ����� �������������';