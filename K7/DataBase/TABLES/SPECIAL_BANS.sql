CREATE TABLE SPECIAL_BANS
(
  SPECIAL_BAN_ID           INTEGER PRIMARY KEY,
  SPECIAL_BAN_NAME         VARCHAR2(50 BYTE) NOT NULL,
  USER_CREATED       VARCHAR2(30 BYTE) NOT NULL,
  DATE_CREATED       DATE NOT NULL,
  USER_LAST_UPDATED  VARCHAR2(30 BYTE) NOT NULL,
  DATE_LAST_UPDATED  DATE NOT NULL
);

COMMENT ON TABLE SPECIAL_BANS IS '���������� ����� ����.�����';

COMMENT ON COLUMN SPECIAL_BANS.SPECIAL_BAN_ID IS '�� ������ ����.����';

COMMENT ON COLUMN SPECIAL_BANS.SPECIAL_BAN_NAME IS '������������ ������ ����. ����';

COMMENT ON COLUMN SPECIAL_BANS.USER_CREATED IS '������������, ��������� ������';

COMMENT ON COLUMN SPECIAL_BANS.DATE_CREATED IS '����/����� �������� ������';

COMMENT ON COLUMN SPECIAL_BANS.USER_LAST_UPDATED IS '������������, ��������������� ������ ���������';

COMMENT ON COLUMN SPECIAL_BANS.DATE_LAST_UPDATED IS '����/����� ��������� �������� ������';

CREATE SEQUENCE S_NEW_SPECIAL_BAN_ID
  START WITH 1
  MAXVALUE 999999999999999999999999999
  MINVALUE 1
  NOCYCLE
  CACHE 20
  NOORDER;

CREATE OR REPLACE TRIGGER TIU_SPECIAL_BANS
  BEFORE INSERT OR UPDATE ON SPECIAL_BANS FOR EACH ROW
--
--#Version=1
--
BEGIN
  IF INSERTING THEN
    IF NVL(:NEW.SPECIAL_BAN_ID, 0) = 0 THEN
      :NEW.SPECIAL_BAN_ID := S_NEW_SPECIAL_BAN_ID.NEXTVAL;
    END IF;
    :NEW.USER_CREATED := USER;
    :NEW.DATE_CREATED := SYSDATE;
  END IF;
  :NEW.USER_LAST_UPDATED := USER;
  :NEW.DATE_LAST_UPDATED := SYSDATE;
END;
/

GRANT DELETE, INSERT, SELECT, UPDATE ON SPECIAL_BANS TO CORP_MOBILE_ROLE;
GRANT DELETE, INSERT, SELECT, UPDATE ON SPECIAL_BANS TO CORP_MOBILE_ROLE_RO;