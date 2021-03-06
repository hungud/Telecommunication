CREATE TABLE DB_LOADER_FULL_FINANCE_BILL(
  ACCOUNT_ID INTEGER NOT NULL,
  YEAR_MONTH INTEGER NOT NULL,
  PHONE_NUMBER VARCHAR2(10 CHAR) NOT NULL,
  ABONKA NUMBER(15, 4) NOT NULL,
  CALLS NUMBER(15, 4) NOT NULL,
  SINGLE_PAYMENTS NUMBER(15, 4) NOT NULL,
  DISCOUNTS NUMBER(15, 4) NOT NULL,
  BILL_SUM NUMBER(15, 4) NOT NULL,
  COMPLETE_BILL INTEGER NOT NULL,
  ABON_MAIN NUMBER(15, 4) NOT NULL,
  ABON_ADD NUMBER(15, 4) NOT NULL,
  ABON_OTHER NUMBER(15, 4) NOT NULL,
  SINGLE_MAIN NUMBER(15, 4) NOT NULL, 
  SINGLE_ADD NUMBER(15, 4) NOT NULL, 
  SINGLE_PENALTI NUMBER(15, 4) NOT NULL, 
  SINGLE_CHANGE_TARIFF NUMBER(15, 4) NOT NULL, 
  SINGLE_TURN_ON_SERV NUMBER(15, 4) NOT NULL,
  SINGLE_CORRECTION_ROUMING NUMBER(15, 4) NOT NULL,
  SINGLE_INTRA_WEB NUMBER(15, 4) NOT NULL,
  SINGLE_VIEW_BLACK_LIST NUMBER(15, 4) NOT NULL,
  SINGLE_OTHER NUMBER(15, 4) NOT NULL, 
  DISCOUNT_YEAR  NUMBER(15, 4) NOT NULL, 
  DISCOUNT_SMS_PLUS NUMBER(15, 4) NOT NULL, 
  DISCOUNT_CALL NUMBER(15, 4) NOT NULL, 
  DISCOUNT_COUNT_ON_PHONES NUMBER(15, 4) NOT NULL,
  DISCOUNT_OTHERS NUMBER(15, 4) NOT NULL, 
  CALLS_COUNTRY NUMBER(15, 4) NOT NULL, 
  CALLS_SITY NUMBER(15, 4) NOT NULL, 
  CALLS_LOCAL NUMBER(15, 4) NOT NULL, 
  CALLS_SMS_MMS NUMBER(15, 4) NOT NULL, 
  CALLS_GPRS NUMBER(15, 4) NOT NULL, 
  CALLS_RUS_RPP NUMBER(15, 4) NOT NULL, 
  CALLS_ALL NUMBER(15, 4) NOT NULL,
  ROUMING_NATIONAL NUMBER(15, 4) NOT NULL,
  ROUMING_INTERNATIONAL NUMBER(15, 4) NOT NULL
  );
  
CREATE UNIQUE INDEX UNIQUE_ACC_ID_Y_M_PHONE_BAN ON DB_LOADER_FULL_FINANCE_BILL
(ACCOUNT_ID, YEAR_MONTH, PHONE_NUMBER, NVL(BAN,0));

  
CREATE UNIQUE INDEX UNIQUE_ACC_ID_Y_M_PHONE ON DB_LOADER_FULL_FINANCE_BILL
(ACCOUNT_ID, YEAR_MONTH, PHONE_NUMBER)
LOGGING
TABLESPACE USERS
PCTFREE    10
INITRANS   2
MAXTRANS   255
STORAGE    (
            INITIAL          64K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           )
NOPARALLEL;

ALTER TABLE DB_LOADER_FULL_FINANCE_BILL ADD (
  CONSTRAINT UNIQUE_ACC_ID_Y_M_PHONE_BAN
  UNIQUE (ACCOUNT_ID, YEAR_MONTH, PHONE_NUMBER, NVL(BAN, 0)));

ALTER TABLE DB_LOADER_FULL_FINANCE_BILL ADD (
  CONSTRAINT UNIQUE_ACC_ID_Y_M_PHONE
 UNIQUE (ACCOUNT_ID, YEAR_MONTH, PHONE_NUMBER)
    USING INDEX 
    TABLESPACE USERS
    PCTFREE    10
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                PCTINCREASE      0
               ));


CREATE INDEX I_DB_LOADER_FULL_FIN_BILL_PH ON DB_LOADER_FULL_FINANCE_BILL(PHONE_NUMBER) COMPRESS;

