--#if not TableExists("USER_NAMES") then
CREATE TABLE USER_NAMES
(
  USER_NAME_ID            INTEGER               NOT NULL,
  USER_FIO                VARCHAR2(400 CHAR),
  USER_NAME               VARCHAR2(120 CHAR),
  PASSWORD2               VARCHAR2(120 CHAR),
  FILIAL_ID               INTEGER,
  RIGHTS_TYPE             INTEGER,
  USER_NAME_CREATED       VARCHAR2(30 CHAR),
  DATE_CREATED            DATE,
  USER_NAME_LAST_UPDATED  VARCHAR2(30 CHAR),
  DATE_LAST_UPDATED       DATE
)
LOGGING 
NOCOMPRESS 
NOCACHE
NOPARALLEL
MONITORING;
--#end if

--#if GetTableComment("USER_NAMES")<>"������������" then
COMMENT ON TABLE USER_NAMES IS '������������';
--#end if

--#if GetColumnComment("USER_NAMES.USER_NAME_ID")<>"��������� ����" then
COMMENT ON COLUMN USER_NAMES.USER_NAME_ID IS '��������� ����';
--#end if

--#if GetColumnComment("USER_NAMES.USER_FIO")<>"��� ������������" then
COMMENT ON COLUMN USER_NAMES.USER_FIO IS '��� ������������';
--#end if

--#if GetColumnComment("USER_NAMES.USER_NAME")<>"��� ������������ Oracle" then
COMMENT ON COLUMN USER_NAMES.USER_NAME IS '��� ������������ Oracle';
--#end if

--#if GetColumnComment("USER_NAMES.PASSWORD2")<>"������ (�� ��������)" then
COMMENT ON COLUMN USER_NAMES.PASSWORD2 IS '������ (�� ��������)';
--#end if

--#if GetColumnComment("USER_NAMES.FILIAL_ID")<>"��� ������� �� ���������" then
COMMENT ON COLUMN USER_NAMES.FILIAL_ID IS '��� ������� �� ���������';
--#end if

--#if GetColumnComment("USER_NAMES.RIGHTS_TYPE")<>"��� ���� ������������� : 1 - �������������, 2 - ��������, 3 - ������ ���. �� ��������, ����� ������� ������������" then
COMMENT ON COLUMN USER_NAMES.RIGHTS_TYPE IS '��� ���� ������������� : 1 - �������������, 2 - ��������, 3 - ������ ���. �� ��������, ����� ������� ������������';
--#end if

--#if GetColumnComment("USER_NAMES.USER_NAME_CREATED")<>"������������, ��������� ������" then
COMMENT ON COLUMN USER_NAMES.USER_NAME_CREATED IS '������������, ��������� ������';
--#end if

--#if GetColumnComment("USER_NAMES.DATE_CREATED")<>"����/����� �������� ������" then
COMMENT ON COLUMN USER_NAMES.DATE_CREATED IS '����/����� �������� ������';
--#end if

--#if GetColumnComment("USER_NAMES.USER_NAME_LAST_UPDATED")<>"������������, ��������������� ������ ���������" then
COMMENT ON COLUMN USER_NAMES.USER_NAME_LAST_UPDATED IS '������������, ��������������� ������ ���������';
--#end if

--#if GetColumnComment("USER_NAMES.DATE_LAST_UPDATED")<>"����/����� ��������� �������� ������" then
COMMENT ON COLUMN USER_NAMES.DATE_LAST_UPDATED IS '����/����� ��������� �������� ������';
--#end if


--#if not ConstraintExists("PK_USER_NAMES") then
ALTER TABLE USER_NAMES ADD CONSTRAINT PK_USER_NAMES PRIMARY KEY (USER_NAME_ID);
--#end if

--#if not ConstraintExists("FK_USER_NAMES_FILIAL_ID") then
ALTER TABLE USER_NAMES ADD CONSTRAINT FK_USER_NAMES_FILIAL_ID 
 FOREIGN KEY (FILIAL_ID) REFERENCES FILIALS;
