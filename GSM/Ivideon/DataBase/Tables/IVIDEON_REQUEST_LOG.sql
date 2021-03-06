CREATE TABLE IVIDEON_REQUEST_LOG
(
  REQUEST_ID INTEGER PRIMARY KEY,
  ORIGINAL_URL VARCHAR2(500 CHAR) not null,
  URL_PARAMETRS VARCHAR2(2000 CHAR),
  USER_CREATED VARCHAR2(30 CHAR),
  DATE_CREATED DATE
);

COMMENT ON TABLE IVIDEON_REQUEST_LOG IS '��� �������� �� Ivideon';

COMMENT ON COLUMN IVIDEON_REQUEST_LOG.REQUEST_ID IS '�� �������';

COMMENT ON COLUMN IVIDEON_REQUEST_LOG.ORIGINAL_URL IS '������������ ������';

COMMENT ON COLUMN IVIDEON_REQUEST_LOG.URL_PARAMETRS IS '���������� ���������';

COMMENT ON COLUMN IVIDEON_REQUEST_LOG.USER_CREATED IS '��������� ������������';

COMMENT ON COLUMN IVIDEON_REQUEST_LOG.DATE_CREATED IS '���� ��������';


CREATE SEQUENCE S_IVIDEON_REQUEST_ID
  START WITH 1
  MAXVALUE 9999999999999999999999999999
  MINVALUE 1;
  
CREATE OR REPLACE TRIGGER TI_IVIDEON_REQUEST_LOG
  BEFORE INSERT ON IVIDEON_REQUEST_LOG
  REFERENCING NEW AS NEW OLD AS OLD
  FOR EACH ROW
BEGIN
  
  if nvl(:new.REQUEST_ID, 0) = 0 then
    :new.REQUEST_ID := S_IVIDEON_REQUEST_ID.NEXTVAL;
  END IF;
  
  :NEW.USER_CREATED := USER;
  :NEW.DATE_CREATED := SYSDATE; 

END;
/  