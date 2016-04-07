CREATE TABLE DB_LOADER_PAYMENTS
(
  ACCOUNT_ID               INTEGER,
  YEAR_MONTH               INTEGER,
  PHONE_NUMBER             VARCHAR2(10 CHAR),
  PAYMENT_DATE             DATE,
  PAYMENT_SUM              NUMBER(15,2),
  PAYMENT_STATUS_IS_VALID  NUMBER(1),
  PAYMENT_NUMBER           VARCHAR2(30 CHAR),
  PAYMENT_STATUS_TEXT      VARCHAR2(200 CHAR),
  CONTRACT_ID              INTEGER,
  DATE_CREATED             DATE,
  
  CONSTRAINT U_LDR_PAYMENTS
  UNIQUE (PHONE_NUMBER, PAYMENT_NUMBER, PAYMENT_SUM, PAYMENT_DATE, PAYMENT_STATUS_IS_VALID)
  USING INDEX U_LDR_PAYMENTS
  ENABLE VALIDATE,
  
  CONSTRAINT FK_DB_LOADER_PAYMENTS_CONTRACT 
  FOREIGN KEY (CONTRACT_ID) 
  REFERENCES CONTRACTS (CONTRACT_ID)
  ON DELETE SET NULL
  ENABLE VALIDATE
  
  
);

COMMENT ON TABLE DB_LOADER_PAYMENTS IS '�������';

COMMENT ON COLUMN DB_LOADER_PAYMENTS.ACCOUNT_ID IS 'ID �������';

COMMENT ON COLUMN DB_LOADER_PAYMENTS.YEAR_MONTH IS '��� � �����';

COMMENT ON COLUMN DB_LOADER_PAYMENTS.PHONE_NUMBER IS '����� ��������';

COMMENT ON COLUMN DB_LOADER_PAYMENTS.PAYMENT_DATE IS '���� �������';

COMMENT ON COLUMN DB_LOADER_PAYMENTS.PAYMENT_SUM IS '����� �������';

COMMENT ON COLUMN DB_LOADER_PAYMENTS.PAYMENT_STATUS_IS_VALID IS '������ �������';

COMMENT ON COLUMN DB_LOADER_PAYMENTS.PAYMENT_NUMBER IS '����� �������';

COMMENT ON COLUMN DB_LOADER_PAYMENTS.PAYMENT_STATUS_TEXT IS '�������� ������� ������� ';

COMMENT ON COLUMN DB_LOADER_PAYMENTS.CONTRACT_ID IS '������ �� ��������, � �������� ��������� �����';

COMMENT ON COLUMN DB_LOADER_PAYMENTS.DATE_CREATED IS '���� �������� ������� � ��';



CREATE INDEX I_DB_LOADER_PAYMENTS_CONTRACT ON DB_LOADER_PAYMENTS
(CONTRACT_ID);


CREATE INDEX I_DB_LOADER_PAYMENTS_F2 ON DB_LOADER_PAYMENTS
(ACCOUNT_ID, NVL("PAYMENT_NUMBER",'0'), NVL("PHONE_NUMBER",'000'))
COMPRESS 1;


CREATE INDEX I_DB_LOADER_PAYMENTS_PHONE ON DB_LOADER_PAYMENTS
(PHONE_NUMBER)
COMPRESS 1;


CREATE UNIQUE INDEX U_LDR_PAYMENTS ON DB_LOADER_PAYMENTS
(PHONE_NUMBER, PAYMENT_NUMBER, PAYMENT_SUM, PAYMENT_DATE, PAYMENT_STATUS_IS_VALID);


CREATE OR REPLACE TRIGGER TI_DB_LOADER_PAYMENTS
--#Version=1
  BEFORE INSERT ON DB_LOADER_PAYMENTS FOR EACH ROW
BEGIN
    :NEW.DATE_CREATED := SYSDATE;
     CREATE_PAYMENT_TICKET(:NEW.PHONE_NUMBER, :NEW.PAYMENT_DATE, :NEW.PAYMENT_SUM, :NEW.PAYMENT_NUMBER);
END;
/

GRANT DELETE, INSERT, SELECT, UPDATE ON DB_LOADER_PAYMENTS TO LONTANA_ROLE;

GRANT SELECT ON DB_LOADER_PAYMENTS TO LONTANA_ROLE_RO;

GRANT SELECT ON DB_LOADER_PAYMENTS TO ROAMING_RETARIF_CHECKER;
