
  CREATE OR REPLACE PACKAGE "LONTANA"."BEELINE_REST_API_PCKG" AS

-- Таблицы для загрузки данных

-- Логи загрузки
-- create table db_loader_resp_log (log_id number(10), load_date timestamp, phone varchar2(10), requestid number, code number(10), status varchar2(10), message varchar2(128), note varchar2(32));
-- create sequence db_loader_resp_log_id;
-- select LOG_ID,to_char(load_date,'YYYY-MM-DD HH24:mi:ss.ff3') load_date, phone, requestid, code, status,message from db_loader_resp_log;

-- Rests
-- create table db_loader_rests (rests_id number(38), load_date timestamp, phone varchar2(10 char), unitType varchar2(32 char), restType varchar2(16 char), initialSize number(18,2), currValue number(18,2), nextValue number(18,2), frequency varchar2(16 char), soc varchar2(16 char), socName varchar2(1024 char), restName varchar2(2048 char));
-- create sequence db_loader_rests_id;

-- Call Forward
-- create table db_loader_cfrw (cfrw_id number(10), load_date timestamp, requestid number(10), cfType varchar2(32));
-- create sequence db_loader_cfrw_id;

-- Subscribtions
-- create table db_loader_subs (subs_id number(10), load_date timestamp, phone varchar2(10), id varchar2(32), name varchar2(64), try_price number(12,2), buy_price number(12,2), buy_price_period number(10), start_date varchar2(32), end_free_date varchar2(32), end_date varchar2(32), try_buy_mode varchar2(16), provider_name varchar2(128), provider_contact varchar2(128), category varchar2(64), type varchar2(8));
-- create sequence db_loader_subs_id;

  type TRests is table of TInfoRest index by pls_integer;
--  constants      --------- BEGIN ---------------------------------------------------------------------------------------------

  beeline_protocol                constant varchar2(6)  :='https';
  beeline_domain                  constant varchar2(64) :='my.beeline.ru';
  beeline_auth_path               constant varchar2(64) :='/api/1.0/auth';
  info_rests_path                 constant varchar2(64) :='/api/1.0/info/rests';
  req_callForward_path            constant varchar2(64) :='/api/1.0/request/callForward';
  info_callForward_path           constant varchar2(64) :='/api/1.0/info/callForward';
  req_callForward_edt_path        constant varchar2(64) :='/api/1.0/request/callForward/edit';
  info_subscriptions_path         constant varchar2(64) :='/api/1.0/info/subscriptions';
  req_subscription_rmv_path       constant varchar2(64) :='/api/1.0/request/subscription/remove';

  err_ok  constant varchar2(5)  :='20000';
  
  c_turn_tariff_immediately       constant number       := 0;   -- значение доступного объёма трафика на тарифе/пакете при значении равном, либо менее, которого 
                                                                -- новый пакет подключается немедленно, по-умолчанию "0".
  c_turn_tariff_smallrest         constant number       := 0.1; -- (%/100) минимальный остаток на тарифе - процент значения от изначально доступного объёма когда 
                                                                -- при равном ему остатке измерения остатков делаются каждые c_turn_tariff_smallchecktime минут,  
                                                                -- по-умолчаниу при остатке трафика менее 10% остатки меряются каждые 10 минут.
  c_turn_tariff_checktime_min     constant number       := 10;  -- (минут), минимальный интервал проверки доступного объёма трафика на тарифе/пакете, 
                                                                -- интервал охвата записей для запроса остатков от оператора должен быть равным промежутку времени 
                                                                -- с момента последнего сбора данных (вычисляемый).
  c_turn_tariff_checktime_max     constant number       := 60;  -- (минут), максимальный интервал проверки доступного объёма трафика на тарифе/пакете. 
  c_turn_tariff_ctrlpnt_inc       constant number       := 0.2; -- (%/100), процент от объёма начального трафика на тарифе/пакете при значении измерений
                                                                -- равном либо более которого ставится отметка опорной точки (для линейного прогноза), по-умолчанию "20%" .
