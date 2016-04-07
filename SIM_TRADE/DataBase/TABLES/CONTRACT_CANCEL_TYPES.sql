CREATE TABLE CONTRACT_CANCEL_TYPES
(
  CONTRACT_CANCEL_TYPE_ID    INTEGER            NOT NULL,
  CONTRACT_CANCEL_TYPE_NAME  VARCHAR2(100 CHAR),
  USER_CREATED               VARCHAR2(30 CHAR),
  DATE_CREATED               DATE,
  USER_LAST_UPDATED          VARCHAR2(30 CHAR),
  DATE_LAST_UPDATED          DATE
);

COMMENT ON TABLE CONTRACT_CANCEL_TYPES IS '������� ����������� ��������';

COMMENT ON COLUMN CONTRACT_CANCEL_TYPES.CONTRACT_CANCEL_TYPE_ID IS '��������� ����';

COMMENT ON COLUMN CONTRACT_CANCEL_TYPES.CONTRACT_CANCEL_TYPE_NAME IS '������������ ';

COMMENT ON COLUMN CONTRACT_CANCEL_TYPES.USER_CREATED IS '������������, ��������� ������';

COMMENT ON COLUMN CONTRACT_CANCEL_TYPES.DATE_CREATED IS '����/����� �������� ������';

COMMENT ON COLUMN CONTRACT_CANCEL_TYPES.USER_LAST_UPDATED IS '������������, ��������������� ������ ���������';

COMMENT ON COLUMN CONTRACT_CANCEL_TYPES.DATE_LAST_UPDATED IS '����/����� ��������� �������� ������';



CREATE UNIQUE INDEX PK_CONTRACT_CANCEL_TYPES ON CONTRACT_CANCEL_TYPES
(CONTRACT_CANCEL_TYPE_ID);

CREATE SEQUENCE S_NEW_CONTRACT_CANCEL_TYPE_ID
  START WITH 1
  MAXVALUE 999999999999999999999999999
  MINVALUE 1;

CREATE OR REPLACE FUNCTION NEW_CONTRACT_CANCEL_TYPE_ID
   RETURN NUMBER
IS
   --#Version=1
   vRES   NUMBER;
BEGIN
   SELECT S_NEW_CONTRACT_CANCEL_TYPE_ID.NEXTVAL INTO vRES FROM DUAL;

   RETURN vRES;
END;
/



CREATE OR REPLACE TRIGGER TIU_CONTRACT_CANCEL_TYPES
--#Version=1
  BEFORE INSERT OR UPDATE ON CONTRACT_CANCEL_TYPES FOR EACH ROW
BEGIN
  IF INSERTING THEN
    IF NVL(:NEW.CONTRACT_CANCEL_TYPE_ID, 0) = 0 then
      :NEW.CONTRACT_CANCEL_TYPE_ID := NEW_CONTRACT_CANCEL_TYPE_ID;
    END IF;
    :NEW.USER_CREATED := USER;
    :NEW.DATE_CREATED := SYSDATE;
  END IF;
  :NEW.USER_LAST_UPDATED := USER;
  :NEW.DATE_LAST_UPDATED := SYSDATE;
END;
/


ALTER TABLE CONTRACT_CANCEL_TYPES ADD (
  CONSTRAINT PK_CONTRACT_CANCEL_TYPES
  PRIMARY KEY
  (CONTRACT_CANCEL_TYPE_ID)
  USING INDEX PK_CONTRACT_CANCEL_TYPES
  ENABLE VALIDATE);
  
Insert into CONTRACT_CANCEL_TYPES(CONTRACT_CANCEL_TYPE_NAME) values ('�������������� ������');
Insert into CONTRACT_CANCEL_TYPES(CONTRACT_CANCEL_TYPE_NAME) values ('������� �� ������� ���������');
Insert into CONTRACT_CANCEL_TYPES(CONTRACT_CANCEL_TYPE_NAME) values ('�����');
Insert into CONTRACT_CANCEL_TYPES(CONTRACT_CANCEL_TYPE_NAME) values ('������');
Insert into CONTRACT_CANCEL_TYPES(CONTRACT_CANCEL_TYPE_NAME) values ('����� �� �������������');
Insert into CONTRACT_CANCEL_TYPES(CONTRACT_CANCEL_TYPE_NAME) values ('��������� �����');  