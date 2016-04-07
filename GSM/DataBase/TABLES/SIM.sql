CREATE TABLE SIM
(
  SIM_ID              INTEGER                   NOT NULL,
  AGENT_ID            INTEGER                   NOT NULL,
  SUBAGENT_ID         INTEGER,
  OPERATOR_ID         INTEGER                   NOT NULL,
  DATE_INIT           DATE,
  STATUS_ID           INTEGER,
  DATE_MOVE           DATE,
  ACCOUNT             VARCHAR2(100 BYTE)        NOT NULL,
  CELL_NUMBER         VARCHAR2(10 BYTE)         NOT NULL,
  TARIFF_ID           INTEGER                   NOT NULL,
  SIM_NUMBER          VARCHAR2(100 BYTE),
  ABON_PAY            NUMBER(10,2)              DEFAULT 0,
  DATE_ACTIVATE       DATE,
  DATE_ERASE          DATE,
  BALANCE             NUMBER(10,2)              DEFAULT 0,
  DATE_BALANCE        DATE,
  DATE_LAST_ACTIVITY  DATE,
  SERVICEGID_STATUS   NUMBER(1)                 DEFAULT 0,
  CHECKED             NUMBER(1)                 DEFAULT 0                     NOT NULL
)
TABLESPACE USERS
PCTUSED    0
PCTFREE    10
INITRANS   1
MAXTRANS   255
STORAGE    (
            INITIAL          64K
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

COMMENT ON TABLE SIM IS '������ ���-����';

COMMENT ON COLUMN SIM.SIM_ID IS '��� ���-�����';

COMMENT ON COLUMN SIM.AGENT_ID IS '��� ������';

COMMENT ON COLUMN SIM.SUBAGENT_ID IS '��� ���������';

COMMENT ON COLUMN SIM.OPERATOR_ID IS '��� ���������';

COMMENT ON COLUMN SIM.DATE_INIT IS '���� ���������';

COMMENT ON COLUMN SIM.STATUS_ID IS '������1';

COMMENT ON COLUMN SIM.DATE_MOVE IS '���� �������� ���������';

COMMENT ON COLUMN SIM.ACCOUNT IS '������� ����';

COMMENT ON COLUMN SIM.CELL_NUMBER IS '����� ��������';

COMMENT ON COLUMN SIM.TARIFF_ID IS '�����';

COMMENT ON COLUMN SIM.SIM_NUMBER IS '����� ���-�����';

COMMENT ON COLUMN SIM.ABON_PAY IS '����������� �����';

COMMENT ON COLUMN SIM.DATE_ACTIVATE IS '���� ���������(�������� ��������)';

COMMENT ON COLUMN SIM.DATE_ERASE IS '���� ��������';

COMMENT ON COLUMN SIM.BALANCE IS '������';

COMMENT ON COLUMN SIM.DATE_BALANCE IS '���� �������� �������';

COMMENT ON COLUMN SIM.DATE_LAST_ACTIVITY IS '���� ���������� ��������� ��������(����������� ��� �������� �������� ���)';

COMMENT ON COLUMN SIM.SERVICEGID_STATUS IS '������ � ������-����';

COMMENT ON COLUMN SIM.CHECKED IS '0-�� ���������, 1-���������';


CREATE UNIQUE INDEX PK_SIM ON SIM
(SIM_ID)
LOGGING
TABLESPACE USERS
PCTFREE    10
INITRANS   2
MAXTRANS   255
STORAGE    (
            INITIAL          64K
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           )
NOPARALLEL;


CREATE UNIQUE INDEX UK_SIM_NUM_CELL_ACC ON SIM
(CELL_NUMBER, ACCOUNT, SIM_NUMBER)
LOGGING
TABLESPACE USERS
PCTFREE    10
INITRANS   2
MAXTRANS   255
STORAGE    (
            INITIAL          64K
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           )
NOPARALLEL;


CREATE UNIQUE INDEX UK_SIM_SIMNUMBER ON SIM
(SIM_NUMBER)
LOGGING
TABLESPACE USERS
PCTFREE    10
INITRANS   2
MAXTRANS   255
STORAGE    (
            INITIAL          64K
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           )
NOPARALLEL;

CREATE SEQUENCE S_NEW_SIM_ID;

CREATE OR REPLACE FUNCTION NEW_SIM_ID RETURN NUMBER IS
--#Version=1
  vRES NUMBER;
BEGIN
  SELECT S_NEW_SIM_ID.NEXTVAL
    INTO vRES
    FROM DUAL;
  RETURN vRES;
END;

CREATE OR REPLACE TRIGGER TI_SIM
  BEFORE INSERT ON SIM FOR EACH ROW
--#Version=1
BEGIN
  IF NVL(:NEW.SIM_ID, 0) = 0 then
    :NEW.SIM_ID := NEW_SIM_ID;
  END IF;  
  IF NVL(:NEW.SERVICEGID_STATUS, -1) = -1 then
    :NEW.SERVICEGID_STATUS:=1;
  END IF;  
END;

CREATE OR REPLACE TRIGGER tibr_sim
  before insert ON SIM   for each row
declare
begin
  select s_sim_id.nextval into :new.sim_id from dual;
end tibr_sim;
/


ALTER TABLE SIM ADD (
  CONSTRAINT PK_SIM
 PRIMARY KEY
 (SIM_ID)
    USING INDEX 
    TABLESPACE USERS
    PCTFREE    10
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                PCTINCREASE      0
               ),
  CONSTRAINT UK_SIM_NUM_CELL_ACC
 UNIQUE (CELL_NUMBER, ACCOUNT, SIM_NUMBER)
    USING INDEX 
    TABLESPACE USERS
    PCTFREE    10
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                PCTINCREASE      0
               ),
  CONSTRAINT UK_SIM_SIMNUMBER
 UNIQUE (SIM_NUMBER)
    USING INDEX 
    TABLESPACE USERS
    PCTFREE    10
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                PCTINCREASE      0
               ));

ALTER TABLE SIM ADD (
  CONSTRAINT FK_SIM_REF_AGENT 
 FOREIGN KEY (AGENT_ID) 
 REFERENCES AGENT (AGENT_ID),
  CONSTRAINT FK_SIM_REF_OPERATORS 
 FOREIGN KEY (OPERATOR_ID) 
 REFERENCES OPERATORS (OPERATOR_ID),
  CONSTRAINT FK_SIM_REF_SUBAGENT 
 FOREIGN KEY (SUBAGENT_ID) 
 REFERENCES SUBAGENT (SUBAGENT_ID),
  CONSTRAINT FK_SIM_REF_TARIFFS 
 FOREIGN KEY (TARIFF_ID) 
 REFERENCES TARIFFS (TARIFF_ID));
 
 ALTER TABLE SIM ADD (
  CONSTRAINT FK_SIM_STATUS_ID 
 FOREIGN KEY (STATUS_ID) 
 REFERENCES SIM_STATUSES(SIM_STATUS_ID));
 
ALTER TABLE SIM ADD PHONE_IS_ACTIVE INTEGER; 

COMMENT ON COLUMN SIM.PHONE_IS_ACTIVE IS '0 - ����������, 1 - �������';

GRANT DELETE, INSERT, SELECT, UPDATE ON SIM TO LONTANA_ROLE;