--   constants     ---------  END  ---------------------------------------------------------------------------------------------

  function intr_to_sec(p_time interval day to second) return number; -- перевод интервала в днях в секунды

  function get_token(p_login varchar2, p_passwd varchar2) return varchar2;
  function get_data(purl in varchar2, phdr in varchar2) return clob;
  function info_rests(token varchar2, phash varchar2, pclient varchar2, ctn varchar2) return TRests;
  function req_callforward(token varchar2, phash varchar2, pclient varchar2, ctn varchar2) return number;
  function info_callforward(token varchar2, phash varchar2, pclient varchar2, ctn varchar2, requestid integer) return number;
  function req_callForward_edit(token varchar2, phash varchar2, pclient varchar2, ctn varchar2, CallFrwEdtReqDo varchar2) return number;
  function info_subscriptions(token varchar2, phash varchar2, pclient varchar2, ctn varchar2) return number;
  function req_subscriptions_remove(token varchar2, phash varchar2, pclient varchar2, ctn varchar2, subscriptionid varchar2, ptype varchar2) return number;

  function gprs_check_turn_tariff(p_phone varchar2) return number; -- проверка остатка интернет траффика на тарифе/пакете и подключение нового при необходимости 

  oracle_wallet_file    constant varchar2(1024) := ms_params.GET_PARAM_VALUE('SSL_WALLET_DIR'); --'file:C:\OracleClient32'
  oracle_wallet_passwd  constant varchar2(1024) := '082g625p4Y412sD';



END BEELINE_REST_API_PCKG;
CREATE OR REPLACE PACKAGE BODY "LONTANA"."BEELINE_REST_API_PCKG" AS

--   intr_to_sec  --------- BEGIN ---------------------------------------------------------------------------------------------
  function intr_to_sec(p_time interval day to second) return number as
  begin
    return(extract(day from p_time)*24*60*60+extract(hour from p_time)*60*60+extract(minute from p_time)*60+extract(second from p_time));
  end;
--   intr_to_sec  ---------  END  ---------------------------------------------------------------------------------------------

--   get_resp_stat --------- BEGIN ---------------------------------------------------------------------------------------------
  function get_resp_stat(obj in json, phone varchar2, requestid number, note varchar2, p_req varchar2, p_data clob) return db_loader_resp_log%rowtype as
    rs db_loader_resp_log%rowtype;
  pragma autonomous_transaction;
  begin
    select db_loader_resp_log_id.nextval into rs.log_id from dual;
    rs.load_date  := systimestamp;
    rs.code       := obj.get('code').get_number;
    rs.status     := obj.get('status').get_string;
    rs.message    := obj.get('message').get_string;
    rs.phone      := phone;
    rs.requestid  := requestid;
    rs.note       := note;
    rs.request    := p_req;
    rs.response   := p_data;
    insert into db_loader_resp_log values rs;
    commit;
    return(rs);
  end;

  function get_resp_stat(code number, status varchar2, message varchar2, phone varchar2, requestid number, note varchar2, return_status number, p_req varchar2, p_data clob) return number as
    rs db_loader_resp_log%rowtype;
  pragma autonomous_transaction;
  begin
    select db_loader_resp_log_id.nextval into rs.log_id from dual;
    rs.load_date  := systimestamp;
    rs.code       := code;
    rs.status     := status;
    rs.message    := message;
    rs.phone      := phone;
    rs.requestid  := requestid;
    rs.note       := note;
    rs.request    := p_req;
    rs.response   := p_data;
    insert into db_loader_resp_log values rs;
    commit;
    return(return_status);
  end;
--   get_resp_stat ---------  END  ---------------------------------------------------------------------------------------------

--   get_data   ------------ BEGIN ---------------------------------------------------------------------------------------------
  function get_data(purl in varchar2, phdr in varchar2) return clob as
    req   UTL_HTTP.REQ;
    resp  UTL_HTTP.RESP;
    v_data clob;
begin
    UTL_HTTP.set_wallet(oracle_wallet_file, oracle_wallet_passwd);
    req := UTL_HTTP.BEGIN_REQUEST(purl);

    UTL_HTTP.SET_HEADER(req, 'User-Agent', 'Mozilla/4.0');
    utl_http.set_body_charset(req,'UTF-8');

    if phdr is not null then
      UTL_HTTP.SET_HEADER(req, phdr);
    end if;

    resp := UTL_HTTP.GET_RESPONSE(req);
    UTL_HTTP.READ_TEXT(resp,v_data);
    UTL_HTTP.END_RESPONSE(resp);
    RETURN (v_data);
    EXCEPTION
      WHEN UTL_HTTP.END_OF_BODY THEN
        UTL_HTTP.END_RESPONSE(resp);
    RETURN ('');
  end;
