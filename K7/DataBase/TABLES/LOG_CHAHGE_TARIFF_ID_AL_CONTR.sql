CREATE TABLE LOG_CHAHGE_TARIFF_ID_AL_CONTR
(
  PHONE_NUMBER VARCHAR2(10),
  TARIFF_ID_OLD INTEGER,
  TARIFF_ID_NEW INTEGER,
  DATE_INSERTED DATE DEFAULT SYSDATE,
  USER_INSERTED VARCHAR2(30) DEFAULT USER
);

COMMENT ON TABLE LOG_CHAHGE_TARIFF_ID_AL_CONTR IS '��� ���������� ��������� ������ ��� �������������� �������� ���������(��������� LOAD_NEW_CONTRACTS_BY_UTL)';

COMMENT ON COLUMN LOG_CHAHGE_TARIFF_ID_AL_CONTR.PHONE_NUMBER IS '����� ��������';
COMMENT ON COLUMN LOG_CHAHGE_TARIFF_ID_AL_CONTR.TARIFF_ID_OLD IS '������ ID ������';
COMMENT ON COLUMN LOG_CHAHGE_TARIFF_ID_AL_CONTR.TARIFF_ID_NEW IS '����� ID ������';
COMMENT ON COLUMN LOG_CHAHGE_TARIFF_ID_AL_CONTR.DATE_INSERTED IS '���� �������';
COMMENT ON COLUMN LOG_CHAHGE_TARIFF_ID_AL_CONTR.USER_INSERTED IS '���������� ������������';