CREATE TABLE TARIFF_OPTION_GROUP_COSTS(
  TARIFF_OPT_GROUP_COST_ID INTEGER PRIMARY KEY,
  OPTION_GROUP_ID INTEGER,
  OPTION_CODE VARCHAR2(50 CHAR) NOT NULL,
  TURN_ON_COST NUMBER(13, 5) NOT NULL,
  MONTHLY_COST NUMBER(13, 5) NOT NULL,
  BILL_TURN_ON_COST NUMBER(13, 5) NOT NULL,
  BILL_MONTHLY_COST NUMBER(13, 5) NOT NULL,
  USER_CREATED VARCHAR2(30 CHAR),
  DATE_CREATED DATE,
  USER_LAST_UPDATED VARCHAR2(30 CHAR),
  DATE_LAST_UPDATED DATE
  );
  
CREATE SEQUENCE S_NEW_TARIFF_OPT_GROUP_COST_ID
  START WITH 1
  MAXVALUE 999999999999999999999999999
  MINVALUE 1
  NOCYCLE
  NOCACHE
  NOORDER;  
  
CREATE OR REPLACE FUNCTION NEW_TARIFF_OPT_GROUP_COST_ID RETURN NUMBER IS
--#Version=1
  vRES NUMBER;
BEGIN
  SELECT S_NEW_TARIFF_OPT_GROUP_COST_ID.NEXTVAL
  INTO vRES
  FROM DUAL;
  RETURN vRES;
END;  

CREATE OR REPLACE TRIGGER TIU_TARIFF_OPTION_GROUP_COSTS
  BEFORE INSERT OR UPDATE ON TARIFF_OPTION_GROUP_COSTS FOR EACH ROW
--#Version=1
BEGIN
  IF INSERTING THEN
    IF NVL(:NEW.TARIFF_OPT_GROUP_COST_ID, 0) = 0 then
      :NEW.TARIFF_OPT_GROUP_COST_ID := NEW_TARIFF_OPT_GROUP_COST_ID;
    END IF;
    :NEW.USER_CREATED := USER;
    :NEW.DATE_CREATED := SYSDATE;
  END IF;
  :NEW.USER_LAST_UPDATED := USER;
  :NEW.DATE_LAST_UPDATED := SYSDATE;
END;
  
ALTER TABLE TARIFF_OPTION_GROUP_COSTS ADD (
  CONSTRAINT FK_OPTION_GROUP_ID
 FOREIGN KEY (OPTION_GROUP_ID) 
 REFERENCES TARIFF_OPTION_GROUP(OPTION_GROUP_ID));  
 
GRANT SELECT, INSERT, UPDATE, DELETE ON TARIFF_OPTION_GROUP_COSTS TO CORP_MOBILE_ROLE;
 
GRANT SELECT ON TARIFF_OPTION_GROUP_COSTS TO CORP_MOBILE_ROLE_RO;
 
GRANT SELECT, INSERT, UPDATE, DELETE ON TARIFF_OPTION_GROUP_COSTS TO LONTANA_ROLE;