--   get_data   ------------  END  ---------------------------------------------------------------------------------------------

--   get_token  ------------ BEGIN ---------------------------------------------------------------------------------------------
  function get_token(p_login in varchar2, p_passwd in varchar2) return varchar2 AS
    v_token varchar2(100);
    v_login varchar2(50);
    pragma autonomous_transaction;
  BEGIN

    v_token := json_ext.get_string(json(get_data(beeline_protocol||'://'||beeline_domain||beeline_auth_path||'?login='||p_login||chr(38)||'password='||p_passwd,'')),'token');
    if v_token is not null then
      select acc_log into v_login from beeline_api_token_list where acc_log = p_login for update;
      if v_login is null then
        insert into beeline_api_token_list values (p_login, null,null,v_token, sysdate);
      else
        update beeline_api_token_list set rest_token=v_token, rest_last_update=sysdate where acc_log=p_login;
      end if;
  
      commit;      
    end if;    
    RETURN (v_token);
  END;
--   get_token  ------------  END  ---------------------------------------------------------------------------------------------

--   info_rests ------------ BEGIN ---------------------------------------------------------------------------------------------
  function info_rests(token varchar2, phash varchar2, pclient varchar2, ctn varchar2) return TRests as
    obj       json;
    tmp       json_list;
    tmpobj    json;
    resp_stat db_loader_resp_log%rowtype;
    v_rest    TInfoRest;
    v_rests   TRests;
    v_data    db_loader_resp_log.response%type;
    v_req     db_loader_resp_log.request%type;
    v_hdr     varchar2(512);
    v_grs     number(12);
  begin
    
    v_req  := beeline_protocol||'://'||beeline_domain||info_rests_path||'?ctn='||ctn;
    v_hdr  := 'Cookie: token='||token||'; domain='||beeline_domain||'; path='||info_rests_path||';';
    v_data := get_data(v_req, v_hdr);
    v_grs  := get_resp_stat(-9000,'LogReqResp','Save request and response into log.', ctn,0,'info_rests',0,v_req||chr(38)||'token='||token, v_data);
    if v_data  is null  then return(v_rests); end if;
    obj := json(v_data);

    resp_stat := get_resp_stat(json_ext.get_json(obj,'meta'), ctn,0,'info_rests',v_req||chr(38)||'token='||token, v_data);
    if resp_stat.code <> err_ok then return(v_rests);  end if;

    tmp := json_ext.get_json_list(obj,'rests');
    for i in 1 .. tmp.count loop
      v_rest := TInfoRest(systimestamp, ctn, '','',0,0,0,'','','','');
      tmpobj := json(tmp.get(i));

      if (tmpobj.exist('unitType'))    then v_rest.unitType     := tmpobj.get('unitType').get_string; else v_rest.unitType := ''; end if;
      if (tmpobj.exist('restType'))    then v_rest.restType     := tmpobj.get('restType').get_string; else v_rest.restType := ''; end if;
      if (tmpobj.exist('initialSize')) then v_rest.initialSize  := tmpobj.get('initialSize').get_number; else v_rest.initialSize := 0; end if;
      if (tmpobj.exist('currValue'))   then v_rest.currValue    := tmpobj.get('currValue').get_number; else v_rest.currValue := 0; end if;
      if (tmpobj.exist('nextValue'))   then v_rest.nextValue    := tmpobj.get('nextValue').get_number; else v_rest.nextValue := 0; end if;
      if (tmpobj.exist('frequency'))   then v_rest.frequency    := tmpobj.get('frequency').get_string; else v_rest.frequency := ''; end if;
      if (tmpobj.exist('soc'))         then v_rest.soc          := tmpobj.get('soc').get_string; else v_rest.soc := ''; end if;
      if (tmpobj.exist('socName'))     then v_rest.socName      := tmpobj.get('socName').get_string; else v_rest.socName := ''; end if;
      if (tmpobj.exist('restName'))    then v_rest.restName     := tmpobj.get('restName').get_string; else v_rest.restName := ''; end if;

      v_rests(i) := v_rest;
    end loop;

    return(v_rests);
  end;
