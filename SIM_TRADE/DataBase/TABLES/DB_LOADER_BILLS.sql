--drop TABLE DB_LOADER_BILLS;

CREATE TABLE DB_LOADER_BILLS (
  ACCOUNT_ID INTEGER,
  YEAR_MONTH INTEGER,
  PHONE_NUMBER VARCHAR2(10 CHAR),
  DATE_BEGIN         DATE,
  DATE_END           DATE,
  BILL_SUM           NUMBER(15, 2),
  SUBSCRIBER_PAYMENT_MAIN NUMBER(15, 2),
  SUBSCRIBER_PAYMENT_ADD  NUMBER(15, 2),
  SINGLE_PAYMENTS    NUMBER(15, 2),
  CALLS_LOCAL_COST         NUMBER(15, 2),
  CALLS_OTHER_CITY_COST    NUMBER(15, 2),
  CALLS_OTHER_COUNTRY_COST NUMBER(15, 2),
  MESSAGES_COST      NUMBER(15, 2),
  INTERNET_COST      NUMBER(15, 2),
  OTHER_COUNTRY_ROAMING_COST NUMBER(15, 2),
  NATIONAL_ROAMING_COST NUMBER(15, 2),
  PENI_COST          NUMBER(15, 2),
  DISCOUNT_VALUE     NUMBER(15, 2)
);

COMMENT ON TABLE DB_LOADER_BILLS IS '������������ ���������� �����';

COMMENT ON COLUMN DB_LOADER_BILLS.ACCOUNT_ID          IS '��� �������� �����';
COMMENT ON COLUMN DB_LOADER_BILLS.YEAR_MONTH          IS '��� � ����� ��������� �������';
COMMENT ON COLUMN DB_LOADER_BILLS.PHONE_NUMBER        IS '����� ��������';
COMMENT ON COLUMN DB_LOADER_BILLS.DATE_BEGIN          IS '���� ������ ������� (����������� ��������)';
COMMENT ON COLUMN DB_LOADER_BILLS.DATE_END            IS '���� ��������� ������� (����������� ��������)';
COMMENT ON COLUMN DB_LOADER_BILLS.BILL_SUM            IS '����������� ����� (������)';
COMMENT ON COLUMN DB_LOADER_BILLS.SUBSCRIBER_PAYMENT_MAIN IS '����������� ����� �� ������';
COMMENT ON COLUMN DB_LOADER_BILLS.SUBSCRIBER_PAYMENT_ADD IS '��������� �� �������������� ������';
COMMENT ON COLUMN DB_LOADER_BILLS.SINGLE_PAYMENTS     IS '������� ����������';
COMMENT ON COLUMN DB_LOADER_BILLS.CALLS_LOCAL_COST    IS '��������� ������� �������';
COMMENT ON COLUMN DB_LOADER_BILLS.CALLS_OTHER_CITY_COST IS '������������� ������';
COMMENT ON COLUMN DB_LOADER_BILLS.CALLS_OTHER_COUNTRY_COST IS '������������� ������';
COMMENT ON COLUMN DB_LOADER_BILLS.MESSAGES_COST       IS '��������� ��������� (SMS, MMS)';
COMMENT ON COLUMN DB_LOADER_BILLS.INTERNET_COST       IS '��������� ���������';
COMMENT ON COLUMN DB_LOADER_BILLS.OTHER_COUNTRY_ROAMING_COST IS '������������� �������';
COMMENT ON COLUMN DB_LOADER_BILLS.NATIONAL_ROAMING_COST IS '������������ �������';
COMMENT ON COLUMN DB_LOADER_BILLS.PENI_COST           IS '����������� ����';
COMMENT ON COLUMN DB_LOADER_BILLS.DISCOUNT_VALUE      IS '������';

CREATE UNIQUE INDEX UQ_DB_LOADER_BILLS_PHON_YM_ACC ON DB_LOADER_BILLS (PHONE_NUMBER, YEAR_MONTH, ACCOUNT_ID)
COMPRESS 1
/

CREATE INDEX I_DB_LOADER_BILLS_PHONE_D_END
ON DB_LOADER_BILLS (PHONE_NUMBER, DATE_END)
COMPRESS 1
/

