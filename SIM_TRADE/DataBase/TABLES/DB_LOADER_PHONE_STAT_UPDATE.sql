
CREATE TABLE DB_LOADER_PHONE_STAT_UPDATE (
  login varchar2(50),
  YEAR INTEGER,
  MONTH integer,
  PHONE_NUMBER VARCHAR2(10 CHAR),
  INSERT_DATE DATE
);
CREATE OR REPLACE TRIGGER TI_DB_LOADER_PHONE_STAT_UPDATE
  BEFORE INSERT ON DB_LOADER_PHONE_STAT_UPDATE FOR EACH ROW
--#Version=1
BEGIN
    :NEW.INSERT_DATE := sysdate;
END;



--GRANT DELETE, INSERT, SELECT, UPDATE ON DB_LOADER_PHONE_STAT_UPDATE TO CORP_MOBILE_ROLE;

--GRANT SELECT ON DB_LOADER_PHONE_STAT_UPDATE TO CORP_MOBILE_ROLE_RO;  