--   info_rests ------------  END  ------------------------------------------------------------------------------------

--   req_callforward --- BEGIN ------------------------------------------------------------------------------------
  function req_callforward(token varchar2, phash varchar2, pclient varchar2, ctn varchar2) return number as
    obj       json;
    resp_stat db_loader_resp_log%rowtype;
    v_data    db_loader_resp_log.response%type;
    v_req     db_loader_resp_log.request%type;
    v_hdr     varchar2(512);
    v_grs     number(12);
  begin
    if token  is null  then
      return (get_resp_stat(-2000,'TokenIsEmpty','The token attribute must not be an empty string', ctn,0,'req_callforward',0,v_req, v_data));
    elsif ctn is null then
      return (get_resp_stat(-2001,'CtnIsEmpty','The CTN attribute must not be an empty string', ctn, 0,'req_callforward',0,v_req, v_data));
    end if;
    
    v_req := beeline_protocol||'://'||beeline_domain||req_callforward_path||'?ctn='||ctn;
    v_hdr  :='Cookie: token='||token||'; domain='||beeline_domain||'; path='||req_callforward_path||';';
    v_data := get_data(v_req, v_hdr);
    v_grs  := get_resp_stat(-9000,'LogReqResp','Save request and response into log.', ctn,0,'req_callforward',0,v_req||chr(38)||'token='||token, v_data);
    if v_data  is null  then
      return (get_resp_stat(-2100,'NoData','Server retrieve null.',ctn,0,'req_callforward', 0,v_req||chr(38)||'token='||token, v_data));
    end if;
    obj := json(v_data);

    resp_stat := get_resp_stat(json_ext.get_json(obj,'meta'), ctn,0,'req_callforward',v_req||chr(38)||'token='||token, v_data);
    if resp_stat.code <> err_ok then
      return(0);
    end if;
    return(json_ext.get_number(obj,'requestId'));
  end;
--   req_callforward ---  END  ------------------------------------------------------------------------------------

--   info_callforward ------ BEGIN ------------------------------------------------------------------------------------
  function info_callforward(token varchar2, phash varchar2, pclient varchar2, ctn varchar2, requestid integer) return number as
    obj       json;
    tmp       json_list;
    tmpobj    json;
    resp_stat db_loader_resp_log%rowtype;
    v_cfrw    db_loader_cfrw%rowtype;
    v_data    db_loader_resp_log.response%type;
    v_req     db_loader_resp_log.request%type;
    v_hdr     varchar2(512);
    v_grs     number(12);
  begin
    if token  is null  then
      return (get_resp_stat(-2000,'TokenIsEmpty','The token attribute must not be an empty string', ctn, requestid,'info_callforward', 0,v_req, v_data));
    elsif requestid =0 then
      return (get_resp_stat(-2002,'RequestidIsNull','The RequestID attribute must not be 0', ctn, requestid,'info_callforward', 0,v_req, v_data));
    end if;

    v_req := beeline_protocol||'://'||beeline_domain||info_callforward_path||'?requestId='||requestid;
    v_hdr := 'Cookie: token='||token||'; domain='||beeline_domain||'; path='||info_callforward_path||';';
    v_data := get_data(v_req, v_hdr);
    v_grs  := get_resp_stat(-9000,'LogReqResp','Save request and response into log.', ctn,0,'info_callforward',0,v_req||chr(38)||'token='||token, v_data);
    if v_data  is null  then
      return (get_resp_stat(-2100,'NoData','Server retrieve null.',ctn,0,'info_callforward', 0,v_req||chr(38)||'token='||token, v_data));
    end if;
    obj := json(v_data);

    resp_stat := get_resp_stat(json_ext.get_json(obj,'meta'), ctn, requestid,'info_callforward',v_req||chr(38)||'token='||token, v_data);
    if resp_stat.code <> err_ok then
      return(0);
    end if;

    tmp := json_ext.get_json_list(obj,'callForwards');
    for i in 1 .. tmp.count loop
      select db_loader_cfrw_id.nextval into v_cfrw.cfrw_id from dual;
      v_cfrw.load_date := systimestamp;
      v_cfrw.requestid := requestid;
      tmpobj := json(tmp.get(i));

      if (tmpobj.exist('cfType')) then v_cfrw.cfType := tmpobj.get('cfType').get_string; else v_cfrw.cfType := ''; end if;

      insert into db_loader_cfrw values v_cfrw;
    end loop;

    return(1);
  end;
