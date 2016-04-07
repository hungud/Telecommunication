CREATE TABLE FTP_SETTINGS 
(
  FTP_ID    INTEGER ,
  FTP_LOCAL_NAME VARCHAR2 (30) NOT NULL,
  FTP_ADDRESS VARCHAR2(30 CHAR),
  PORT           VARCHAR2(30 CHAR),
  LOGIN          VARCHAR2(30 CHAR),
  PASSWORD       VARCHAR2(30 CHAR),
  STATUS         NUMBER NOT NULL
);

COMMENT ON TABLE FTP_SETTINGS  IS '������� � ����������� ��� ����������� � FTP/SFTP ��������';
COMMENT ON COLUMN FTP_SETTINGS.FTP_ID  IS '������������� ������';
COMMENT ON COLUMN FTP_SETTINGS.FTP_LOCAL_NAME  IS '��������� ��� ������� (��� ����������� �������������)';
COMMENT ON COLUMN FTP_SETTINGS.FTP_ADDRESS  IS '����� �������';
COMMENT ON COLUMN FTP_SETTINGS.PORT IS '���� �������';
COMMENT ON COLUMN FTP_SETTINGS.LOGIN IS '����� ��� �����������';
COMMENT ON COLUMN FTP_SETTINGS.PASSWORD  IS '������ �������';
COMMENT ON COLUMN FTP_SETTINGS.STATUS  IS '������ (0 - �� �������; 1 - �������), � �������� � FTP_LOCAL_NAME ������ ���� ������������ ������� ������ ���� ������';

CREATE SEQUENCE S_FTP_SETTINGS
  START WITH 0
  MAXVALUE 999999999999999999999999999
  MINVALUE 0
  NOCYCLE
  CACHE 20
  NOORDER;

  
CREATE OR REPLACE TRIGGER TI_FTP_SETTINGS
--#Version=1
  BEFORE INSERT ON FTP_SETTINGS FOR EACH ROW
BEGIN
    :NEW.FTP_ID := S_FTP_SETTINGS.NEXTVAL;
END;  
