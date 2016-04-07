-- Настройки для работы HTTP в Oracle 11g

begin
  dbms_network_acl_admin.drop_acl('utl_http.xml');
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
    principal  => 'CORP_MOBILE',
    is_grant   => TRUE,
    privilege  => 'connect',
    start_date => null,
    end_date   => null
  );

  dbms_network_acl_admin.add_privilege(
    acl        => 'utl_http.xml',
    principal  => 'SIM_TRADE',
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
  
  dbms_network_acl_admin.add_privilege(
    acl        => 'utl_http.xml',
    principal  => 'CORP_MOBILE',
    is_grant   => TRUE,
    privilege  => 'resolve',
    start_date => null,
    end_date   => null
  );
  dbms_network_acl_admin.add_privilege(
    acl        => 'utl_http.xml',
    principal  => 'SIM_TRADE',
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

dbms_network_acl_admin.assign_acl(
    acl        => 'utl_http.xml',
    host       => 'my.mbvn.ru'
  );

dbms_network_acl_admin.assign_acl(
    acl        => 'utl_http.xml',
    host       => 'sms.targetsms.ru'
  );

dbms_network_acl_admin.assign_acl(
    acl        => 'utl_http.xml',
    host       => 'sms.e-vostok.ru'
  );
  commit;
end;
