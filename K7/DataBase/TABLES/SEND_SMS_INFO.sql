--ALTER TABLE SEND_SMS_INFO
-- DROP PRIMARY KEY CASCADE;

--DROP TABLE SEND_SMS_INFO CASCADE CONSTRAINTS;
-- �������� 02.11.2012 ������� ����� �������� �����������

CREATE TABLE SEND_SMS_INFO
(
  ID           NUMBER                           NOT NULL,
  TYPE_NOTIFY  VARCHAR2(38 BYTE),
  YEAR_MONTH   VARCHAR2(20 BYTE),
  IS_SEND      NUMBER(38)
);

CREATE UNIQUE INDEX I_TYPE_NOTIFY_YEAR_MONTH ON SEND_SMS_INFO
(TYPE_NOTIFY, YEAR_MONTH);


ALTER TABLE SEND_SMS_INFO ADD (
  PRIMARY KEY
  (ID));



GRANT DELETE, INSERT, SELECT, UPDATE ON SEND_SMS_INFO TO LONTANA_ROLE;

