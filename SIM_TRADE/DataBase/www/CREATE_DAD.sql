BEGIN
  dbms_epg.create_dad('lk', '/lk/*');
  dbms_epg.map_dad('lk', '/LK/*');
  dbms_epg.map_dad('lk', '/Lk/*');
  dbms_epg.map_dad('lk', '/lK/*');
-- Настройка авторизации
  DBMS_EPG.authorize_dad (
    dad_name => 'lk',
    user     => 'LONTANA_WWW');
  DBMS_EPG.set_dad_attribute (
    dad_name   => 'lk',
    attr_name  => 'default-page',
    attr_value => 'MAIN');
  DBMS_EPG.SET_DAD_ATTRIBUTE (
   'lk',
   'database-username',   
   'LONTANA_WWW');
  DBMS_EPG.SET_DAD_ATTRIBUTE (
   'lk',
   'database-username',   
   'LONTANA_WWW');
  DBMS_EPG.SET_DAD_ATTRIBUTE ('lk','exclusion-list', 'sys.*'); 
  DBMS_EPG.SET_DAD_ATTRIBUTE ('lk','exclusion-list', 'dbms_*'); 
  DBMS_EPG.SET_DAD_ATTRIBUTE ('lk','exclusion-list', 'utl_*');
  DBMS_EPG.SET_DAD_ATTRIBUTE ('lk','exclusion-list', 'owa_*'); 
  DBMS_EPG.SET_DAD_ATTRIBUTE ('lk','exclusion-list', 'owa.*');
  DBMS_EPG.SET_DAD_ATTRIBUTE ('lk','exclusion-list', 'htp.*');
  DBMS_EPG.SET_DAD_ATTRIBUTE ('lk','exclusion-list', 'htf.*');
  DBMS_EPG.SET_DAD_ATTRIBUTE ('lk','exclusion-list', 's_*');
  DBMS_EPG.SET_DAD_ATTRIBUTE ('lk','exclusion-list', 'mf_*');
END;
/

ALTER USER anonymous ACCOUNT UNLOCK;

begin
dbms_xdb.cfg_update(xmltype.insertxmlbefore(dbms_xdb.cfg_get(),'/xdbconfig/sysconfig/protocolconfig/httpconfig/authentication',
xmltype('<allow-repository-anonymous-access
xmlns="http://xmlns.oracle.com/xdb/xdbconfig.xsd">true</allow-repository-anonymous-access>')));
commit;
dbms_xdb.cfg_refresh;
end;
/