--   info_callforward ------  END  ------------------------------------------------------------------------------------

--   req_callforward_edit -- BEGIN ------------------------------------------------------------------------------------
  function req_callForward_edit(token varchar2, phash varchar2, pclient varchar2, ctn varchar2, CallFrwEdtReqDo varchar2) return number as
    obj       json;
    tmp       json_list;
    tmpobj    json;
    resp_stat db_loader_resp_log%rowtype;
    v_cfrw    db_loader_cfrw%rowtype;
    v_data    db_loader_resp_log.response%type;
    v_req     db_loader_resp_log.request%type;
    v_hdr     varchar2(512);
    v_grs     number(12);
  begin
    if token  is null  then
      return (get_resp_stat(-2000,'TokenIsEmpty','The token attribute must not be an empty string',ctn,0,'req_callforward_edit', 0,v_req, v_data));
    elsif ctn  is null then
      return (get_resp_stat(-2001,'CtnIsEmpty','The CTN attribute must not be an empty string',ctn, 0,'req_callforward_edit', 0,v_req, v_data));
    end if;

    v_req  := beeline_protocol||'://'||beeline_domain||req_callForward_edt_path||'?ctn='||ctn;
    v_hdr  := 'Cookie: token='||token||'; domain='||beeline_domain||'; path='||req_callForward_edt_path||';';
    v_data := get_data(v_req, v_hdr);
    v_grs  := get_resp_stat(-9000,'LogReqResp','Save request and response into log.', ctn,0,'req_callforward_edit',0,v_req||chr(38)||'token='||token, v_data);
    if v_data  is null  then
      return (get_resp_stat(-2100,'NoData','Server retrieve null.',ctn,0,'req_callforward_edit', 0,v_req||chr(38)||'token='||token,v_data));
    end if;
    obj := json(v_data);

    resp_stat := get_resp_stat(json_ext.get_json(obj,'meta'),ctn, 0,'req_callforward_edit',v_req||chr(38)||'token='||token,v_data);
    if resp_stat.code <> err_ok then
      return(0);
    end if;
    return(json_ext.get_number(obj,'requestId'));
  end;
--   req_callforward_edit --  END  ------------------------------------------------------------------------------------

