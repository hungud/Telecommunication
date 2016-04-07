-- Настройки для работы HTTP в Oracle 11g

--dbms_network_acl_admin.drop_acl('utl_http.xml');
--
--#Execute MAIN_SCHEMA=IsClient("")
--#if not RecordExists("select 1 from  DBA_NETWORK_ACL_PRIVILEGES where (instr(upper(acl),upper('utl_http.xml'))>0) and (instr(upper(privilege),upper('CONNECT'))>0) AND (principal='" & ISclient("") & "')") then
  dbms_network_acl_admin.create_acl (
    acl         => 'utl_http.xml',
    description => 'HTTP Access',
    principal   => '&MAIN_SCHEMA',
    is_grant    => TRUE,
    privilege   => 'connect',
    start_date  => null,
    end_date    => null
  );
--#end if
--#if not RecordExists("select 1 from  DBA_NETWORK_ACL_PRIVILEGES where (instr(upper(acl),upper('utl_http.xml'))>0) and (instr(upper(privilege),upper('RESOLVE'))>0) AND (principal='" & ISclient("") & "')") then
  dbms_network_acl_admin.add_privilege(
    acl        => 'utl_http.xml',
    principal  => '&MAIN_SCHEMA',
    is_grant   => TRUE,
    privilege  => 'resolve',
    start_date => null,
    end_date   => null
  );
--#end if

--#if not RecordExists("select HOST,LOWER_PORT,UPPER_PORT,ACL from  DBA_NETWORK_ACLS WHERE UPPER(HOST)=UPPER('localhost')") then
 begin
  dbms_network_acl_admin.assign_acl(
    acl        => 'utl_http.xml',
    host       => 'localhost',
    lower_port => 7988,
    upper_port => 7999
  );
 end;
--#end if
--#if isclient("CORP_MOBILE") then
--#if not RecordExists("select HOST,LOWER_PORT,UPPER_PORT,ACL from  DBA_NETWORK_ACLS WHERE UPPER(HOST)=UPPER('109.95.211.34')") then
-- для К7
begin
  dbms_network_acl_admin.assign_acl(
    acl        => 'utl_http.xml',
    host       => '109.95.211.34',
    lower_port => 7988,
    upper_port => 7999
  );
  commit;
end;
--#end if
--#if not RecordExists("select HOST,LOWER_PORT,UPPER_PORT,ACL from  DBA_NETWORK_ACLS WHERE UPPER(HOST)=UPPER('109.95.211.35')") then
begin
  dbms_network_acl_admin.assign_acl(
    acl        => 'utl_http.xml',
    host       => '109.95.211.35',
    lower_port => 7988,
    upper_port => 7999
  );
  commit;
end;
--#end if

--#if not RecordExists("select HOST,LOWER_PORT,UPPER_PORT,ACL from  DBA_NETWORK_ACLS WHERE UPPER(HOST)=UPPER('109.95.210.128')") then
begin
  dbms_network_acl_admin.assign_acl(
    acl        => 'utl_http.xml',
    host       => '109.95.210.128',
    lower_port => 7988,
    upper_port => 7999
  );
  commit;
end;
--#end if

--#end if

--#if not RecordExists("select HOST,LOWER_PORT,UPPER_PORT,ACL from  DBA_NETWORK_ACLS WHERE UPPER(HOST)=UPPER('109.95.211.35')") AND (isclient("CORP_MOBILE") OR IsClient("GSM_CORP")) then
  dbms_network_acl_admin.assign_acl(
    acl        => 'utl_http.xml',
    host       => 'www.smstraffic.ru',
    lower_port => 80,
    upper_port => NULL
  );
  commit;
end;
--#end if
--#if IsClient("GSM_CORP") then
--#if not RecordExists("select * from  DBA_NETWORK_ACL_PRIVILEGES where (instr(upper(acl),upper('utl_http.xml'))>0) and (instr(upper(privilege),upper('CONNECT'))>0) AND (principal='LONTANA_WWW')")  then
-- Для личного кабинета
  dbms_network_acl_admin.add_privilege(
    acl        => 'utl_http.xml',
    principal  => 'LONTANA_WWW',
    is_grant   => TRUE,
    privilege  => 'connect',
    start_date => null,
    end_date   => null
  );
