CREATE TABLE SEND_MAIL_PARAM
(
  SMPT_SERVER    VARCHAR2(100 CHAR)             NOT NULL,
  SMPT_PORT      INTEGER                        NOT NULL,
  USER_LOGIN     VARCHAR2(100 CHAR)             NOT NULL,
  USER_PASSWORD  VARCHAR2(100 CHAR)             NOT NULL,
  SMPT_FROM      VARCHAR2(500 CHAR)
);

COMMENT ON TABLE  SEND_MAIL_PARAM               IS '������� �������� �������� ��������� ��� ��������';
COMMENT ON COLUMN SEND_MAIL_PARAM.SMPT_SERVER   IS '����� ������';
COMMENT ON COLUMN SEND_MAIL_PARAM.SMPT_PORT     IS '���� �������';
COMMENT ON COLUMN SEND_MAIL_PARAM.USER_LOGIN    IS '����� ������������';
COMMENT ON COLUMN SEND_MAIL_PARAM.USER_PASSWORD IS '������ ������������';
COMMENT ON COLUMN SEND_MAIL_PARAM.SMPT_FROM     IS '�� ���� ����������';

GRANT DELETE, INSERT, SELECT, UPDATE ON SEND_MAIL_PARAM TO BUSINESS_COMM_ROLE;
GRANT SELECT, UPDATE ON SEND_MAIL_PARAM TO BUSINESS_COMM_ROLE_RO;
