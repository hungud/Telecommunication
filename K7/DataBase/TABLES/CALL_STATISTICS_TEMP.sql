CREATE GLOBAL TEMPORARY TABLE CALL_STATISTICS_TEMP(
  YEAR_MONTH INTEGER,
  SUBSCR_NO NUMBER(11),
  AT_FT_CODE VARCHAR2(6 BYTE),
  CALL_SUM NUMBER(15, 4) DEFAULT 0 NOT NULL,
  DATA_VOL NUMBER(11, 2) DEFAULT 0 NOT NULL,
  ZERO_COST_DATA_VOL NUMBER(11, 2) DEFAULT 0 NOT NULL,
  AT_C_DR_SC NUMBER(11, 2) DEFAULT 0 NOT NULL,
  ZERO_COST_AT_C_DR_SC NUMBER(11, 2) DEFAULT 0 NOT NULL, 
  AT_CDRRD_M NUMBER(11, 2) DEFAULT 0 NOT NULL,
  ZERO_COST_AT_CDRRD_M NUMBER(11, 2) DEFAULT 0 NOT NULL, 
  AMOUNT INTEGER DEFAULT 0 NOT NULL,
  ZERO_COST_AMOUNT INTEGER DEFAULT 0 NOT NULL
  ) ON COMMIT PRESERVE ROWS;

COMMENT ON TABLE CALL_STATISTICS_TEMP IS '������� ���������� �� CALL_YYYY_MM'; 
COMMENT ON COLUMN CALL_STATISTICS_TEMP.YEAR_MONTH IS '�����';
COMMENT ON COLUMN CALL_STATISTICS_TEMP.SUBSCR_NO IS '����� ��������';
COMMENT ON COLUMN CALL_STATISTICS_TEMP.AT_FT_CODE IS '��� ������';
COMMENT ON COLUMN CALL_STATISTICS_TEMP.CALL_SUM IS '����� �������';
COMMENT ON COLUMN CALL_STATISTICS_TEMP.DATA_VOL IS '����� ���������(��)';
COMMENT ON COLUMN CALL_STATISTICS_TEMP.ZERO_COST_DATA_VOL IS '����� ����������� ���������(��)';
COMMENT ON COLUMN CALL_STATISTICS_TEMP.AT_C_DR_SC IS '������������ (���.)';
COMMENT ON COLUMN CALL_STATISTICS_TEMP.ZERO_COST_AT_C_DR_SC IS '������������ ���������� (���.)';
COMMENT ON COLUMN CALL_STATISTICS_TEMP.AT_CDRRD_M IS '������������ (���., � �����������)';
COMMENT ON COLUMN CALL_STATISTICS_TEMP.ZERO_COST_AT_CDRRD_M IS '������������ ���������� (���., � �����������)';
COMMENT ON COLUMN CALL_STATISTICS_TEMP.AMOUNT IS '���������� �������';
COMMENT ON COLUMN CALL_STATISTICS_TEMP.ZERO_COST_AMOUNT IS '���������� ���������� �������';