--   info_subscriptions ---- BEGIN ---------------------------------------------------------------------------------------------
  function info_subscriptions(token varchar2, phash varchar2, pclient varchar2, ctn varchar2) return number as
    obj       json;
    tmp       json_list;
    tmpobj    json;
    resp_stat db_loader_resp_log%rowtype;
    v_subs    db_loader_subs%rowtype;
    v_data    db_loader_resp_log.response%type;
    v_req     db_loader_resp_log.request%type;
    v_hdr     varchar2(512);
    v_grs     number(12);
  begin
    if token  is null  then
      return (get_resp_stat(-2000,'TokenIsEmpty','The token attribute must not be an empty string', ctn, 0,'info_subscriptions',0,v_req, v_data));
    elsif ctn is null then
      return (get_resp_stat(-2001,'CtnIsEmpty','The CTN attribute must not be an empty string', ctn, 0,'info_subscriptions',0,v_req, v_data));
    end if;
    
    v_req := beeline_protocol||'://'||beeline_domain||info_subscriptions_path||'?ctn='||ctn;
    v_hdr := 'Cookie: token='||token||'; domain='||beeline_domain||'; path='||info_subscriptions_path||';';
    v_data := get_data(v_req, v_hdr);
    v_grs  := get_resp_stat(-9000,'LogReqResp','Save request and response into log.', ctn,0,'info_subscriptions',0,v_req||chr(38)||'token='||token, v_data);
    if v_data  is null  then
      return (get_resp_stat(-2100,'NoData','Server retrieve null.',ctn,0,'info_subscriptions', 0,v_req||chr(38)||'token='||token, v_data));
    end if;
    obj := json(v_data);

    resp_stat := get_resp_stat(json_ext.get_json(obj,'meta'), ctn,0,'info_subscriptions',v_req||chr(38)||'token='||token, v_data);
    if resp_stat.code <> err_ok then
      return(0);
    end if;

    tmp := json_ext.get_json_list(obj,'subscriptions');
    for i in 1 .. tmp.count loop
      select db_loader_subs_id.nextval into v_subs.subs_id from dual;
      v_subs.load_date := systimestamp;
      v_subs.phone := ctn;

      tmpobj := json(tmp.get(i));

      if (tmpobj.exist('id'))               then v_subs.id                := tmpobj.get('id').get_string; else v_subs.id := ''; end if;
      if (tmpobj.exist('name'))             then v_subs.name              := tmpobj.get('name').get_string; else v_subs.name := ''; end if;
      if (tmpobj.exist('try_price'))        then v_subs.try_price         := tmpobj.get('try_price').get_number; else v_subs.try_price := 0; end if;
      if (tmpobj.exist('buy_price'))        then v_subs.buy_price         := tmpobj.get('buy_price').get_number; else v_subs.buy_price := 0; end if;
      if (tmpobj.exist('buy_price_period')) then v_subs.buy_price_period  := tmpobj.get('buy_price_period').get_number; else v_subs.buy_price_period := 0; end if;
      if (tmpobj.exist('start_date'))       then v_subs.start_date        := tmpobj.get('start_date').get_string; else v_subs.start_date := ''; end if;
      if (tmpobj.exist('end_free_date'))    then v_subs.end_free_date     := tmpobj.get('end_free_date').get_string; else v_subs.end_free_date := ''; end if;
      if (tmpobj.exist('end_date'))         then v_subs.end_date          := tmpobj.get('end_date').get_string; else v_subs.end_date := ''; end if;
      if (tmpobj.exist('try_buy_mode'))     then v_subs.try_buy_mode      := tmpobj.get('try_buy_mode').get_string; else v_subs.try_buy_mode := ''; end if;
      if (tmpobj.exist('provider_name'))    then v_subs.provider_name     := tmpobj.get('provider_name').get_string; else v_subs.provider_name := ''; end if;
      if (tmpobj.exist('provider_contact')) then v_subs.provider_contact  := tmpobj.get('provider_contact').get_string; else v_subs.provider_contact := ''; end if;
      if (tmpobj.exist('category'))         then v_subs.category          := tmpobj.get('category').get_string; else v_subs.category := ''; end if;
      if (tmpobj.exist('type'))             then v_subs.type              := tmpobj.get('type').get_string; else v_subs.type := ''; end if;

      insert into db_loader_subs values v_subs;
    end loop;

    return(1);
  end;
--   info_subscriptions ----  END  ------------------------------------------------------------------------------------

--   req_subscription_remove ---- BEGIN ---------------------------------------------------------------------------------------------
  function req_subscriptions_remove(token varchar2, phash varchar2, pclient varchar2, ctn varchar2, subscriptionid varchar2, ptype varchar2) return number as
    obj       json;
    resp_stat db_loader_resp_log%rowtype;
    v_data    db_loader_resp_log.response%type;
    v_req     db_loader_resp_log.request%type;
    v_hdr     varchar2(512);
    v_grs     number(12);
  begin
    if token  is null  then
      return (get_resp_stat(-2000,'TokenIsEmpty','The token attribute must not be an empty string', ctn, 0,'req_subscriptions_remove',0,v_req, v_data));
    elsif ctn is null then
      return (get_resp_stat(-2001,'CtnIsEmpty','The CTN attribute must not be an empty string', ctn, 0,'req_subscriptions_remove',0,v_req, v_data));
    end if;

    v_req := beeline_protocol||'://'||beeline_domain||req_subscription_rmv_path||'?ctn='||ctn;
    v_hdr := 'Cookie: token='||token||'; domain='||beeline_domain||'; path='||req_subscription_rmv_path||';';
    v_data := get_data(v_req, v_hdr);
    v_grs  := get_resp_stat(-9000,'LogReqResp','Save request and response into log.', ctn,0,'req_subscriptions_remove',0,v_req||chr(38)||'token='||token, v_data);
    if v_data  is null  then
      return (get_resp_stat(-2100,'NoData','Server retrieve null.',ctn,0,'req_subscriptions_remove', 0,v_req||chr(38)||'token='||token, v_data));
    end if;
    obj := json(v_data);

    resp_stat := get_resp_stat(json_ext.get_json(obj,'meta'), ctn,0,'req_subscriptions_remove',v_req||chr(38)||'token='||token, v_data);
    if resp_stat.code <> err_ok then
      return(0);
    end if;
    return(json_ext.get_number(obj,'requestId'));

  end;
