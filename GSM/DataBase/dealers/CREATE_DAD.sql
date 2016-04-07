BEGIN
  dbms_epg.DROP_dad('dealers');
  dbms_epg.create_dad('dealers', '/dealers/*');
  dbms_epg.map_dad('dealers', '/DEALERS/*');
-- Настройка авторизации
  DBMS_EPG.authorize_dad (
    dad_name => 'dealers',
    user     => 'WWW_DEALER');
  DBMS_EPG.set_dad_attribute (
    dad_name   => 'dealers',
    attr_name  => 'default-page',
    attr_value => 'MAIN');
  DBMS_EPG.SET_DAD_ATTRIBUTE (
   'dealers',
   'database-username',   
   'WWW_DEALER');
  DBMS_EPG.SET_DAD_ATTRIBUTE ('dealers','exclusion-list', 'sys.*'); 
  DBMS_EPG.SET_DAD_ATTRIBUTE ('dealers','exclusion-list', 'dbms_*'); 
  DBMS_EPG.SET_DAD_ATTRIBUTE ('dealers','exclusion-list', 'utl_*');
  DBMS_EPG.SET_DAD_ATTRIBUTE ('dealers','exclusion-list', 'owa_*'); 
  DBMS_EPG.SET_DAD_ATTRIBUTE ('dealers','exclusion-list', 'owa.*');
  DBMS_EPG.SET_DAD_ATTRIBUTE ('dealers','exclusion-list', 'htp.*');
  DBMS_EPG.SET_DAD_ATTRIBUTE ('dealers','exclusion-list', 'htf.*');
  DBMS_EPG.SET_DAD_ATTRIBUTE ('dealers','exclusion-list', 's_*');
  DBMS_EPG.SET_DAD_ATTRIBUTE ('dealers','exclusion-list', 'mf_*');
END;
/

--ALTER USER anonymous ACCOUNT UNLOCK;
/*
begin
dbms_xdb.cfg_update(xmltype.insertxmlbefore(dbms_xdb.cfg_get(),'/xdbconfig/sysconfig/protocolconfig/httpconfig/authentication',
xmltype('<allow-repository-anonymous-access
xmlns="http://xmlns.oracle.com/xdb/xdbconfig.xsd">true</allow-repository-anonymous-access>')));
commit;
dbms_xdb.cfg_refresh;
end;
/
*/