CREATE OR REPLACE TRIGGER TIU_DB_LDR_F_FINANCE_BILL
  BEFORE INSERT OR UPDATE ON DB_LOADER_FULL_FINANCE_BILL FOR EACH ROW
--#Version=1
BEGIN
  IF INSERTING THEN
    :NEW.USER_CREATED := USER;
    :NEW.DATE_CREATED := SYSDATE;
  END IF;
  :NEW.USER_LAST_UPDATED := USER;
  :NEW.DATE_LAST_UPDATED := SYSDATE;
END;

CREATE OR REPLACE TRIGGER TD_DB_LOADER_FULL_FINANCE_BILL
--
--#Version=1
--
BEFORE DELETE
ON DB_LOADER_FULL_FINANCE_BILL
REFERENCING NEW AS New OLD AS Old
FOR EACH ROW
BEGIN
    delete from DB_LOADER_FULL_BILL_ABON_PER 
        where 
              account_id = :OLD.account_id
              and year_month = :OLD.year_month
              and phone_number = :OLD.phone_number;
              
    delete from DB_LOADER_FULL_BILL_MG_ROUMING 
        where 
              account_id = :OLD.account_id
              and year_month = :OLD.year_month
              and phone_number = :OLD.phone_number;
   
   delete from DB_LOADER_FULL_BILL_MN_ROUMING 
        where 
              account_id = :OLD.account_id
              and year_month = :OLD.year_month
              and phone_number = :OLD.phone_number;
END TD_DB_LOADER_FULL_FINANCE_BILL;
/



ALTER TABLE DB_LOADER_FULL_FINANCE_BILL ADD (DATE_CREATED DATE);
ALTER TABLE DB_LOADER_FULL_FINANCE_BILL ADD (USER_CREATED       VARCHAR2(30 CHAR));
ALTER TABLE DB_LOADER_FULL_FINANCE_BILL ADD (USER_LAST_UPDATED  VARCHAR2(30 CHAR));
ALTER TABLE DB_LOADER_FULL_FINANCE_BILL ADD (DATE_LAST_UPDATED  DATE);


ALTER TABLE DB_LOADER_FULL_FINANCE_BILL ADD DISCOUNT_SOVINTEL NUMBER(15, 4) DEFAULT 0 NOT NULL;

ALTER TABLE DB_LOADER_FULL_FINANCE_BILL ADD BAN NUMBER(15, 0);

COMMENT ON COLUMN DB_LOADER_FULL_FINANCE_BILL.DISCOUNT_SOVINTEL IS '������ �������� �� ��� �����';

COMMENT ON COLUMN DB_LOADER_FULL_FINANCE_BILL.USER_CREATED IS '������������, ��������� ������';
COMMENT ON COLUMN DB_LOADER_FULL_FINANCE_BILL.DATE_CREATED IS '����/����� �������� ������';
COMMENT ON COLUMN DB_LOADER_FULL_FINANCE_BILL.USER_LAST_UPDATED IS '������������, ��������������� ������ ���������';
COMMENT ON COLUMN DB_LOADER_FULL_FINANCE_BILL.DATE_LAST_UPDATED IS '����/����� ��������� �������� ������';


COMMENT ON COLUMN DB_LOADER_FULL_FINANCE_BILL.ACCOUNT_ID IS '�/�� �������';  

COMMENT ON COLUMN DB_LOADER_FULL_FINANCE_BILL.YEAR_MONTH IS '�����';  

COMMENT ON COLUMN DB_LOADER_FULL_FINANCE_BILL.PHONE_NUMBER IS '�����';  

COMMENT ON COLUMN DB_LOADER_FULL_FINANCE_BILL.ABONKA IS '��� ������';  

COMMENT ON COLUMN DB_LOADER_FULL_FINANCE_BILL.CALLS IS '��� ������';     

COMMENT ON COLUMN DB_LOADER_FULL_FINANCE_BILL.SINGLE_PAYMENTS IS '������� ����������';  

COMMENT ON COLUMN DB_LOADER_FULL_FINANCE_BILL.DISCOUNTS IS '������';  

COMMENT ON COLUMN DB_LOADER_FULL_FINANCE_BILL.BILL_SUM IS '�����';  

COMMENT ON COLUMN DB_LOADER_FULL_FINANCE_BILL.COMPLETE_BILL IS '���� ��������� �����'; 

COMMENT ON COLUMN DB_LOADER_FULL_FINANCE_BILL.ABON_MAIN IS '����. ��. �� ��';  

