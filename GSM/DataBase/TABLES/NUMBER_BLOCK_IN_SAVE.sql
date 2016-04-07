CREATE TABLE NUMBER_BLOCK_IN_SAVE(
  PHONE_NUMBER VARCHAR2(10 BYTE),
  USER_LAST_UPDATED VARCHAR2(30 BYTE),
  DATE_LAST_UPDATED DATE,
  USER_CREATED VARCHAR2(30 BYTE),
  DATE_CREATED DATE
  );

COMMENT ON TABLE number_block_in_save IS '������, ��������������� �� ����������';

COMMENT ON COLUMN NUMBER_BLOCK_IN_SAVE.PHONE_NUMBER IS '����� ��������';

COMMENT ON COLUMN NUMBER_BLOCK_IN_SAVE.USER_LAST_UPDATED IS '������������, ����������';

COMMENT ON COLUMN NUMBER_BLOCK_IN_SAVE.DATE_LAST_UPDATED IS '���� ���������';

COMMENT ON COLUMN NUMBER_BLOCK_IN_SAVE.USER_CREATED IS '������������, ���������';

COMMENT ON COLUMN NUMBER_BLOCK_IN_SAVE.DATE_CREATED IS '���� ��������';

CREATE OR REPLACE TRIGGER TIU_PHONE_BLOCK_IN_SAVE
  BEFORE INSERT OR UPDATE ON number_block_in_save
  REFERENCING NEW AS New OLD AS Old FOR EACH ROW
BEGIN
  IF INSERTING THEN
    :NEW.DATE_CREATED := SYSDATE;
    :NEW.USER_CREATED := USER;
  END IF;
  IF UPDATING THEN
    :NEW.DATE_LAST_UPDATED := SYSDATE;
    :NEW.USER_LAST_UPDATED := USER;
  END IF;
EXCEPTION
  WHEN OTHERS THEN
    -- Consider logging the error and then re-raise
    RAISE;
END TIU_PHONEBLOCKINSAVE;
/

ALTER TABLE NUMBER_BLOCK_IN_SAVE MODIFY(PHONE_NUMBER NOT NULL);

GRANT SELECT, INSERT, UPDATE, DELETE ON NUMBER_BLOCK_IN_SAVE TO LONTANA_ROLE;

GRANT SELECT ON NUMBER_BLOCK_IN_SAVE TO LONTANA_ROLE;