--#end if

--#if not IndexExists("I_USER_NAMES_FILIAL_ID") then
CREATE INDEX I_USER_NAMES_FILIAL_ID ON USER_NAMES (FILIAL_ID);
--#end if

--#if GetVersion("TIU_USER_NAMES")<1 then
CREATE OR REPLACE TRIGGER TIU_USER_NAMES
  BEFORE INSERT OR UPDATE ON USER_NAMES FOR EACH ROW
--#Version=1
BEGIN
  IF INSERTING THEN
    IF NVL(:NEW.USER_NAME_ID, 0) = 0 then
      :NEW.USER_NAME_ID := NEW_USER_NAME_ID;
    END IF;
    :NEW.USER_NAME_CREATED := USER;
    :NEW.DATE_CREATED := SYSDATE;
  END IF;
  :NEW.USER_NAME_LAST_UPDATED := USER;
  :NEW.DATE_LAST_UPDATED := SYSDATE;
END;
--#end if

--#if not ColumnExists("USER_NAMES.CHECK_ALLOW_ACCOUNT") then
ALTER TABLE USER_NAMES ADD CHECK_ALLOW_ACCOUNT NUMBER(1);
--#end if

--#if GetColumnComment("USER_NAMES.CHECK_ALLOW_ACCOUNT")<>"���� ��������. 1 - ��������� ������ ������������ � �/�" then
COMMENT ON COLUMN USER_NAMES.CHECK_ALLOW_ACCOUNT IS '���� ��������. 1 - ��������� ������ ������������ � �/�';
--#end if

--#if not ColumnExists("USER_NAMES.USER_NAME_OKTEL") AND ISClient("GSM_CORP") then
ALTER TABLE USER_NAMES ADD USER_NAME_OKTEL VARCHAR2(120 CHAR);
--#end if

--#if GetColumnComment("USER_NAMES.USER_NAME_OKTEL")<>"��� � Oktel" AND ISClient("GSM_CORP") then
COMMENT ON COLUMN USER_NAMES.USER_NAME_OKTEL IS '��� � IP ���������';
--#end if

--#if not ColumnExists("USER_NAMES.PASSWORD_OKTEL") and isclient("GSM_CORP") then
ALTER TABLE USER_NAMES ADD PASSWORD_OKTEL VARCHAR2(20 CHAR);
--#end if

--#if GetColumnComment("USER_NAMES.PASSWORD_OKTEL")<>"������ � IP ���������" and isclient("GSM_CORP") then
COMMENT ON COLUMN USER_NAMES.PASSWORD_OKTEL IS '������ � Oktel';
--#end if
              
--#if not ColumnExists("USER_NAMES.ENCRYPT_PWD") then
ALTER TABLE USER_NAMES ADD ENCRYPT_PWD NUMBER(1);
--#end if

--#if GetColumnComment("USER_NAMES.ENCRYPT_PWD")<>"1 - ����������� ������" then
COMMENT ON COLUMN USER_NAMES.ENCRYPT_PWD IS '1 - ����������� ������';
--#end if

--#if not ColumnExists("USER_NAMES.MAX_PROMISED_PAYMENT") then
ALTER TABLE USER_NAMES ADD MAX_PROMISED_PAYMENT NUMBER(15, 2);
--#end if

--#if GetColumnComment("USER_NAMES.MAX_PROMISED_PAYMENT")<>"������������ ��������� ������" then
COMMENT ON COLUMN USER_NAMES.MAX_PROMISED_PAYMENT IS '������������ ��������� ������';
--#end if

alter table USER_NAMES add
(
  RESPONSIBLE_STATUS NUMBER DEFAULT 1,
  LAST_ACTIVE TIMESTAMP 
);

COMMENT ON COLUMN  USER_NAMES.RESPONSIBLE_STATUS IS '�������� �� ������ ������������ ������������� �����. 1-��, 0-���';
COMMENT ON COLUMN  USER_NAMES.LAST_ACTIVE IS '����� ��������� ����������';