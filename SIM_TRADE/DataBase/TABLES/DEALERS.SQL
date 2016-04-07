--#if isclient("CORP_MOBILE") then
--DROP TABLE DEALERS CASCADE CONSTRAINTS;
--#if not TableExists("DEALERS") then
-- Степан Котенков - справочник диллеров
-- V2 29.05.2013 Назин Добавил колонку DEALERS.sender_name
CREATE TABLE DEALERS(
  DEALER_KOD         INTEGER NOT NULL,
  DEALER_NAME        VARCHAR2(100 CHAR),
  PATTERN            VARCHAR2(10 CHAR),
  REPLACEMENT        VARCHAR2(100 CHAR),
  DATE_CREATED       DATE,
  USER_CREATED       VARCHAR2(30 CHAR),
  DATE_LAST_UPDATED  DATE,
  USER_LAST_UPDATED  VARCHAR2(30 CHAR)
  );
  
COMMENT ON TABLE DEALERS IS 'Справочник дилеров';

COMMENT ON COLUMN DEALERS.DEALER_KOD IS 'Код дилера';

COMMENT ON COLUMN DEALERS.DEALER_NAME IS 'Дилер';

COMMENT ON COLUMN DEALERS.PATTERN IS 'Шаблон';

COMMENT ON COLUMN DEALERS.REPLACEMENT IS 'Замена';

COMMENT ON COLUMN DEALERS.USER_CREATED IS 'Пользователь, создавший запись';

COMMENT ON COLUMN DEALERS.DATE_CREATED IS 'Дата/время создания записи';

COMMENT ON COLUMN DEALERS.DATE_LAST_UPDATED IS 'Дата/время последней редакции записи';

COMMENT ON COLUMN DEALERS.USER_LAST_UPDATED IS 'Пользователь, редактировавший запись последним';

CREATE OR REPLACE TRIGGER TIU_DEALERS
  BEFORE INSERT OR UPDATE ON DEALERS FOR EACH ROW
  --Version=1
BEGIN
  IF INSERTING THEN
    :NEW.USER_CREATED := USER;
    :NEW.DATE_CREATED := SYSDATE;
  END IF;  
  :NEW.USER_LAST_UPDATED := USER;
  :NEW.DATE_LAST_UPDATED := SYSDATE;
END;
--#end if;
--#if not ColumnExists("DEALERS.SENDER_NAME") then 
alter table DEALERS add sender_name varchar2(10);
comment on column DEALERS.sender_name
  is 'Псевдоним в смс';
alter table DEALERS
  add constraint CK_DEALERS_SN_LATIN
  check (regexp_like(SENDER_NAME,'^[a-zA-Z]+$'));
--#end if;

--#if not ColumnExists("DEALERS.WELCOME_SMS") then 
alter table DEALERS add WELCOME_SMS varchar2(512);
comment on column DEALERS.WELCOME_SMS
  is 'Приветственная СМС при заведении договора';
--#end if;

--#Execute MAIN_SCHEMA=IsClient("")

--#if not GrantExists("DEALERS", "ROLE", "SELECT") then
begin EXECUTE IMMEDIATE 'GRANT ALL ON ADD_DB_LOADER_PHONE_STAT_UPD TO &MAIN_SCHEMA'||'_ROLE'; end;
--#end if

--#if not GrantExists("DEALERS", "ROLE_RO", "SELECT") then
begin EXECUTE IMMEDIATE 'GRANT SELECT ON ADD_DB_LOADER_PHONE_STAT_UPD TO &MAIN_SCHEMA'||'_ROLE_RO'; end;
--#end if

--#end if
