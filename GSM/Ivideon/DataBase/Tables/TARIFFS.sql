CREATE TABLE TARIFFS(
  TARIFF_ID Integer NOT NULL primary key,
  TARIFF_CODE Varchar2(20 ) NOT NULL,
  TARIFF_NAME Varchar2(50 ) NOT NULL,
  MONTHLY_COST Number(10,2) NOT NULL,
  IS_DAYLY_TARIFF Integer NOT NULL,
  COST_COEEF Number(10,2) DEFAULT 1 NOT NULL,
  USER_CREATED Varchar2(30 ) NOT NULL,
  DATE_CREATED Date NOT NULL,
  USER_LAST_UPDATED Varchar2(30 ),
  DATE_LAST_UPDATED Date
)
/


-- Table and Columns comments section
  
COMMENT ON TABLE TARIFFS IS '������'
/
COMMENT ON COLUMN TARIFFS.TARIFF_ID IS '������������� ������'
/
COMMENT ON COLUMN TARIFFS.TARIFF_CODE IS '��� ������'
/
COMMENT ON COLUMN TARIFFS.TARIFF_NAME IS '������������ ������'
/
COMMENT ON COLUMN TARIFFS.MONTHLY_COST IS '�������� ����.����� �� �����'
/
COMMENT ON COLUMN TARIFFS.IS_DAYLY_TARIFF IS '�������, �����������, �� �� ���: 0 -  ����.����� ����������� ����� �� �����; 1 - ����������'
/
COMMENT ON COLUMN TARIFFS.COST_COEEF IS '����������� ��������� ����.����� ��� ���������.'
/
COMMENT ON COLUMN TARIFFS.USER_CREATED IS '��������� ������������'
/
COMMENT ON COLUMN TARIFFS.DATE_CREATED IS '���� ��������'
/
COMMENT ON COLUMN TARIFFS.USER_LAST_UPDATED IS '��������� ��������� ������������'
/
COMMENT ON COLUMN TARIFFS.DATE_LAST_UPDATED IS '���� ���������� ����������'
/

CREATE SEQUENCE S_TARIFF_ID_ID
  START WITH 1
  MAXVALUE 9999999999999999999999999999
  MINVALUE 1;
  
CREATE OR REPLACE TRIGGER TIU_TARIFFS
  BEFORE INSERT OR UPDATE ON TARIFFS
  REFERENCING NEW AS NEW OLD AS OLD
  FOR EACH ROW
BEGIN
  
  IF INSERTING THEN
    if nvl(:new.TARIFF_ID, 0) = 0 then
      :new.TARIFF_ID := S_TARIFF_ID_ID.NEXTVAL;
    END IF;
    
    :NEW.USER_CREATED := USER;
    :NEW.DATE_CREATED := SYSDATE;
  END IF;
  
  IF UPDATING THEN
    :NEW.USER_LAST_UPDATED := USER;
    :NEW.DATE_LAST_UPDATED := SYSDATE;
  END IF;
END;
/  
ALTER TABLE IVIDEON.TARIFFS
MODIFY(TARIFF_CODE VARCHAR2(50 BYTE))