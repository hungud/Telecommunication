CREATE TABLE TARIFF_AND_SERVICE_CONTACT(
  TAS_CONTACT_ID INTEGER PRIMARY KEY,
  TARIFF_ID INTEGER NOT NULL,
  TARIFF_OPTION_ID INTEGER NOT NULL,
  USER_CREATED VARCHAR2(30 CHAR),
  DATE_CREATED DATE,
  USER_LAST_UPDATED VARCHAR2(30 CHAR),
  DATE_LAST_UPDATED DATE
  );
  
ALTER TABLE TARIFF_AND_SERVICE_CONTACT ADD (
 CONSTRAINT FK_TAS_TARIFF_ID
   FOREIGN KEY (TARIFF_ID) 
   REFERENCES TARIFFS(TARIFF_ID));  
  
ALTER TABLE TARIFF_AND_SERVICE_CONTACT ADD (
 CONSTRAINT FK_TAS_TARIFF_OPTION_ID
   FOREIGN KEY (TARIFF_OPTION_ID) 
   REFERENCES TARIFF_OPTIONS(TARIFF_OPTION_ID)); 
 

COMMENT ON TABLE TARIFF_AND_SERVICE_CONTACT IS '���������� ������ ������������ ����� �������� � ��������';
COMMENT ON COLUMN TARIFF_AND_SERVICE_CONTACT.TAS_CONTACT_ID IS '�� �����';
COMMENT ON COLUMN TARIFF_AND_SERVICE_CONTACT.TARIFF_ID IS '�� ������';
COMMENT ON COLUMN TARIFF_AND_SERVICE_CONTACT.TARIFF_OPTION_ID IS '�� ������';
COMMENT ON COLUMN TARIFF_AND_SERVICE_CONTACT.USER_CREATED IS '���������';
COMMENT ON COLUMN TARIFF_AND_SERVICE_CONTACT.DATE_CREATED IS '���� ��������';
COMMENT ON COLUMN TARIFF_AND_SERVICE_CONTACT.USER_LAST_UPDATED IS '��������';
COMMENT ON COLUMN TARIFF_AND_SERVICE_CONTACT.DATE_LAST_UPDATED IS '���� ����������';
  
CREATE SEQUENCE S_NEW_TAS_CONTACT_ID
  START WITH 1
  MAXVALUE 999999999999999999999999999
  MINVALUE 1
  NOCYCLE
  CACHE 20
  NOORDER;

CREATE OR REPLACE FUNCTION NEW_TAS_CONTACT_ID RETURN NUMBER IS
--#Version=1
  vRES NUMBER;
BEGIN
  SELECT S_NEW_TAS_CONTACT_ID.NEXTVAL
  INTO vRES
  FROM DUAL;
  RETURN vRES;
END;

CREATE OR REPLACE TRIGGER TIU_TARIFF_AND_SERVICE_CONTACT
  BEFORE INSERT OR UPDATE ON TARIFF_AND_SERVICE_CONTACT FOR EACH ROW 
--#Version=1
BEGIN 
  IF INSERTING THEN 
    IF NVL(:NEW.TAS_CONTACT_ID, 0) = 0 then
      :NEW.TAS_CONTACT_ID := NEW_TAS_CONTACT_ID;
    END IF;
    :NEW.USER_CREATED := USER;
    :NEW.DATE_CREATED := SYSDATE;
  END IF;
  :NEW.USER_LAST_UPDATED := USER;
  :NEW.DATE_LAST_UPDATED := SYSDATE;
END;
/  

GRANT INSERT, SELECT, UPDATE, DELETE ON TARIFF_AND_SERVICE_CONTACT TO CORP_MOBILE_ROLE;

GRANT SELECT ON TARIFF_AND_SERVICE_CONTACT TO CORP_MOBILE_ROLE_RO;