--#end if
--#if not RecordExists("select * from  DBA_NETWORK_ACL_PRIVILEGES where (instr(upper(acl),upper('utl_http.xml'))>0) and (instr(upper(privilege),upper('RESOLVE'))>0) AND (principal='LONTANA_WWW')")  then
  dbms_network_acl_admin.add_privilege(
    acl        => 'utl_http.xml',
    principal  => 'LONTANA_WWW',
    is_grant   => TRUE,
    privilege  => 'resolve',
    start_date => null,
    end_date   => null
  );
--#end if

--#if not RecordExists("select HOST,LOWER_PORT,UPPER_PORT,ACL from  DBA_NETWORK_ACLS WHERE UPPER(HOST)=UPPER('www.e-xo.ru')")  then
  dbms_network_acl_admin.assign_acl(
    acl        => 'utl_http.xml',
    host       => 'www.e-xo.ru',
    lower_port => 80,
    upper_port => NULL
  );
  commit;
--#end if


--#end if

--#if not RecordExists("select HOST,LOWER_PORT,UPPER_PORT,ACL from  DBA_NETWORK_ACLS WHERE UPPER(HOST)=UPPER('109.95.211.36')")  then
  begin
  dbms_network_acl_admin.assign_acl(
    acl        => 'utl_http.xml',
    host       => '109.95.211.36',
    lower_port => 80,
    upper_port => NULL
  );
  commit;
  end;
--#end if

--#if not RecordExists("select HOST,LOWER_PORT,UPPER_PORT,ACL from  DBA_NETWORK_ACLS WHERE UPPER(HOST)=UPPER('109.95.211.36')")  then
  begin
  dbms_network_acl_admin.assign_acl(
    acl        => 'utl_http.xml',
    host       => '109.95.211.26',
    lower_port => 7988,
    upper_port => NULL
  );
  commit;
  end;
--#end if


--#if not RecordExists("select HOST,LOWER_PORT,UPPER_PORT,ACL from  DBA_NETWORK_ACLS WHERE UPPER(HOST)=UPPER('109.95.211.36')")  then
  begin
  dbms_network_acl_admin.assign_acl(
    acl        => 'utl_http.xml',
    host       => 'smtp.qip.ru',
    lower_port => 25,
    upper_port => NULL
  );
  commit;
  end;
--#end if

--#if not RecordExists("select HOST,LOWER_PORT,UPPER_PORT,ACL from  DBA_NETWORK_ACLS WHERE UPPER(HOST)=UPPER('beeline-api.tarifer.ru)")  then
  begin
  dbms_network_acl_admin.assign_acl(
    acl        => 'utl_http.xml',
    host       => 'beeline-api.tarifer.ru',
    lower_port => 1,
    upper_port => 9999
  );
  commit;
  end;
--#end if


  DBMS_NETWORK_ACL_ADMIN.create_acl (
    acl          => 'utl_tcp.xml', 
    description  => 'Allow connections using UTL_TCP',
    principal    => 'CORP_MOBILE',
    is_grant     => TRUE, 
    privilege    => 'connect',
    start_date   => SYSTIMESTAMP,
    end_date     => NULL);

  COMMIT;

  DBMS_NETWORK_ACL_ADMIN.add_privilege ( 
    acl         => 'utl_tcp.xml', 
    principal   => 'CORP_MOBILE',
    is_grant    => FALSE, 
    privilege   => 'connect', 
    position    => NULL, 
    start_date  => NULL,
    end_date    => NULL);

  COMMIT;

  DBMS_NETWORK_ACL_ADMIN.assign_acl (
    acl         => 'utl_tcp.xml',
    host        => 'mybsd.ru', 
    lower_port  => NULL,
    upper_port  => NULL);


 
 DBMS_NETWORK_ACL_ADMIN.assign_acl (
    acl         => 'utl_tcp.xml',
    host        => '83.222.4.33', 
    lower_port  => NULL,
    upper_port  => NULL);

  COMMIT;

