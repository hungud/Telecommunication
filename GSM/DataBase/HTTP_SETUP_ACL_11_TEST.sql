-- Настройки для работы HTTP в Oracle 11g
declare
	l_acl_name         VARCHAR2(30) := 'utl_tcp.xml';
  l_ftp_server_ip    VARCHAR2(20) := '136.243.5.113';
  l_ftp_server_name  VARCHAR2(20) := 'sftpprod.tarifer.ru';
  l_username         VARCHAR2(30) := 'LONTANA';
begin
  --dbms_network_acl_admin.drop_acl('utl_http.xml');
  --
  dbms_network_acl_admin.create_acl (
    acl         => 'utl_http.xml',
    description => 'HTTP Access',
    principal   => 'LONTANA',
    is_grant    => TRUE,
    privilege   => 'connect',
    start_date  => null,
    end_date    => null
  );
  
  dbms_network_acl_admin.add_privilege(
    acl        => 'utl_http.xml',
    principal  => 'LONTANA',
    is_grant   => TRUE,
    privilege  => 'connect',
    start_date => null,
    end_date   => null
  );
  
  dbms_network_acl_admin.add_privilege(
    acl        => 'utl_http.xml',
    principal  => 'LONTANA',
    is_grant   => TRUE,
    privilege  => 'resolve',
    start_date => null,
    end_date   => null
  );
  
  dbms_network_acl_admin.assign_acl(
    acl        => 'utl_http.xml',
    host       => 'localhost',
    lower_port => 7988,
    upper_port => 7999
  );


  dbms_network_acl_admin.assign_acl(
    acl        => 'utl_http.xml',
    host       => 'beeline-api.tarifer.lan'
  );
  
  dbms_network_acl_admin.assign_acl
  (
    acl        => 'utl_http.xml',
    host       => 'api.tarifer.ru'
  );

  dbms_network_acl_admin.assign_acl
  (
    acl        => 'utl_http.xml',
    host       => 'beeline-api.tarifer.ru'
  );

 commit;

  DBMS_NETWORK_ACL_ADMIN.create_acl (
    acl          => l_acl_name, 
    description  => 'Allow connections using UTL_TCP',
    principal    => l_username,
    is_grant     => TRUE, 
    privilege    => 'connect',
    start_date   => SYSTIMESTAMP,
    end_date     => NULL);

  COMMIT;

  DBMS_NETWORK_ACL_ADMIN.add_privilege ( 
    acl         => l_acl_name, 
    principal   => l_username,
    is_grant    => FALSE, 
    privilege   => 'connect', 
    position    => NULL, 
    start_date  => NULL,
    end_date    => NULL);

  COMMIT;

  DBMS_NETWORK_ACL_ADMIN.assign_acl (
    acl         => l_acl_name,
    host        => l_ftp_server_ip, 
    lower_port  => NULL,
    upper_port  => NULL);

  DBMS_NETWORK_ACL_ADMIN.assign_acl (
    acl         => l_acl_name,
    host        => l_ftp_server_name, 
    lower_port  => NULL,
    upper_port  => NULL);

dbms_network_acl_admin.assign_acl(
    acl        => 'utl_http.xml',
    host       => '217.118.84.12',
    lower_port => 3340,
    upper_port => 3340
  );

dbms_network_acl_admin.assign_acl(
    acl        => 'utl_http.xml',
    host       => 'cc.gsmcorp.tarifer.ru'
  );

dbms_network_acl_admin.assign_acl(
    acl        => 'utl_http.xml',
    host       => 'gsmcorporacia.ru'
  );

  dbms_network_acl_admin.assign_acl(
    acl        => 'utl_http.xml',
    host       => 'www.smstraffic.ru'
  );

  dbms_network_acl_admin.assign_acl(
    acl        => 'utl_http.xml',
    host       => 'server1.smstraffic.ru'
  );

  dbms_network_acl_admin.assign_acl
  (
    acl        => 'utl_http.xml',
    host       => '127.0.0.1',
    lower_port => 25,
    upper_port => 25
  );

  dbms_network_acl_admin.assign_acl
  (
    acl        => 'utl_http.xml',
    host       => '217.118.87.62',
    lower_port => 80,
    upper_port => 80
  );

  dbms_network_acl_admin.assign_acl
  (
    acl        => 'utl_http.xml',
    host       => 'beeline.ru',
    lower_port => 1,
    upper_port => 9999
  );

  dbms_network_acl_admin.assign_acl
  (
    acl        => 'utl_http.xml',
    host       => 'localhost',
    lower_port => 319,
    upper_port => 319
  );

  dbms_network_acl_admin.assign_acl
  (
    acl        => 'utl_http.xml',
    host       => 'schemas.xmlsoap.org',
    lower_port => 1,
    upper_port => 9999
  );

  dbms_network_acl_admin.assign_acl
  (
    acl        => 'utl_http.xml',
    host       => 'uatssouss.beeline.ru',
    lower_port => 80,
    upper_port => 80
  );

  dbms_network_acl_admin.assign_acl
  (
    acl        => 'utl_http.xml',
    host       => 'uatssouss.beeline.ru',
    lower_port => 443,
    upper_port => 443
  );

  dbms_network_acl_admin.assign_acl
  (
    acl        => 'utl_http.xml',
    host       => 'www.e-xo.ru',
    lower_port => 80,
    upper_port => 80
  );
  
  -- для работы каптчи на сайте личного кабинета абонента GSM
  DBMS_NETWORK_ACL_ADMIN.ADD_PRIVILEGE(acl       => 'utl_http.xml',
                                         principal => 'LONTANA_WWW',
                                         is_grant  => true,
                                         privilege => 'connect');

  dbms_network_acl_admin.assign_acl
  (
    acl        => 'utl_http.xml',
    host       => 'xmlsoap.org',
    lower_port => 1,
    upper_port => 9999
  );

  dbms_java.grant_permission( 'LONTANA', 'SYS:java.net.SocketPermission', '217.118.84.12:3340', 'connect,resolve' );


  COMMIT;




end;
