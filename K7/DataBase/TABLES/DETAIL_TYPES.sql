CREATE TABLE DETAIL_TYPES(
  DETAIL_TYPE_ID INTEGER PRIMARY KEY,
  TYPE_CONNECTION VARCHAR2(100 CHAR) NOT NULL,
  TYPE_CALL VARCHAR2(100 CHAR),
  COMMENT_CALL VARCHAR2(100 CHAR) NOT NULL,
  DILER_PAY NUMBER(1) DEFAULT 0
  );
  
CREATE SEQUENCE S_NEW_DETAIL_TYPE_ID
  START WITH 1
  MAXVALUE 999999999999999999999999999
  MINVALUE 1
  NOCYCLE
  NOCACHE
  NOORDER;  
  
CREATE OR REPLACE FUNCTION NEW_DETAIL_TYPE_ID RETURN INTEGER IS
--#Version=1
  vRES NUMBER;
BEGIN
  SELECT S_NEW_DETAIL_TYPE_ID.NEXTVAL
    INTO vRES
    FROM DUAL;
  RETURN vRES;
END;  

CREATE OR REPLACE TRIGGER TIU_DETAIL_TYPES
  BEFORE INSERT OR UPDATE ON DETAIL_TYPES FOR EACH ROW
--#Version=1
DECLARE
  PRAGMA AUTONOMOUS_TRANSACTION;
BEGIN
  IF INSERTING THEN
    IF NVL(:NEW.DETAIL_TYPE_ID, 0)=0 THEN
      :NEW.DETAIL_TYPE_ID:=NEW_DETAIL_TYPE_ID;
    END IF;
  END IF;
END;
/ 
  
CREATE INDEX I_DETAIL_TYPES_TYPE_CONNECTION ON DETAIL_TYPES
  (TYPE_CONNECTION)
  LOGGING
  NOPARALLEL;
  
CREATE INDEX I_DETAIL_TYPES_TYPE_CALL ON DETAIL_TYPES
  (TYPE_CALL)
  LOGGING
  NOPARALLEL;
  
CREATE INDEX I_DETAIL_TYPES_COMMENT_CALL ON DETAIL_TYPES
  (COMMENT_CALL)
  LOGGING
  NOPARALLEL;  
  
--GRANT DELETE, INSERT, SELECT, UPDATE ON DETAIL_TYPES TO CORP_MOBILE_ROLE;

--GRANT SELECT ON DETAIL_TYPES TO CORP_MOBILE_ROLE_RO; 