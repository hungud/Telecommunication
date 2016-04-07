ALTER TABLE SIM_JOURNAL
 DROP PRIMARY KEY CASCADE;
DROP TABLE SIM_JOURNAL CASCADE CONSTRAINTS;

CREATE TABLE SIM_JOURNAL
(
  SIM_JOURNAL_ID      INTEGER                   NOT NULL,
  AGENT_ID            INTEGER,
  SUB_AGENT_ID        INTEGER,
  OPERATOR_ID         INTEGER,
  ACCOUNT             VARCHAR2(20 BYTE),
  PHONE_NUM           VARCHAR2(10 CHAR),
  TARIFF_ID           INTEGER,
  SERIAL_NUM          VARCHAR2(32 CHAR),
  USER_CREATED        VARCHAR2(30 CHAR),
  DATE_CREATED        DATE,
  USER_LAST_UPDATED   VARCHAR2(30 CHAR),
  DATE_LAST_UPDATED   DATE,
  SUB_AGENT_DATE      DATE,
  INIT_DATE           DATE,
  BALANS              NUMBER(10,2),
  BALANS_DATE         DATE,
  LAST_ACTIVITY_DATE  DATE,
  SERVICE_GID_STATE   NUMBER(1)                 DEFAULT 0
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

COMMENT ON TABLE SIM_JOURNAL IS '������ ����� SIM-����';

COMMENT ON COLUMN SIM_JOURNAL.INIT_DATE IS '���� �����������';

COMMENT ON COLUMN SIM_JOURNAL.BALANS IS '������';

COMMENT ON COLUMN SIM_JOURNAL.BALANS_DATE IS '��������� ���� �������� �������';

COMMENT ON COLUMN SIM_JOURNAL.LAST_ACTIVITY_DATE IS '���� ���������� ��������� ��������';

COMMENT ON COLUMN SIM_JOURNAL.SERVICE_GID_STATE IS '0-������ ������, 1-���������� ������';

COMMENT ON COLUMN SIM_JOURNAL.SUB_AGENT_DATE IS '���� �������� ���������';

COMMENT ON COLUMN SIM_JOURNAL.SIM_JOURNAL_ID IS '��������� ����';

COMMENT ON COLUMN SIM_JOURNAL.AGENT_ID IS '��� ������';

COMMENT ON COLUMN SIM_JOURNAL.SUB_AGENT_ID IS '��� ���������';

COMMENT ON COLUMN SIM_JOURNAL.OPERATOR_ID IS '��� ��������� ������� �����';

COMMENT ON COLUMN SIM_JOURNAL.ACCOUNT IS '� �������� �����';

COMMENT ON COLUMN SIM_JOURNAL.PHONE_NUM IS '� ��������';

COMMENT ON COLUMN SIM_JOURNAL.TARIFF_ID IS '��� ��������� �����';

COMMENT ON COLUMN SIM_JOURNAL.SERIAL_NUM IS '�������� ����� �����';

COMMENT ON COLUMN SIM_JOURNAL.USER_CREATED IS '������������, ��������� ������';

COMMENT ON COLUMN SIM_JOURNAL.DATE_CREATED IS '����/����� �������� ������';

COMMENT ON COLUMN SIM_JOURNAL.USER_LAST_UPDATED IS '������������, ��������������� ������ ���������';

COMMENT ON COLUMN SIM_JOURNAL.DATE_LAST_UPDATED IS '����/����� ��������� �������� ������';


CREATE INDEX I_SIM_JOURNAL_SUB_AGENT_ID ON SIM_JOURNAL
(SUB_AGENT_ID)
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


CREATE INDEX I_SIM_JOURNAL_OPERATOR_ID ON SIM_JOURNAL
(OPERATOR_ID)
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


CREATE UNIQUE INDEX PK_SIM_JOURNAL ON SIM_JOURNAL
(SIM_JOURNAL_ID)
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


CREATE INDEX I_SIM_JOURNAL_AGENT_ID ON SIM_JOURNAL
(AGENT_ID)
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


CREATE SEQUENCE S_NEW_SIM_JOURNAL_ID
  START WITH 101
  MAXVALUE 999999999999999999999999999
  MINVALUE 1
  NOCYCLE
  CACHE 20
  NOORDER;
  

CREATE OR REPLACE FUNCTION NEW_SIM_JOURNAL_ID RETURN NUMBER IS
--#Version=1
  vRES NUMBER;
BEGIN
  SELECT S_NEW_SIM_JOURNAL_ID.NEXTVAL
    INTO vRES
    FROM DUAL;
  RETURN vRES;
END;


CREATE OR REPLACE TRIGGER TIU_SIM_JOURNAL
BEFORE INSERT OR UPDATE ON SIM_JOURNAL FOR EACH ROW
--#Version=1
BEGIN
  IF INSERTING THEN
    IF NVL(:NEW.SIM_JOURNAL_ID, 0) = 0 then
      :NEW.SIM_JOURNAL_ID := NEW_SIM_JOURNAL_ID;
    END IF;
    :NEW.USER_CREATED := USER;
    :NEW.DATE_CREATED := SYSDATE;
  END IF;
  :NEW.USER_LAST_UPDATED := USER;
  :NEW.DATE_LAST_UPDATED := SYSDATE;
END;
/


ALTER TABLE SIM_JOURNAL ADD (
  CONSTRAINT PK_SIM_JOURNAL
 PRIMARY KEY
 (SIM_JOURNAL_ID)
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

ALTER TABLE SIM_JOURNAL ADD (
  CONSTRAINT FK_SIM_JOURNAL_OPERATOR_ID 
 FOREIGN KEY (OPERATOR_ID) 
 REFERENCES OPERATORS (OPERATOR_ID));

GRANT DELETE, INSERT, SELECT, UPDATE ON SIM_JOURNAL TO LONTANA_ROLE;