CREATE TABLE BILL_FINANCE_FOR_CLIENTS_SAVED(
  ACCOUNT_ID INTEGER NOT NULL,
  YEAR_MONTH INTEGER NOT NULL,
  PHONE_NUMBER VARCHAR2(10 CHAR) NOT NULL,
  BILL_SUM_OLD NUMBER(15, 4) NOT NULL,
  BILL_SUM_NEW NUMBER(15, 4) NOT NULL,
  ABON_TP_OLD NUMBER(15, 4) NOT NULL,
  ABON_TP_NEW NUMBER(15, 4) NOT NULL,
  ABON_ADD_OLD NUMBER(15, 4) NOT NULL,
  ABON_ADD_NEW NUMBER(15, 4) NOT NULL,
  DISCOUNT_OLD NUMBER(15, 4) NOT NULL,
  DISCOUNT_NEW NUMBER(15, 4) NOT NULL,
  SINGLE_PENALTI NUMBER(15, 4) NOT NULL,
  SINGLE_PAYMENTS_OLD NUMBER(15, 4) NOT NULL,
  SINGLE_PAYMENTS_NEW NUMBER(15, 4) NOT NULL,
  CALLS_COUNTRY NUMBER(15,4) NOT NULL,
  CALLS_SITY	NUMBER(15,4) NOT NULL,
  CALLS_LOCAL NUMBER(15,4) NOT NULL,
  CALLS_SMS_MMS NUMBER(15,4) NOT NULL,
  CALLS_GPRS NUMBER(15,4) NOT NULL,
  CALLS_RUS_RPP NUMBER(15,4) NOT NULL,
  COMPLETE_BILL INTEGER NOT NULL,
  USER_CREATED	VARCHAR2(30 Char),
  DATE_CREATED	DATE,
  USER_LAST_UPDATED	VARCHAR2(30 Char),
  DATE_LAST_UPDATED	DATE
  );  
  
CREATE INDEX I_BILL_FIN_FOR_CL_SAVED_DATE ON BILL_FINANCE_FOR_CLIENTS_SAVED
(PHONE_NUMBER, ACCOUNT_ID, YEAR_MONTH, COMPLETE_BILL)
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


CREATE INDEX I_BILL_FIN_FOR_CLIENTS_SAVED ON BILL_FINANCE_FOR_CLIENTS_SAVED
(PHONE_NUMBER, ACCOUNT_ID, YEAR_MONTH)
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

CREATE OR REPLACE TRIGGER TIU_BILL_FIN_FOR_CLIENTS_SAVED
  BEFORE INSERT OR UPDATE ON BILL_FINANCE_FOR_CLIENTS_SAVED FOR EACH ROW
  --Version=1
BEGIN
  IF INSERTING THEN
    :NEW.USER_CREATED := USER;
    :NEW.DATE_CREATED := SYSDATE;
  END IF;  
  :NEW.USER_LAST_UPDATED := USER;
  :NEW.DATE_LAST_UPDATED := SYSDATE;
END;
/  
    
GRANT SELECT, INSERT, DELETE, UPDATE ON BILL_FINANCE_FOR_CLIENTS_SAVED TO LONTANA_ROLE;
  
--GRANT SELECT, INSERT, DELETE, UPDATE ON BILL_FINANCE_FOR_CLIENTS_SAVED TO SIM_TRADE_ROLE;
  
--GRANT SELECT, INSERT, DELETE, UPDATE ON BILL_FINANCE_FOR_CLIENTS_SAVED TO CORP_MOBILE_ROLE;
  
--GRANT SELECT, INSERT, DELETE, UPDATE ON BILL_FINANCE_FOR_CLIENTS_SAVED TO CORP_MOBILE_ROLE_RO;