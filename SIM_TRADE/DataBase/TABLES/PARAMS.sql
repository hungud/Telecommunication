--#if not TableExists("PARAMS") then
-- Create table
create table PARAMS
(
  param_id INTEGER not null,
  name     VARCHAR2(30) not null,
  value    VARCHAR2(256),
  type     CHAR(1) not null,
  descr    VARCHAR2(400)
);
-- S - строка 
-- P - пароль
-- N - число.
-- B - логическое (1/0)
--#end if

--#if not ConstraintExists("PK_PARAMS")
-- Create/Recreate primary, unique and foreign key constraints 
alter table PARAMS
  add constraint PK_PARAMS primary key (PARAM_ID)
  using index 
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
--#end if

--#if not ConstraintExists("UNQ_PARAM_NAME")
alter table PARAMS
  add constraint UNQ_PARAM_NAME unique (NAME)
  using index 
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
--#end if
  
--#if not ObjectExists("S_NEW_PARAM_ID")
CREATE SEQUENCE S_NEW_PARAM_ID
  START WITH 41
  MAXVALUE 999999999999999999999999999
  MINVALUE 1
  NOCYCLE
  CACHE 20
  NOORDER;
--#end if
  

--#if not ObjectExists("TI_PARAM_ID")
CREATE OR REPLACE TRIGGER TI_PARAM_ID
  BEFORE INSERT ON  PARAMS FOR EACH ROW 
DECLARE

BEGIN
      :NEW.PARAM_ID:= S_NEW_PARAM_ID.NEXTVAL;
END;  
--#end if


--#Execute MAIN_SCHEMA=IsClient("")

--#if not GrantExists("PARAMS", "ROLE", "SELECT") then
begin EXECUTE IMMEDIATE 'GRANT ALL ON PARAMS TO &MAIN_SCHEMA'||'_ROLE'; end;
--#end if

--#if not GrantExists("PARAMS", "ROLE_RO", "SELECT") then
begin EXECUTE IMMEDIATE 'GRANT SELECT ON PARAMS TO &MAIN_SCHEMA'||'_ROLE_RO'; end;
--#end if

CREATE UNIQUE INDEX I_PARAMS_NAME_VALUE ON PARAMS(NAME, VALUE);

ALTER TABLE PARAMS MODIFY(NAME VARCHAR2(60)); 

CREATE UNIQUE INDEX I_PARAMS_NAME_VALUE ON PARAMS(NAME, VALUE);
INSERT INTO PARAMS (NAME, VALUE, TYPE, DESCR) VALUES('ROBOT_SITE_ADRESS', 'http://beeline-api.tarifer.lan:3057;', 'N', 'Адрес робота по новому кабинету Билайн http://beeline-api.tarifer.ru';
INSERT INTO PARAMS (NAME, VALUE, TYPE, DESCR) VALUES('BEELINE_BLOCK_CODE_FOR_BLOCK', 'WIB', 'S', 'Код блокировки по желанию (полная)';
INSERT INTO PARAMS (NAME, VALUE, TYPE, DESCR) VALUES('BEELINE_BLOCK_CODE_FOR_BLOCK_SAVE', 'S1B', 'S', 'Код блокировки по сохранению(полная)';
INSERT INTO PARAMS (NAME, VALUE, TYPE, DESCR) VALUES('SMS_SYSTEM_ERROR_NOTICE_PHONES', '9277401866;', 'N', 'Номера для смс-уведомлений об ошибках системы';
INSERT INTO PARAMS (NAME, VALUE, TYPE, DESCR) VALUES('SMS_SYSTEM_ERROR_NOTICE_TYPES', 'HB;RD;P;ST;TS;', 'N', 'Типы уведомлений.HotBilling;ReportData;Payments;abonSTate';
INSERT INTO PARAMS (NAME, VALUE, TYPE, DESCR) VALUES('DAY_SITE_LOAD', '0', 'B', 'Кол-во дней по прошествие которых деталка будет грузится с сайта.';
INSERT INTO PARAMS (NAME, VALUE, TYPE, DESCR) VALUES('LOADER_N_PAYMENTS_DAY', '5', 'N', 'Указывает на кол-во дней за которые нужно проверять платежи.';
INSERT INTO PARAMS (NAME, VALUE, TYPE, DESCR) VALUES('USS_BEELINE_LOADER_TIME_OUT', '3600', 'N', 'Таймаут для загрузчика с uss.beeline.ru в сек.';
INSERT INTO PARAMS (NAME, VALUE, TYPE, DESCR) VALUES('BEELINE_SOAP_LOG_LEVEL', '1', 'N', 'Логирование обращений к АПИ БИ.';
INSERT INTO PARAMS (NAME, VALUE, TYPE, DESCR) VALUES('SSL_WALLET_DIR', 'file:/u02/app/oracle/wallets', 'S', 'Месторасположения SLL ключей';
Insert into PARAMS  (NAME, VALUE, TYPE, DESCR)  Values   ('BLOCK_SMS_INTERVAL', '12', 'N', 'Период отправки смс с отрицательном балансе в часах');

COMMIT;
