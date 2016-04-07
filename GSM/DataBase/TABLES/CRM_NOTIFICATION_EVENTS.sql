CREATE TABLE CRM_NOTIFICATION_EVENTS(
  CRM_NOTIFICATION_EVENT_ID INTEGER NOT NULL PRIMARY KEY,
  NOTIFICATION_ID INTEGER ,
  USER_NAME VARCHAR2(50),
  ACTION VARCHAR2(10),
  CREATED_AT DATE,
  ABONENT_NUMBER VARCHAR2(12),
  MESSAGE VARCHAR2(500)
  );

COMMENT ON TABLE CRM_NOTIFICATION_EVENTS IS '���� �� ��������� ��� ������������ � CRM';
COMMENT ON COLUMN CRM_NOTIFICATION_EVENTS.CRM_NOTIFICATION_EVENT_ID IS '������������� ����';   
COMMENT ON COLUMN CRM_NOTIFICATION_EVENTS.NOTIFICATION_ID IS '������������� �����������';
COMMENT ON COLUMN CRM_NOTIFICATION_EVENTS.USER_NAME IS '��� ������������, ������������ �������� ��� ������������';
COMMENT ON COLUMN CRM_NOTIFICATION_EVENTS.ACTION IS '��� �������� (create/update/delete)';
COMMENT ON COLUMN CRM_NOTIFICATION_EVENTS.CREATED_AT IS '���� � ����� ��������';
COMMENT ON COLUMN CRM_NOTIFICATION_EVENTS.ABONENT_NUMBER IS '����� ��������';
COMMENT ON COLUMN CRM_NOTIFICATION_EVENTS.MESSAGE IS '����� ���������';



CREATE SEQUENCE CRM_NOTIFICATION_EVENTS_SEQ
  START WITH 1
  MAXVALUE 9999999999999999999999999999
  MINVALUE 1
  NOCYCLE
  CACHE 20
  NOORDER;
  

CREATE OR REPLACE TRIGGER CRM_NOTIFICATION_EVENTS_PKT
BEFORE INSERT ON CRM_NOTIFICATION_EVENTS 
FOR EACH ROW
BEGIN
  :new.CRM_NOTIFICATION_EVENT_ID := CRM_NOTIFICATION_EVENTS_SEQ.NEXTVAL;
END;  


CREATE SYNONYM CRM_USER.CRM_NOTIFICATION_EVENTS FOR CRM_NOTIFICATION_EVENTS;

  
GRANT DELETE, INSERT, SELECT, UPDATE on CRM_NOTIFICATION_EVENTS TO LONTANA_ROLE;
GRANT DELETE, INSERT, SELECT, UPDATE on CRM_NOTIFICATION_EVENTS TO LONTANA_ROLE_RO;

GRANT SELECT on CRM_NOTIFICATION_EVENTS_SEQ TO CRM_USER;

GRANT SELECT on CRM_NOTIFICATION_EVENTS_SEQ TO LONTANA_ROLE;
GRANT SELECT on CRM_NOTIFICATION_EVENTS_SEQ TO LONTANA_ROLE_RO;

GRANT DELETE, INSERT, SELECT, UPDATE on CRM_NOTIFICATION_EVENTS TO CRM_USER;
GRANT SELECT on CRM_NOTIFICATION_EVENTS_SEQ TO CRM_USER;

ALTER TABLE CRM_NOTIFICATION_EVENTS add (ACTIVE_FROM DATE, ACTIVE_TILL DATE);
COMMENT ON COLUMN CRM_NOTIFICATION_EVENTS.ACTIVE_FROM IS '������� � ����';
COMMENT ON COLUMN CRM_NOTIFICATION_EVENTS.ACTIVE_TILL IS '������� �� ����';

ALTER TABLE CRM_NOTIFICATION_EVENTS
MODIFY(MESSAGE VARCHAR2(2000 CHAR))
/