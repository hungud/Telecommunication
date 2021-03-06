DROP TABLE CORP_MOBILE.DB_LOADER_REPORT_DATA CASCADE CONSTRAINTS;

CREATE TABLE CORP_MOBILE.DB_LOADER_REPORT_DATA
(
  YEAR_MONTH        INTEGER,
  PHONE_NUMBER      VARCHAR2(20 CHAR)           NOT NULL,
  DETAIL_SUM        NUMBER(10,2)                NOT NULL,
  DATE_LAST_UPDATE  DATE
)
TABLESPACE USERS
RESULT_CACHE (MODE DEFAULT)
PCTUSED    0
PCTFREE    10
INITRANS   1
MAXTRANS   255
STORAGE    (
            INITIAL          10M
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
            FLASH_CACHE      DEFAULT
            CELL_FLASH_CACHE DEFAULT
           )
LOGGING 
NOCOMPRESS 
NOCACHE
NOPARALLEL
MONITORING;


CREATE UNIQUE INDEX CORP_MOBILE.I_DB_LOADER_REPORT_Y_M_PHONE ON CORP_MOBILE.DB_LOADER_REPORT_DATA
(YEAR_MONTH, PHONE_NUMBER)
LOGGING
TABLESPACE USERS
PCTFREE    10
INITRANS   2
MAXTRANS   255
STORAGE    (
            INITIAL          9M
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
            FLASH_CACHE      DEFAULT
            CELL_FLASH_CACHE DEFAULT
           )
NOPARALLEL
COMPRESS 1;


CREATE OR REPLACE TRIGGER CORP_MOBILE.TU_DB_LDR_RPT_DATA
BEFORE UPDATE
ON CORP_MOBILE.DB_LOADER_REPORT_DATA
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
DECLARE
  CURSOR C(pPHONE IN VARCHAR2) IS
    SELECT C.PHONE_NUMBER_FEDERAL,
           C.CURR_TARIFF_ID,
           TR.CALC_KOEFF_DETAL
      FROM CONTRACTS C,
           TARIFFS TR
      WHERE C.PHONE_NUMBER_FEDERAL = pPHONE
        AND NOT EXISTS (SELECT 1
                          FROM CONTRACT_CANCELS CC
                          WHERE C.CONTRACT_ID = CC.CONTRACT_ID)
        AND C.CURR_TARIFF_ID = TR.TARIFF_ID(+)
        AND TR.CALC_KOEFF_DETAL IS NOT NULL;
  DUMMY C%ROWTYPE;
BEGIN
  OPEN C(:NEW.PHONE_NUMBER);
  FETCH C INTO DUMMY;
  IF C%FOUND THEN
    :NEW.DETAIL_SUM:=:NEW.DETAIL_SUM * DUMMY.CALC_KOEFF_DETAL;
  END IF;
  CLOSE C;
  IF UPDATING THEN  
    IF (:new.DETAIL_SUM > :old.DETAIL_SUM) THEN
      :new.DATE_LAST_UPDATE := SYSDATE;
      INSERT INTO QUEUE_CURRENT_BALANCES(PHONE_NUMBER, QUEUE_TYPE)
        VALUES(:NEW.PHONE_NUMBER, 43);  
    ELSE
      :new.DETAIL_SUM := :old.DETAIL_SUM;
    END IF;
  END IF;          
END;
/


CREATE OR REPLACE SYNONYM CORP_MOBILE_C7.DB_LOADER_REPORT_DATA FOR CORP_MOBILE.DB_LOADER_REPORT_DATA;


CREATE OR REPLACE SYNONYM CORP_MOBILE_COPY_1341.DB_LOADER_REPORT_DATA FOR CORP_MOBILE.DB_LOADER_REPORT_DATA;


CREATE OR REPLACE SYNONYM CORP_MOBILE_COPY2.DB_LOADER_REPORT_DATA FOR CORP_MOBILE.DB_LOADER_REPORT_DATA;


CREATE OR REPLACE SYNONYM CORP_MOBILE_COPY4.DB_LOADER_REPORT_DATA FOR CORP_MOBILE.DB_LOADER_REPORT_DATA;


CREATE OR REPLACE SYNONYM "CORP_MOBILE_C�".DB_LOADER_REPORT_DATA FOR CORP_MOBILE.DB_LOADER_REPORT_DATA;


CREATE OR REPLACE SYNONYM CORP_MOBILE_COPY_27.DB_LOADER_REPORT_DATA FOR CORP_MOBILE.DB_LOADER_REPORT_DATA;


CREATE OR REPLACE SYNONYM CORP_MOBILE_COPY_NPV.DB_LOADER_REPORT_DATA FOR CORP_MOBILE.DB_LOADER_REPORT_DATA;


CREATE OR REPLACE SYNONYM CORP_MOBILE_COPY_LEV.DB_LOADER_REPORT_DATA FOR CORP_MOBILE.DB_LOADER_REPORT_DATA;


CREATE OR REPLACE SYNONYM CORP_MOBILE_C0318.DB_LOADER_REPORT_DATA FOR CORP_MOBILE.DB_LOADER_REPORT_DATA;


CREATE OR REPLACE SYNONYM CORP_MOBILE_C0409.DB_LOADER_REPORT_DATA FOR CORP_MOBILE.DB_LOADER_REPORT_DATA;


GRANT DELETE, INSERT, SELECT, UPDATE ON CORP_MOBILE.DB_LOADER_REPORT_DATA TO CORP_MOBILE_C0318;

GRANT DELETE, INSERT, SELECT, UPDATE ON CORP_MOBILE.DB_LOADER_REPORT_DATA TO CORP_MOBILE_C0409;

GRANT DELETE, INSERT, SELECT, UPDATE ON CORP_MOBILE.DB_LOADER_REPORT_DATA TO CORP_MOBILE_C7;

GRANT DELETE, INSERT, SELECT, UPDATE ON CORP_MOBILE.DB_LOADER_REPORT_DATA TO CORP_MOBILE_COPY2;

GRANT DELETE, INSERT, SELECT, UPDATE ON CORP_MOBILE.DB_LOADER_REPORT_DATA TO CORP_MOBILE_COPY4;

GRANT DELETE, INSERT, SELECT, UPDATE ON CORP_MOBILE.DB_LOADER_REPORT_DATA TO CORP_MOBILE_COPY_1341;

GRANT DELETE, INSERT, SELECT, UPDATE ON CORP_MOBILE.DB_LOADER_REPORT_DATA TO CORP_MOBILE_COPY_27;

GRANT DELETE, INSERT, SELECT, UPDATE ON CORP_MOBILE.DB_LOADER_REPORT_DATA TO CORP_MOBILE_COPY_LEV;

GRANT DELETE, INSERT, SELECT, UPDATE ON CORP_MOBILE.DB_LOADER_REPORT_DATA TO CORP_MOBILE_COPY_NPV;

GRANT DELETE, INSERT, SELECT, UPDATE ON CORP_MOBILE.DB_LOADER_REPORT_DATA TO "CORP_MOBILE_C�";

GRANT DELETE, INSERT, SELECT, UPDATE ON CORP_MOBILE.DB_LOADER_REPORT_DATA TO CORP_MOBILE_ROLE;

GRANT SELECT ON CORP_MOBILE.DB_LOADER_REPORT_DATA TO CORP_MOBILE_ROLE_RO;
