CREATE TABLE PAYMENT_PURPOSE_TYPE(
  PAYMENT_PURPOSE_ID Integer NOT NULL PRIMARY KEY,
  PAYMENT_PURPOSE_CODE Varchar2(30 CHAR) NOT NULL,
  PAYMENT_PURPOSE_DESC Varchar2(150 CHAR) NOT NULL
)
/
  
COMMENT ON TABLE PAYMENT_PURPOSE_TYPE IS '���� ���������� ��������'
/
COMMENT ON COLUMN PAYMENT_PURPOSE_TYPE.PAYMENT_PURPOSE_ID IS '������������� ������'
/
COMMENT ON COLUMN PAYMENT_PURPOSE_TYPE.PAYMENT_PURPOSE_CODE IS '��� ���������� �������'
/
COMMENT ON COLUMN PAYMENT_PURPOSE_TYPE.PAYMENT_PURPOSE_DESC IS '����������� ���� �������'
/
CREATE SEQUENCE S_PAYMENT_PURPOSE_ID
  START WITH 1
  MAXVALUE 9999999999999999999999999999
  MINVALUE 1;
  
CREATE OR REPLACE TRIGGER TI_PAYMENT_PURPOSE_TYPE
  BEFORE INSERT ON PAYMENT_PURPOSE_TYPE
  REFERENCING NEW AS NEW OLD AS OLD
  FOR EACH ROW
BEGIN
  
  if nvl(:new.PAYMENT_PURPOSE_ID, 0) = 0 then
    :new.PAYMENT_PURPOSE_ID := S_PAYMENT_PURPOSE_ID.NEXTVAL;
  END IF;

END;
/  
SET DEFINE OFF;
Insert into PAYMENT_PURPOSE_TYPE
   (PAYMENT_PURPOSE_CODE, PAYMENT_PURPOSE_DESC)
 Values
   ('paykeeper_payment', '���������� �� ������� PayKeeper');
COMMIT;
