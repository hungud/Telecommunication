CREATE SEQUENCE S_NEW_TARIFF_OPTION_COST_ID;

CREATE OR REPLACE FUNCTION NEW_TARIFF_OPTION_COST_ID RETURN NUMBER IS
--#Version=1
  vRES NUMBER;
BEGIN
  SELECT S_NEW_TARIFF_OPTION_COST_ID.NEXTVAL
  INTO vRES
  FROM DUAL;
  RETURN vRES;
END;
/

CREATE TABLE TARIFF_OPTION_COSTS
(
  TARIFF_OPTION_COST_ID       INTEGER                    NOT NULL,
  --
  TARIFF_OPTION_ID   INTEGER
    CONSTRAINT CHK_TARIFF_OPT_COSTS_OPTID_NN NOT NULL
    CONSTRAINT CHK_TARIFF_OPT_COSTS_OPT_ID REFERENCES TARIFF_OPTIONS ON DELETE CASCADE,
  --
  BEGIN_DATE         DATE
    CONSTRAINT CHK_TARIFF_OPT_COSTS_BEGD_NN NOT NULL,
  --
  END_DATE           DATE
    CONSTRAINT CHK_TARIFF_OPT_COSTS_ENDD_NN NOT NULL,
  --
  TARIFF_ID          INTEGER
    CONSTRAINT FK_TARIFF_OPTION_COSTS_TARIFF REFERENCES TARIFFS ON DELETE CASCADE,
  --
  TURN_ON_COST       NUMBER(12, 2),
  MONTHLY_COST       NUMBER(12, 2),
  --
  USER_CREATED       VARCHAR2(30 CHAR),
  DATE_CREATED       DATE,
  USER_LAST_UPDATED  VARCHAR2(30 CHAR),
  DATE_LAST_UPDATED  DATE
);

ALTER TABLE TARIFF_OPTION_COSTS ADD  CONSTRAINT PK_TARIFF_OPTION_COSTS PRIMARY KEY (TARIFF_OPTION_COST_ID);

CREATE OR REPLACE TRIGGER TIU_TARIFF_OPTION_COSTS
  BEFORE INSERT OR UPDATE ON TARIFF_OPTION_COSTS FOR EACH ROW
--#Version=1
BEGIN
  IF INSERTING THEN
    IF NVL(:NEW.TARIFF_OPTION_COST_ID, 0) = 0 then
      :NEW.TARIFF_OPTION_COST_ID := NEW_TARIFF_OPTION_COST_ID;
    END IF;
    :NEW.USER_CREATED := USER;
    :NEW.DATE_CREATED := SYSDATE;
  END IF;
  :NEW.USER_LAST_UPDATED := USER;
  :NEW.DATE_LAST_UPDATED := SYSDATE;
END;
/

 

COMMENT ON TABLE TARIFF_OPTION_COSTS IS '��������� �������� �����';

COMMENT ON COLUMN TARIFF_OPTION_COSTS.TARIFF_OPTION_COST_ID IS '��������� ����';

COMMENT ON COLUMN TARIFF_OPTION_COSTS.TARIFF_OPTION_ID IS '��� �������� �����';

COMMENT ON COLUMN TARIFF_OPTION_COSTS.BEGIN_DATE IS '���� ������ ��������';

COMMENT ON COLUMN TARIFF_OPTION_COSTS.END_DATE IS '���� ��������� ��������';

COMMENT ON COLUMN TARIFF_OPTION_COSTS.TARIFF_ID IS '��� ��������� ����� (�������������)';

COMMENT ON COLUMN TARIFF_OPTION_COSTS.TURN_ON_COST IS '��������� �����������';

COMMENT ON COLUMN TARIFF_OPTION_COSTS.MONTHLY_COST IS '����������� ���������';

COMMENT ON COLUMN TARIFF_OPTION_COSTS.USER_CREATED IS '������������, ��������� ������';

COMMENT ON COLUMN TARIFF_OPTION_COSTS.DATE_CREATED IS '����/����� �������� ������';

COMMENT ON COLUMN TARIFF_OPTION_COSTS.USER_LAST_UPDATED IS '������������, ��������������� ������ ���������';

COMMENT ON COLUMN TARIFF_OPTION_COSTS.DATE_LAST_UPDATED IS '����/����� ��������� �������� ������';

CREATE INDEX I_TARIFF_OPTION_COSTS_OPTIONID ON TARIFF_OPTION_COSTS (TARIFF_OPTION_ID);

CREATE INDEX I_TARIFF_OPTION_COSTS_TARIFFID ON TARIFF_OPTION_COSTS (TARIFF_ID);

ALTER TABLE TARIFF_OPTION_COSTS ADD OPERATOR_TURN_ON_COST NUMBER(12,2);

COMMENT ON COLUMN TARIFF_OPTION_COSTS.OPERATOR_TURN_ON_COST IS '��������� ����������� ����� � ���������';

ALTER TABLE TARIFF_OPTION_COSTS ADD OPERATOR_MONTHLY_COST NUMBER(12,2);

COMMENT ON COLUMN TARIFF_OPTION_COSTS.OPERATOR_MONTHLY_COST IS '����������� ��������� � ���������';

-- ����������� ��������
CREATE INDEX I_TARIFF_OPTION_COSTS_BEGD_ED ON TARIFF_OPTION_COSTS(BEGIN_DATE DESC, END_DATE);

CREATE INDEX I_TARIFF_OPTION_COSTS_OPT1 ON TARIFF_OPTION_COSTS 
  (TARIFF_OPTION_ID, TARIFF_OPTION_COST_ID, BEGIN_DATE, END_DATE,
   TURN_ON_COST, MONTHLY_COST, OPERATOR_TURN_ON_COST, OPERATOR_MONTHLY_COST);