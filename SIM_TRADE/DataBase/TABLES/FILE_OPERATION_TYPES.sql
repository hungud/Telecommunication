CREATE TABLE FILE_OPERATION_TYPES
(
  FILE_OPERATION_TYPE_ID   INTEGER,
  OPERATION_NAME             VARCHAR2(50)
);

COMMENT ON TABLE FILE_OPERATION_TYPES IS '���������� �������� � �������';

COMMENT ON COLUMN FILE_OPERATION_TYPES.FILE_OPERATION_TYPE_ID IS '������������� ��������';
COMMENT ON COLUMN FILE_OPERATION_TYPES.OPERATION_NAME IS '�������� ��������';

CREATE SEQUENCE S_FILE_OPERATION_TYPES
  START WITH 0
  MAXVALUE 999999999999999999999999999
  MINVALUE 0
  NOCYCLE
  CACHE 20
  NOORDER;
  
CREATE OR REPLACE TRIGGER TI_FILE_OPERATION_TYPES
--#Version=1
  BEFORE INSERT ON FILE_OPERATION_TYPES FOR EACH ROW
BEGIN
    :NEW.FILE_OPERATION_TYPE_ID := S_FILE_OPERATION_TYPES.NEXTVAL;
END;
/  

INSERT INTO FILE_OPERATION_TYPES (OPERATION_NAME) VALUES ('��������');
INSERT INTO FILE_OPERATION_TYPES (OPERATION_NAME) VALUES ('�����������');
INSERT INTO FILE_OPERATION_TYPES (OPERATION_NAME) VALUES ('�����������');
INSERT INTO FILE_OPERATION_TYPES (OPERATION_NAME) VALUES ('��������');
INSERT INTO FILE_OPERATION_TYPES (OPERATION_NAME) VALUES ('����������������');

COMMIT;