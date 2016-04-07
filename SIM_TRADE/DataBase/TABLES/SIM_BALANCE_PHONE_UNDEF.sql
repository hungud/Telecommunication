CREATE TABLE SIM_BALANCE_PHONE_UNDEF(
  PHONE_UNDEF_ID INTEGER PRIMARY KEY,
  PHONE_NUMBER VARCHAR2(10 CHAR) NOT NULL,
  BALANCE NUMBER NOT NULL,
  NOTE VARCHAR2(500 CHAR),
  DATE_BALANCE_CHECK DATE
);

CREATE SEQUENCE S_NEW_PHONE_UNDEF_ID;

CREATE OR REPLACE FUNCTION NEW_PHONE_UNDEF_ID RETURN NUMBER IS
--#Version=1
  vRES NUMBER;
BEGIN
  SELECT S_NEW_PHONE_UNDEF_ID.NEXTVAL
    INTO vRES
    FROM DUAL;
  RETURN vRES;
END;

CREATE OR REPLACE TRIGGER TIU_SIM_BALANCE_PHONE_UNDEF
  BEFORE INSERT OR UPDATE ON SIM_BALANCE_PHONE_UNDEF FOR EACH ROW
--#Version=1
BEGIN
  IF INSERTING THEN
    IF NVL(:NEW.PHONE_UNDEF_ID, 0) = 0 then
      :NEW.PHONE_UNDEF_ID := NEW_PHONE_UNDEF_ID;
    END IF;
    :NEW.DATE_BALANCE_CHECK := SYSDATE;   
  END IF;
END;

CREATE INDEX I_SIM_BAL_PH_UNDEF_PH_NUMBER ON SIM_BALANCE_PHONE_UNDEF
(PHONE_NUMBER)
LOGGING
NOPARALLEL;

GRANT DELETE, INSERT, SELECT, UPDATE ON LONTANA.SIM_BALANCE_PHONE_UNDEF TO DB_LOADER;

GRANT DELETE, INSERT, SELECT, UPDATE ON LONTANA.SIM_BALANCE_PHONE_UNDEF TO LONTANA_ROLE;