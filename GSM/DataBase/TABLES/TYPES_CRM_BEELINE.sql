create table TYPES_CRM_BEELINE 
(
  id integer primary key,
  type_name varchar2(50 char) not null
);

COMMENT ON TABLE TYPES_CRM_BEELINE IS '���� ��� ������������� ������ �� �������������� ��������';

COMMENT ON COLUMN TYPES_CRM_BEELINE.ID IS '��������� ����';

COMMENT ON COLUMN TYPES_CRM_BEELINE.type_name IS '�������� ����';

CREATE SEQUENCE S_NEW_TYPES_CRM_BEELINE_ID
  START WITH 1
  MAXVALUE 999999999999999999999999999
  MINVALUE 1
  NOCYCLE
  CACHE 20
  NOORDER;



CREATE OR REPLACE TRIGGER TI_TYPES_CRM_BEELINE_ID
  BEFORE INSERT OR UPDATE ON TYPES_CRM_BEELINE FOR EACH ROW
--
--#Version=1
--
BEGIN
  
  IF NVL(:NEW.ID, 0) = 0 THEN
    :NEW.ID := S_NEW_TYPES_CRM_BEELINE_ID.NEXTVAL;
  END IF;
  
END;
/
GRANT SELECT, INSERT, DELETE, UPDATE ON TYPES_CRM_BEELINE TO LONTANA_ROLE;
GRANT SELECT, INSERT, DELETE, UPDATE ON TYPES_CRM_BEELINE TO LONTANA_ROLE_RO;

INSERT INTO TYPES_CRM_BEELINE(type_name) VALUES ('����� �� ������');
INSERT INTO TYPES_CRM_BEELINE(type_name) VALUES ('������ � ��������');
Commit;