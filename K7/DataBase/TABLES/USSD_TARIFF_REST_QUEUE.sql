CREATE TABLE USSD_TARIFF_REST_QUEUE
(
  PHONE_NUMBER       VARCHAR2(10 BYTE),
  DATE_CREATED      DATE                        DEFAULT SYSDATE,
  USER_CREATED      VARCHAR2(20 BYTE)           DEFAULT USER
);

COMMENT ON TABLE USSD_TARIFF_REST_QUEUE IS '������� ������ �� ��������� �������� �� �������';

COMMENT ON COLUMN USSD_TARIFF_REST_QUEUE.PHONE_NUMBER IS '����� ��������';

COMMENT ON COLUMN USSD_TARIFF_REST_QUEUE.DATE_CREATED IS '���� ��������';

COMMENT ON COLUMN USSD_TARIFF_REST_QUEUE.USER_CREATED IS '������������, ��������� ������';