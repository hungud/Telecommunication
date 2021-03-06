CREATE TABLE ACTION_TYPE(
  ACTION_TYPE_ID Integer NOT NULL PRIMARY KEY,
  ACTION_NAME Varchar2(30 ) NOT NULL
)
/

  
COMMENT ON TABLE ACTION_TYPE IS '���� ������'
/
COMMENT ON COLUMN ACTION_TYPE.ACTION_TYPE_ID IS '������������� ������'
/
COMMENT ON COLUMN ACTION_TYPE.ACTION_NAME IS '�������� ���� ������'
/
CREATE SEQUENCE S_ACTION_TYPE_ID
  START WITH 1
  MAXVALUE 9999999999999999999999999999
  MINVALUE 1;
  
CREATE OR REPLACE TRIGGER TI_ACTION_TYPE
  BEFORE INSERT ON ACTION_TYPE
  REFERENCING NEW AS NEW OLD AS OLD
  FOR EACH ROW
BEGIN
  
  if nvl(:new.ACTION_TYPE_ID, 0) = 0 then
    :new.ACTION_TYPE_ID := S_ACTION_TYPE_ID.NEXTVAL;
  END IF;

END;
/  