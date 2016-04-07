CREATE TABLE PAYMENT_HISTORY(
  PAYMENTS_HISTORY_ID Integer NOT NULL PRIMARY KEY,
  ABONENT_ID Integer NOT NULL,
  PAYMENT_SUM Number(10, 2) NOT NULL,
  PAYMENT_DATE Date NOT NULL,
  USER_CREATED Varchar2(30 ) NOT NULL,
  DATE_CREATED Date NOT NULL
)
/

ALTER TABLE PAYMENT_HISTORY ADD (
  CONSTRAINT FK_PH_ABONENT_ID
  FOREIGN KEY (ABONENT_ID) 
  REFERENCES IVIDEON_ABONENTS (ABONENT_ID)
  );

-- Table and Columns comments section
  
COMMENT ON TABLE PAYMENT_HISTORY IS '������� ����������� ��������'
/
COMMENT ON COLUMN PAYMENT_HISTORY.PAYMENTS_HISTORY_ID IS '������������� ������'
/
COMMENT ON COLUMN PAYMENT_HISTORY.ABONENT_ID IS '������������� ������������ ������� IVIDEON_ABONENTS.ABONENTN_ID'
/
COMMENT ON COLUMN PAYMENT_HISTORY.PAYMENT_SUM IS '����� �������'
/
COMMENT ON COLUMN PAYMENT_HISTORY.PAYMENT_DATE IS '���� ����������� �������'
/
COMMENT ON COLUMN PAYMENT_HISTORY.USER_CREATED IS '��������� ������������'
/
COMMENT ON COLUMN PAYMENT_HISTORY.DATE_CREATED IS '���� �������� ������'
/

CREATE SEQUENCE S_PAYMENTS_HISTORY_ID
  START WITH 1
  MAXVALUE 9999999999999999999999999999
  MINVALUE 1;
  
CREATE OR REPLACE TRIGGER TI_PAYMENT_HISTORY
  BEFORE INSERT ON PAYMENT_HISTORY
  REFERENCING NEW AS NEW OLD AS OLD
  FOR EACH ROW
BEGIN
  
  if nvl(:new.PAYMENTS_HISTORY_ID, 0) = 0 then
    :new.PAYMENTS_HISTORY_ID := S_PAYMENTS_HISTORY_ID.NEXTVAL;
  END IF;

  :NEW.USER_CREATED := USER;
  :NEW.DATE_CREATED := SYSDATE;

END;
/  
alter table PAYMENT_HISTORY add(
IVIDEON_PAYMENT_ID Integer,
PAYKEEPER_PAYMENT_ID Integer NOT NULL,
PAYMENT_PURPOSE_ID Integer NOT NULL
);

COMMENT ON COLUMN PAYMENT_HISTORY.IVIDEON_PAYMENT_ID IS '������������� ������� � ������� IVIDEON'
/
COMMENT ON COLUMN PAYMENT_HISTORY.PAYKEEPER_PAYMENT_ID IS '������������� ������� � ������� PayKeeper'
/
COMMENT ON COLUMN PAYMENT_HISTORY.PAYMENT_PURPOSE_ID IS '������������� ���������� ������� (PAYMENT_PURPOSE_TYPE.PAYMENT_PURPOSE_ID)'

ALTER TABLE PAYMENT_HISTORY ADD (
  CONSTRAINT FK_PAYMENT_PURPOSE_TYPE_ID
  FOREIGN KEY (PAYMENT_PURPOSE_ID) 
  REFERENCES PAYMENT_PURPOSE_TYPE (PAYMENT_PURPOSE_ID)
  );