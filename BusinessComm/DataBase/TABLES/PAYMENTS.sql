CREATE TABLE PAYMENTS(
  PAYMENT_ID INTEGER NOT NULL PRIMARY KEY,
  VIRTUAL_ACCOUNT_ID INTEGER,
  PHONE_ID INTEGER,
  INN VARCHAR2(12 CHAR),
  DATE_PAY DATE NOT NULL,
  SUM_PAY NUMBER(15,2) NOT NULL,
  DOC_NUMBER VARCHAR2(10 CHAR) NOT NULL,
  PAYMENT_PURPOSE VARCHAR2(500 CHAR),
  USER_CREATED VARCHAR2(30 CHAR) NOT NULL,
  DATE_CREATED DATE NOT NULL,
  USER_LAST_UPDATED VARCHAR2(30 CHAR) NOT NULL,
  DATE_LAST_UPDATED DATE,
  PAYMENT_FILE_ID INTEGER,
  YEAR_MONTH Integer,
  PAYER_BIK integer
  );

COMMENT ON TABLE PAYMENTS IS '�������';
COMMENT ON COLUMN PAYMENTS.payment_id IS '��������� ����';
COMMENT ON COLUMN PAYMENTS.VIRTUAL_ACCOUNT_ID IS '������������ ���������� �������� VIRTUAL_ACCOUNTS.VIRTUAL_ACCOUNTS_ID';
COMMENT ON COLUMN PAYMENTS.PHONE_ID IS '������������� ������ �������� PHONES.PHONE_ID';
COMMENT ON COLUMN PAYMENTS.INN IS '��� �����������';
COMMENT ON COLUMN PAYMENTS.DATE_PAY IS '���� �������';
COMMENT ON COLUMN PAYMENTS.SUM_PAY IS '����� �������';
COMMENT ON COLUMN PAYMENTS.DOC_NUMBER IS '����� ���������� ���������';
COMMENT ON COLUMN PAYMENTS.PAYMENT_PURPOSE IS '���������� �������';
COMMENT ON COLUMN PAYMENTS.USER_CREATED IS '������������, ���������';
COMMENT ON COLUMN PAYMENTS.DATE_CREATED IS '���� ��������';
COMMENT ON COLUMN PAYMENTS.USER_LAST_UPDATED IS '������������, ����������';
COMMENT ON COLUMN PAYMENTS.DATE_LAST_UPDATED IS '���� ���������� ���������';
COMMENT ON COLUMN PAYMENTS.PAYMENT_FILE_ID IS '������������� ����������� ����� (PAYMENTS_FILES.FILE_ID)';
COMMENT ON COLUMN PAYMENTS.YEAR_MONTH IS '���_����� �������';
COMMENT ON COLUMN PAYMENTS.PAYER_BIK is '��� �����������';

CREATE SEQUENCE S_PAYMENT_ID
  START WITH 1
  MAXVALUE 999999999999999999999999999
  MINVALUE 1
  NOCYCLE
  NOCACHE
  NOORDER;  
  
