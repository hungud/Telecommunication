CREATE TABLE CALL_2016_01(
  DBF_ID     INTEGER,
  SUBSCR_NO  NUMBER(11),
  CH_SEIZ_DT DATE,
  US_SEQ_N   NUMBER(9),
  AT_SOC     VARCHAR2(9 BYTE),
  AT_FT_CODE VARCHAR2(6 BYTE),
  PC_PLAN_CD VARCHAR2(9 BYTE),
  C_ACT_CD   VARCHAR2(1 BYTE),
  AT_C_DR_SC NUMBER(9),
  AT_CDRRD_M NUMBER(11, 2),
  AT_CHG_AMT NUMBER(11, 2),
  CALLING_NO VARCHAR2(21 BYTE),
  MESSAGE_TP VARCHAR2(1 BYTE),
  SRV_FT_CD  VARCHAR2(6 BYTE),
  DATA_VOL   NUMBER(11, 2),
  IMEI       NUMBER(15),
  CELL_ID    NUMBER(6),
  PROV_ID    VARCHAR2(8 BYTE),
  DIALED_DIG VARCHAR2(21 BYTE),
  UOM        VARCHAR2(2 BYTE),
  DISCT_SOCS VARCHAR2(100 BYTE),
  CALL_COST  NUMBER(11, 2),
  MN_UNLIM   NUMBER(1),
  INSERT_DATE DATE
  ) TABLESPACE CALL_2016_01;

COMMENT ON TABLE CALL_2016_01 IS '����������� ������� �� 2015 - 12';

COMMENT ON COLUMN CALL_2016_01.DBF_ID IS 'ID ����� ���������';
COMMENT ON COLUMN CALL_2016_01.SUBSCR_NO IS '������� �����';
COMMENT ON COLUMN CALL_2016_01.CH_SEIZ_DT IS '����_����� ���������� ������';
COMMENT ON COLUMN CALL_2016_01.US_SEQ_N IS '���������� ����� ������ (��������� ����)';
COMMENT ON COLUMN CALL_2016_01.AT_SOC IS '������, �� ������� ������������ �����������';
COMMENT ON COLUMN CALL_2016_01.AT_FT_CODE IS '��� ������ � �������';
COMMENT ON COLUMN CALL_2016_01.PC_PLAN_CD IS '�������� ����';
COMMENT ON COLUMN CALL_2016_01.C_ACT_CD IS '��� ������';
COMMENT ON COLUMN CALL_2016_01.AT_C_DR_SC IS '������������ (���.)';
COMMENT ON COLUMN CALL_2016_01.AT_CDRRD_M IS '������������ (���., � �����������)';
COMMENT ON COLUMN CALL_2016_01.AT_CHG_AMT IS '���������';
COMMENT ON COLUMN CALL_2016_01.CALLING_NO IS '����� ���������� ������';
COMMENT ON COLUMN CALL_2016_01.MESSAGE_TP IS '��� ������: �������� ��� �������';
COMMENT ON COLUMN CALL_2016_01.SRV_FT_CD IS '������ (���)';
COMMENT ON COLUMN CALL_2016_01.DATA_VOL IS '����� (��� data)';
COMMENT ON COLUMN CALL_2016_01.IMEI IS 'IMEI (���)';
COMMENT ON COLUMN CALL_2016_01.CELL_ID IS '������������� ����';
COMMENT ON COLUMN CALL_2016_01.PROV_ID IS '�������-���������';
COMMENT ON COLUMN CALL_2016_01.DIALED_DIG IS '��������� �����';
COMMENT ON COLUMN CALL_2016_01.UOM IS '������� ���������';
COMMENT ON COLUMN CALL_2016_01.DISCT_SOCS IS '������-������';
COMMENT ON COLUMN CALL_2016_01.CALL_COST IS '��������� ��������';
COMMENT ON COLUMN CALL_2016_01.MN_UNLIM IS '������-������';
COMMENT ON COLUMN CALL_2016_01.INSERT_DATE IS '���� �������';

