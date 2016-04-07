CREATE TABLE REGIONS
(
  REGIONS_ID         INTEGER                    NOT NULL,
  COUNTRY_ID         INTEGER                    NOT NULL,
  REGIONS_NAME       VARCHAR2(50 BYTE)          NOT NULL,
  USER_CREATED       VARCHAR2(30 BYTE),
  DATE_CREATED       DATE,
  USER_LAST_UPDATED  VARCHAR2(30 BYTE),
  DATE_LAST_UPDATED  DATE
);

COMMENT ON TABLE REGIONS IS '��������� ��������';
COMMENT ON COLUMN REGIONS.REGIONS_ID IS '������������� ������';
COMMENT ON COLUMN REGIONS.REGIONS_NAME IS '������������ �������';
COMMENT ON COLUMN REGIONS.COUNTRY_ID IS '��� ������ COUNTRIES.COUNTRY_ID';
COMMENT ON COLUMN REGIONS.USER_CREATED IS '������������, ��������� ������';
COMMENT ON COLUMN REGIONS.DATE_CREATED IS '����/����� �������� ������';
COMMENT ON COLUMN REGIONS.USER_LAST_UPDATED IS '������������, ��������������� ������ ���������';
COMMENT ON COLUMN REGIONS.DATE_LAST_UPDATED IS '����/����� ��������� �������� ������';



CREATE UNIQUE INDEX REGIONS_ID_PK ON REGIONS
(REGIONS_ID);

CREATE UNIQUE INDEX REGION_ID_COUNTRY_ID ON REGIONS
(REGIONS_ID, COUNTRY_ID);

CREATE SEQUENCE S_NEW_REGIONS
  START WITH 1
  MAXVALUE 999999999999999999999999999
  MINVALUE 1
  NOCYCLE
  CACHE 20
  NOORDER;
  
CREATE OR REPLACE TRIGGER TUI_REGIONS
BEFORE INSERT OR UPDATE
ON REGIONS
REFERENCING NEW AS New OLD AS Old
FOR EACH ROW
BEGIN
 
 IF INSERTING THEN
    IF NVL(:NEW.REGIONS_ID, 0) = 0 then
      :NEW.REGIONS_ID := S_NEW_REGIONS.NEXTVAL;
    END IF;
    :NEW.USER_CREATED := USER;
    :NEW.DATE_CREATED := SYSDATE;
    :NEW.USER_LAST_UPDATED := USER;
    :NEW.DATE_LAST_UPDATED := SYSDATE;
  END IF;
  if UPDATING THEN
    :NEW.USER_LAST_UPDATED := USER;
    :NEW.DATE_LAST_UPDATED := SYSDATE;
  end if;
  
END;
/

ALTER TABLE REGIONS ADD (
  CONSTRAINT REGIONS_ID_PK
  PRIMARY KEY (REGIONS_ID)
  USING INDEX REGIONS_ID_PK
  ENABLE VALIDATE);

ALTER TABLE REGIONS ADD (
  CONSTRAINT COUNTRY_ID_FK 
  FOREIGN KEY (COUNTRY_ID) 
  REFERENCES COUNTRIES (COUNTRY_ID)
  ENABLE VALIDATE);

GRANT DELETE, INSERT, SELECT, UPDATE ON REGIONS TO BUSINESS_COMM_ROLE;
GRANT SELECT ON S_NEW_REGIONS TO BUSINESS_COMM_ROLE;
GRANT SELECT, UPDATE ON REGIONS TO BUSINESS_COMM_ROLE_RO;