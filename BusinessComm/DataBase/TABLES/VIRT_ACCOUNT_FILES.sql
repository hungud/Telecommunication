CREATE TABLE VIRT_ACCOUNT_FILES
(
    FILE_ID            INTEGER,
  FILE_NAME          VARCHAR2(50 BYTE),
  LOAD_START_DATE    DATE,
  LOAD_END_DATE      DATE,
  USER_CREATE        VARCHAR2(30 CHAR),
  DATE_CREATE        DATE,
  PARSER_START_DATE  DATE,
  PARSER_END_DATE    DATE,
  ERROR_TEXT         VARCHAR2(256 CHAR)
);


COMMENT ON TABLE VIRT_ACCOUNT_FILES IS '������� � ������� ����������� ������';
/

COMMENT ON COLUMN VIRT_ACCOUNT_FILES.FILE_ID IS 'ID ������������ �����';
/

COMMENT ON COLUMN VIRT_ACCOUNT_FILES.FILE_NAME IS '��� �����';
/

COMMENT ON COLUMN VIRT_ACCOUNT_FILES.LOAD_START_DATE IS '����-����� ������ �������� �����';
/

COMMENT ON COLUMN VIRT_ACCOUNT_FILES.LOAD_END_DATE IS '����-����� ��������� �������� �����';
/

COMMENT ON COLUMN VIRT_ACCOUNT_FILES.USER_CREATE IS '��������� ������������';
/

COMMENT ON COLUMN VIRT_ACCOUNT_FILES.DATE_CREATE IS '���� ��������';
/

OMMENT ON COLUMN VIRT_ACCOUNT_FILES.PARSER_START_DATE IS '����-����� ������ ������� �����';

COMMENT ON COLUMN VIRT_ACCOUNT_FILES.PARSER_END_DATE IS '����-����� ��������� ������� �����';

COMMENT ON COLUMN VIRT_ACCOUNT_FILES.ERROR_TEXT IS '����� ������ �������';


CREATE INDEX I_VIRT_ACC_FILE_ID_FILE_NAME ON VIRT_ACCOUNT_FILES
(FILE_ID, FILE_NAME) COMPRESS 2;



CREATE SEQUENCE S_VIRT_ACCOUNT_FILES_ID
  START WITH 1
  MAXVALUE 9999999999999999999999999999
  MINVALUE 1
  NOCYCLE
  NOCACHE
  NOORDER;
  
CREATE OR REPLACE TRIGGER TI_VIRT_ACCOUNT_FILES
  BEFORE INSERT ON VIRT_ACCOUNT_FILES FOR EACH ROW
BEGIN
    
    if nvl(:NEW.FILE_ID, 0) = 0 then
      :NEW.FILE_ID := S_VIRT_ACCOUNT_FILES_ID.Nextval;
    end if;
    :NEW.DATE_CREATE := SYSDATE;
    :NEW.USER_CREATE := USER;
    
END;
/


ALTER TABLE VIRT_ACCOUNT_FILES ADD PRIMARY KEY
  (FILE_ID) ENABLE VALIDATE;
 / 

GRANT SELECT ON VIRT_ACCOUNT_FILES TO BUSINESS_COMM_ROLE;

GRANT SELECT ON S_VIRT_ACCOUNT_FILES_ID TO BUSINESS_COMM_ROLE;