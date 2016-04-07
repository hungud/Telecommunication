CREATE TABLE FIELD_DETAILS(
  FIELD_DETAILS_ID INTEGER PRIMARY KEY,
  FIELD_TYPE_ID INTEGER NOT NULL,
  FIELD_VALUE VARCHAR2(30 CHAR) NOT NULL
);

COMMENT ON COLUMN FIELD_DETAILS.FIELD_DETAILS_ID IS '��������� ����'; 

COMMENT ON COLUMN FIELD_DETAILS.FIELD_TYPE_ID IS '��� ����'; 

COMMENT ON COLUMN FIELD_DETAILS.FIELD_VALUE IS '�������� ����'; 

CREATE SEQUENCE S_NEW_FIELD_DETAILS_ID;

CREATE OR REPLACE FUNCTION NEW_FIELD_DETAILS_ID RETURN NUMBER IS
--#Version=1
  vRES NUMBER;
BEGIN
  SELECT S_NEW_FIELD_DETAILS_ID.NEXTVAL
    INTO vRES
    FROM DUAL;
  RETURN vRES;
END;

CREATE OR REPLACE TRIGGER TIU_FIELD_DETAILS
  BEFORE INSERT ON FIELD_DETAILS FOR EACH ROW
--#Version=1
BEGIN
  IF NVL(:NEW.FIELD_DETAILS_ID, 0) = 0 then
    :NEW.FIELD_DETAILS_ID := NEW_FIELD_DETAILS_ID;
  END IF;
  :NEW.DATE_CHECK:=SYSDATE;
END;

ALTER TABLE FIELD_DETAILS ADD DATE_CHECK DATE;

GRANT SELECT, UPDATE, INSERT, DELETE ON FIELD_DETAILS TO CORP_MOBILE_ROLE;

GRANT SELECT, UPDATE, INSERT, DELETE ON FIELD_DETAILS TO CORP_MOBILE_DB_LOADER;