CREATE UNIQUE INDEX PK_CALL_2016_01 ON CALL_2016_01(SUBSCR_NO, CH_SEIZ_DT, US_SEQ_N) COMPRESS 1 tablespace CALL_2016_01;

CREATE INDEX I_CALL_2016_01$SUBSC$AT_FT_CD ON CALL_2016_01(SUBSCR_NO, AT_FT_CODE) COMPRESS 1 tablespace CALL_2016_01;

CREATE INDEX I_CALL_2016_01$DBF_ID ON CALL_2016_01(DBF_ID) COMPRESS 1 tablespace CALL_2016_01;

ALTER TABLE CALL_2016_01 ADD (
  CONSTRAINT CALL_2016_01$DBF_ID$F 
  FOREIGN KEY (DBF_ID) 
  REFERENCES HOT_BILLING_FILES(HBF_ID));

ALTER TABLE CALL_2016_01 ADD (
  CONSTRAINT CALL_2016_01$AT_FT_CODE$F 
  FOREIGN KEY (AT_FT_CODE) 
  REFERENCES HOT_BILLING_CALL_AT_FT_CODE(AT_FT_CODE));

ALTER TABLE CALL_2016_01 ADD (
  CONSTRAINT CALL_2016_01$C_ACT_CD$F 
  FOREIGN KEY (C_ACT_CD) 
  REFERENCES HOT_BILLING_CALL_C_ACT_CD(C_ACT_CD));

ALTER TABLE CALL_2016_01 ADD (
  CONSTRAINT CALL_2016_01$MESSAGE_TP$F 
  FOREIGN KEY (MESSAGE_TP) 
  REFERENCES HOT_BILLING_CALL_MESSAGE_TP(MESSAGE_TP));

ALTER TABLE CALL_2016_01 ADD (
  CONSTRAINT CALL_2016_01$SRV_FT_CD$F 
  FOREIGN KEY (SRV_FT_CD) 
  REFERENCES HOT_BILLING_CALL_SRV_FT_CD(SRV_FT_CD));

ALTER TABLE CALL_2016_01 ADD (
  CONSTRAINT CALL_2016_01$PROV_ID$F 
  FOREIGN KEY (PROV_ID) 
  REFERENCES HOT_BILLING_CALL_PROV_ID(PROV_ID));

ALTER TABLE CALL_2016_01 ADD (
  CONSTRAINT CALL_2016_01$UOM$F 
  FOREIGN KEY (UOM) 
  REFERENCES HOT_BILLING_CALL_UOM(UOM));
  
CREATE OR REPLACE TRIGGER TIU_CALL_2016_01 
  BEFORE INSERT OR UPDATE ON CALL_2016_01 
  REFERENCING NEW AS NEW OLD AS OLD FOR EACH ROW  
DECLARE
  CURSOR C(pYEAR_MONTH IN INTEGER, pSUBSCR_NO IN VARCHAR2, pAT_FT_CODE IN VARCHAR2) IS
    SELECT CS.ROWID
      FROM CALL_STATISTICS CS
      WHERE CS.YEAR_MONTH = pYEAR_MONTH
        AND CS.SUBSCR_NO = pSUBSCR_NO
        AND CS.AT_FT_CODE = pAT_FT_CODE;
  vDUMMY C%ROWTYPE;
  vYEAR_MONTH INTEGER;
