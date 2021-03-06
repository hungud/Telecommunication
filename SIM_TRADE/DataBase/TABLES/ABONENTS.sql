--
-- ABONENTS  (Table) 
--
CREATE TABLE ABONENTS
(
  ABONENT_ID         NUMBER(38)                 NOT NULL,
  SURNAME            VARCHAR2(30 CHAR)          NOT NULL,
  NAME               VARCHAR2(30 CHAR)          NOT NULL,
  PATRONYMIC         VARCHAR2(30 CHAR),
  BDATE              DATE,
  PASSPORT_SER       VARCHAR2(10 CHAR),
  PASSPORT_NUM       VARCHAR2(10 CHAR),
  PASSPORT_DATE      DATE,
  PASSPORT_GET       VARCHAR2(100 CHAR),
  CITIZENSHIP        NUMBER(38),
  COUNTRY_ID         NUMBER(38),
  REGION_ID          NUMBER(38),
  REGION_NAME        VARCHAR2(100 CHAR),
  CITY_NAME          VARCHAR2(50 CHAR),
  STREET_NAME        VARCHAR2(50 CHAR),
  HOUSE              VARCHAR2(10 CHAR),
  KORPUS             VARCHAR2(10 CHAR),
  APARTMENT          VARCHAR2(10 CHAR),
  CONTACT_INFO       VARCHAR2(100 CHAR),
  CODE_WORD          VARCHAR2(50 CHAR),
  IS_VIP             NUMBER(1),
  USER_CREATED       VARCHAR2(30 CHAR),
  DATE_CREATED       DATE,
  USER_LAST_UPDATED  VARCHAR2(30 CHAR),
  DATE_LAST_UPDATED  DATE,
  EMAIL              VARCHAR2(100 BYTE)
);

ALTER TABLE ABONENTS ADD (DESCRIPTION  VARCHAR2(100 CHAR));

COMMENT ON TABLE ABONENTS IS '��������';

COMMENT ON COLUMN ABONENTS.DESCRIPTION IS '�����������';

COMMENT ON COLUMN ABONENTS.ABONENT_ID IS '��������� ����';

COMMENT ON COLUMN ABONENTS.SURNAME IS '�������';

COMMENT ON COLUMN ABONENTS.NAME IS '���';

COMMENT ON COLUMN ABONENTS.PATRONYMIC IS '��������';

COMMENT ON COLUMN ABONENTS.BDATE IS '���� ��������';

COMMENT ON COLUMN ABONENTS.PASSPORT_SER IS '����� ��������';

COMMENT ON COLUMN ABONENTS.PASSPORT_NUM IS '����� ��������';

COMMENT ON COLUMN ABONENTS.PASSPORT_DATE IS '���� ������ ��������';

COMMENT ON COLUMN ABONENTS.PASSPORT_GET IS '��� ����� �������';

COMMENT ON COLUMN ABONENTS.CITIZENSHIP IS '����������� (��� ������ �� ����������� �����)';

COMMENT ON COLUMN ABONENTS.COUNTRY_ID IS '��������: ������ (��� ������ �� ����������� �����)';

COMMENT ON COLUMN ABONENTS.REGION_ID IS '��������: ������ (��� ������� �� ����������� ��������)';

COMMENT ON COLUMN ABONENTS.REGION_NAME IS '��������: ������������ �������';

COMMENT ON COLUMN ABONENTS.CITY_NAME IS '��������: �����';

COMMENT ON COLUMN ABONENTS.STREET_NAME IS '��������: �����';

COMMENT ON COLUMN ABONENTS.HOUSE IS '��������: ���';

COMMENT ON COLUMN ABONENTS.KORPUS IS '��������: ������';

COMMENT ON COLUMN ABONENTS.APARTMENT IS '��������: ��������';

COMMENT ON COLUMN ABONENTS.CONTACT_INFO IS '���������� ���������� (������; �������� � ������������ ����)';

COMMENT ON COLUMN ABONENTS.CODE_WORD IS '������� �����';

COMMENT ON COLUMN ABONENTS.IS_VIP IS '������� VIP �������';

COMMENT ON COLUMN ABONENTS.USER_CREATED IS '������������, ��������� ������';

COMMENT ON COLUMN ABONENTS.DATE_CREATED IS '����/����� �������� ������';

COMMENT ON COLUMN ABONENTS.USER_LAST_UPDATED IS '������������, ��������������� ������ ���������';

COMMENT ON COLUMN ABONENTS.DATE_LAST_UPDATED IS '����/����� ��������� �������� ������';

COMMENT ON COLUMN ABONENTS.EMAIL IS 'E-mail ��������';


--
-- I_ABONENTS_BDATE  (Index) 
--


create index I_ABONENTS_SN_N_P on ABONENTS (ABONENT_ID, SURNAME, NAME, PATRONYMIC)
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
  
  
CREATE INDEX I_ABONENTS_BDATE ON ABONENTS
(BDATE)
LOGGING
TABLESPACE USERS
PCTFREE    10
INITRANS   2
MAXTRANS   255
STORAGE    (
            INITIAL          128K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           )
NOPARALLEL;


--
-- I_ABONENTS_CITIZENSHIP  (Index) 
--
CREATE INDEX I_ABONENTS_CITIZENSHIP ON ABONENTS
(CITIZENSHIP)
LOGGING
TABLESPACE USERS
PCTFREE    10
INITRANS   2
MAXTRANS   255
STORAGE    (
            INITIAL          320K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           )
