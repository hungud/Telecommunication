CREATE TABLE FILE_TYPES(
  FILE_TYPE_ID Integer NOT NULL PRIMARY KEY,
  TYPE_NAME Varchar2(30 CHAR) NOT NULL
)
;
-- Table and Columns comments section
  
COMMENT ON TABLE FILE_TYPES IS '���� ����������� ������ (����� ��������. ����������� � �.�.)'
/
COMMENT ON COLUMN FILE_TYPES.FILE_TYPE_ID IS '������������� ������'
/
COMMENT ON COLUMN FILE_TYPES.TYPE_NAME IS '��� ������(��������, ���� ��������)'
/

CREATE SEQUENCE S_FILE_TYPE_ID
  START WITH 0
  MAXVALUE 999999999999999999999999999
  MINVALUE 0
  NOCYCLE
  NOCACHE
  NOORDER;  
  
CREATE OR REPLACE TRIGGER TI_FILE_TYPES
  BEFORE INSERT OR UPDATE ON FILE_TYPES FOR EACH ROW
--#Version=1
BEGIN
  IF NVL(:NEW.FILE_TYPE_ID, 0)=0 THEN
      :NEW.FILE_TYPE_ID := S_FILE_TYPE_ID.NEXTVAL;
  END IF;
END;
/ 

ALTER TABLE FILE_OPERATION_LOGS ADD CONSTRAINT FK_FILE_TYPE_ID FOREIGN KEY (FILE_TYPE_ID) REFERENCES FILE_TYPES (FILE_TYPE_ID);

GRANT SELECT, INSERT, DELETE, UPDATE ON PAYMENTS TO BUSINESS_COMM_ROLE;

INSERT INTO FILE_TYPES (TYPE_NAME) VALUES ('�������');
Commit;

