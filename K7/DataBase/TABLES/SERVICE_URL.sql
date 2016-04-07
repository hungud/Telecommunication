--#if not TableExists("SERVICE_URL") then
-- Овсянников Лев. 26.10.2012 Справочник URL доступных сервисов. Создана для исключения настроек в тексте пакета LOADER_CALL_PCKG
CREATE TABLE SERVICE_URL
(
  TYPE_LOAD  NUMBER(38)                         NOT NULL,
  URL        VARCHAR2(200 BYTE)                 NOT NULL
);

-- 
-- Non Foreign Key Constraints for Table SERVICE_URL 
-- 
ALTER TABLE SERVICE_URL ADD (
  PRIMARY KEY
  (TYPE_LOAD)
  USING INDEX);

--#end if

--#if not RecordExists("SELECT * FROM SERVICE_URL WHERE TYPE_LOAD=1") then
insert into SERVICE_URL (type_load, url) values (1, 'http://localhost:7988/soap/ISiteRobot');
--#end if
--#if not RecordExists("SELECT * FROM SERVICE_URL WHERE TYPE_LOAD=5") then
insert into SERVICE_URL (type_load, url) values (5, 'http://localhost:7988/soap/ISiteRobot');
--#end if
--#if not RecordExists("SELECT * FROM SERVICE_URL WHERE TYPE_LOAD=10") then
insert into SERVICE_URL (type_load, url) values (10, 'http://localhost:7988/soap/ISiteRobot');
--#end if
--#if not RecordExists("SELECT * FROM SERVICE_URL WHERE TYPE_LOAD=11") then
insert into SERVICE_URL (type_load, url) values (11, 'http://localhost:7988/soap/ISiteRobot');
--#end if
--#if not RecordExists("SELECT * FROM SERVICE_URL WHERE TYPE_LOAD=15") then
insert into SERVICE_URL (type_load, url) values (15, 'http://localhost:7988/soap/ISiteRobot');
--#end if
--#if not RecordExists("SELECT * FROM SERVICE_URL WHERE TYPE_LOAD=20") then
insert into SERVICE_URL (type_load, url) values (20, 'http://localhost:7988/soap/ISiteRobot');
--#end if
--#if not RecordExists("SELECT * FROM SERVICE_URL WHERE TYPE_LOAD=25") then
insert into SERVICE_URL (type_load, url) values (25, 'http://localhost:7988/soap/ISiteRobot');
--#end if
--#if not RecordExists("SELECT * FROM SERVICE_URL WHERE TYPE_LOAD=30") then
insert into SERVICE_URL (type_load, url) values (30, 'http://localhost:7988/soap/ISiteRobot');
--#end if
--#if not RecordExists("SELECT * FROM SERVICE_URL WHERE TYPE_LOAD=35") then
insert into SERVICE_URL (type_load, url) values (35, 'http://localhost:7988/soap/ISiteRobot');
--#end if
--#if not RecordExists("SELECT * FROM SERVICE_URL WHERE TYPE_LOAD=50") then
insert into SERVICE_URL (type_load, url) values (50, 'http://localhost:7988/soap/ISiteRobot');
--#end if
--#if not RecordExists("SELECT * FROM SERVICE_URL WHERE TYPE_LOAD=51") then
insert into SERVICE_URL (type_load, url) values (51, 'http://localhost:7988/soap/ISiteRobot');
--#end if
--#if not RecordExists("SELECT * FROM SERVICE_URL WHERE TYPE_LOAD=52") then
insert into SERVICE_URL (type_load, url) values (52, 'http://localhost:7988/soap/ISiteRobot');
--#end if
--#if not RecordExists("SELECT * FROM SERVICE_URL WHERE TYPE_LOAD=55") then
insert into SERVICE_URL (type_load, url) values (55, 'http://localhost:7988/soap/ISiteRobot');
--#end if
--#if not RecordExists("SELECT * FROM SERVICE_URL WHERE TYPE_LOAD=85") and isclient("GSM_CORP") then
-- GET_PARTNER_URL
insert into SERVICE_URL (type_load, url) values (85, 'http://localhost:7988/soap/ISiteRobot');  
--#end if
--#if not RecordExists("SELECT * FROM SERVICE_URL WHERE TYPE_LOAD=90") and isclient("GSM_CORP") then
-- GET_ADD_DETAIL_COST
insert into SERVICE_URL (type_load, url) values (90, 'http://localhost:7988/soap/ISiteRobot');  
--#end if
--#if not RecordExists("SELECT * FROM SERVICE_URL WHERE TYPE_LOAD=95") and isclient("GSM_CORP") then
-- GET_PARTNER_BALANCE
insert into SERVICE_URL (type_load, url) values (95, 'http://localhost:7988/soap/ISiteRobot');  
--#end if
--#if not RecordExists("SELECT * FROM SERVICE_URL WHERE TYPE_LOAD=100") then
insert into SERVICE_URL (type_load, url) values (100, 'http://localhost:7990/soap/ISiteRobot');
--#end if
--#if not RecordExists("SELECT * FROM SERVICE_URL WHERE TYPE_LOAD=105") then
insert into SERVICE_URL (type_load, url) values (105, 'http://localhost:7990/soap/ISiteRobot');
--#end if
--#if not RecordExists("SELECT * FROM SERVICE_URL WHERE TYPE_LOAD=110") then
insert into SERVICE_URL (type_load, url) values (110, 'http://localhost:7990/soap/ISiteRobot');
--#end if
--#if not RecordExists("SELECT * FROM SERVICE_URL WHERE TYPE_LOAD=115") then
insert into SERVICE_URL (type_load, url) values (115, 'http://localhost:7990/soap/ISiteRobot');
--#end if
--#if not RecordExists("SELECT * FROM SERVICE_URL WHERE TYPE_LOAD=120") then
insert into SERVICE_URL (type_load, url) values (120, 'http://localhost:7990/soap/ISiteRobot');
--#end if
--#if not RecordExists("SELECT * FROM SERVICE_URL WHERE TYPE_LOAD=125") then
insert into SERVICE_URL (type_load, url) values (125, 'http://localhost:7990/soap/ISiteRobot');
--#end if
--#if not RecordExists("SELECT * FROM SERVICE_URL WHERE TYPE_LOAD=130") then
insert into SERVICE_URL (type_load, url) values (130, 'http://localhost:7990/soap/ISiteRobot');
--#end if


