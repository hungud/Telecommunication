CREATE TABLE LONTANA.SIM_STATUS_HISTORY
( 
  SIM_STATUS_HISTORY_ID NUMBER,
  SIM_STATUS_ID         NUMBER,
  SIM_ID                NUMBER,
  USER_CREATED          VARCHAR2(30 BYTE),
  DATE_STATUS           DATE
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

COMMENT ON TABLE LONTANA.SIM_STATUS_HISTORY IS '������� sim-����';

COMMENT ON COLUMN LONTANA.SIM_STATUS_HISTORY.SIM_STATUS_HISTORY_ID IS '��������� ����';

COMMENT ON COLUMN LONTANA.SIM_STATUS_HISTORY.SIM_STATUS_ID IS '������������ �������';

COMMENT ON COLUMN LONTANA.SIM_STATUS_HISTORY.SIM_ID IS '������������ �����';

COMMENT ON COLUMN LONTANA.SIM_STATUS_HISTORY.USER_CREATED IS '������������, ��������� ������';

COMMENT ON COLUMN LONTANA.SIM_STATUS_HISTORY.DATE_STATUS IS '����/����� �������� ������';


CREATE UNIQUE INDEX LONTANA.PK_SIM_STATUS_HISTORY ON LONTANA.SIM_STATUS_HISTORY
(SIM_STATUS_HISTORY_ID)
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


CREATE SEQUENCE S_NEW_SIM_STATUS_HISTORY_ID
  START WITH 101
  MAXVALUE 999999999999999999999999999
  MINVALUE 1
  NOCYCLE
  CACHE 20
  NOORDER;
  

CREATE OR REPLACE FUNCTION NEW_SIM_STATUS_HISTORY_ID RETURN NUMBER IS
--#Version=1
  vRES NUMBER;
BEGIN
  SELECT S_NEW_SIM_STATUS_ID.NEXTVAL
    INTO vRES
    FROM DUAL;
  RETURN vRES;
END;

CREATE OR REPLACE TRIGGER LONTANA.TIU_SIM_STATUS_HISTORY
  BEFORE INSERT OR UPDATE ON LONTANA.SIM_STATUS_HISTORY FOR EACH ROW
BEGIN
  IF INSERTING THEN
    IF NVL(:NEW.SIM_STATUS_ID, 0) = 0 THEN
      :NEW.SIM_STATUS_ID := NEW_SIM_STATUS_HISTORY_ID;
    END IF;
    :NEW.USER_CREATED := USER;
    :NEW.DATE_STATUS := SYSDATE;
  END IF;
END;
/


ALTER TABLE LONTANA.SIM_STATUS_HISTORY ADD (
  CONSTRAINT PK_SIM_STATUSES
 PRIMARY KEY
 (SIM_STATUS_HISTORY_ID)
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
               
alter table SIM_STATUS_HISTORY add DESCR VARCHAR2(500 CHAR);               

GRANT DELETE, INSERT, SELECT, UPDATE ON LONTANA.SIM_STATUS_HISTORY TO LONTANA_ROLE;

GRANT DELETE, INSERT, SELECT, UPDATE ON LONTANA.SIM_STATUS_HISTORY TO DB_LOADER;