CREATE TABLE K7_LK.USER_EVENTS (
  USER_EVENT_ID INTEGER NOT NULL PRIMARY KEY,
  EVENT_NAME VARCHAR2(50 CHAR)

);

COMMENT ON TABLE K7_LK.USER_EVENTS IS '��� �������� ������������';
/
COMMENT ON COLUMN K7_LK.USER_EVENTS.USER_EVENT_ID IS '�� ������';
/
COMMENT ON COLUMN K7_LK.USER_EVENTS.EVENT_NAME IS '��� ��������';
/
CREATE SEQUENCE K7_LK.S_USER_EVENT_ID
  START WITH 1
  MAXVALUE 999999999999999999999999999
  MINVALUE 1
  NOCYCLE
  CACHE 20
  NOORDER;
/  


CREATE OR REPLACE TRIGGER K7_LK.TBI_USER_EVENTS
  BEFORE INSERT ON K7_LK.USER_EVENTS  
  FOR EACH ROW
BEGIN
  
  if nvl(:NEW.USER_EVENT_ID, 0) = 0 then
    :NEW.USER_EVENT_ID := K7_LK.S_USER_EVENT_ID.NEXTVAL;  
  end if;
END;
/