BEGIN
  IF INSERTING THEN 
    :NEW.INSERT_DATE:=SYSDATE;            
  END IF; 
  IF LENGTH(:NEW.CELL_ID) < 2 THEN
    :NEW.CELL_ID:=NULL;
  END IF;
  -- ���������� ����������
  IF (INSERTING) 
      OR ((:NEW.CALL_COST<>:OLD.CALL_COST)
          OR (:NEW.DATA_VOL<>:OLD.DATA_VOL)
          OR (:NEW.AT_C_DR_SC<>:OLD.AT_C_DR_SC)
          OR (:NEW.AT_CDRRD_M<>:OLD.AT_CDRRD_M)) THEN
    vYEAR_MONTH:=TO_NUMBER(TO_CHAR(:NEW.CH_SEIZ_DT, 'YYYYMM'));  
    OPEN C(vYEAR_MONTH, :NEW.SUBSCR_NO, :NEW.AT_FT_CODE);
    FETCH C INTO vDUMMY;
    IF C%FOUND THEN
      IF INSERTING THEN      
        UPDATE CALL_STATISTICS CS
          SET CS.CALL_SUM = CS.CALL_SUM + :NEW.CALL_COST,
              CS.DATA_VOL = CS.DATA_VOL + :NEW.DATA_VOL,
              CS.ZERO_COST_DATA_VOL = CS.ZERO_COST_DATA_VOL 
                + CASE WHEN :NEW.CALL_COST = 0 THEN :NEW.DATA_VOL ELSE 0 END,
              CS.AT_C_DR_SC = CS.AT_C_DR_SC + :NEW.AT_C_DR_SC,
              CS.ZERO_COST_AT_C_DR_SC = CS.ZERO_COST_AT_C_DR_SC 
                + CASE WHEN :NEW.CALL_COST = 0 THEN :NEW.AT_C_DR_SC ELSE 0 END,
              CS.AT_CDRRD_M = CS.AT_CDRRD_M + :NEW.AT_CDRRD_M,
              CS.ZERO_COST_AT_CDRRD_M = CS.ZERO_COST_AT_CDRRD_M 
                + CASE WHEN :NEW.CALL_COST = 0 THEN :NEW.AT_CDRRD_M ELSE 0 END,
              CS.AMOUNT = CS.AMOUNT + 1,
              CS.ZERO_COST_AMOUNT = CS.ZERO_COST_AMOUNT 
                + CASE WHEN :NEW.CALL_COST = 0 THEN 1 ELSE 0 END   
          WHERE CS.ROWID = vDUMMY.ROWID;
      ELSE
        UPDATE CALL_STATISTICS CS
          SET CS.CALL_SUM = CS.CALL_SUM + :NEW.CALL_COST - :OLD.CALL_COST,
              CS.DATA_VOL = CS.DATA_VOL + :NEW.DATA_VOL - :OLD.DATA_VOL,
              CS.ZERO_COST_DATA_VOL = CS.ZERO_COST_DATA_VOL 
                + CASE WHEN :NEW.CALL_COST = 0 THEN :NEW.DATA_VOL ELSE 0 END 
                - CASE WHEN :OLD.CALL_COST = 0 THEN :OLD.DATA_VOL ELSE 0 END,
              CS.AT_C_DR_SC = CS.AT_C_DR_SC + :NEW.AT_C_DR_SC - :OLD.AT_C_DR_SC,
              CS.ZERO_COST_AT_C_DR_SC = CS.ZERO_COST_AT_C_DR_SC 
                + CASE WHEN :NEW.CALL_COST = 0 THEN :NEW.AT_C_DR_SC ELSE 0 END 
                - CASE WHEN :OLD.CALL_COST = 0 THEN :OLD.AT_C_DR_SC ELSE 0 END,
              CS.AT_CDRRD_M = CS.AT_CDRRD_M + :NEW.AT_CDRRD_M - :OLD.AT_CDRRD_M,
              CS.ZERO_COST_AT_CDRRD_M = CS.ZERO_COST_AT_CDRRD_M 
                + CASE WHEN :NEW.CALL_COST = 0 THEN :NEW.AT_CDRRD_M ELSE 0 END 
                - CASE WHEN :OLD.CALL_COST = 0 THEN :OLD.AT_CDRRD_M ELSE 0 END,
              CS.ZERO_COST_AMOUNT = CS.ZERO_COST_AMOUNT 
                + CASE WHEN :NEW.CALL_COST = 0 THEN 1 ELSE 0 END 
                - CASE WHEN :OLD.CALL_COST = 0 THEN 1 ELSE 0 END  
          WHERE CS.ROWID = vDUMMY.ROWID;
      END IF;
    ELSE
      INSERT INTO CALL_STATISTICS(YEAR_MONTH, SUBSCR_NO, AT_FT_CODE, CALL_SUM, 
                                  DATA_VOL, ZERO_COST_DATA_VOL, 
                                  AT_C_DR_SC, ZERO_COST_AT_C_DR_SC, 
                                  AT_CDRRD_M, ZERO_COST_AT_CDRRD_M,
                                  AMOUNT, ZERO_COST_AMOUNT)
        VALUES(vYEAR_MONTH, :NEW.SUBSCR_NO, :NEW.AT_FT_CODE, :NEW.CALL_COST,
               :NEW.DATA_VOL, CASE WHEN :NEW.CALL_COST = 0 THEN :NEW.DATA_VOL ELSE 0 END, 
               :NEW.AT_C_DR_SC, CASE WHEN :NEW.CALL_COST = 0 THEN :NEW.AT_C_DR_SC ELSE 0 END, 
               :NEW.AT_CDRRD_M, CASE WHEN :NEW.CALL_COST = 0 THEN :NEW.AT_CDRRD_M ELSE 0 END,
               1, 1);
    END IF;
  END IF;
  --      
