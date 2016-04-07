ALTER TABLE D_LOG_EXCHANGE
 DROP PRIMARY KEY CASCADE;

DROP TABLE D_LOG_EXCHANGE CASCADE CONSTRAINTS;

CREATE TABLE D_LOG_EXCHANGE
(
  CHANGE_DATE        DATE,
  CHANGE_TYPE        VARCHAR2(1 CHAR),
  RESOURCE_TYPE      VARCHAR2(30 CHAR),
  ID                 VARCHAR2(30 CHAR),
  USER_NAME          VARCHAR2(30 CHAR),
  TEXT               VARCHAR2(2000 CHAR),
  PHONE_NUMBER       VARCHAR2(20 BYTE),
  D_LOG_EXCHANGE_ID  INTEGER
)
TABLESPACE USERS
RESULT_CACHE (MODE DEFAULT)
PCTUSED    0
PCTFREE    10
INITRANS   1
MAXTRANS   255
STORAGE    (
            INITIAL          352M
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

COMMENT ON TABLE D_LOG_EXCHANGE IS '������ ����������� ��������';

COMMENT ON COLUMN D_LOG_EXCHANGE.CHANGE_DATE IS '���� � ����� ���������';

COMMENT ON COLUMN D_LOG_EXCHANGE.CHANGE_TYPE IS '��� ���������:  
E ������ 
L ����� �� �������� 
I �������� 
R ������������ 
U ������� 
D ������ 
O ������ ����� � ������������� ����������� 
Y ��� ���������';

COMMENT ON COLUMN D_LOG_EXCHANGE.RESOURCE_TYPE IS '��� ������ (�������� : "������ ���������", "�����������"...)';

COMMENT ON COLUMN D_LOG_EXCHANGE.ID IS '��� ���������� ������';

COMMENT ON COLUMN D_LOG_EXCHANGE.USER_NAME IS '��� ������������, ���������� ���������';

COMMENT ON COLUMN D_LOG_EXCHANGE.TEXT IS '��������� �������� ��������';

COMMENT ON COLUMN D_LOG_EXCHANGE.PHONE_NUMBER IS '����� ��������';



CREATE INDEX I_CONTROL_OPERATION_DATE ON D_LOG_EXCHANGE
(CHANGE_DATE)
LOGGING
TABLESPACE USERS
PCTFREE    10
INITRANS   2
MAXTRANS   255
STORAGE    (
            INITIAL          20M
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
            FLASH_CACHE      DEFAULT
            CELL_FLASH_CACHE DEFAULT
           )
NOPARALLEL;


CREATE INDEX I_CONTROL_OPERATION_ID ON D_LOG_EXCHANGE
(ID)
LOGGING
TABLESPACE USERS
PCTFREE    10
INITRANS   2
MAXTRANS   255
STORAGE    (
            INITIAL          23M
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
            FLASH_CACHE      DEFAULT
            CELL_FLASH_CACHE DEFAULT
           )
NOPARALLEL;


CREATE INDEX I_D_LOG_EXCHANGE_PHONE_NUMBER ON D_LOG_EXCHANGE
(PHONE_NUMBER)
LOGGING
TABLESPACE USERS
PCTFREE    10
INITRANS   2
MAXTRANS   255
STORAGE    (
            INITIAL          22M
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
            FLASH_CACHE      DEFAULT
            CELL_FLASH_CACHE DEFAULT
           )
NOPARALLEL;


CREATE UNIQUE INDEX PK_D_LOG_EXCHANGE ON D_LOG_EXCHANGE
(D_LOG_EXCHANGE_ID)
LOGGING
TABLESPACE USERS
PCTFREE    10
INITRANS   2
MAXTRANS   255
STORAGE    (
            INITIAL          20M
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
            FLASH_CACHE      DEFAULT
            CELL_FLASH_CACHE DEFAULT
           )
NOPARALLEL;


CREATE OR REPLACE TRIGGER T_IU_D_LOG_EXCHANGE 
--#Version=1
BEFORE INSERT ON D_LOG_EXCHANGE 
FOR EACH ROW
BEGIN 
  IF INSERTING THEN
    IF NVL(:NEW.D_LOG_EXCHANGE_ID, 0) = 0 then
      :NEW.D_LOG_EXCHANGE_ID := NEW_D_LOG_EXCHANGE_ID;
    END IF;
    :NEW.CHANGE_DATE := SYSDATE; 
    :NEW.USER_NAME := USER;
  END IF;
END;
/


ALTER TABLE D_LOG_EXCHANGE ADD (
  CONSTRAINT PK_D_LOG_EXCHANGE
  PRIMARY KEY
  (D_LOG_EXCHANGE_ID)
  USING INDEX PK_D_LOG_EXCHANGE
  ENABLE VALIDATE);