CREATE OR REPLACE TRIGGER TIU_PAYMENTS
BEFORE DELETE OR INSERT OR UPDATE
ON PAYMENTS
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
BEGIN
   IF INSERTING THEN
    :NEW.USER_CREATED := USER;
    :NEW.DATE_CREATED := SYSDATE;
    IF NVL(:NEW.PAYMENT_ID, 0)=0 THEN
      :NEW.PAYMENT_ID := S_PAYMENT_ID.NEXTVAL;
    END IF;
  :NEW.USER_LAST_UPDATED := USER;
  :NEW.DATE_LAST_UPDATED := SYSDATE;
   insert into PAYMANTS_HIST (PAYMENT_ID, VIRTUAL_ACCOUNT_ID, PHONE_ID, INN, DATE_PAY,
                              SUM_PAY, DOC_NUMBER, PAYMENT_PURPOSE, USER_CREATED, DATE_CREATED,
                              USER_LAST_UPDATED, DATE_LAST_UPDATED, PAYMENT_FILE_ID, YEAR_MONTH,
                              PAYER_BIK, STATE)
                     VALUES (:NEW.PAYMENT_ID, :NEW.VIRTUAL_ACCOUNT_ID, :NEW.PHONE_ID, :NEW.INN, :NEW.DATE_PAY,
                              :NEW.SUM_PAY, :NEW.DOC_NUMBER, :NEW.PAYMENT_PURPOSE, :NEW.USER_CREATED, :NEW.DATE_CREATED,
                              :NEW.USER_LAST_UPDATED, :NEW.DATE_LAST_UPDATED, :NEW.PAYMENT_FILE_ID, :NEW.YEAR_MONTH,
                              :NEW.PAYER_BIK, '����� ������');
                              
   BALANCE.INSERT_PAYMENT_INTO_BALANCE_TR (:NEW.VIRTUAL_ACCOUNT_ID, :NEW.DATE_PAY, :NEW.PAYMENT_ID, :NEW.PHONE_ID, :NEW.SUM_PAY);    
                          
  END IF;



  if UPDATING THEN
    :NEW.USER_LAST_UPDATED := USER;
    :NEW.DATE_LAST_UPDATED := SYSDATE;
   insert into PAYMANTS_HIST (PAYMENT_ID, VIRTUAL_ACCOUNT_ID, PHONE_ID, INN, DATE_PAY,
                              SUM_PAY, DOC_NUMBER, PAYMENT_PURPOSE, USER_CREATED, DATE_CREATED,
                              USER_LAST_UPDATED, DATE_LAST_UPDATED, PAYMENT_FILE_ID, YEAR_MONTH,
                              PAYER_BIK, STATE)
                     VALUES (:NEW.PAYMENT_ID, :NEW.VIRTUAL_ACCOUNT_ID, :NEW.PHONE_ID, :NEW.INN, :NEW.DATE_PAY,
                              :NEW.SUM_PAY, :NEW.DOC_NUMBER, :NEW.PAYMENT_PURPOSE, :NEW.USER_CREATED, :NEW.DATE_CREATED,
                              :NEW.USER_LAST_UPDATED, :NEW.DATE_LAST_UPDATED, :NEW.PAYMENT_FILE_ID, :NEW.YEAR_MONTH,
                              :NEW.PAYER_BIK, '��������� ������');
  end if;

  if DELETING THEN
   insert into PAYMANTS_HIST (PAYMENT_ID, VIRTUAL_ACCOUNT_ID, PHONE_ID, INN, DATE_PAY,
                              SUM_PAY, DOC_NUMBER, PAYMENT_PURPOSE, USER_CREATED, DATE_CREATED,
                              USER_LAST_UPDATED, DATE_LAST_UPDATED, PAYMENT_FILE_ID, YEAR_MONTH,
                              PAYER_BIK, STATE)
                     VALUES (:OLD.PAYMENT_ID, :OLD.VIRTUAL_ACCOUNT_ID, :OLD.PHONE_ID, :OLD.INN, :OLD.DATE_PAY,
                              :OLD.SUM_PAY, :OLD.DOC_NUMBER, :OLD.PAYMENT_PURPOSE, :OLD.USER_CREATED, :OLD.DATE_CREATED,
                              :OLD.USER_LAST_UPDATED, :OLD.DATE_LAST_UPDATED, :OLD.PAYMENT_FILE_ID, :OLD.YEAR_MONTH,
                              :OLD.PAYER_BIK, '�������� ������');
                              
     delete from BALANCE_VIRT_ACOUNTS 
       where VIRTUAL_ACCOUNTS_ID = :OLD.VIRTUAL_ACCOUNT_ID
         and PAYMENT_ID = :OLD.PAYMENT_ID;
                                  
      BALANCE.RECALC_BALANCE2 (:OLD.VIRTUAL_ACCOUNT_ID, :OLD.YEAR_MONTH);                          

  end if;
  
  
   EXCEPTION
     WHEN OTHERS THEN
       RAISE;
END;
/
ALTER TABLE PAYMENTS ADD CONSTRAINT FK_PAYMENT_FILE_ID FOREIGN KEY (PAYMENT_FILE_ID) REFERENCES PAYMENTS_FILES (FILE_ID);

GRANT SELECT, INSERT ON PAYMENTS TO BUSINESS_COMM_ROLE;
GRANT SELECT ON S_PAYMENT_ID TO BUSINESS_COMM_ROLE;
GRANT SELECT, INSERT ON PAYMENTS TO BUSINESS_COMM_ROLE_RO;

CREATE INDEX I_PAYMENT_YEAR_MONTH ON PAYMENTS (YEAR_MONTH);
CREATE INDEX I_PAY_INN_D_PAY_S_PAY_DOC_N ON PAYMENTS (INN, DATE_PAY, SUM_PAY, PAYER_BIK, DOC_NUMBER);