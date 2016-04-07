CREATE TABLE DB_LOADER_PHONE_PERIODS(
  YEAR_MONTH INTEGER,
  PHONE_NUMBER VARCHAR2(10 CHAR),
  ACCOUNT_ID INTEGER,
  TARIFF_CODE VARCHAR2(12 CHAR), 
  CONSTRAINT PK_DB_PHONE_MODEL_PERIODS PRIMARY KEY (PHONE_NUMBER, YEAR_MONTH)
  ) ORGANIZATION INDEX;

CREATE OR REPLACE TRIGGER TIU_DB_LOADER_PHONE_PERIODS
  before insert or update ON DB_LOADER_PHONE_PERIODS   
  for each row
begin
  IF INSERTING THEN
    INSERT INTO QUEUE_ABONENT_PER_REBILD(YEAR_MONTH, PHONE_NUMBER)
      VALUES(:NEW.YEAR_MONTH, :NEW.PHONE_NUMBER);
  END IF;
end TIU_DB_LOADER_PHONE_PERIODS;
/

--GRANT SELECT, INSERT, UPDATE, DELETE ON DB_LOADER_PHONE_PERIODS TO CORP_MOBILE_ROLE;

--GRANT SELECT ON DB_LOADER_PHONE_PERIODS TO CORP_MOBILE_ROLE_RO;

--GRANT SELECT, INSERT, UPDATE, DELETE ON DB_LOADER_PHONE_PERIODS TO LONTANA_ROLE;

--GRANT SELECT ON DB_LOADER_PHONE_PERIODS TO LONTANA_ROLE_RO;

--GRANT SELECT, INSERT, UPDATE, DELETE ON DB_LOADER_PHONE_PERIODS TO SIM_TRADE_ROLE;