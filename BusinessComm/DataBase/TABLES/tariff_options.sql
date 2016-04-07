CREATE TABLE tariff_options
(
  ID_tariff_options    NUMBER                     NOT NULL,
  NAME_tariff_options  VARCHAR2(60 CHAR)          NOT NULL,
  USER_CREATED         VARCHAR2(30 CHAR)          NOT NULL,
  DATE_CREATED         DATE                       NOT NULL,
  USER_LAST_UPDATED    VARCHAR2(30 CHAR),
  DATE_LAST_UPDATED    DATE                       NOT NULL
);


CREATE UNIQUE INDEX tariff_options_PK ON tariff_options
(ID_tariff_options)
;


ALTER TABLE tariff_options ADD (
  CONSTRAINT tariff_options_PK
  PRIMARY KEY
  (ID_tariff_options)
  USING INDEX tariff_options_PK
  ENABLE VALIDATE);


CREATE SEQUENCE S_NEW_tariff_options
  START WITH 1
  MAXVALUE 999999999999999999999999999
  MINVALUE 1
  NOCYCLE
  CACHE 20
  NOORDER;


CREATE OR REPLACE TRIGGER TIU_tariff_options
  BEFORE INSERT OR UPDATE ON tariff_options FOR EACH ROW
BEGIN
 IF INSERTING THEN
    IF NVL(:NEW.ID_tariff_options, 0) = 0 then
      :NEW.ID_tariff_options := S_NEW_tariff_options.NEXTVAL;
    END IF;
    :NEW.USER_CREATED := USER;
    :NEW.DATE_CREATED := SYSDATE;
    :NEW.USER_LAST_UPDATED := USER;
    :NEW.DATE_LAST_UPDATED := SYSDATE;
  END IF;
  if UPDATING THEN
    :NEW.USER_LAST_UPDATED := USER;
    :NEW.DATE_LAST_UPDATED := SYSDATE;
  end if;
END;
/

COMMENT ON  TABLE TARIFF_OPTIONS IS 'Справочник тарифных опций';
COMMENT ON COLUMN TARIFF_OPTIONS.ID_TARIFF_OPTIONS IS 'Ид тарифной опции';
COMMENT ON COLUMN TARIFF_OPTIONS.NAME_TARIFF_OPTIONS IS 'Наименование тарифной опции';
COMMENT ON COLUMN TARIFF_OPTIONS.USER_CREATED IS 'Пользователь, создавший запись';
COMMENT ON COLUMN TARIFF_OPTIONS.DATE_CREATED IS 'Дата/время создания записи';
COMMENT ON COLUMN TARIFF_OPTIONS.USER_LAST_UPDATED IS 'Пользователь, редактировавший запись последним';
COMMENT ON COLUMN TARIFF_OPTIONS.DATE_LAST_UPDATED IS 'Дата/время последней редакции записи';

GRANT SELECT ON S_NEW_tariff_options TO BUSINESS_COMM_ROLE;
GRANT SELECT, UPDATE ON tariff_options TO BUSINESS_COMM_ROLE;
GRANT SELECT, UPDATE ON tariff_options TO BUSINESS_COMM_ROLE_RO;