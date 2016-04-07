--#if not TableExists("DELAYED_ON_OFF_TARIFF_OPTIONS") then
CREATE TABLE DELAYED_ON_OFF_TARIFF_OPTIONS(
  DELAYED_TURN_TO_ID  INTEGER NOT NULL,
  PHONE_NUMBER        VARCHAR2(10)  not null,
  OPTION_CODE         VARCHAR2(30 CHAR)  not null,
  ACTION_TYPE             NUMBER(1) not null,
  ACTION_DATE            DATE  not null,
  DATE_CREATED           DATE,  
  USER_CREATED           VARCHAR2(30),
  DATE_LAST_UPDATED           DATE,  
  USER_LAST_UPDATED           VARCHAR2(30)
  );

COMMENT ON TABLE DELAYED_ON_OFF_TARIFF_OPTIONS IS '������� �� ���������� ����������� / ���������� �����';
COMMENT ON COLUMN DELAYED_ON_OFF_TARIFF_OPTIONS.DELAYED_TURN_TO_ID IS '��������� ����';
COMMENT ON COLUMN DELAYED_ON_OFF_TARIFF_OPTIONS.PHONE_NUMBER IS '����� ��������';
COMMENT ON COLUMN DELAYED_ON_OFF_TARIFF_OPTIONS.OPTION_CODE IS '��� �����';
COMMENT ON COLUMN DELAYED_ON_OFF_TARIFF_OPTIONS.ACTION_TYPE IS '��� �������� ( 0 - ����. / 1 - �����.)';
COMMENT ON COLUMN DELAYED_ON_OFF_TARIFF_OPTIONS.ACTION_DATE IS '����, ����� ������ ������ ���� ���������/����������';
COMMENT ON COLUMN DELAYED_ON_OFF_TARIFF_OPTIONS.DATE_CREATED IS '���� �������� ������';
COMMENT ON COLUMN DELAYED_ON_OFF_TARIFF_OPTIONS.USER_CREATED IS '��� ������������, ���������� ������';
COMMENT ON COLUMN DELAYED_ON_OFF_TARIFF_OPTIONS.DATE_LAST_UPDATED IS '���� ���������� ���������� ������';
COMMENT ON COLUMN DELAYED_ON_OFF_TARIFF_OPTIONS.USER_LAST_UPDATED IS '��� ������������, ����������� ������ ��������� ������';

--#end if

ALTER TABLE DELAYED_ON_OFF_TARIFF_OPTIONS ADD CONSTRAINT PK_DEL_ON_OFF_TARIFF_OPTIONS PRIMARY KEY (DELAYED_TURN_TO_ID);

CREATE INDEX I_DELAYED_ON_OFF_TARIFF_OPT_PN ON DELAYED_ON_OFF_TARIFF_OPTIONS(PHONE_NUMBER);

CREATE SEQUENCE S_NEW_DELAYED_TURN_TO_ID
START WITH 1 MAXVALUE 999999999999999999999999999
MINVALUE 1
NOCYCLE
CACHE 20
NOORDER;

CREATE OR REPLACE TRIGGER TIU_DELAYED_TURN_TARIFF_OPT
  BEFORE INSERT OR UPDATE ON DELAYED_ON_OFF_TARIFF_OPTIONS FOR EACH ROW
BEGIN
  
  IF INSERTING THEN  

    IF NVL(:NEW.DELAYED_TURN_TO_ID, 0) = 0 THEN
      :NEW.DELAYED_TURN_TO_ID := S_NEW_DELAYED_TURN_TO_ID.NEXTVAL;
    END IF;
    :NEW.USER_CREATED := USER;
    :NEW.DATE_CREATED := SYSDATE;
  END IF;
  IF UPDATING THEN
    :NEW.USER_LAST_UPDATED := USER;
    :NEW.DATE_LAST_UPDATED := SYSDATE;
  END IF;
  
END;

GRANT SELECT, UPDATE, INSERT, DELETE ON DELAYED_ON_OFF_TARIFF_OPTIONS TO CORP_MOBILE_ROLE;
GRANT SELECT ON DELAYED_ON_OFF_TARIFF_OPTIONS TO CORP_MOBILE_ROLE;