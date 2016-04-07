create table DELAYED_ON_OFF_TARIFF_OPT_LOG
(
  PHONE_NUMBER        VARCHAR2(10)  not null,
  OPTION_CODE         VARCHAR2(30 CHAR)  not null,
  ACTION_TYPE             NUMBER(1) not null,
  ACTION_DATE            DATE  not null,
  DATE_CREATED           DATE,  
  USER_CREATED           VARCHAR2(30),
  REQUEST_DATE_TIME   DATE,
  RESULT_TURN          VARCHAR2(3000),
  DATE_LAST_UPDATED           DATE,  
  USER_LAST_UPDATED           VARCHAR2(30),
  DATE_CREATED_LOG DATE,
  USER_CREATED_LOG varchar2(30)

);

COMMENT ON TABLE DELAYED_ON_OFF_TARIFF_OPT_LOG IS '������� � ����� ��������� ���������� ����������� / ���������� �����';
COMMENT ON COLUMN DELAYED_ON_OFF_TARIFF_OPT_LOG.PHONE_NUMBER IS '����� ��������';
COMMENT ON COLUMN DELAYED_ON_OFF_TARIFF_OPT_LOG.OPTION_CODE IS '��� �����';
COMMENT ON COLUMN DELAYED_ON_OFF_TARIFF_OPT_LOG.ACTION_TYPE IS '��� �������� ( 0 - ����. / 1 - �����.)';
COMMENT ON COLUMN DELAYED_ON_OFF_TARIFF_OPT_LOG.ACTION_DATE IS '����, ����� ������ ������ ���� ���������/����������';
COMMENT ON COLUMN DELAYED_ON_OFF_TARIFF_OPT_LOG.DATE_CREATED IS '���� �������� ������ � DELAYED_ON_OFF_TARIFF_OPTIONS';
COMMENT ON COLUMN DELAYED_ON_OFF_TARIFF_OPT_LOG.USER_CREATED IS '��� ������������, ���������� ������ � DELAYED_ON_OFF_TARIFF_OPTIONS';
COMMENT ON COLUMN DELAYED_ON_OFF_TARIFF_OPT_LOG.REQUEST_DATE_TIME IS '���� � ����� �������� ������';
COMMENT ON COLUMN DELAYED_ON_OFF_TARIFF_OPT_LOG.RESULT_TURN IS '���������';
COMMENT ON COLUMN DELAYED_ON_OFF_TARIFF_OPT_LOG.DATE_CREATED_LOG IS '���� �������� ������ � DELAYED_ON_OFF_TARIFF_OPT_LOG';
COMMENT ON COLUMN DELAYED_ON_OFF_TARIFF_OPT_LOG.USER_CREATED_LOG IS '��� ������������, ���������� ������ � DELAYED_ON_OFF_TARIFF_OPT_LOG';
COMMENT ON COLUMN DELAYED_ON_OFF_TARIFF_OPTIONS.DATE_LAST_UPDATED IS '���� ���������� ���������� ������ � DELAYED_ON_OFF_TARIFF_OPTIONS';
COMMENT ON COLUMN DELAYED_ON_OFF_TARIFF_OPTIONS.USER_LAST_UPDATED IS '��� ������������, ����������� ������ ��������� ������ � DELAYED_ON_OFF_TARIFF_OPTIONS';

CREATE OR REPLACE TRIGGER TI_DELAYED_TURN_TARIFF_OPT_LOG
  BEFORE INSERT ON DELAYED_ON_OFF_TARIFF_OPT_LOG FOR EACH ROW
BEGIN
  :NEW.DATE_CREATED_LOG := SYSDATE;
  :NEW.USER_CREATED_LOG := USER;
END;

GRANT SELECT ON DELAYED_ON_OFF_TARIFF_OPT_LOG TO CORP_MOBILE_ROLE_RO;