--   req_subscription_remove ----  END  ------------------------------------------------------------------------------------

--   gprs_check_turn_tariff ---- BEGIN ---------------------------------------------------------------------------------------------
  function gprs_check_turn_tariff(p_phone varchar2) return number as -- проверка остатка интернет траффика на тарифе/пакете и подключение нового при необходимости
    type t_stat is table of gprs_stat%rowtype index by pls_integer;
    v_rec           t_stat;
    v_num           number(38);
    v_time          interval day (5) to second (9);
    v_num0          number(38);-- секунд с начала месяца
    v_time0         interval day (5) to second (9); -- с начала месяца
    v_vol           number(12);
    v_tariff_code   varchar2(30);
    delta_time_sec  number(12);
    ctrl_pnt_cnt    number(12); -- кол-во уже пройденных опорных точек
    initvalue_sum   number(12); --суммарный объём трафика полностью израсходованных тарифов
    new_opt_id      number(38);
    v_str           varchar2(1024);
    v_grs           number(12);

  begin
    /*
    v_rec(1) - первая точка измерений 
    v_rec(2) - предпоследнее измерение
    v_rec(3) - текущее измерение, в последсвии м.б. даже только что измеренное и ещё не внесённое в БД
    */

    select tariff_code into v_tariff_code from (select tariff_code from gprs_turn_log where phone=p_phone and date_off is null order by date_off desc) where rownum <2;

    if v_tariff_code is not null then  

      select * into v_rec(1) 
        from (select * from gprs_stat where phone = p_phone and tariff_code= v_tariff_code order by curr_check_date, stat_id) where rownum <2;

      select * into v_rec(2) 
        from (select * from (select * from gprs_stat where phone = p_phone and tariff_code= v_tariff_code order by curr_check_date desc, stat_id desc) where rownum <3  order by curr_check_date, stat_id) where rownum <2;
      
      select * into v_rec(3) 
        from (select * from gprs_stat where phone = p_phone and tariff_code= v_tariff_code order by curr_check_date desc, stat_id desc) where rownum <2;

      -- рассчёт даты/времени следующей проверки, определить когда мы предположительно пробъём следующие 20% или 0  
      --определим путь в цифрах
      if nvl(v_rec(3).currvalue,0) <= c_turn_tariff_immediately then -- по-умолчанию "0"
        -- подключить доп.пакет
--        dbms_output.put_line('Подключить доп.пакет');
        -- определить предполагаемый необходимый объём трафика до конца месца
        -- текущая скорость потребления с начала месяца по настоящее время
        select sum(distinct initvalue) into initvalue_sum from gprs_stat where phone=p_phone;
--        dbms_output.put_line('Израсходованный объём: '||to_Char(initvalue_sum));
        -- с начала месяца 
        v_num0 := abs(intr_to_sec(v_rec(3).curr_check_date - round(sysdate,'MM')));
        -- до конца месяца 
        v_num := abs(intr_to_sec(last_day(sysdate)-v_rec(3).curr_check_date));
        -- До конца месяца потребуется (МБ)
        v_num := v_num*initvalue_sum/v_num0;
--        dbms_output.put_line('До конца месяца потребуется: '||v_num);

        -- конец истории наблюдений предыдущей опции
        update gprs_turn_log set date_off = systimestamp where phone = p_phone and tariff_code = v_tariff_code;

        -- opt_id подходящего пакета    
        select opt_id into new_opt_id from (select opt_id, min(vol) from gprs_opts where vol>= v_num group by opt_id) where rownum<2;  
        select opt_code, vol, opt_name into v_tariff_code, v_num0, v_str from gprs_opts where opt_id=new_opt_id;  
