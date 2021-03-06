ALTER TABLE D_PHONE_NUMBERS
 DROP PRIMARY KEY CASCADE;

DROP TABLE D_PHONE_NUMBERS CASCADE CONSTRAINTS;

--
-- D_PHONE_NUMBERS  (Table) 
--
CREATE TABLE D_PHONE_NUMBERS
(
  PHONE_NUMBER_ID          INTEGER              NOT NULL,
  PHONE_NUMBER             VARCHAR2(20 CHAR)    NOT NULL,
  OPERATOR_ID              INTEGER,
  HL                       VARCHAR2(10 CHAR),
  PRICE                    NUMBER,
  SIM_NUMBER1              VARCHAR2(20 CHAR),
  SIM_NUMBER2              VARCHAR2(20 CHAR),
  TARIFF_ID                INTEGER,
  CODE_WORD                VARCHAR2(100 CHAR),
  STATUS_ID                INTEGER,
  ABONENT_ID               INTEGER,
  USER_ID                  INTEGER,
  COMMENTS                 VARCHAR2(2000 CHAR),
  DELIVER_STARTED          DATE,
  DELIVER_FINISHED         DATE,
  DELIVER_ADDRESS          VARCHAR2(200 CHAR),
  DELIVER_CONTACT          VARCHAR2(100 CHAR),
  DELIVER_CONTACT_PHONE    VARCHAR2(20 CHAR),
  USER_CREATED             VARCHAR2(30 CHAR),
  DATE_CREATED             DATE,
  USER_LAST_UPDATED        VARCHAR2(30 CHAR),
  DATE_LAST_UPDATED        DATE,
  SURNAME                  VARCHAR2(30 CHAR),
  NAME                     VARCHAR2(30 CHAR),
  PATRONYMIC               VARCHAR2(30 CHAR),
  BDATE                    VARCHAR2(10 CHAR),
  PASSPORT_SER_NUM         VARCHAR2(20 CHAR),
  PASSPORT_DATE            VARCHAR2(10 CHAR),
  PASSPORT_GET             VARCHAR2(50 CHAR),
  CONTACT_PHONE            VARCHAR2(20 CHAR),
  MAIL                     VARCHAR2(100 CHAR),
  REGISTRATION             VARCHAR2(100 CHAR),
  DATE_LOAD                DATE,
  COMMENT_OPERATOR         VARCHAR2(2000 CHAR),
  USER_ID_OPERATOR         INTEGER,
  DATE_CHANGED_OPERATOR    DATE,
  DATE_CHANGED_CONTRAGENT  DATE,
  STATUS_ID_CONTRAGENT     INTEGER,
  STATUS_ID_OPERATOR       INTEGER,
  IS_ACTIVE                NUMBER(1)            DEFAULT 1,
  IS_ACTIVATED_1C          NUMBER(1),
  USER_ID_STORED           INTEGER,
  DATE_STORED              DATE,
  DATE_STORED_LOADED       DATE,
  DATE_ACTIVATION_LOADED   DATE,
  IS_ACTIVE_STORED         NUMBER(1),
  DATE_ACTIVATION          DATE,
  DESCRIPTION_CHANGED      VARCHAR2(255 CHAR),
  D_MAIN_STORE_ID          INTEGER
)
TABLESPACE USERS
RESULT_CACHE (MODE DEFAULT)
PCTUSED    0
PCTFREE    10
INITRANS   1
MAXTRANS   255
STORAGE    (
            INITIAL          11M
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

COMMENT ON TABLE D_PHONE_NUMBERS IS '���������� ������';

COMMENT ON COLUMN D_PHONE_NUMBERS.PHONE_NUMBER_ID IS '��������� ����';

COMMENT ON COLUMN D_PHONE_NUMBERS.PHONE_NUMBER IS '����� ��������';

COMMENT ON COLUMN D_PHONE_NUMBERS.OPERATOR_ID IS '��� ��������� ����� (�������, ���, ������...)';

COMMENT ON COLUMN D_PHONE_NUMBERS.PRICE IS '���������';

COMMENT ON COLUMN D_PHONE_NUMBERS.SIM_NUMBER1 IS '����� ��� ����� ������ �����';

COMMENT ON COLUMN D_PHONE_NUMBERS.SIM_NUMBER2 IS '����� ��� ����� ������ �����';

COMMENT ON COLUMN D_PHONE_NUMBERS.TARIFF_ID IS '��� ������';

COMMENT ON COLUMN D_PHONE_NUMBERS.CODE_WORD IS '������� �����';

COMMENT ON COLUMN D_PHONE_NUMBERS.STATUS_ID IS '��� �������� �������';

COMMENT ON COLUMN D_PHONE_NUMBERS.ABONENT_ID IS '���� �������� (���, ���������� ������...)';

COMMENT ON COLUMN D_PHONE_NUMBERS.USER_ID IS '��� ������������ (�����������, ������� ���� ����� � ������)';

COMMENT ON COLUMN D_PHONE_NUMBERS.COMMENTS IS '�����������';

COMMENT ON COLUMN D_PHONE_NUMBERS.DELIVER_STARTED IS '�������� �������� ����������� (����), ������� ���� ����� � ������';

COMMENT ON COLUMN D_PHONE_NUMBERS.DELIVER_FINISHED IS '�������� ��������� (����)';

COMMENT ON COLUMN D_PHONE_NUMBERS.DELIVER_ADDRESS IS '�����, ���� ����� ���������';

COMMENT ON COLUMN D_PHONE_NUMBERS.DELIVER_CONTACT IS '���������� ����, ���� ��������� ��� �����';

COMMENT ON COLUMN D_PHONE_NUMBERS.DELIVER_CONTACT_PHONE IS '���������� ������� ����, �������� ��������� ��� �����';

COMMENT ON COLUMN D_PHONE_NUMBERS.SURNAME IS '�������';

COMMENT ON COLUMN D_PHONE_NUMBERS.NAME IS '���';

COMMENT ON COLUMN D_PHONE_NUMBERS.PATRONYMIC IS '��������';

COMMENT ON COLUMN D_PHONE_NUMBERS.BDATE IS '���� ��������';

COMMENT ON COLUMN D_PHONE_NUMBERS.PASSPORT_SER_NUM IS '����� � ����� ��������';

COMMENT ON COLUMN D_PHONE_NUMBERS.PASSPORT_DATE IS '���� ������ ��������';

COMMENT ON COLUMN D_PHONE_NUMBERS.PASSPORT_GET IS '��� ����� �������';

COMMENT ON COLUMN D_PHONE_NUMBERS.CONTACT_PHONE IS '���������� �������';

COMMENT ON COLUMN D_PHONE_NUMBERS.MAIL IS '����� ����������� �����';

COMMENT ON COLUMN D_PHONE_NUMBERS.REGISTRATION IS '���������� (�����) ����������� ';

COMMENT ON COLUMN D_PHONE_NUMBERS.DATE_LOAD IS '���� ��������';

COMMENT ON COLUMN D_PHONE_NUMBERS.COMMENT_OPERATOR IS '����������� ���������';

COMMENT ON COLUMN D_PHONE_NUMBERS.USER_ID_OPERATOR IS '��������, ������������ ����� ���������';

COMMENT ON COLUMN D_PHONE_NUMBERS.DATE_CHANGED_OPERATOR IS '���� ��������� ����������';

COMMENT ON COLUMN D_PHONE_NUMBERS.DATE_CHANGED_CONTRAGENT IS '���� ��������� ������������';

COMMENT ON COLUMN D_PHONE_NUMBERS.STATUS_ID_CONTRAGENT IS '������, ������������� ������������';

COMMENT ON COLUMN D_PHONE_NUMBERS.STATUS_ID_OPERATOR IS '������, ������������� ����������';

COMMENT ON COLUMN D_PHONE_NUMBERS.IS_ACTIVATED_1C IS '������� ��������� ���� � 1� (��� ��������)';

COMMENT ON COLUMN D_PHONE_NUMBERS.USER_ID_STORED IS '��� ������������ (�����������), � �������� ��������� �������� �����';

COMMENT ON COLUMN D_PHONE_NUMBERS.DATE_STORED IS '����, ����� ����� ��������� �� ����� �����������';

COMMENT ON COLUMN D_PHONE_NUMBERS.DATE_STORED_LOADED IS '����, ����� ��������� ���������� �� �������� ������ �� ������ �����������';

COMMENT ON COLUMN D_PHONE_NUMBERS.IS_ACTIVE_STORED IS '1 - ���������� � �������� ������� (USER_ID_STORED, DATE_STORED, DATE_STORED_LOADED), ����� ��������� ��� ����� �� �������� �� ������ �����������.
  ��� �������� ������ �������� �����������, 
  - ���� ����� �������� �� ������ �����������, �� ��������� USER_ID_STORED, DATE_STORED, DATE_STORED_LOADED, IS_ACTIVE_STORED=1
  - ���� ����� ������� �� ������, ��������� ��� ����
  - ���� ����� ��� �� �������� �� ������ �����������, ������ IS_ACTIVE_STORED = 0 (��������� ���� ��������� ������������)
  ��� �������� ������� �� ����������� ������ 
  - ���� ����� ��� �� ������ ����������� (���� ��� IS_ACTIVE_STORED = 0)
      ������� ����� "���������", � ������� ���� USER_ID_STORED, DATE_STORED, DATE_STORED_LOADED, IS_ACTIVE_STORED      
  ';

COMMENT ON COLUMN D_PHONE_NUMBERS.DATE_ACTIVATION IS '���� ���������';

COMMENT ON COLUMN D_PHONE_NUMBERS.DESCRIPTION_CHANGED IS '�������� ������������, ����������� ������';

COMMENT ON COLUMN D_PHONE_NUMBERS.D_MAIN_STORE_ID IS '��� ������� ������������ ������ �� ������� ��������� �����';



--
-- I_D_PHONE_NUMBERS_ABONENT_ID  (Index) 
--
CREATE INDEX I_D_PHONE_NUMBERS_ABONENT_ID ON D_PHONE_NUMBERS
(ABONENT_ID)
LOGGING
TABLESPACE USERS
PCTFREE    10
INITRANS   2
MAXTRANS   255
STORAGE    (
            INITIAL          128K
            NEXT             1M
            MAXSIZE          UNLIMITED
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
            FLASH_CACHE      DEFAULT
            CELL_FLASH_CACHE DEFAULT
           )
NOPARALLEL;


--
-- I_D_PHONE_NUMBERS_DATE_LOAD  (Index) 
--
CREATE INDEX I_D_PHONE_NUMBERS_DATE_LOAD ON D_PHONE_NUMBERS
(DATE_LOAD)
LOGGING
TABLESPACE USERS
PCTFREE    10
INITRANS   2
MAXTRANS   255
STORAGE    (
            INITIAL          9M
            NEXT             1M
            MAXSIZE          UNLIMITED
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
            FLASH_CACHE      DEFAULT
            CELL_FLASH_CACHE DEFAULT
           )
NOPARALLEL;


--
-- I_D_PHONE_NUMBERS_MAIN_STORE  (Index) 
--
CREATE INDEX I_D_PHONE_NUMBERS_MAIN_STORE ON D_PHONE_NUMBERS
(D_MAIN_STORE_ID)
LOGGING
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
NOPARALLEL;


--
-- I_D_PHONE_NUMBERS_OPERATOR_ID  (Index) 
--
CREATE INDEX I_D_PHONE_NUMBERS_OPERATOR_ID ON D_PHONE_NUMBERS
(OPERATOR_ID)
LOGGING
TABLESPACE USERS
PCTFREE    10
INITRANS   2
MAXTRANS   255
STORAGE    (
            INITIAL          2M
            NEXT             1M
            MAXSIZE          UNLIMITED
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
            FLASH_CACHE      DEFAULT
            CELL_FLASH_CACHE DEFAULT
           )
NOPARALLEL;


--
-- I_D_PHONE_NUMBERS_PHONE_NUMBER  (Index) 
--
CREATE INDEX I_D_PHONE_NUMBERS_PHONE_NUMBER ON D_PHONE_NUMBERS
(PHONE_NUMBER)
LOGGING
TABLESPACE USERS
PCTFREE    10
INITRANS   2
MAXTRANS   255
STORAGE    (
            INITIAL          2M
            NEXT             1M
            MAXSIZE          UNLIMITED
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
            FLASH_CACHE      DEFAULT
            CELL_FLASH_CACHE DEFAULT
           )
NOPARALLEL;


--
-- I_D_PHONE_NUMBERS_SIM  (Index) 
--
CREATE INDEX I_D_PHONE_NUMBERS_SIM ON D_PHONE_NUMBERS
(SIM_NUMBER1, SIM_NUMBER2)
LOGGING
TABLESPACE USERS
PCTFREE    10
INITRANS   2
MAXTRANS   255
STORAGE    (
            INITIAL          640K
            NEXT             1M
            MAXSIZE          UNLIMITED
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
            FLASH_CACHE      DEFAULT
            CELL_FLASH_CACHE DEFAULT
           )
NOPARALLEL;


--
-- I_D_PHONE_NUMBERS_STATUS_ID  (Index) 
--
CREATE INDEX I_D_PHONE_NUMBERS_STATUS_ID ON D_PHONE_NUMBERS
(STATUS_ID)
LOGGING
TABLESPACE USERS
PCTFREE    10
INITRANS   2
MAXTRANS   255
STORAGE    (
            INITIAL          448K
            NEXT             1M
            MAXSIZE          UNLIMITED
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
            FLASH_CACHE      DEFAULT
            CELL_FLASH_CACHE DEFAULT
           )
NOPARALLEL;


--
-- I_D_PHONE_NUMBERS_STAT_ID_CNTR  (Index) 
--
CREATE INDEX I_D_PHONE_NUMBERS_STAT_ID_CNTR ON D_PHONE_NUMBERS
(STATUS_ID_CONTRAGENT)
LOGGING
TABLESPACE USERS
PCTFREE    10
INITRANS   2
MAXTRANS   255
STORAGE    (
            INITIAL          128K
            NEXT             1M
            MAXSIZE          UNLIMITED
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
            FLASH_CACHE      DEFAULT
            CELL_FLASH_CACHE DEFAULT
           )
NOPARALLEL;


--
-- I_D_PHONE_NUMBERS_STAT_ID_OPER  (Index) 
--
CREATE INDEX I_D_PHONE_NUMBERS_STAT_ID_OPER ON D_PHONE_NUMBERS
(STATUS_ID_OPERATOR)
LOGGING
TABLESPACE USERS
PCTFREE    10
INITRANS   2
MAXTRANS   255
STORAGE    (
            INITIAL          256K
            NEXT             1M
            MAXSIZE          UNLIMITED
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
            FLASH_CACHE      DEFAULT
            CELL_FLASH_CACHE DEFAULT
           )
NOPARALLEL;


--
-- I_D_PHONE_NUMBERS_TARIFF_ID  (Index) 
--
CREATE INDEX I_D_PHONE_NUMBERS_TARIFF_ID ON D_PHONE_NUMBERS
(TARIFF_ID)
LOGGING
TABLESPACE USERS
PCTFREE    10
INITRANS   2
MAXTRANS   255
STORAGE    (
            INITIAL          2M
            NEXT             1M
            MAXSIZE          UNLIMITED
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
            FLASH_CACHE      DEFAULT
            CELL_FLASH_CACHE DEFAULT
           )
NOPARALLEL;


--
-- I_D_PHONE_NUMBERS_USER_ID  (Index) 
--
CREATE INDEX I_D_PHONE_NUMBERS_USER_ID ON D_PHONE_NUMBERS
(USER_ID)
LOGGING
TABLESPACE USERS
PCTFREE    10
INITRANS   2
MAXTRANS   255
STORAGE    (
            INITIAL          448K
            NEXT             1M
            MAXSIZE          UNLIMITED
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
            FLASH_CACHE      DEFAULT
            CELL_FLASH_CACHE DEFAULT
           )
NOPARALLEL;


--
-- I_D_PHONE_NUMBERS_USER_ID_OPER  (Index) 
--
CREATE INDEX I_D_PHONE_NUMBERS_USER_ID_OPER ON D_PHONE_NUMBERS
(USER_ID_OPERATOR)
LOGGING
TABLESPACE USERS
PCTFREE    10
INITRANS   2
MAXTRANS   255
STORAGE    (
            INITIAL          128K
            NEXT             1M
            MAXSIZE          UNLIMITED
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
            FLASH_CACHE      DEFAULT
            CELL_FLASH_CACHE DEFAULT
           )
NOPARALLEL;


--
-- I_D_PHONE_NUMBERS_USER_ID_ST  (Index) 
--
CREATE INDEX I_D_PHONE_NUMBERS_USER_ID_ST ON D_PHONE_NUMBERS
(USER_ID_STORED)
LOGGING
TABLESPACE USERS
PCTFREE    10
INITRANS   2
MAXTRANS   255
STORAGE    (
            INITIAL          2M
            NEXT             1M
            MAXSIZE          UNLIMITED
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
            FLASH_CACHE      DEFAULT
            CELL_FLASH_CACHE DEFAULT
           )
NOPARALLEL;


--
-- PK_D_PHONE_NUMBERS  (Index) 
--
CREATE UNIQUE INDEX PK_D_PHONE_NUMBERS ON D_PHONE_NUMBERS
(PHONE_NUMBER_ID)
LOGGING
TABLESPACE USERS
PCTFREE    10
INITRANS   2
MAXTRANS   255
STORAGE    (
            INITIAL          1M
            NEXT             1M
            MAXSIZE          UNLIMITED
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
            FLASH_CACHE      DEFAULT
            CELL_FLASH_CACHE DEFAULT
           )
NOPARALLEL;


--
-- TIU_D_PHONE_NUMBERS  (Trigger) 
--
CREATE OR REPLACE TRIGGER TIU_D_PHONE_NUMBERS
--#Version=3
  BEFORE INSERT OR UPDATE OF PHONE_NUMBER, USER_ID, STATUS_ID ON D_PHONE_NUMBERS FOR EACH ROW
DECLARE
  vSTATUS_CODE D_STATUSES.STATUS_CODE%TYPE;
BEGIN
  IF INSTR(:NEW.PHONE_NUMBER, ' ') > 0 THEN
    :NEW.PHONE_NUMBER := REPLACE(:NEW.PHONE_NUMBER, ' ', '');
  END IF;
  -- ���� ����� ����� � ������ ���������� (��������������� USER_ID) �� ������������� DATE_CHANGED_OPERATOR
  IF (INSERTING AND :NEW.USER_ID IS NOT NULL)
    OR 
    (UPDATING 
     AND (:OLD.USER_ID IS NULL AND :NEW.USER_ID IS NOT NULL
          OR
          :OLD.USER_ID <> :NEW.USER_ID -- :OLD.USER_ID IS NOT NULL AND :NEW.USER_ID IS NOT NULL
         )
     )
  THEN
    :NEW.DATE_CHANGED_CONTRAGENT := SYSDATE;
  END IF;
  -- ��������� ���� ��������� ������
  BEGIN
    SELECT S.STATUS_CODE
      INTO vSTATUS_CODE 
      FROM D_STATUSES S
     WHERE S.STATUS_ID = :NEW.STATUS_ID;
  EXCEPTION WHEN NO_DATA_FOUND THEN
    vSTATUS_CODE := NULL;
  END;
  -- ��������� ���� ��������� (���� ������ �� ���������)
  IF vSTATUS_CODE IS NULL OR vSTATUS_CODE NOT IN ('ACTIVATED', 'ACTIVATED_1C') THEN
    :NEW.DATE_ACTIVATION := NULL;
  END IF;
END;
/


--
-- TIU_PHONE_NUMBERS  (Trigger) 
--
CREATE OR REPLACE TRIGGER TIU_PHONE_NUMBERS
--#Version=1
  BEFORE INSERT OR UPDATE ON D_PHONE_NUMBERS FOR EACH ROW
BEGIN
  IF INSERTING THEN
    IF NVL(:NEW.PHONE_NUMBER_ID, 0) = 0 then
      :NEW.PHONE_NUMBER_ID := NEW_D_PHONE_NUMBER_ID;
    END IF;
    :NEW.USER_CREATED := USER;
    :NEW.DATE_CREATED := SYSDATE;
  END IF;
  :NEW.USER_LAST_UPDATED := USER;
  :NEW.DATE_LAST_UPDATED := SYSDATE;
END;
/


--
-- TIUA_D_PHONE_NUMBERS  (Trigger) 
--
CREATE OR REPLACE TRIGGER TIUA_D_PHONE_NUMBERS
--#Version=2 
-- V2 - 12.01.2016 ������� �. - ����������� ������������������ ���������� �������� ����� TIU_PHONE_NUMBERS
  BEFORE INSERT OR UPDATE OF PHONE_NUMBER, USER_ID, STATUS_ID ON D_PHONE_NUMBERS FOR EACH ROW
  FOLLOWS TIU_PHONE_NUMBERS
BEGIN
  -- �������� �������� ������������ ������� ������� �����
  IF :NEW.DESCRIPTION_CHANGED IS NULL THEN
    BEGIN
      SELECT NVL(D.DESCRIPTION, D.USER_NAME)
        INTO :NEW.DESCRIPTION_CHANGED 
        FROM D_USER_NAMES D
       WHERE D.USER_ID = G_STATE.USER_ID;
    EXCEPTION WHEN NO_DATA_FOUND THEN
      :NEW.DESCRIPTION_CHANGED := '�� ��������� ('||USER||')';
    END;
  END IF;
  --
  IF INSERTING THEN
    IF :NEW.STATUS_ID IS NOT NULL THEN
      INSERT INTO D_PHONE_STATUS_HISTORIES(PHONE_NUMBER_ID, NEW_STATUS_ID, CONTRAGENT_USER_ID,
                                           USER_CHANGED_STATUS, CHANGED_USER_ID, CHANGED_USER_TYPE)
      VALUES (:NEW.PHONE_NUMBER_ID, :NEW.STATUS_ID, :NEW.USER_ID, 
              :NEW.DESCRIPTION_CHANGED, G_STATE.USER_ID, DECODE(G_STATE.IS_CONTRAGENT, 1, 1, DECODE(G_STATE.IS_ADMIN, 1, 7, 2)));
    END IF;
  ELSE
    IF NVL(:NEW.STATUS_ID, -1) <> NVL(:OLD.STATUS_ID, -1) THEN
      INSERT INTO D_PHONE_STATUS_HISTORIES(PHONE_NUMBER_ID, NEW_STATUS_ID, CONTRAGENT_USER_ID,
                                           USER_CHANGED_STATUS, CHANGED_USER_ID, CHANGED_USER_TYPE)
      VALUES (:NEW.PHONE_NUMBER_ID, :NEW.STATUS_ID, :NEW.USER_ID, 
              :NEW.DESCRIPTION_CHANGED, G_STATE.USER_ID, DECODE(G_STATE.IS_CONTRAGENT, 1, 1, DECODE(G_STATE.IS_ADMIN, 1, 7, 2)));
    END IF;
  END IF;
  -- ��� ����������� ������� 
  :NEW.DESCRIPTION_CHANGED := NULL;
END;
/


-- 
-- Non Foreign Key Constraints for Table D_PHONE_NUMBERS 
-- 
ALTER TABLE D_PHONE_NUMBERS ADD (
  CONSTRAINT PK_D_PHONE_NUMBERS
  PRIMARY KEY
  (PHONE_NUMBER_ID)
  USING INDEX PK_D_PHONE_NUMBERS
  ENABLE VALIDATE);

-- 
-- Foreign Key Constraints for Table D_PHONE_NUMBERS 
-- 
ALTER TABLE D_PHONE_NUMBERS ADD (
  CONSTRAINT FK_D_PHONE_NUMBERS_MAIN_STORE 
  FOREIGN KEY (D_MAIN_STORE_ID) 
  REFERENCES D_MAIN_STORES (D_MAIN_STORE_ID)
  ENABLE VALIDATE,
  CONSTRAINT FK_D_PHONE_NUMBERS_OPERATOR_ID 
  FOREIGN KEY (OPERATOR_ID) 
  REFERENCES D_OPERATORS (OPERATOR_ID)
  ENABLE VALIDATE,
  CONSTRAINT FK_D_PHONE_NUMBERS_STATUS_ID 
  FOREIGN KEY (STATUS_ID) 
  REFERENCES D_STATUSES (STATUS_ID)
  ENABLE VALIDATE,
  CONSTRAINT FK_D_PHONE_NUMBERS_STAT_ID_CN 
  FOREIGN KEY (STATUS_ID_CONTRAGENT) 
  REFERENCES D_STATUSES (STATUS_ID)
  ENABLE VALIDATE,
  CONSTRAINT FK_D_PHONE_NUMBERS_STAT_ID_OP 
  FOREIGN KEY (STATUS_ID_OPERATOR) 
  REFERENCES D_STATUSES (STATUS_ID)
  ENABLE VALIDATE,
  CONSTRAINT FK_D_PHONE_NUMBERS_TARIFF_ID 
  FOREIGN KEY (TARIFF_ID) 
  REFERENCES D_TARIFFS (TARIFF_ID)
  ENABLE VALIDATE,
  CONSTRAINT FK_D_PHONE_NUMBERS_USER_ID 
  FOREIGN KEY (USER_ID) 
  REFERENCES D_USER_NAMES (USER_ID)
  ENABLE VALIDATE,
  CONSTRAINT FK_D_PHONE_NUMBERS_USER_ID_OP 
  FOREIGN KEY (USER_ID_OPERATOR) 
  REFERENCES D_USER_NAMES (USER_ID)
  ENABLE VALIDATE,
  CONSTRAINT FK_D_PHONE_NUMBERS_USER_ID_ST 
  FOREIGN KEY (USER_ID_STORED) 
  REFERENCES D_USER_NAMES (USER_ID)
  ENABLE VALIDATE);

GRANT DELETE, INSERT, SELECT, UPDATE ON D_PHONE_NUMBERS TO WWW_DEALER_ROLE;
