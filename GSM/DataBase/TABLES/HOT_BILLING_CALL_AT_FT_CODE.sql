CREATE TABLE HOT_BILLING_CALL_AT_FT_CODE(
  AT_FT_CODE VARCHAR2(6 BYTE) PRIMARY KEY,
  AT_FT_DESC VARCHAR2(100 CHAR),
  DATE_INSERT DATE,
  DATE_LAST_UPDATE DATE,  
  C_ACT_CD VARCHAR2(1 BYTE),
  MESSAGE_TP VARCHAR2(1 BYTE),
  SRV_FT_CD VARCHAR2(6 BYTE),
  UOM VARCHAR2(2 BYTE),
  SERVICE_ID NUMBER(1),
  IS_ROAMING NUMBER(1)
  ) TABLESPACE HOT_BILLING;

COMMENT ON TABLE HOT_BILLING_CALL_AT_FT_CODE IS 'Airtime Feature Code - �������� ���� ������';

COMMENT ON COLUMN HOT_BILLING_CALL_AT_FT_CODE.AT_FT_CODE IS '���';
COMMENT ON COLUMN HOT_BILLING_CALL_AT_FT_CODE.AT_FT_DESC IS '��������';
COMMENT ON COLUMN HOT_BILLING_CALL_AT_FT_CODE.DATE_INSERT IS '���� �������';
COMMENT ON COLUMN HOT_BILLING_CALL_AT_FT_CODE.DATE_LAST_UPDATE IS '���� ����������';
COMMENT ON COLUMN HOT_BILLING_CALL_AT_FT_CODE.C_ACT_CD IS '��� ������';
COMMENT ON COLUMN HOT_BILLING_CALL_AT_FT_CODE.MESSAGE_TP IS '��� ������: �������� ��� �������';
COMMENT ON COLUMN HOT_BILLING_CALL_AT_FT_CODE.SRV_FT_CD IS '������ (���)';
COMMENT ON COLUMN HOT_BILLING_CALL_AT_FT_CODE.UOM IS '������� ���������';
COMMENT ON COLUMN HOT_BILLING_CALL_AT_FT_CODE.SERVICE_ID IS '��� �������';
COMMENT ON COLUMN HOT_BILLING_CALL_AT_FT_CODE.IS_ROAMING IS '��� ��������';

CREATE OR REPLACE TRIGGER TIU_HB_CALL_AT_FT_CODE
  BEFORE INSERT OR UPDATE ON HOT_BILLING_CALL_AT_FT_CODE FOR EACH ROW
BEGIN
  IF INSERTING THEN
    :NEW.DATE_INSERT:=SYSDATE;
  END IF;
  :NEW.DATE_LAST_UPDATE:=SYSDATE;  
END;  

ALTER TABLE HOT_BILLING_CALL_AT_FT_CODE ADD (
  CONSTRAINT HOT_B_C_AT_FT_CODE$C_ACT_CD$F 
  FOREIGN KEY (C_ACT_CD) 
  REFERENCES HOT_BILLING_CALL_C_ACT_CD(C_ACT_CD));

ALTER TABLE HOT_BILLING_CALL_AT_FT_CODE ADD (
  CONSTRAINT HOT_B_C_AT_FT_CD$MESSAGE_TP$F 
  FOREIGN KEY (MESSAGE_TP) 
  REFERENCES HOT_BILLING_CALL_MESSAGE_TP(MESSAGE_TP));

ALTER TABLE HOT_BILLING_CALL_AT_FT_CODE ADD (
  CONSTRAINT HOT_B_C_AT_FT_CODE$SRV_FT_CD$F 
  FOREIGN KEY (SRV_FT_CD) 
  REFERENCES HOT_BILLING_CALL_SRV_FT_CD(SRV_FT_CD));

ALTER TABLE HOT_BILLING_CALL_AT_FT_CODE ADD (
  CONSTRAINT HOT_B_C_AT_FT_CODE$UOM$F 
  FOREIGN KEY (UOM) 
  REFERENCES HOT_BILLING_CALL_UOM(UOM));

ALTER TABLE HOT_BILLING_CALL_AT_FT_CODE ADD (
  CONSTRAINT HOT_B_C_AT_FT_CD$SERVICE_ID$F 
  FOREIGN KEY (SERVICE_ID) 
  REFERENCES HOT_BILLING_CALL_SERVICE_TYPE(SERVICE_ID));

ALTER TABLE HOT_BILLING_CALL_AT_FT_CODE ADD (
  CONSTRAINT HOT_B_C_AT_FT_CD$IS_ROAMING$F 
  FOREIGN KEY (IS_ROAMING) 
  REFERENCES HOT_BILLING_CALL_IS_ROAMING(IS_ROAMING));
  
GRANT DELETE, INSERT, SELECT, UPDATE ON HOT_BILLING_CALL_AT_FT_CODE TO LONTANA_ROLE;

GRANT SELECT ON HOT_BILLING_CALL_AT_FT_CODE TO LONTANA_ROLE_RO;