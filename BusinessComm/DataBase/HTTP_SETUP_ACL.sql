-- Настройки для работы HTTP в Oracle 11g
begin
  dbms_network_acl_admin.drop_acl('utl_http.xml');
  --
  dbms_network_acl_admin.create_acl (
    acl         => 'utl_http.xml',
    description => 'HTTP Access',
    principal   => 'BUSINESS_COMM',
    is_grant    => TRUE,
    privilege   => 'connect',
    start_date  => null,
    end_date    => null
  );
  
  dbms_network_acl_admin.add_privilege(
    acl        => 'utl_http.xml',
    principal  => 'BUSINESS_COMM',
    is_grant   => TRUE,
    privilege  => 'resolve',
    start_date => null,
    end_date   => null
  );
  

  dbms_network_acl_admin.assign_acl(
      acl        => 'utl_http.xml',
      host       => 'api.tarifer.ru'
    );
   
  --для сервера в локальной сети
  dbms_network_acl_admin.assign_acl(
      acl        => 'utl_http.xml',
      host       => '10.191.1.202'
    );
    
  --для сервера в локальной сети
  dbms_network_acl_admin.assign_acl(
      acl        => 'utl_http.xml',
      host       => '10.191.1.*'
    );
 /* -- для внешнего сервера 
  dbms_network_acl_admin.assign_acl(
      acl        => 'utl_http.xml',
      host       => 'sftpprod.tarifer.ru'-- для внешнего сервера надо будет использовать sftpprod.tarifer.ru
    );  
    
  */  

  commit;
end;