--#if not GrantExists("SERVICE_URL", "CORP_MOBILE_ROLE", "UPDATE") AND IsClient("CORP_MOBILE") then
 GRANT SELECT, INSERT, UPDATE, DELETE ON SERVICE_URL TO CORP_MOBILE_ROLE;
--#end if

--#if not GrantExists("SERVICE_URL", "LONTANA_ROLE", "UPDATE") AND IsClient("GSM_CORP") then
 GRANT SELECT, INSERT, UPDATE, DELETE ON SERVICE_URL TO LONTANA_ROLE;
--#end if

--#if not GrantExists("SERVICE_URL", "SIM_TRADE_ROLE", "UPDATE") AND IsClient("SIM_TRADE") then
 GRANT SELECT, INSERT, UPDATE, DELETE ON SERVICE_URL TO SIM_TRADE_ROLE;
--#end if


--#if not GrantExists("SERVICE_URL", "CORP_MOBILE_ROLE_RO", "SELECT") AND IsClient("CORP_MOBILE") then
 GRANT SELECT, INSERT, UPDATE, DELETE ON SERVICE_URL TO CORP_MOBILE_ROLE_RO;
--#end if

--#if not GrantExists("SERVICE_URL", "LONTANA_ROLE_RO", "SELECT") AND IsClient("GSM_CORP") then
 GRANT SELECT, INSERT, UPDATE, DELETE ON SERVICE_URL TO LONTANA_ROLE_RO;
--#end if

--#if not GrantExists("SERVICE_URL", "SIM_TRADE_ROLE_RO", "SELECT") AND IsClient("SIM_TRADE") then
 GRANT SELECT, INSERT, UPDATE, DELETE ON SERVICE_URL TO SIM_TRADE_ROLE_RO;
--#end if


