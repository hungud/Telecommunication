--#if isclient("CORP_MOBILE") or isclient("GSM_CORP") then

--#if not TableExists("REPLACE_SIM_LOG") then
create table REPLACE_SIM_LOG
(
  phone    VARCHAR2(11),
  old_sim  VARCHAR2(18),
  new_sim  VARCHAR2(18),
  rep_user VARCHAR2(200),
  rep_date DATE,
  err      INTEGER,
  bsal_id  INTEGER
);
--#end if
 
 
--#if not IndexExists("REPLACE_SIM_LOG$PHONE$IDX") THEN
create index REPLACE_SIM_LOG$PHONE$IDX on REPLACE_SIM_LOG (PHONE);
--#end if

--#Execute MAIN_SCHEMA=IsClient("")

--#if not GrantExists("REPLACE_SIM_LOG", "ROLE", "UPDATE") then
begin EXECUTE IMMEDIATE 'GRANT ALL ON REPLACE_SIM_LOG TO &MAIN_SCHEMA'||'_ROLE'; end;
--#end if

--#if not GrantExists("REPLACE_SIM_LOG", "ROLE_RO", "SELECT") then
begin EXECUTE IMMEDIATE 'GRANT SELECT ON REPLACE_SIM_LOG TO &MAIN_SCHEMA'||'_ROLE_RO'; end;
--#end if


--#if GetVersion("TI_REPLACE_SIM_LOG")<1 then
CREATE OR REPLACE TRIGGER TI_REPLACE_SIM_LOG
  BEFORE INSERT ON  REPLACE_SIM_LOG FOR EACH ROW
--#Version=1
BEGIN
     :NEW.rep_date := sysdate;
     :NEW.rep_user := sys_context ('USERENV','CURRENT_USER');
END;
--#end if

--#end if
