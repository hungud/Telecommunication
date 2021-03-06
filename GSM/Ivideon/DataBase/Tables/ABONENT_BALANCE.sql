CREATE TABLE ABONENT_BALANCE(
  ABONENT_ID Integer NOT NULL PRIMARY KEY,
  BALANCE Number(10,2) DEFAULT 0 NOT NULL,
  DATE_LAST_UPDATED Date
)
/

  
COMMENT ON TABLE ABONENT_BALANCE IS '������ ������������ ������� Ivideon �� ������� ������ �������'
/
COMMENT ON COLUMN ABONENT_BALANCE.ABONENT_ID IS '������������� ������������ ������� IVIDEON_ABONENTS.ABONENTN_ID'
/
COMMENT ON COLUMN ABONENT_BALANCE.BALANCE IS '������ ������������'
/
COMMENT ON COLUMN ABONENT_BALANCE.DATE_LAST_UPDATED IS '���� ���������� ��������� �������'
/
ALTER TABLE ABONENT_BALANCE ADD (
  CONSTRAINT FK_ABONENT_ID
  FOREIGN KEY (ABONENT_ID) 
  REFERENCES IVIDEON_ABONENTS (ABONENT_ID)
  );
/
CREATE OR REPLACE TRIGGER TIU_ABONENT_BALANCE
  BEFORE INSERT OR UPDATE ON ABONENT_BALANCE
  REFERENCING NEW AS NEW OLD AS OLD
  FOR EACH ROW
BEGIN
  :NEW.DATE_LAST_UPDATED := SYSDATE;
END;  