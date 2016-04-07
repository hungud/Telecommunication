CREATE GLOBAL TEMPORARY TABLE HOT_BILLING_CALLS_READING(
  DBF_ID     INTEGER,
  SUBSCR_NO  VARCHAR2(11 BYTE),
  CH_SEIZ_DT VARCHAR2(16 BYTE),
  US_SEQ_N   VARCHAR2(9 BYTE),
  AT_SOC     VARCHAR2(9 BYTE),
  AT_FT_CODE VARCHAR2(6 BYTE),
  PC_PLAN_CD VARCHAR2(9 BYTE),
  C_ACT_CD   VARCHAR2(1 BYTE),
  AT_CHG_AMT VARCHAR2(14 BYTE),
  CALLING_NO VARCHAR2(21 BYTE),
  MESSAGE_TP VARCHAR2(1 BYTE),
  SRV_FT_CD  VARCHAR2(6 BYTE),
  DURATION   VARCHAR2(8 BYTE),
  DATA_VOL   VARCHAR2(14 BYTE),
  IMEI       VARCHAR2(15 BYTE),
  CELL_ID    VARCHAR2(6 BYTE),
  PROV_ID    VARCHAR2(8 BYTE),
  DIALED_DIG VARCHAR2(21 BYTE),
  UOM        VARCHAR2(2 BYTE),
  DISCT_SOCS VARCHAR2(100 BYTE),
  AT_FT_DESC VARCHAR2(100 CHAR)
  ) ON COMMIT PRESERVE ROWS;

COMMENT ON TABLE HOT_BILLING_CALLS_READING IS '��������� ������� ��� ��������(������.)';

COMMENT ON COLUMN HOT_BILLING_CALLS_READING.DBF_ID IS 'ID ����� ���������';
COMMENT ON COLUMN HOT_BILLING_CALLS_READING.SUBSCR_NO IS '������� �����';
COMMENT ON COLUMN HOT_BILLING_CALLS_READING.CH_SEIZ_DT IS '����_����� ���������� ������';
COMMENT ON COLUMN HOT_BILLING_CALLS_READING.US_SEQ_N IS '���������� ����� ������ (��������� ����)';
COMMENT ON COLUMN HOT_BILLING_CALLS_READING.AT_SOC IS '������, �� ������� ������������ �����������';
COMMENT ON COLUMN HOT_BILLING_CALLS_READING.AT_FT_CODE IS '��� ������ � �������';
COMMENT ON COLUMN HOT_BILLING_CALLS_READING.PC_PLAN_CD IS '�������� ����';
COMMENT ON COLUMN HOT_BILLING_CALLS_READING.C_ACT_CD IS '��� ������';
COMMENT ON COLUMN HOT_BILLING_CALLS_READING.AT_CHG_AMT IS '���������';
COMMENT ON COLUMN HOT_BILLING_CALLS_READING.CALLING_NO IS '����� ���������� ������';
COMMENT ON COLUMN HOT_BILLING_CALLS_READING.MESSAGE_TP IS '��� ������: �������� ��� �������';
COMMENT ON COLUMN HOT_BILLING_CALLS_READING.SRV_FT_CD IS '������ (���)';
COMMENT ON COLUMN HOT_BILLING_CALLS_READING.DURATION IS '������������';
COMMENT ON COLUMN HOT_BILLING_CALLS_READING.DATA_VOL IS '����� (��� data)';
COMMENT ON COLUMN HOT_BILLING_CALLS_READING.IMEI IS 'IMEI (���)';
COMMENT ON COLUMN HOT_BILLING_CALLS_READING.CELL_ID IS '������������� ����';
COMMENT ON COLUMN HOT_BILLING_CALLS_READING.PROV_ID IS '�������-��������� (������� ROAMING_PROVIDERS)';
COMMENT ON COLUMN HOT_BILLING_CALLS_READING.DIALED_DIG IS '��������� �����';
COMMENT ON COLUMN HOT_BILLING_CALLS_READING.UOM IS '������� ���������';
COMMENT ON COLUMN HOT_BILLING_CALLS_READING.DISCT_SOCS IS '������-������';
COMMENT ON COLUMN HOT_BILLING_CALLS_READING.AT_FT_DESC IS '��� ������ (�����).';

CREATE INDEX I_HB_CR$SUBSCR_NO$AT_FT_CODE ON HOT_BILLING_CALLS_READING(SUBSCR_NO, AT_FT_CODE) COMPRESS 1;

CREATE INDEX I_HB_CR$DBF_ID ON HOT_BILLING_CALLS_READING(DBF_ID);

CREATE INDEX PK_HOT_BILLING_CALLS_READING ON HOT_BILLING_CALLS_READING(SUBSCR_NO, CH_SEIZ_DT, US_SEQ_N) COMPRESS 1;

CREATE INDEX I_HB_CR$UOM ON HOT_BILLING_CALLS_READING(UOM);

CREATE INDEX I_HB_CR$C_ACT_CD ON HOT_BILLING_CALLS_READING(C_ACT_CD);

CREATE INDEX I_HB_CR$MESSAGE_TP ON HOT_BILLING_CALLS_READING(MESSAGE_TP);

CREATE INDEX I_HB_CR$SRV_FT_CD ON HOT_BILLING_CALLS_READING(SRV_FT_CD);

GRANT DELETE, INSERT, SELECT, UPDATE ON HOT_BILLING_CALLS_READING TO LONTANA_ROLE;

GRANT SELECT ON HOT_BILLING_CALLS_READING TO LONTANA_ROLE_RO;