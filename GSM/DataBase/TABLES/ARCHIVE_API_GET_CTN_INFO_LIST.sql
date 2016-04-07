CREATE TABLE ARCHIVE_API_GET_CTN_INFO_LIST(
  BAN NUMBER(10),
  CTN NUMBER(15),
  STATUSDATE VARCHAR2(25 Char),
  STATUS VARCHAR2(15 Char),
  PRICEPLAN VARCHAR2(15 Char),
  REASONSTATUS VARCHAR2(15 Char),
  LASTACTIVITY VARCHAR2(15 Char),
  ACTIVATIONDATE VARCHAR2(25 Char),
  SUBSCRIBERHLR VARCHAR2(15 Char),
  BEGIN_DATE DATE,
  END_DATE DATE,
  LAST_CHECK_DATE DATE
  ) TABLESPACE TS_ARCHIVE;
   
COMMENT ON TABLE ARCHIVE_API_GET_CTN_INFO_LIST IS '����� �������� �� ���'; 
COMMENT ON COLUMN ARCHIVE_API_GET_CTN_INFO_LIST.BAN IS '������� ����'; 
COMMENT ON COLUMN ARCHIVE_API_GET_CTN_INFO_LIST.CTN IS '����� ��������'; 
COMMENT ON COLUMN ARCHIVE_API_GET_CTN_INFO_LIST.STATUSDATE IS '���� ����� �������'; 
COMMENT ON COLUMN ARCHIVE_API_GET_CTN_INFO_LIST.STATUS IS '���/��'; 
COMMENT ON COLUMN ARCHIVE_API_GET_CTN_INFO_LIST.PRICEPLAN IS '��� ������'; 
COMMENT ON COLUMN ARCHIVE_API_GET_CTN_INFO_LIST.REASONSTATUS IS '��� �������'; 
COMMENT ON COLUMN ARCHIVE_API_GET_CTN_INFO_LIST.LASTACTIVITY IS '��� ����������'; 
COMMENT ON COLUMN ARCHIVE_API_GET_CTN_INFO_LIST.ACTIVATIONDATE IS '���� ���������'; 
COMMENT ON COLUMN ARCHIVE_API_GET_CTN_INFO_LIST.SUBSCRIBERHLR IS '��� HLR'; 
COMMENT ON COLUMN ARCHIVE_API_GET_CTN_INFO_LIST.BEGIN_DATE IS '���� ������'; 
COMMENT ON COLUMN ARCHIVE_API_GET_CTN_INFO_LIST.END_DATE IS '���� �����'; 
COMMENT ON COLUMN ARCHIVE_API_GET_CTN_INFO_LIST.LAST_CHECK_DATE IS '���� ���� ��������'; 
  
CREATE INDEX I_ARCH_API_GET_CTN_INFO_LIST 
  ON ARCHIVE_API_GET_CTN_INFO_LIST(BAN, CTN, END_DATE)
  TABLESPACE TS_ARCHIVE;