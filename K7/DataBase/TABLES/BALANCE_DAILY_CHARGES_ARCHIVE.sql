CREATE TABLE BALANCE_DAILY_CHARGES_ARCHIVE(
  PHONE_NUMBER NUMBER(10),
  CHARGES_TYPE_ID INTEGER,
  CHARGES_DATE DATE,
  CHARGES_SUMM NUMBER(15, 4),
  CHARGES_COMMENT VARCHAR2(150 CHAR), 
  CONTRACT_ID INTEGER,
  IS_ACTIVE INT,
  TARIFF_ID INT,
  BALANCE_ROW_ID INTEGER,
  CONSTRAINT FK_BALANCE_D_C_A_TYPE_ID
    FOREIGN KEY (CHARGES_TYPE_ID)
    REFERENCES BALANCE_CHARGES_TYPES(CHARGES_TYPE_ID),
  CONSTRAINT FK_BALANCE_D_C_A_TARIFF_ID
    FOREIGN KEY (TARIFF_ID)
    REFERENCES TARIFFS(TARIFF_ID),
  CONSTRAINT FK_BALANCE_D_C_A_BAL_ROW_ID
    FOREIGN KEY (BALANCE_ROW_ID)
    REFERENCES BALANCE_DATA(BALANCE_ROW_ID)
  );

COMMENT ON TABLE BALANCE_DAILY_CHARGES_ARCHIVE IS '������� � ����������� ������� �� ������� "�� �������"'; 
COMMENT ON COLUMN BALANCE_DAILY_CHARGES_ARCHIVE.PHONE_NUMBER IS '�������';
COMMENT ON COLUMN BALANCE_DAILY_CHARGES_ARCHIVE.CHARGES_TYPE_ID IS '��� ����������';
COMMENT ON COLUMN BALANCE_DAILY_CHARGES_ARCHIVE.CHARGES_DATE IS '���� ����������';
COMMENT ON COLUMN BALANCE_DAILY_CHARGES_ARCHIVE.CHARGES_SUMM IS '����� ����������';
COMMENT ON COLUMN BALANCE_DAILY_CHARGES_ARCHIVE.CHARGES_COMMENT IS '����������';
COMMENT ON COLUMN BALANCE_DAILY_CHARGES_ARCHIVE.CONTRACT_ID IS '�� ��������';
COMMENT ON COLUMN BALANCE_DAILY_CHARGES_ARCHIVE.IS_ACTIVE IS '���/��';
COMMENT ON COLUMN BALANCE_DAILY_CHARGES_ARCHIVE.TARIFF_ID IS '�� ������';
COMMENT ON COLUMN BALANCE_DAILY_CHARGES_ARCHIVE.BALANCE_ROW_ID IS '������ �� ������ � ����������� �������';

CREATE INDEX I_BALANCE_D_C_A_PN ON BALANCE_DAILY_CHARGES_ARCHIVE(PHONE_NUMBER);

CREATE INDEX I_BALANCE_D_C_A_CTID ON BALANCE_DAILY_CHARGES_ARCHIVE(CHARGES_TYPE_ID);

CREATE INDEX I_BALANCE_D_C_A_BALANCE_ROW_ID ON BALANCE_DAILY_CHARGES_ARCHIVE(BALANCE_ROW_ID);