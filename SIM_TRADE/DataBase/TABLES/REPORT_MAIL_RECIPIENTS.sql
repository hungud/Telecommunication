CREATE TABLE REPORT_MAIL_RECIPIENTS(
  RECORD_ID INTEGER PRIMARY KEY,
  TYPE_REPORT VARCHAR2(100 CHAR) NOT NULL, 
  MAIL_ADRESS VARCHAR2(100 CHAR) NOT NULL
);

COMMENT ON TABLE REPORT_MAIL_RECIPIENTS IS '������ �������� �������';

CREATE SEQUENCE S_NEW_RECORD_ID;

CREATE OR REPLACE FUNCTION NEW_RECORD_ID RETURN NUMBER IS
--#Version=1
  vRES NUMBER;
BEGIN
  SELECT S_NEW_RECORD_ID.NEXTVAL
  INTO vRES
  FROM DUAL;
  RETURN vRES;
END;
/

CREATE OR REPLACE TRIGGER TIU_REPORT_MAIL_RECIPIENTS
  BEFORE INSERT OR UPDATE ON REPORT_MAIL_RECIPIENTS FOR EACH ROW
--#Version=1
BEGIN
  IF INSERTING THEN
    IF NVL(:NEW.RECORD_ID, 0) = 0 then
      :NEW.RECORD_ID := NEW_RECORD_ID;
    END IF;
  END IF;
END;
/