END;  

CREATE OR REPLACE TRIGGER TD_CALL_2016_01 
  BEFORE DELETE ON CALL_2016_01 
  REFERENCING NEW AS NEW OLD AS OLD FOR EACH ROW  
BEGIN
  IF :OLD.CALL_COST <> 0 THEN
    UPDATE CALL_STATISTICS CS
      SET CS.CALL_SUM = CS.CALL_SUM - :OLD.CALL_COST,
          CS.DATA_VOL = CS.DATA_VOL - :OLD.DATA_VOL,
          CS.ZERO_COST_DATA_VOL = CS.ZERO_COST_DATA_VOL
            - CASE WHEN :OLD.CALL_COST = 0 THEN :OLD.DATA_VOL ELSE 0 END,
          CS.AT_C_DR_SC = CS.AT_C_DR_SC - :OLD.AT_C_DR_SC,
          CS.ZERO_COST_AT_C_DR_SC = CS.ZERO_COST_AT_C_DR_SC
            - CASE WHEN :OLD.CALL_COST = 0 THEN :OLD.AT_C_DR_SC ELSE 0 END,
          CS.AT_CDRRD_M = CS.AT_CDRRD_M - :OLD.AT_CDRRD_M,
          CS.ZERO_COST_AT_CDRRD_M = CS.ZERO_COST_AT_CDRRD_M
            - CASE WHEN :OLD.CALL_COST = 0 THEN :OLD.AT_CDRRD_M ELSE 0 END,
          CS.AMOUNT = CS.AMOUNT - 1,  
          CS.ZERO_COST_AMOUNT = CS.ZERO_COST_AMOUNT 
            - CASE WHEN :OLD.CALL_COST = 0 THEN 1 ELSE 0 END   
      WHERE CS.YEAR_MONTH = TO_NUMBER(TO_CHAR(:OLD.CH_SEIZ_DT, 'YYYYMM'))
        AND CS.SUBSCR_NO = :OLD.SUBSCR_NO
        AND CS.AT_FT_CODE = :OLD.AT_FT_CODE;
  END IF;
END;  

GRANT DELETE, INSERT, SELECT, UPDATE ON CALL_2016_01 TO CORP_MOBILE_ROLE;

GRANT SELECT ON CALL_2016_01 TO CORP_MOBILE_ROLE_RO;