NOPARALLEL;


--
-- I_ABONENTS_CITY_NAME  (Index) 
--
CREATE INDEX I_ABONENTS_CITY_NAME ON ABONENTS
(CITY_NAME)
LOGGING
TABLESPACE USERS
PCTFREE    10
INITRANS   2
MAXTRANS   255
STORAGE    (
            INITIAL          128K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           )
NOPARALLEL;


--
-- I_ABONENTS_COUNTRY_ID  (Index) 
--
CREATE INDEX I_ABONENTS_COUNTRY_ID ON ABONENTS
(COUNTRY_ID)
LOGGING
TABLESPACE USERS
PCTFREE    10
INITRANS   2
MAXTRANS   255
STORAGE    (
            INITIAL          320K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           )
NOPARALLEL;


--
-- I_ABONENTS_HOUSE  (Index) 
--
CREATE INDEX I_ABONENTS_HOUSE ON ABONENTS
(HOUSE)
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
           )
NOPARALLEL;


--
-- I_ABONENTS_NAME  (Index) 
--
CREATE INDEX I_ABONENTS_NAME ON ABONENTS
(NAME)
LOGGING
TABLESPACE USERS
PCTFREE    10
INITRANS   2
MAXTRANS   255
STORAGE    (
            INITIAL          2M
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           )
NOPARALLEL;


--
-- I_ABONENTS_PATRONYMIC  (Index) 
--
CREATE INDEX I_ABONENTS_PATRONYMIC ON ABONENTS
(PATRONYMIC)
LOGGING
TABLESPACE USERS
PCTFREE    10
INITRANS   2
MAXTRANS   255
STORAGE    (
            INITIAL          2M
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           )
NOPARALLEL;


--
-- I_ABONENTS_REGION_ID  (Index) 
--
CREATE INDEX I_ABONENTS_REGION_ID ON ABONENTS
(REGION_ID)
LOGGING
TABLESPACE USERS
PCTFREE    10
INITRANS   2
MAXTRANS   255
STORAGE    (
            INITIAL          320K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           )
NOPARALLEL;


--
-- I_ABONENTS_STREET_NAME  (Index) 
--
CREATE INDEX I_ABONENTS_STREET_NAME ON ABONENTS
(STREET_NAME)
LOGGING
TABLESPACE USERS
PCTFREE    10
INITRANS   2
MAXTRANS   255
STORAGE    (
            INITIAL          128K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           )
NOPARALLEL;


--
-- I_ABONENTS_SURNAME  (Index) 
--
CREATE INDEX I_ABONENTS_SURNAME ON ABONENTS
(SURNAME)
LOGGING
TABLESPACE USERS
PCTFREE    10
INITRANS   2
MAXTRANS   255
STORAGE    (
            INITIAL          2M
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           )
NOPARALLEL;


--
-- I_FAST  (Index) 
--
CREATE INDEX I_FAST ON ABONENTS
(ABONENT_ID, SURNAME, NAME, PATRONYMIC, BDATE, 
CONTACT_INFO)
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
           )
NOPARALLEL;


--
-- PK_ABONENTS  (Index) 
--
CREATE UNIQUE INDEX PK_ABONENTS ON ABONENTS
(ABONENT_ID)
LOGGING
TABLESPACE USERS
PCTFREE    10
INITRANS   2
MAXTRANS   255
STORAGE    (
            INITIAL          704K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           )
NOPARALLEL;


--
-- TIU_ABONENTS  (Trigger) 
--
CREATE OR REPLACE TRIGGER TIU_ABONENTS
  BEFORE INSERT OR UPDATE ON ABONENTS FOR EACH ROW
--#Version=1
BEGIN
  IF INSERTING THEN
    IF NVL(:NEW.ABONENT_ID, 0) = 0 then
      :NEW.ABONENT_ID := NEW_ABONENT_ID;
    END IF;
    :NEW.USER_CREATED := USER;
    :NEW.DATE_CREATED := SYSDATE;
  END IF;
  :NEW.USER_LAST_UPDATED := USER;
  :NEW.DATE_LAST_UPDATED := SYSDATE;
END;
/


-- 
-- Non Foreign Key Constraints for Table ABONENTS 
-- 
ALTER TABLE ABONENTS ADD (
  CONSTRAINT PK_ABONENTS
  PRIMARY KEY
  (ABONENT_ID)
  USING INDEX PK_ABONENTS);

ALTER TABLE ABONENTS ADD CONSTRAINT FK_ABONENT_COUNTRY_ID
FOREIGN KEY(COUNTRY_ID) REFERENCES COUNTRIES;

ALTER TABLE ABONENTS ADD CONSTRAINT FK_ABONENT_REGION_ID
FOREIGN KEY(REGION_ID) REFERENCES REGIONS;

GRANT DELETE, INSERT, SELECT, UPDATE ON ABONENTS TO CORP_MOBILE_COPY1;

GRANT DELETE, INSERT, SELECT, UPDATE ON ABONENTS TO CORP_MOBILE_ROLE;

GRANT SELECT ON ABONENTS TO CORP_MOBILE_ROLE_RO;

ALTER TABLE ABONENTS ADD DESCRIPTION VARCHAR2(100 CHAR);

-- ���������� ���� ��������
-- UPDATE ABONENTS SET DESCRIPTION = SURNAME||' '||NAME||' '||PATRONYMIC