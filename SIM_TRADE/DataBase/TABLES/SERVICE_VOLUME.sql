CREATE SEQUENCE S_NEW_SERVICE_VOLUME_ID;

CREATE TABLE SERVICE_VOLUME
(
  SERVICE_VOLUME_ID NUMBER NOT NULL,
  NOTICE_VOLUME INTEGER,  
  NOTICE_VOLUME_TEXT VARCHAR2(200 CHAR),
  VOLUME_EXCEEDED INTEGER,  
  VOLUME_EXCEEDED_TEXT VARCHAR2(200 CHAR),
  OPTION_CODE VARCHAR2(30 CHAR),
  SQL_TEXT VARCHAR2(2000 CHAR),
  SQL_PV VARCHAR2(200 CHAR)
);


COMMENT ON TABLE SERVICE_VOLUME IS '������ ������� �� ������';

COMMENT ON COLUMN SERVICE_VOLUME.NOTICE_VOLUME IS '����� ���������� � ������� � �����';

COMMENT ON COLUMN SERVICE_VOLUME.NOTICE_VOLUME_TEXT IS '����� ���������� � ������� � �����';

COMMENT ON COLUMN SERVICE_VOLUME.OPTION_CODE IS '��� �����';

COMMENT ON COLUMN SERVICE_VOLUME.VOLUME_EXCEEDED IS '����� ������ �� ������';

COMMENT ON COLUMN SERVICE_VOLUME.VOLUME_EXCEEDED_TEXT IS '����� ���������� � ���������� ������ ������ �� ������';

CREATE OR REPLACE FUNCTION NEW_SERVICE_VOLUME_ID RETURN NUMBER IS
--#Version=1
  vRES NUMBER;
BEGIN
  SELECT S_NEW_SERVICE_VOLUME_ID.NEXTVAL
  INTO vRES
  FROM DUAL;
  RETURN vRES;
END;
/


CREATE OR REPLACE TRIGGER TI_SERVICE_VOLUME
  BEFORE INSERT OR UPDATE ON SERVICE_VOLUME FOR EACH ROW
--#Version=1
BEGIN
   IF NVL(:NEW.SERVICE_VOLUME_ID, 0) = 0 then
      :NEW.SERVICE_VOLUME_ID := NEW_SERVICE_VOLUME_ID;
    END IF;
END;
/

GRANT DELETE, INSERT, SELECT, UPDATE ON SERVICE_VOLUME TO CORP_MOBILE_ROLE;
GRANT SELECT ON SERVICE_VOLUME TO CORP_MOBILE_ROLE_RO;