--        dbms_output.put_line('Новый пакет имеет ид.: '||new_opt_id);
--        dbms_output.put_line('Код : '||v_tariff_code);
--        dbms_output.put_line('Наименование : '||v_str);
        
        -- Подключить новый пакет
        v_grs  := get_resp_stat(-9000,'LogReqResp','Log response for turn tariff.', p_phone, 0,'gprs_check_turn_tariff',0
                                ,'Phone number: '||p_phone||' | Tariff: '||v_tariff_code
                                , beeline_api_pckg.turn_tariff_option(p_phone,v_tariff_code, 1, null, null, null));
  
        -- Добавить запись в gprs_stat о первой опорной точке и времени следующего измерения на основании предыдущих измерений
        insert into gprs_turn_log values (NEW_gprs_turn_log_id, p_phone, v_tariff_code, systimestamp, null);
        --Добавить первую запись и инициировать первый сбор данных
        insert into gprs_stat values (new_gprs_stat_id, p_phone, v_tariff_code, v_num0, v_num0, systimestamp, systimestamp+c_turn_tariff_checktime_min/24/60,1);
         
      elsif v_rec(3).currvalue <= v_rec(3).initvalue*c_turn_tariff_smallrest then -- по-умолчанию 0.1, т.е. 10%
        -- если попадаем в 10% остаток трафика, то выполнить проверку через 10 минут
--        dbms_output.put_line('10 min');
        update gprs_stat set next_check_date = systimestamp+c_turn_tariff_checktime_min/24/60 where stat_id=v_rec(3).stat_id; -- по-умолчанию 10 минут
      else 
        --Проверка на пробой 20%
        -------------------------------
        -- подсчёт количества контрольных точек для множителя контрольного интервала, для сохранения линейности параметра 
        select nvl(count(1),1) into ctrl_pnt_cnt from gprs_stat where phone = p_phone and tariff_code = v_tariff_code and ctrl_pnt<>0 and stat_id <>v_rec(3).stat_id;
--        dbms_output.put_line('Число контрольных точек: '||ctrl_pnt_cnt);
--        dbms_output.put_line('20% Check');
        if v_rec(3).currvalue <= v_rec(3).initvalue*(1-c_turn_tariff_ctrlpnt_inc)*ctrl_pnt_cnt  then -- по-умолчанию 0.2, текущее измерение меньше либо равно чем init-20%*число_контрольных_точек
          -- ставим метку контрольной точки
          v_rec(3).ctrl_pnt := 1;
        else -- иначе сбрасываем метку контрольной точки
          v_rec(3).ctrl_pnt := 0;
        end if;
        
        -- Определить дату следующей проверки
        ----------------------------------------------
        -- Время в секундах с последней проверки
        v_num := intr_to_sec(v_rec(3).curr_check_date-v_rec(2).curr_check_date);
        -- Определить объём трафика израсходованного с последней проверки, если 0. то даём
        v_num0 := v_rec(2).currvalue-v_rec(3).currvalue;
        if v_num0 = 0 or v_num = 0 then
          delta_time_sec := c_turn_tariff_checktime_max;  -- по-умолчанию 60 мин;
        else 
          delta_time_sec :=v_rec(3).initvalue*c_turn_tariff_ctrlpnt_inc*ctrl_pnt_cnt*v_num/v_num0;  -- c_turn_tariff_ctrlpnt_inc (по-умолчанию 0.2)
--          dbms_output.put_line('Приращение даты проверки в секундах: '||delta_time_sec);
          -- если расчётное время потребления 20% трафика от предыдкщей опорной точки более 1 часа, то следующее измерение назначаем через 1 час
          if delta_time_sec/60 > 1 then delta_time_sec := c_turn_tariff_checktime_max; end if;
        end if;
        -- Зафиксируем дату следующей проверки и контрольную метку
        update gprs_stat set next_check_date = systimestamp+delta_time_sec/24/60, ctrl_pnt = v_rec(3).ctrl_pnt  where stat_id=v_rec(3).stat_id;
        
      end if;
      commit;
    else
--      dbms_output.put_line('v_tariff_code получил пустое значение, считать нечего! ');
      return(-1);
    end if;  
    return(0);
  end; 
--   gprs_check_turn_tariff ----  END  ------------------------------------------------------------------------------------

END BEELINE_REST_API_PCKG;