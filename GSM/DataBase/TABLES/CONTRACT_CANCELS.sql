CREATE TABLE CONTRACT_CANCELS
(
  CONTRACT_CANCEL_ID       NUMBER(38)           NOT NULL,
  CONTRACT_ID              NUMBER(38)           NOT NULL,
  FILIAL_ID                NUMBER(38),
  CONTRACT_CANCEL_DATE     DATE                 NOT NULL,
  CONTRACT_CANCEL_TYPE_ID  NUMBER(38),
  SUM_GET                  NUMBER,
  SUM_PUT                  NUMBER,
  USER_CREATED             VARCHAR2(30 CHAR),
  DATE_CREATED             DATE,
  USER_LAST_UPDATED        VARCHAR2(30 CHAR),
  DATE_LAST_UPDATED        DATE,
  CONFIRMED                NUMBER(1)
);

COMMENT ON TABLE CONTRACT_CANCELS IS '����������� ���������';

COMMENT ON COLUMN CONTRACT_CANCELS.SUM_PUT IS '����� ����������� �������';

COMMENT ON COLUMN CONTRACT_CANCELS.USER_CREATED IS '������������, ��������� ������';

COMMENT ON COLUMN CONTRACT_CANCELS.DATE_CREATED IS '����/����� �������� ������';

COMMENT ON COLUMN CONTRACT_CANCELS.USER_LAST_UPDATED IS '������������, ��������������� ������ ���������';

COMMENT ON COLUMN CONTRACT_CANCELS.DATE_LAST_UPDATED IS '����/����� ��������� �������� ������';

COMMENT ON COLUMN CONTRACT_CANCELS.CONFIRMED IS '1 - �������� ��������';

COMMENT ON COLUMN CONTRACT_CANCELS.CONTRACT_CANCEL_ID IS '��������� ����';

COMMENT ON COLUMN CONTRACT_CANCELS.CONTRACT_ID IS '��� ���������';

COMMENT ON COLUMN CONTRACT_CANCELS.FILIAL_ID IS '��� �������';

COMMENT ON COLUMN CONTRACT_CANCELS.CONTRACT_CANCEL_DATE IS '���� ����������� ���������';

COMMENT ON COLUMN CONTRACT_CANCELS.CONTRACT_CANCEL_TYPE_ID IS '��� ������� ����������� ��������';

COMMENT ON COLUMN CONTRACT_CANCELS.SUM_GET IS '����� ���������� �� �������';


--
-- I_CONTRACT_CANCELS_CONTRACT_ID  (Index) 
--
CREATE UNIQUE INDEX I_CONTRACT_CANCELS_CONTRACT_ID ON CONTRACT_CANCELS
(CONTRACT_ID)
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
-- I_CONTRACT_CANCELS_FILIAL_ID  (Index) 
--
CREATE INDEX I_CONTRACT_CANCELS_FILIAL_ID ON CONTRACT_CANCELS
(FILIAL_ID)
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
-- I_CONTRACT_CANCELS_TYPE_ID  (Index) 
--
CREATE INDEX I_CONTRACT_CANCELS_TYPE_ID ON CONTRACT_CANCELS
(CONTRACT_CANCEL_TYPE_ID)
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
-- I_CONTRACT_CNLS_C_ID_C_CNL_DT  (Index) 
--
CREATE INDEX I_CONTRACT_CNLS_C_ID_C_CNL_DT ON CONTRACT_CANCELS
(CONTRACT_ID, CONTRACT_CANCEL_DATE)
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
-- PK_CONTRACT_CANCELS  (Index) 
--
CREATE UNIQUE INDEX PK_CONTRACT_CANCELS ON CONTRACT_CANCELS
(CONTRACT_CANCEL_ID)
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
-- TIU_CONTRACT_CANCELS  (Trigger) 
--
CREATE OR REPLACE TRIGGER TIU_CONTRACT_CANCELS
  BEFORE INSERT OR UPDATE ON CONTRACT_CANCELS FOR EACH ROW
--#Version=1
BEGIN
  IF INSERTING THEN
    IF NVL(:NEW.CONTRACT_CANCEL_ID, 0) = 0 then
      :NEW.CONTRACT_CANCEL_ID := NEW_CONTRACT_CANCEL_ID;
    END IF;
    :NEW.USER_CREATED := USER;
    :NEW.DATE_CREATED := SYSDATE;
  END IF;
  :NEW.USER_LAST_UPDATED := USER;
  :NEW.DATE_LAST_UPDATED := SYSDATE;
  UPDATE CONTRACTS CT 
    SET CURR_TARIFF_ID=-1 
    WHERE CT.CONTRACT_ID=:NEW.CONTRACT_ID;
  DELETE PHONE_NUMBER_WITH_DAILY_ABON D
    WHERE D.PHONE_NUMBER = (SELECT C.PHONE_NUMBER_FEDERAL 
                              FROM CONTRACTS C
                              WHERE C.CONTRACT_ID = :NEW.CONTRACT_ID);
END;
/


-- 
-- Non Foreign Key Constraints for Table CONTRACT_CANCELS 
-- 
ALTER TABLE CONTRACT_CANCELS ADD (
  CONSTRAINT PK_CONTRACT_CANCELS
  PRIMARY KEY
  (CONTRACT_CANCEL_ID)
  USING INDEX PK_CONTRACT_CANCELS);

ALTER TABLE CONTRACT_CANCELS ADD (RECEIVED_PAYMENT_ID NUMBER(38));

COMMENT ON COLUMN CONTRACT_CANCELS.RECEIVED_PAYMENT_ID IS '������ �� ������� ������ ��������';

GRANT DELETE, INSERT, SELECT, UPDATE ON CONTRACT_CANCELS TO CORP_MOBILE_COPY;

GRANT DELETE, INSERT, SELECT, UPDATE ON CONTRACT_CANCELS TO CORP_MOBILE_COPY3;

GRANT DELETE, INSERT, SELECT, UPDATE ON CONTRACT_CANCELS TO CORP_MOBILE_ROLE;

GRANT SELECT ON CONTRACT_CANCELS TO CORP_MOBILE_ROLE_RO;


