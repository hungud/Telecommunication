DROP TABLE VIRT_ACCOUNT_TEMP CASCADE CONSTRAINTS;

CREATE TABLE VIRT_ACCOUNT_TEMP
(
  INN        INTEGER,
  NAME       VARCHAR2(256 CHAR),
  EMAIL      VARCHAR2(100 CHAR),
  NUMBERS    VARCHAR2(256 CHAR),
  SERVICE01  INTEGER,
  SERVICE02  INTEGER,
  SERVICE03  INTEGER,
  SERVICE04  INTEGER,
  SERVICE05  INTEGER,
  SERVICE06  INTEGER,
  SERVICE07  INTEGER,
  SERVICE08  INTEGER,
  SERVICE09  INTEGER,
  SERVICE10  INTEGER,
  DBF_ID     NUMBER
);

COMMENT ON TABLE  VIRT_ACCOUNT_TEMP IS '������� ������������ �� dbf������ �� ����������� ������';
COMMENT ON COLUMN VIRT_ACCOUNT_TEMP.INN IS '���';
COMMENT ON COLUMN VIRT_ACCOUNT_TEMP.EMAIL IS '�-mail ����� ��� �������� ������������ ������';
COMMENT ON COLUMN VIRT_ACCOUNT_TEMP.NAME IS '�������� �������(��.����)';
COMMENT ON COLUMN VIRT_ACCOUNT_TEMP.NUMBERS IS '������ �������, ����������� �� ������� Enter (chr(13))';
COMMENT ON COLUMN VIRT_ACCOUNT_TEMP.SERVICE01 IS '������ 1 --  0 - ��� ������, 1 - ���� ������; �������� ������ ������ � ����������� �����';
COMMENT ON COLUMN VIRT_ACCOUNT_TEMP.SERVICE02 IS '������ 2';
COMMENT ON COLUMN VIRT_ACCOUNT_TEMP.SERVICE03 IS '������ 3';
COMMENT ON COLUMN VIRT_ACCOUNT_TEMP.SERVICE04 IS '������ 4';
COMMENT ON COLUMN VIRT_ACCOUNT_TEMP.SERVICE05 IS '������ 5';
COMMENT ON COLUMN VIRT_ACCOUNT_TEMP.SERVICE06 IS '������ 6';
COMMENT ON COLUMN VIRT_ACCOUNT_TEMP.SERVICE07 IS '������ 7';
COMMENT ON COLUMN VIRT_ACCOUNT_TEMP.SERVICE08 IS '������ 8';
COMMENT ON COLUMN VIRT_ACCOUNT_TEMP.SERVICE09 IS '������ 9';
COMMENT ON COLUMN VIRT_ACCOUNT_TEMP.SERVICE10 IS '������ 10';
COMMENT ON COLUMN VIRT_ACCOUNT_TEMP.DBF_ID IS '������ �� ����������� ����';