CREATE INDEX I_DB_LOADER_BILLS_PHONE_B_F_CL
ON DB_LOADER_BILLS (PHONE_NUMBER, YEAR_MONTH, ACCOUNT_ID, DATE_BEGIN,
                      DATE_END, BILL_SUM, SUBSCRIBER_PAYMENT_MAIN, SUBSCRIBER_PAYMENT_ADD, 
                      SINGLE_PAYMENTS, DISCOUNT_VALUE, TARIFF_CODE, BILL_CHECKED)
COMPRESS 1
/

--DROP INDEX UQ_DB_LOADER_BILLS_PHON_YM_ACC 

CREATE OR REPLACE TRIGGER TIU_DB_LOADER_BILLS
  BEFORE INSERT OR UPDATE ON DB_LOADER_BILLS FOR EACH ROW
--#Version=1
BEGIN
  IF INSERTING THEN
    :NEW.USER_CREATED := USER;
    :NEW.DATE_CREATED := SYSDATE;
  END IF;
  :NEW.USER_LAST_UPDATED := USER;
  :NEW.DATE_LAST_UPDATED := SYSDATE;
END;

ALTER TABLE DB_LOADER_BILLS ADD (DATE_CREATED DATE);
ALTER TABLE DB_LOADER_BILLS ADD (USER_CREATED       VARCHAR2(30 CHAR));
ALTER TABLE DB_LOADER_BILLS ADD (USER_LAST_UPDATED  VARCHAR2(30 CHAR));
ALTER TABLE DB_LOADER_BILLS ADD (DATE_LAST_UPDATED  DATE);

COMMENT ON COLUMN DB_LOADER_BILLS.USER_CREATED IS '������������, ��������� ������';
COMMENT ON COLUMN DB_LOADER_BILLS.DATE_CREATED IS '����/����� �������� ������';
COMMENT ON COLUMN DB_LOADER_BILLS.USER_LAST_UPDATED IS '������������, ��������������� ������ ���������';
COMMENT ON COLUMN DB_LOADER_BILLS.DATE_LAST_UPDATED IS '����/����� ��������� �������� ������';


ALTER TABLE DB_LOADER_BILLS ADD CONSTRAINT FK_DB_LOADER_BILLS_ACCOUNT_ID
FOREIGN KEY (ACCOUNT_ID) REFERENCES ACCOUNTS;

ALTER TABLE DB_LOADER_BILLS ADD TARIFF_CODE VARCHAR2(30 CHAR);

COMMENT ON COLUMN DB_LOADER_BILLS.TARIFF_CODE IS '��� ������';


ALTER TABLE DB_LOADER_BILLS ADD OTHER_COUNTRY_ROAMING_CALLS NUMBER(15, 2);

COMMENT ON COLUMN DB_LOADER_BILLS.OTHER_COUNTRY_ROAMING_CALLS IS '������������� ������� ������� ����� (���������� ��������)';

ALTER TABLE DB_LOADER_BILLS ADD OTHER_COUNTRY_ROAMING_MESSAGES NUMBER(15, 2);

COMMENT ON COLUMN DB_LOADER_BILLS.OTHER_COUNTRY_ROAMING_MESSAGES IS '������������� ������� SMS (���������� ��������)';

ALTER TABLE DB_LOADER_BILLS ADD OTHER_COUNTRY_ROAMING_INTERNET NUMBER(15, 2);

COMMENT ON COLUMN DB_LOADER_BILLS.OTHER_COUNTRY_ROAMING_INTERNET IS '������������� ������� GPRS (���������� ��������)';

ALTER TABLE DB_LOADER_BILLS ADD NATIONAL_ROAMING_CALLS NUMBER(15, 2);

COMMENT ON COLUMN DB_LOADER_BILLS.NATIONAL_ROAMING_CALLS IS '������������ ������� ������� ����� (���������� ��������)';

ALTER TABLE DB_LOADER_BILLS ADD NATIONAL_ROAMING_MESSAGES NUMBER(15, 2);

COMMENT ON COLUMN DB_LOADER_BILLS.NATIONAL_ROAMING_MESSAGES IS '������������ ������� SMS (���������� ��������)';

ALTER TABLE DB_LOADER_BILLS ADD NATIONAL_ROAMING_INTERNET NUMBER(15, 2);

COMMENT ON COLUMN DB_LOADER_BILLS.NATIONAL_ROAMING_INTERNET IS '������������ ������� GPRS (���������� ��������)';

ALTER TABLE DB_LOADER_BILLS ADD BILL_CHECKED integer;

COMMENT ON COLUMN DB_LOADER_BILLS.BILL_CHECKED IS '�������� ����� ������';
