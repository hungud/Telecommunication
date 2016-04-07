--DROP TABLE MF_SESSIONS;

-- ������ (����������� ����� ���������� ��������� ��� ������ �������� ��������)
-- ToDo: ����� ������������ �������� ���������� ������.
CREATE TABLE MF_SESSIONS (
  SESSION_ID number(12, 0),
  USER_ID NUMBER(8, 0),
  SESSION_KEY VARCHAR2(37 CHAR),
  START_DATE_TIME DATE,
  LAST_ACCESS_DATE_TIME DATE,
  IS_ADMIN NUMBER(1, 0) CONSTRAINT MF_CHK_SESSION_IS_ADMIN CHECK (IS_ADMIN IN (0, 1)),
  EXPIRED_FLAG NUMBER(1, 0) DEFAULT 0 CONSTRAINT MF_CHK_SESSION_EXPIRED_FLAG CHECK (EXPIRED_FLAG IN (0, 1)),
  PREV_ACCESS_DATE_TIME DATE, -- ����-����� ����������� ����������
  CONSTRAINT MF_PK_SESSIONS PRIMARY KEY (SESSION_ID)
--  CONSTRAINT MF_FK_SESSIONS_USER_ID FOREIGN KEY (USER_ID) REFERENCES MF_USER_NAMES
  ) /*TABLESPACE MF_DATA*/;
  
CREATE UNIQUE INDEX MF_SESSIONS_SESSION_KEY
  ON MF_SESSIONS (SESSION_KEY);

CREATE SEQUENCE MF_S_NEW_SESSION_ID NOCACHE;

CREATE INDEX I_MF_SESSIONS_USER_ID ON MF_SESSIONS (USER_ID) 
  COMPRESS 1;