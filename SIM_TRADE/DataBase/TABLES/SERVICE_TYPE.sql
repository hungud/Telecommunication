--DROP TABLE SERVICE_TYPE CASCADE CONSTRAINTS;

-- �. ��������. ������� ������������ "���" - "��� ������" 

CREATE TABLE SERVICE_TYPE
(
  SERVICE_CODE  NUMBER(38),
  SERVICE_NAME  VARCHAR2(20 CHAR)
)

INSERT INTO SERVICE_TYPE (SERVICE_CODE, SERVICE_NAME) VALUES (1, '������');

INSERT INTO SERVICE_TYPE (SERVICE_CODE, SERVICE_NAME) VALUES (2, '���');

INSERT INTO SERVICE_TYPE (SERVICE_CODE, SERVICE_NAME) VALUES (3, '���');

INSERT INTO SERVICE_TYPE (SERVICE_CODE, SERVICE_NAME) VALUES (4, '��������');

INSERT INTO SERVICE_TYPE (SERVICE_CODE, SERVICE_NAME) VALUES (5, 'WAP');

INSERT INTO SERVICE_TYPE (SERVICE_CODE, SERVICE_NAME) VALUES (6, '������');


COMMENT ON TABLE SERVICE_TYPE IS '��� �����';

COMMENT ON COLUMN SERVICE_TYPE.SERVICE_CODE IS '��� ������';

COMMENT ON COLUMN SERVICE_TYPE.SERVICE_NAME IS '������������ ������';


GRANT DELETE, INSERT, SELECT, UPDATE ON SERVICE_TYPE TO CORP_MOBILE_ROLE;

GRANT DELETE, INSERT, SELECT, UPDATE ON SERVICE_TYPE TO LONTANA;

GRANT DELETE, INSERT, SELECT, UPDATE ON SERVICE_TYPE TO SIM_TRADE;

GRANT SELECT ON SERVICE_TYPE TO CORP_MOBILE_ROLE_RO;
