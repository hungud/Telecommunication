CREATE TABLE QUEUE_ABONENT_PER_REBILD(
  YEAR_MONTH INTEGER,
  PHONE_NUMBER VARCHAR2(10 CHAR),
  DATE_INSERT DATE
  );

COMMENT ON TABLE QUEUE_ABONENT_PER_REBILD IS '������� ��������� ���������� ����������� ��������'; 
COMMENT ON COLUMN QUEUE_ABONENT_PER_REBILD.YEAR_MONTH IS '��� �����';
COMMENT ON COLUMN QUEUE_ABONENT_PER_REBILD.PHONE_NUMBER IS '����� ��������';
COMMENT ON COLUMN QUEUE_ABONENT_PER_REBILD.DATE_INSERT IS '���� �������';


CREATE OR REPLACE TRIGGER TIU_QUEUE_ABONENT_PER_REBILD
  BEFORE INSERT OR UPDATE ON QUEUE_ABONENT_PER_REBILD FOR EACH ROW 
--#Version=1
BEGIN 
  IF INSERTING THEN 
    IF :NEW.DATE_INSERT IS NULL then 
      :NEW.DATE_INSERT := SYSDATE; 
    END IF; 
  END IF;
END;

CREATE INDEX I_QUEUE_ABONENT_PER_REBILD_PH ON QUEUE_ABONENT_PER_REBILD(YEAR_MONTH, TO_NUMBER(PHONE_NUMBER));