COMMENT ON COLUMN DB_LOADER_FULL_FINANCE_BILL.ABON_ADD IS '����. ��. �� ������'; 

COMMENT ON COLUMN DB_LOADER_FULL_FINANCE_BILL.ABON_OTHER IS '������ ������';  

COMMENT ON COLUMN DB_LOADER_FULL_FINANCE_BILL.SINGLE_MAIN IS '������� ����. ��. �� ��';  

COMMENT ON COLUMN DB_LOADER_FULL_FINANCE_BILL.SINGLE_ADD IS '������� ����. ��. �� ������';  

COMMENT ON COLUMN DB_LOADER_FULL_FINANCE_BILL.SINGLE_PENALTI IS '����� �� ��������� ���������'; 

COMMENT ON COLUMN DB_LOADER_FULL_FINANCE_BILL.SINGLE_CHANGE_TARIFF IS '����� ��';  

COMMENT ON COLUMN DB_LOADER_FULL_FINANCE_BILL.SINGLE_TURN_ON_SERV IS '����� �� ����������� �����'; 

COMMENT ON COLUMN DB_LOADER_FULL_FINANCE_BILL.SINGLE_CORRECTION_ROUMING IS '������������� ��������';  

COMMENT ON COLUMN DB_LOADER_FULL_FINANCE_BILL.SINGLE_INTRA_WEB IS '������ ��������(������ ���. �������)';     

COMMENT ON COLUMN DB_LOADER_FULL_FINANCE_BILL.SINGLE_VIEW_BLACK_LIST IS '�������� ������� ������';  

COMMENT ON COLUMN DB_LOADER_FULL_FINANCE_BILL.SINGLE_OTHER IS '������ ������� ����������';  

COMMENT ON COLUMN DB_LOADER_FULL_FINANCE_BILL.DISCOUNT_YEAR IS '������� ������ �� ������';  

COMMENT ON COLUMN DB_LOADER_FULL_FINANCE_BILL.DISCOUNT_SMS_PLUS IS '������ �� ����� "���300 � +"'; 

COMMENT ON COLUMN DB_LOADER_FULL_FINANCE_BILL.DISCOUNT_CALL IS '����� 1.2%';  

COMMENT ON COLUMN DB_LOADER_FULL_FINANCE_BILL.DISCOUNT_COUNT_ON_PHONES IS '������ �� ���-�� ����� �������'; 

COMMENT ON COLUMN DB_LOADER_FULL_FINANCE_BILL.DISCOUNT_OTHERS IS '������ ������';  

COMMENT ON COLUMN DB_LOADER_FULL_FINANCE_BILL.CALLS_COUNTRY IS '�/� ������';     

COMMENT ON COLUMN DB_LOADER_FULL_FINANCE_BILL.CALLS_SITY IS '�/� ������';  

COMMENT ON COLUMN DB_LOADER_FULL_FINANCE_BILL.CALLS_LOCAL IS '������� ������';  

COMMENT ON COLUMN DB_LOADER_FULL_FINANCE_BILL.CALLS_SMS_MMS IS '��� � ���';  

COMMENT ON COLUMN DB_LOADER_FULL_FINANCE_BILL.CALLS_GPRS IS '��������';     

COMMENT ON COLUMN DB_LOADER_FULL_FINANCE_BILL.CALLS_RUS_RPP IS '';  

COMMENT ON COLUMN DB_LOADER_FULL_FINANCE_BILL.CALLS_ALL IS '����� �������';  

COMMENT ON COLUMN DB_LOADER_FULL_FINANCE_BILL.ROUMING_NATIONAL IS '������������ �������';  

COMMENT ON COLUMN DB_LOADER_FULL_FINANCE_BILL.ROUMING_INTERNATIONAL IS '������������� �������';   

COMMENT ON COLUMN DB_LOADER_FULL_FINANCE_BILL.BAN IS '���-����� � �������';             
                              
--GRANT SELECT, INSERT, UPDATE, DELETE ON DB_LOADER_FULL_FINANCE_BILL TO SIM_TRADE_ROLE;
               
--GRANT SELECT, INSERT, UPDATE, DELETE ON DB_LOADER_FULL_FINANCE_BILL TO LONTANA_ROLE;
               
--GRANT SELECT, INSERT, UPDATE, DELETE ON DB_LOADER_FULL_FINANCE_BILL TO CORP_MOBILE_ROLE;
               
--GRANT SELECT ON DB_LOADER_FULL_FINANCE_BILL TO CORP_MOBILE_ROLE_RO; 