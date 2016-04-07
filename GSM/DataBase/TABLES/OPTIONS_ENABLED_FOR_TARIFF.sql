--#if not ObjectExists("S_NEW_OPTIONS_ENABL_FOR_TAR_ID")
CREATE SEQUENCE S_NEW_OPTIONS_ENABL_FOR_TAR_ID NOCACHE;
--#end if

--#if not TableExists("OPTION_ENABLED_FOR_TARIFFS") then
CREATE TABLE OPTIONS_ENABLED_FOR_TARIFFS
(
  ID            INTEGER  CONSTRAINT PK_OPTIONS_ENABLED_FOR_TARIFFS PRIMARY KEY,
  TARIFF_ID     INTEGER  
    CONSTRAINT FK_OPTS_EN_FOR_TARIFFS_TAR_IF REFERENCES TARIFFS,
  TARIFF_OPTION_ID INTEGER
    CONSTRAINT FK_OPTS_EN_FOR_TARIFFS_OPT_IF REFERENCES TARIFF_OPTIONS,
  USER_CREATED  VARCHAR2(30 CHAR),
  DATE_CREATED  DATE,
  USER_LAST_UPDATED  VARCHAR2(30 CHAR),
  DATE_LAST_UPDATED  DATE
);
COMMENT ON TABLE OPTIONS_ENABLED_FOR_TARIFFS IS '���������� �������� �����, ����������� � ����������� �� ������ ������';
COMMENT ON COLUMN OPTIONS_ENABLED_FOR_TARIFFS.ID IS '��������� ����';
COMMENT ON COLUMN OPTIONS_ENABLED_FOR_TARIFFS.TARIFF_ID IS '��� ������ (������)';
COMMENT ON COLUMN OPTIONS_ENABLED_FOR_TARIFFS.TARIFF_OPTION_ID IS '��� ����������� �������� ����� (������)';

--#end if


--#if not IndexExists("I_OPTIONS_EN_FOR_TARFS_TAR_OPT") THEN
CREATE UNIQUE INDEX I_OPTIONS_EN_FOR_TARFS_TAR_OPT ON OPTIONS_ENABLED_FOR_TARIFFS(TARIFF_ID, TARIFF_OPTION_ID);
--#end if

--#IF GetVersion("TIU_OPTION_ENABLED_FOR_TARIFFS") < 1 THEN
CREATE OR REPLACE TRIGGER TIU_OPTIONS_ENABLED_FOR_TARIFS 
  BEFORE INSERT OR UPDATE ON OPTIONS_ENABLED_FOR_TARIFFS FOR EACH ROW 
--#Version=1
BEGIN 
  IF INSERTING THEN 
    IF NVL(:NEW.ID, 0) = 0 then 
      :NEW.ID := S_NEW_OPTIONS_ENABL_FOR_TAR_ID.NEXTVAL; 
    END IF; 
    :NEW.USER_CREATED := USER; 
    :NEW.DATE_CREATED := SYSDATE;
  END IF; 
  :NEW.USER_LAST_UPDATED := USER; 
  :NEW.DATE_LAST_UPDATED := SYSDATE; 
END;
--#end if
