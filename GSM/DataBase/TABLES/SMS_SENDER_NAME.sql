Create table SMS_SENDER_NAME 
(
  SMS_SENDER_NAME_ID number (1) PRIMARY KEY,
  SMS_SENDER_NAME varchar2 (20)
);



COMMENT ON COLUMN SMS_SENDER_NAME.SMS_SENDER_NAME_ID IS '������������� ������';
COMMENT ON COLUMN SMS_SENDER_NAME.SMS_SENDER_NAME IS '���, ������������ � ���� "�� ����" ��� �������� ���';

CREATE SEQUENCE S_NEW_SMS_SENDER_NAME_ID
  START WITH 0
  MAXVALUE 999999999999999999999999999
  MINVALUE 0
  NOCYCLE
  CACHE 20
  NOORDER;


CREATE OR REPLACE TRIGGER TI_SMS_SENDER_NAME
--#Version=1
  BEFORE INSERT ON SMS_SENDER_NAME FOR EACH ROW
BEGIN
    :NEW.SMS_SENDER_NAME_ID := S_NEW_SMS_SENDER_NAME_ID.Nextval;
END;
/