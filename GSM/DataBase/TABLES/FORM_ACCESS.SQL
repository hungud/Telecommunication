--#if not TableExists("FORM_ACCESS") then
-- ���������� ���. 28.08.2013 ���������� ��������� � ���������� ��������� �����.
CREATE TABLE FORM_ACCESS
(
  FORM_NAME VARCHAR2(50 CHAR),
  COMPONENT_NAME VARCHAR2(50 CHAR),
  IS_ACTIVE int,
  IS_VISIBLE int,
  USER_NAME VARCHAR2(50 CHAR),
  RIGHTS_TYPE INT,
  CHECK_ALLOW_ACCOUNT INT
);

--#end if

--#if GetTableComment("FORM_ACCESS")<>"���������� ���� �� �������� �����" then
comment on table FORM_ACCESS
  is '���������� ���� �� �������� �����';
--#end if

--#Execute MAIN_SCHEMA=IsClient("")
--#if not GrantExists("FORM_ACCESS", "ROLE", "UPDATE") then
begin EXECUTE IMMEDIATE 'GRANT ALL ON FORM_ACCESS TO &MAIN_SCHEMA'||'_ROLE'; end;
--#end if

--#if not GrantExists("FORM_ACCESS", "ROLE_RO", "SELECT") then
begin EXECUTE IMMEDIATE 'GRANT SELECT ON FORM_ACCESS TO &MAIN_SCHEMA'||'_ROLE_RO'; end;
--#end if

