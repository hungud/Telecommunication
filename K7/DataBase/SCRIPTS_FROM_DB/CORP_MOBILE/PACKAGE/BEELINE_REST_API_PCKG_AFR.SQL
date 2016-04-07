
  CREATE OR REPLACE PACKAGE "CORP_MOBILE"."BEELINE_REST_API_PCKG_AFR" AS
--
--Version=17
--
--v.17 Афросин 2015.07.15 добавилновую функцию mcBalance - получения суммы авансового счета( САС) и баланса, доступного для МК.
--              
--  2015.07.13
--              - изменена функция rep_gprs_autoturn_mon и rep_gprs_autoturn_prev. Изменен тип Trow_rep_gprs_autoturn_1. В отчет добавлены поля по новым пакетам GPRS20_GB и GPRS30_GB и MGN500MIN
--  2015.07.13
--              - изменена функция gprs_check_turn_tariff. Поправлена логика выбора пакета для подключения (пакет подкл. в зависимости от схемы подключения)
--  2015.07.01
--              - добавил exception в процедуру gprs_check_phone_flow
--  2015.06.11
--              - внесены изменения в отчет по подкл. пакетов в текущем месяце. Добавлен запрос по АПИ для номеров, по которым имеется SPEED3B2B. Внесены изменения в сам запрос отчета
--  2015.06.10
--              - contracts замененно на v_contracts и добавленно условие contract_cancel_date is null
--  2015.06.03
--              - для отчёта об автоподключениях прошлые месяца общий потребленный трафик интернет теперь брать из архива детализации (как и кол-во исходящих минут)
--  2015.06.02
--              - в gprs_check_turn_tariff изменен расчёт стоимости пакета, для GPRS_U уточнена формула расчёта стоимости пакета от подключения до конца месяца
--              - в gprs_opts_turn_off добавлена проверка для исключения из обработки номеров которые в настоящее время не на автоинтернет-тарифе 
--              - для отчёта об автоподключениях прошлые месяца добавлено ограничеение на выборку трафика и пакетов рамками указанного месяца
--              - в gprs_check_turn_tariff изменен расчёт стоимости пакета, для GPRS_U уточнена формула расчёта стоимости пакета теперь расчёт не по-секундно, а по-суточно с округлением до ближайшего большего числа суток.
--              - для отчётов об автоподключениях изменен расчёт стоимости пакета, для GPRS_U стоимость рассчитывается через ближайшее большее число дней использования пакета
--  2015.06.01
--              - для отчётов об автоподключениях изменен расчёт стоимости пакета GPRS_U, учитываем что данный пакет м.б. подключен не один раз 
--  2015.05.29
--              - для отчётов об автоподключениях изменен расчёт стоимости пакета, для всех доп.пакетов исключен учёт суммы за подключение
--              - gprs_check_phone_flow - увеличено число работающих потоков до 5
--  2015.05.28
--              - в gprs_check_turn_tariff изменен расчёт стоимости пакета, для GPRS_U исключен учёт суммы за подключение [2015-05-28 11:17:57] Макс
--              - для отчётов об автоподключениях изменен расчёт стоимости пакета, для GPRS_U исключен учёт суммы за подключение
--  2015.05.27
--              - в check_alien_opts добавлен фильтр на номера с автоинтернет тарифом
--              - в отчет текущий месяц по автоподключениям рядом с столбцом GPRS_U добавлена дата последнего подключения этой опции.
--              - в gprs_check_turn_tariff изменен расчёт стоимости пакета - добавлены nvl и признак не дискретного списание DISKR_SPISANIE,
--              - в gprs_check_turn_tariff - OPERATOR_MONTHLY_COST и OPERATOR_TURN_ON_COST заменены на MONTHLY_COST и TURN_ON_COST соответственно 
--  2015.05.26
--              - gprs_check_phone_tariff - добавлен фильтр для отсева номеров с неавтоинтернет тарифами
--              - gprs_check_turn_tariff - изменен алгоритм расчёта подходящего для подключения пакета
--                  1) отбираются все пакеты с объёмом трафика более требуемого расчётного;
--                  2) рассчитывается стоимость безлимита от текущего момента времени до конца месяца; 
--                  3) из стоимостей безлимита по п.2 и отобранных в п.1 пакетов выбираем наименьшую;
--                  4) подключаемым назначается опция соответствующая стоимости выбранной в п.3
--              - добавлены таблица и процедуры (check_alien_opts, proc_alien_phone_opts) для контроля доп.опций подключенных неавтоматом (вручную)
--              - в check_alien_opts замена merge на insert
--  2015.05.21  - для отчёта об автоподключениях за текущий месяц уточнён расчёт объёма потраченного трафика на номере
--              - function  calc_traff - выделен в отдельную функцию подсчёт объёма потраченного трафика на номере и времени на это потребовавшееся (для автомата и отчёта)
--  2015.05.19  - добавлен общий для всех доп.пакетов неснижаемый остаток (500МБ)
--  2015.05.18  - добавлена очистка данных участвующих в расчётах от избыточных и ошибочных, ранее модель подразумевала что билайн всегда отдаёт корректные остатки или не отдаёт их вовсе
--                , теперь учитывается ложная переинициализация остатков при полном расходе каждого использованного тарифа/пакета.
--  2015.05.15  -  добавлена процедура gprs_check_phone_flow для запроса статистик погруппе номеров отдельным потоком

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
  type TRestsMCBalance is table of TInfoRestMCBalance index by pls_integer; 
  
  type Trow_rep_gprs_autoturn_1 is record -- тип для возврата строки из функции-отчёта "Отчёт под автоподключениям доп.пакетов"
    (
      PHONE           gprs_stat.phone%type,             -- номер телефона
      CONTRACT_NUM    CONTRACTS.CONTRACT_NUM%type,      -- номер договора
      CONTRACT_DATE   CONTRACTS.CONTRACT_DATE%type,     -- дата договора
      IS_ACTIVE_WORD  varchar2(32),                     -- статус (блокирован или нет - слово)
      IS_ACTIVE       TARIFFS.IS_ACTIVE%type,           -- статус (блокирован или нет - признак)
      BEGIN_DATE      DB_LOADER_ACCOUNT_PHONE_HISTS.BEGIN_DATE%type, -- дата статуса
      DOP_STATUS      CONTRACT_DOP_STATUSES.DOP_STATUS_NAME%type,          -- доп. статус
      CURR_TARIFF_ID  CONTRACTS.CURR_TARIFF_ID%type,    -- тарифный план ID
      TARIFF_CODE     TARIFFS.TARIFF_CODE%type,         -- тарифный план код
      TARIFF_NAME     TARIFFS.TARIFF_NAME%type,         -- тарифный план наименование
      BALANCE         iot_current_balance.BALANCE%type, -- баланс
      TARIFF          TARIFFS.MONTHLY_PAYMENT%type,     -- абон.плата по тариферу
      tariff_oper     number(18),                       -- абон.плата по билайну из счета
      FI550Z          number(18),                       -- FI550Z - сумма за эти пакеты
      FI850Z          number(18),                       -- FI850Z - сумма за эти пакеты
      FI1150Z         number(18),                       -- FI1150Z - сумма за эти пакеты
      FSG_TT1         number(18),
      FSG_TT2         number(18),
      FSG_TT3         number(18),
      GPRS_20GB     number(18),
      GPRS_30GB     number(18),
      GPRS_U          number(18),                       -- GPRS_U - сумма за эти пакеты
      GPRS_U_ON       date,                             -- дата последнего подключения GPRS_U
      MGN500MIN    number(15,2),
      unknown         number(18),                       -- неизвестные пакеты
      total_traff     number(18,2),                     -- Общий потребленный трафик интернет
      outcom_mi       number(18),                       -- Общее количество исходящих минут
      payments        number(18),                       -- Сумма пополнений за месяц
      SPEED3B2B       number(18),                       -- SPEED3B2B - ограничение, если подключено, выводить.
      SPEED3B2B_WORD  varchar2(32),                     -- SPEED3B2B - ограничение, если подключено, выводить.
      DTM41           number(1)                         -- DTM41 - доп.пакет-ограничение на закачку p2p-трафика
    );
  type tbl_rep_gprs_autoturn_1 is table of Trow_rep_gprs_autoturn_1;

  type TRestStatus is record
    (
      phone               varchar2(10 char),
      status              varchar2(1 char),
      statusRsnCode       varchar2(64 char),
      statusDesc          varchar2(512 char)
    );
  type tbl_TRestStatus is table of TRestStatus;
    
  type TServiceList   -- Тип для записи о подключенном сервисе  
    is record
       (
        name          varchar2(16),
        entityName    varchar2(128),
        entityDesc    varchar2(1024),
        rcRate        number(12,2) := 0,
        rcRatePeriod  varchar2(128),
        category      varchar2(128),
        sdbSize       number(12,2) := 0,
        viewInd       varchar2(16),
        removeInd     varchar2(16),
        effDate       varchar2(32),
        exprDate      varchar2(32)
       ); 
  type tbl_TServiceList is table of TServiceList;

  

--  constants      --------- BEGIN ---------------------------------------------------------------------------------------------

  beeline_protocol                constant varchar2(6)  :='https';
  beeline_domain                  constant varchar2(64) :='my.beeline.ru';
  beeline_auth_path               constant varchar2(64) :='/api/1.0/auth';
  info_rests_path                 constant varchar2(64) :='/api/1.0/info/rests';
  info_get_status_path            constant varchar2(64) :='/api/1.0/info/status';
  info_serviceList_path           constant varchar2(64) :='/api/1.0/info/serviceList';
  req_callForward_path            constant varchar2(64) :='/api/1.0/request/callForward';
  info_callForward_path           constant varchar2(64) :='/api/1.0/info/callForward';
  req_callForward_edt_path        constant varchar2(64) :='/api/1.0/request/callForward/edit';
  info_subscriptions_path         constant varchar2(64) :='/api/1.0/info/subscriptions';
  req_subscription_rmv_path       constant varchar2(64) :='/api/1.0/request/subscription/remove';
  info_get_balance                CONSTANT VARCHAR2 (23 char) := '/api/1.0/info/mcBalance';

  err_ok                          constant varchar2(5)  :='20000';
  
  c_turn_tariff_immediately       constant number       := 10;  -- (минут) время необходимое для израсходования остатка трафика на тарифе 
                                                                -- при котором будет произведено немедленное переключение на новый тариф 
  c_turn_tariff_checktime_min     constant number       := 10;  -- (минут), минимальный интервал проверки доступного объёма трафика на тарифе/пакете 
  c_turn_tariff_checktime_max     constant number       := 60;  -- (минут), максимальный интервал проверки доступного объёма трафика на тарифе/пакете 
  c_turn_tariff_ctrlpnt_inc       constant number       := 0.2; -- (%/100), процент от объёма начального трафика на тарифе/пакете при значении измерений 
                                                                -- равном либо более которого ставится отметка опорной точки (для линейного прогноза) 

  c_errlvl_internet_initialsize   constant number       := 32768; -- порог корректировки значений остатков INTERNET от Билайн, при котором значение признаётся ошибочным и подлежит корректировке. 
  c_errlvl_voice_initialsize      constant number       := 12000; -- порог корректировки значений остатков VOICE от Билайн, при котором значение признаётся ошибочным и подлежит корректировке.                                                                
--   constants     ---------  END  ---------------------------------------------------------------------------------------------

  function intr_to_sec(p_time interval day to second) return number; -- перевод интервала в днях в секунды

  function get_token(p_login varchar2, p_passwd varchar2) return varchar2;
  function get_data(purl in varchar2, phdr in varchar2) return clob;
  function get_resp_stat(code number, status varchar2, message varchar2, phone varchar2, requestid number, note varchar2, return_status number, p_req varchar2, p_data clob) return number;
  function info_rests(token varchar2, phash varchar2, pclient varchar2, ctn varchar2) return TRests;
  function req_callforward(token varchar2, phash varchar2, pclient varchar2, ctn varchar2) return number;
  function info_callforward(token varchar2, phash varchar2, pclient varchar2, ctn varchar2, requestid integer) return number;
  function req_callForward_edit(token varchar2, phash varchar2, pclient varchar2, ctn varchar2, CallFrwEdtReqDo varchar2) return number;
  function info_subscriptions(token varchar2, phash varchar2, pclient varchar2, ctn varchar2) return number;
  function req_subscriptions_remove(token varchar2, phash varchar2, pclient varchar2, ctn varchar2, subscriptionid varchar2, ptype varchar2) return number;

  function  gprs_check_turn_tariff(p_phone varchar2) return number; -- проверка остатка интернет траффика на тарифе/пакете и подключение нового при необходимости 
  function  gprs_get_rest (p_phone varchar2) return number; -- получение и запись остатков по номеру в gprs_stats, добавляет остатки только для неотключенных тарифов/доп.пакетов (возвращает 1 если запись была добавлена)
  function  get_status(pPHONE_NUMBER varchar2) return tbl_TRestStatus pipelined; -- получить статус номера
  function  get_serviceList(pPHONE_NUMBER varchar2) return tbl_TServiceList pipelined;  -- получить список подключенных услуг
  procedure gprs_check_tariff_test(p_flow_code varchar2); -- Запуск обслуживания указанного потока GPRS_FLOWS (TEST)
  procedure gprs_check_tariff_all_test; -- Запуск обслуживания всех номеров (TEST)
  procedure gprs_check_phone_all; -- Запуск обслуживания всех номеров (из CONTRACTS)
  procedure gprs_check_phone_flow(p_STREAM_ID integer); -- Запуск обслуживания номеров в потоке (из CONTRACTS)
  procedure gprs_check_phone_tariff(p_phone varchar2); -- Проверка телефона на необходимость измерений и автоподключения
  procedure gprs_init_new_month; -- Инициализация нового месяца
  function  gprs_opts_turn_off(p_phone varchar2, p_opts_code varchar2, p_note varchar2) return number; -- Отключить опцю
  procedure gprs_opts_turn_off_all(p_phone varchar2, p_note varchar2); -- Отключить всё кроме тарифного плана на указанном номере
  procedure gprs_opts_turn_off_all_phones; -- Отключить все доп.опции, кроме тарифного плана, на всех номерах
  
  type t_calc_traff is record
    (
      total_traff number(24)    := 0,
      total_sec   number(24,3)  := 0
    );   
  type tbl_calc_traff is table of t_calc_traff;  
  function  calc_traff(p_phone varchar2)  return tbl_calc_traff pipelined; -- расчёт израсходованного трафика и затраченного на это времени

  procedure check_alien_opts(p_STREAM_ID integer); -- проверка доп.опций автоинтернет подключенных не автоматом подключения
  procedure proc_alien_phone_opts(rec_al gprs_alien_opts%rowtype); -- отключение чужих опций с номера
  
  function rep_gprs_autoturn_mon(p_phone varchar2 default null) return tbl_rep_gprs_autoturn_1 pipelined; -- ОТЧЕТ ТЕКУЩИЙ. Используется на текущий месяц на момент выгрузки.
                                                                                                          -- (если не задавать параметр выдаст данные по всем номерам)
  function rep_gprs_autoturn_prev(p_phone varchar2 default null, p_year_month varchar2 default null) return tbl_rep_gprs_autoturn_1 pipelined;-- ОТЧЕТ ТЕКУЩИЙ. Используется за прошедшие месяца
  
  FUNCTION mcBalance (pToken     VARCHAR2,
                      pUuid      VARCHAR2,
                      phash      VARCHAR2,
                      ctn        VARCHAR2)
      RETURN TRestsMCBalance;  --получения суммы авансового счета( САС) и баланса, доступного для МК.
                                                                                                              
  oracle_wallet_file    constant varchar2(1024) := ms_params.GET_PARAM_VALUE('SSL_WALLET_DIR'); --'file:C:\OracleClient32'
  oracle_wallet_passwd  constant varchar2(1024) := '082g625p4Y412sD';

--#########################################################################
/*
Пример запуска функции:
CORP_MOBILE@orcl01> exec :v_num := BEELINE_REST_API_PCKG.info_rests(BEELINE_REST_API_PCKG.get_token('AS453209624','32503250'),'','','9623630138')
CORP_MOBILE@orcl01> print v_num

     V_NUM
----------
         1
CORP_MOBILE@orcl01> select * from db_loader_rests;
15 rows selected.

CORP_MOBILE@orcl01> exec :v_num:= BEELINE_REST_API_PCKG.req_callforward(BEELINE_REST_API_PCKG.get_token('AS453209624','32503250'),'','','9623630138')
CORP_MOBILE@orcl01> print v_num
     V_NUM
----------
2224494279

CORP_MOBILE@orcl01> exec :v_num:= BEELINE_REST_API_PCKG.info_callforward(BEELINE_REST_API_PCKG.get_token('AS453209624','32503250'),'','','9623630138',2224494279)
CORP_MOBILE@orcl01> select * from db_loader_cfrw;
no rows selected

CORP_MOBILE@orcl01> exec :v_num:= BEELINE_REST_API_PCKG.req_callforward(BEELINE_REST_API_PCKG.get_token('AS453209624','32503250'),'','','9623630138')
CORP_MOBILE@orcl01> print v_num
     V_NUM
----------
2224494616

CORP_MOBILE@orcl01> exec :v_num:= BEELINE_REST_API_PCKG.req_callforward_edit(BEELINE_REST_API_PCKG.get_token('AS453209624','32503250'),'','','9623630138','')
CORP_MOBILE@orcl01> print v_num
     V_NUM
----------
         0

CORP_MOBILE@orcl01> exec :v_num := BEELINE_REST_API_PCKG.info_subscriptions(BEELINE_REST_API_PCKG.get_token('AS453209624','32503250'),'','','9623630138')
CORP_MOBILE@orcl01> exec :v_num := BEELINE_REST_API_PCKG.req_subscriptions_remove(BEELINE_REST_API_PCKG.get_token('AS453209624','32503250'),'','','9623630138','','')
CORP_MOBILE@orcl01> print v_num
     V_NUM
----------
2224494873

CORP_MOBILE@orcl01> select LOG_ID,to_char(load_date,'YYYY-MM-DD HH24:mi:ss.ff3') load_date, phone, requestid, code, status,message,note from db_loader_resp_log;

    LOG_ID LOAD_DATE                 PHONE       REQUESTID       CODE STATUS     MESSAGE                        NOTE
---------- ------------------------- ---------- ---------- ---------- ---------- ------------------------------ --------------------------------
        27 2015-01-29 15:17:24.057   9623630138          0      20000 "OK"       null                           info_rests
        28 2015-01-29 15:18:46.665   9623630138          0      20000 "OK"       null                           req_callforward
        29 2015-01-29 15:19:20.150   9623630138 2224505646      20017 "ERROR"    "BAD_REQUEST_STATUS"           info_callforward
        30 2015-01-29 15:19:34.851   9623630138          0      20000 "OK"       null                           req_callforward
        31 2015-01-29 15:20:02.635   9623630138          0      20000 "OK"       null                           info_subscriptions
        32 2015-01-29 15:20:23.888   9623630138          0      20000 "OK"       null                           req_subscriptions_remove
        33 2015-01-29 15:21:42.769   9623630138          0      -2100 NoData     Server retrieve null.          req_callforward_edit
        34 2015-01-29 15:23:03.079   9623630138 2224505646      20000 "OK"       null                           info_callforward



После запроса к серверу посредством req_callforward требуется пауза, чтобы info_callforward отдал вменяемый ответ:

        28 2015-01-29 15:18:46.665   9623630138          0      20000 "OK"       null                           req_callforward
        29 2015-01-29 15:19:20.150   9623630138 2224505646      20017 "ERROR"    "BAD_REQUEST_STATUS"           info_callforward
        34 2015-01-29 15:23:03.079   9623630138 2224505646      20000 "OK"       null                           info_callforward

При запросе на '/api/1.0/request/callForward/edit' (метод req_callforward_edit) сервер возвращает NULL, хотя должен requestid, м.б. ссылка метода не рабочая .


Методы работы с подписками и переадресацией проверил, насколько это возможно без данных (списки возвращаютсф пустые).

*/

--#########################################################################

END BEELINE_REST_API_PCKG_AFR;
CREATE OR REPLACE PACKAGE BODY "CORP_MOBILE"."BEELINE_REST_API_PCKG_AFR" AS

--   intr_to_sec  --------- BEGIN ---------------------------------------------------------------------------------------------
  function intr_to_sec(p_time interval day to second) return number as
  begin
    return(extract(day from p_time)*24*60*60+extract(hour from p_time)*60*60+extract(minute from p_time)*60+extract(second from p_time));
  end;
--   intr_to_sec  ---------  END  ---------------------------------------------------------------------------------------------

--   get_resp_stat --------- BEGIN ---------------------------------------------------------------------------------------------
-- Запись входящего сообщения в лог с возвратом в качестве результата парамерта return_status 
  function get_resp_stat(code number, status varchar2, message varchar2, phone varchar2, requestid number, note varchar2, return_status number, p_req varchar2, p_data clob) return number as
  pragma autonomous_transaction;
  begin
    insert into db_loader_resp_log
      (
        LOG_ID,
        LOAD_DATE,
        PHONE,
        REQUESTID,
        CODE,
        STATUS,
        MESSAGE,
        NOTE,
        REQUEST,
        RESPONSE
      ) 
      values
      (
        db_loader_resp_log_id.nextval,
        systimestamp,
        phone,
        requestid,
        code,
        status,
        message,
        note,
        p_req,
        p_data
      );
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
        insert into beeline_api_token_list 
          (
            ACC_LOG,
            TOKEN,
            LAST_UPDATE,
            REST_TOKEN,
            REST_LAST_UPDATE
          )
          values 
          (
            p_login, 
            null,
            null,
            v_token, 
            sysdate
          );
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
    v_rest    TInfoRest;
    v_rests   TRests;
    v_data    db_loader_resp_log.response%type;
    v_req     db_loader_resp_log.request%type;
    v_hdr     varchar2(512);
    v_grs     number(12);
    v_code    db_loader_resp_log.code%type; 
  begin
    
    v_req  := beeline_protocol||'://'||beeline_domain||info_rests_path||'?ctn='||ctn;
    v_hdr  := 'Cookie: token='||token||'; domain='||beeline_domain||'; path='||info_rests_path||';';
    v_data := get_data(v_req, v_hdr);
    v_grs  := get_resp_stat(-9000,'LogReqResp','Save request and response into log.', ctn,0,'info_rests',0,v_req||chr(38)||'token='||token, v_data);
    if v_data  is null  then return(v_rests); end if;
    obj    := json(v_data);

    v_code := nvl(json_ext.get_json(obj,'meta').get('code').get_number,0);
    v_grs  := get_resp_stat
      (
        v_code,
        nvl(json_ext.get_json(obj,'meta').get('status').get_string,''),
        nvl(json_ext.get_json(obj,'meta').get('message').get_string,''),
        ctn,
        0,
        'info_rests',
        0,
        v_req||chr(38)||'token='||token, 
        v_data
      );
    if v_code <> err_ok then return(v_rests);  end if;

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
      
      if upper(v_rest.unitType)='INTERNET' and v_rest.initialSize > c_errlvl_internet_initialsize 
      then 
        v_rest.currValue  :=round(v_rest.currValue/1024/1024,2); 
        v_rest.initialSize:=round(v_rest.initialSize/1024/1024,2); 
      end if;-- 32GB
      if upper(v_rest.unitType)='VOICE' and v_rest.initialSize >= c_errlvl_voice_initialsize
      then 
        v_rest.currValue:=v_rest.currValue/60; 
        v_rest.initialSize:=v_rest.initialSize/60; 
      end if;
      
      v_rests(i) := v_rest;
    end loop;

    return(v_rests);
  end;
--   info_rests ------------  END  ------------------------------------------------------------------------------------

--   get_status ------------ BEGIN ---------------------------------------------------------------------------------------------
  function get_status(pPHONE_NUMBER varchar2) return tbl_TRestStatus pipelined AS  -- получить статус номера
    CURSOR C IS
      SELECT ACCOUNTS.LOGIN,
             ACCOUNTS.New_Pswd,
             ACCOUNTS.ACCOUNT_NUMBER,
             ACCOUNTS.Company_Name,
             Accounts.Account_Id
        FROM DB_LOADER_ACCOUNT_PHONES, ACCOUNTS
       WHERE DB_LOADER_ACCOUNT_PHONES.PHONE_NUMBER = pPHONE_NUMBER
         AND ACCOUNTS.ACCOUNT_ID = DB_LOADER_ACCOUNT_PHONES.ACCOUNT_ID
         AND DB_LOADER_ACCOUNT_PHONES.YEAR_MONTH = (select max(YEAR_MONTH) 
            from DB_LOADER_ACCOUNT_PHONES where PHONE_NUMBER = pPHONE_NUMBER);
    vREC     C%ROWTYPE;
    v_data    db_loader_resp_log.response%type;
    v_req     db_loader_resp_log.request%type;
    v_code    db_loader_resp_log.code%type; 
    v_hdr     varchar2(512);
    v_grs     number(12);
    token     varchar2(64);
    token_old date;
    obj       json;
    v_result  TRestStatus;
  BEGIN
    OPEN C;
    FETCH C INTO vREC;
    CLOSE C;
    IF vREC.LOGIN IS NOT NULL THEN
       select t.rest_token,t.rest_last_update into token,token_old from beeline_api_token_list t where t.acc_log=vREC.login;
       if (token_old<sysdate- 9/24 --9/1440 
         or token_old is null) 
       then 
          token := GET_TOKEN(vREC.login,vREC.new_pswd);
       end if;

      v_req  := beeline_protocol||'://'||beeline_domain||info_get_status_path||'?ctn='||pPHONE_NUMBER;
      v_hdr  := 'Cookie: token='||token||'; domain='||beeline_domain||'; path='||info_get_status_path||';';
      v_data := get_data(v_req, v_hdr);
      v_grs  := get_resp_stat(-9000,'LogReqResp','Get status.', pPHONE_NUMBER,0,'info_get_status',0,v_req||chr(38)||'token='||token, v_data);
      if v_data  is not null  then
        obj  := json(v_data);
        v_code := nvl(json_ext.get_json(obj,'meta').get('code').get_number,0);
        v_grs  := get_resp_stat
          (
            v_code,
            nvl(json_ext.get_json(obj,'meta').get('status').get_string,''),
            nvl(json_ext.get_json(obj,'meta').get('message').get_string,''),
            pPHONE_NUMBER,
            0,
            'info_get_status',
            0,
            v_req||chr(38)||'token='||token, 
            v_data
          );
        if v_code = err_ok then
          v_result.phone         := pPHONE_NUMBER;
          v_result.status        := nvl(obj.get('status').get_string,'');
          v_result.statusRsnCode := nvl(obj.get('statusRsnCode').get_string,'');
          v_result.statusDesc    := nvl(obj.get('statusDesc').get_string,'');
          pipe row(v_result);
        end if;
      end if;
    end if;
  END;
--   get_status ------------  END  ------------------------------------------------------------------------------------

--   get_serviceList ------- BEGIN ---------------------------------------------------------------------------------------------
  function get_serviceList(pPHONE_NUMBER varchar2) return tbl_TServiceList pipelined AS  -- получить список подключенных услуг
    CURSOR C IS
      SELECT ACCOUNTS.LOGIN,
             ACCOUNTS.New_Pswd,
             ACCOUNTS.ACCOUNT_NUMBER,
             ACCOUNTS.Company_Name,
             Accounts.Account_Id
        FROM DB_LOADER_ACCOUNT_PHONES, ACCOUNTS
       WHERE DB_LOADER_ACCOUNT_PHONES.PHONE_NUMBER = pPHONE_NUMBER
         AND ACCOUNTS.ACCOUNT_ID = DB_LOADER_ACCOUNT_PHONES.ACCOUNT_ID
         AND DB_LOADER_ACCOUNT_PHONES.YEAR_MONTH = (select max(YEAR_MONTH) 
            from DB_LOADER_ACCOUNT_PHONES where PHONE_NUMBER = pPHONE_NUMBER);
    vREC          C%ROWTYPE;
    tmp           json_list;
    tmpobj        json;
    v_data        db_loader_resp_log.response%type;
    v_req         db_loader_resp_log.request%type;
    v_code        db_loader_resp_log.code%type; 
    v_hdr         varchar2(512);
    v_grs         number(12);
    token         varchar2(64);
    token_old     date;
    obj           json;
    v_servicelist TServiceList; 
  
  BEGIN
    OPEN C;
    FETCH C INTO vREC;
    CLOSE C;
    IF vREC.LOGIN IS NOT NULL THEN
       select t.rest_token,t.rest_last_update into token,token_old from beeline_api_token_list t where t.acc_log=vREC.login;
       if (token_old<sysdate- 9/24 --9/1440 
         or token_old is null) 
       then 
          token := GET_TOKEN(vREC.login,vREC.new_pswd);
       end if;

      v_req  := beeline_protocol||'://'||beeline_domain||info_serviceList_path||'?ctn='||pPHONE_NUMBER;
      v_hdr  := 'Cookie: token='||token||'; domain='||beeline_domain||'; path='||info_serviceList_path||';';
      v_data := get_data(v_req, v_hdr);
      v_grs  := get_resp_stat(-9000,'LogReqResp','Get services list.', pPHONE_NUMBER,0,'info_get_serviceList',0,v_req||chr(38)||'token='||token, v_data);
      if v_data  is not null  then
        obj  := json(v_data);
        v_code := nvl(json_ext.get_json(obj,'meta').get('code').get_number,0);
        v_grs  := get_resp_stat
          (
            v_code,
            nvl(json_ext.get_json(obj,'meta').get('status').get_string,''),
            nvl(json_ext.get_json(obj,'meta').get('message').get_string,''),
            pPHONE_NUMBER,
            0,
            'info_get_serviceList',
            0,
            v_req||chr(38)||'token='||token, 
            v_data
          );
        if v_code = err_ok then
          tmp := json_ext.get_json_list(obj,'services');
          for i in 1 .. tmp.count loop
            tmpobj := json(tmp.get(i));

            if (tmpobj.exist('name'))         then v_servicelist.name         := tmpobj.get('name').get_string; else v_servicelist.name := ''; end if;
            if (tmpobj.exist('entityName'))   then v_servicelist.entityName   := tmpobj.get('entityName').get_string; else v_servicelist.entityName := ''; end if;
            if (tmpobj.exist('entityDesc'))   then v_servicelist.entityDesc   := tmpobj.get('entityDesc').get_string; else v_servicelist.entityDesc := ''; end if;
            if (tmpobj.exist('rcRate'))       then v_servicelist.rcRate       := tmpobj.get('rcRate').get_number; else v_servicelist.rcRate := 0; end if;
            if (tmpobj.exist('rcRatePeriod')) then v_servicelist.rcRatePeriod := tmpobj.get('rcRatePeriod').get_string; else v_servicelist.rcRatePeriod := ''; end if;
            if (tmpobj.exist('category'))     then v_servicelist.category     := tmpobj.get('category').get_string; else v_servicelist.category := ''; end if;
            if (tmpobj.exist('sdbSize'))      then v_servicelist.sdbSize      := tmpobj.get('sdbSize').get_number; else v_servicelist.sdbSize := 0; end if;
            if (tmpobj.exist('viewInd'))      then v_servicelist.viewInd      := tmpobj.get('viewInd').get_string; else v_servicelist.viewInd := ''; end if;
            if (tmpobj.exist('removeInd'))    then v_servicelist.removeInd    := tmpobj.get('removeInd').get_string; else v_servicelist.removeInd := ''; end if;
            if (tmpobj.exist('effDate'))      then v_servicelist.effDate      := tmpobj.get('effDate').get_string; else v_servicelist.effDate := ''; end if;
            if (tmpobj.exist('exprDate'))     then v_servicelist.exprDate     := tmpobj.get('exprDate').get_string; else v_servicelist.exprDate := ''; end if;    
            pipe row(v_servicelist);
          end loop;
        end if;
      end if;
    end if;
  END;
--   get_serviceList ------------  END  ------------------------------------------------------------------------------------
  
--   req_callforward --- BEGIN ------------------------------------------------------------------------------------
  function req_callforward(token varchar2, phash varchar2, pclient varchar2, ctn varchar2) return number as
    obj       json;
    v_data    db_loader_resp_log.response%type;
    v_req     db_loader_resp_log.request%type;
    v_hdr     varchar2(512);
    v_grs     number(12);
    v_reqid   number(18);
    v_code    db_loader_resp_log.code%type; 
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

    v_reqid:= nvl(json_ext.get_number(obj,'requestId'),0); 
    v_code := nvl(json_ext.get_json(obj,'meta').get('code').get_number,0);
    v_grs  := get_resp_stat
      (
        v_code,
        nvl(json_ext.get_json(obj,'meta').get('status').get_string,''),
        nvl(json_ext.get_json(obj,'meta').get('message').get_string,''),
        ctn,
        v_reqid,
        'req_callforward',
        0,
        v_req||chr(38)||'token='||token, 
        v_data
      );
    if v_code <> err_ok then return(0); end if;
    return(v_reqid);
  end;
--   req_callforward ---  END  ------------------------------------------------------------------------------------

--   info_callforward ------ BEGIN ------------------------------------------------------------------------------------
  function info_callforward(token varchar2, phash varchar2, pclient varchar2, ctn varchar2, requestid integer) return number as
    obj       json;
    tmp       json_list;
    tmpobj    json;
    v_cfrw    db_loader_cfrw%rowtype;
    v_data    db_loader_resp_log.response%type;
    v_req     db_loader_resp_log.request%type;
    v_hdr     varchar2(512);
    v_grs     number(12);
    v_code    db_loader_resp_log.code%type; 
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

    v_code := nvl(json_ext.get_json(obj,'meta').get('code').get_number,0);
    v_grs  := get_resp_stat
      (
        v_code,
        nvl(json_ext.get_json(obj,'meta').get('status').get_string,''),
        nvl(json_ext.get_json(obj,'meta').get('message').get_string,''),
        ctn,
        requestid,
        'info_callforward',
        0,
        v_req||chr(38)||'token='||token, 
        v_data
      );
    if v_code <> err_ok then return(0); end if;

    tmp := json_ext.get_json_list(obj,'callForwards');
    for i in 1 .. tmp.count loop
      v_cfrw.cfrw_id   := db_loader_cfrw_id.nextval;
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
    v_cfrw    db_loader_cfrw%rowtype;
    v_data    db_loader_resp_log.response%type;
    v_req     db_loader_resp_log.request%type;
    v_hdr     varchar2(512);
    v_grs     number(12);
    v_reqid   number(18);
    v_code    db_loader_resp_log.code%type; 
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

    v_reqid:= nvl(json_ext.get_number(obj,'requestId'),0); 
    v_code := nvl(json_ext.get_json(obj,'meta').get('code').get_number,0);
    v_grs  := get_resp_stat
      (
        v_code,
        nvl(json_ext.get_json(obj,'meta').get('status').get_string,''),
        nvl(json_ext.get_json(obj,'meta').get('message').get_string,''),
        ctn,
        v_reqid,
        'req_callforward_edit',
        0,
        v_req||chr(38)||'token='||token, 
        v_data
      );
    if v_code <> err_ok then return(0); end if;

    return(v_reqid);
  end;
--   req_callforward_edit --  END  ------------------------------------------------------------------------------------

--   info_subscriptions ---- BEGIN ---------------------------------------------------------------------------------------------
  function info_subscriptions(token varchar2, phash varchar2, pclient varchar2, ctn varchar2) return number as
    obj       json;
    tmp       json_list;
    tmpobj    json;
    v_subs    db_loader_subs%rowtype;
    v_data    db_loader_resp_log.response%type;
    v_req     db_loader_resp_log.request%type;
    v_hdr     varchar2(512);
    v_grs     number(12);
    v_code    db_loader_resp_log.code%type; 
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

    v_code := nvl(json_ext.get_json(obj,'meta').get('code').get_number,0);
    v_grs  := get_resp_stat
      (
        v_code,
        nvl(json_ext.get_json(obj,'meta').get('status').get_string,''),
        nvl(json_ext.get_json(obj,'meta').get('message').get_string,''),
        ctn,
        0,
        'info_subscriptions',
        0,
        v_req||chr(38)||'token='||token, 
        v_data
      );
    if v_code <> err_ok then return(0); end if;

    tmp := json_ext.get_json_list(obj,'subscriptions');
    for i in 1 .. tmp.count loop
      v_subs.subs_id    := db_loader_subs_id.nextval;
      v_subs.load_date  := systimestamp;
      v_subs.phone      := ctn;

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
    v_data    db_loader_resp_log.response%type;
    v_req     db_loader_resp_log.request%type;
    v_hdr     varchar2(512);
    v_grs     number(12);
    v_reqid   number(18);
    v_code    db_loader_resp_log.code%type; 
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

    v_reqid:= nvl(json_ext.get_number(obj,'requestId'),0); 
    v_code := nvl(json_ext.get_json(obj,'meta').get('code').get_number,0);
    v_grs  := get_resp_stat
      (
        v_code,
        nvl(json_ext.get_json(obj,'meta').get('status').get_string,''),
        nvl(json_ext.get_json(obj,'meta').get('message').get_string,''),
        ctn,
        v_reqid,
        'req_subscriptions_remove',
        0,
        v_req||chr(38)||'token='||token, 
        v_data
      );
    if v_code <> err_ok then return(0); end if;

    return(v_reqid);

  end;
--   req_subscription_remove ----  END  ------------------------------------------------------------------------------------

--   gprs_check_turn_tariff ---- BEGIN ---------------------------------------------------------------------------------------------
  function gprs_check_turn_tariff(p_phone varchar2) return number as -- проверка остатка интернет траффика на тарифе/пакете и подключение нового при необходимости
    type t_stat is table of gprs_stat%rowtype index by pls_integer;
    v_rec                 t_stat;
    v_num                 number(38) := 0;
    v_time                interval day (5) to second (9);
    v_num0                number(38);-- секунд с начала месяца
    v_time0               interval day (5) to second (9); -- с начала месяца
    v_vol                 number(12);
    v_tariff_code         varchar2(30);
    v_tariff_code_old     varchar2(30);
    delta_time_sec        number(12);
    ctrl_pnt_cnt          number(12); -- кол-во уже пройденных опорных точек
    new_opt_id            number(38);
    v_str                 varchar2(1024);
    v_str0                varchar2(1024);
    v_grs                 number(12);
    v_date                timestamp;
    i                     number(12) := 0;
    j                     number(12) := 0;
    v_is_no_turn_on       number     := 0;
    v_rest_auto_internet  number(12) := 500; -- общий для всех доп.пакетов неснижаемый остаток (500МБ) при переподключении, при переключении с тарифа переопределяется на строке 650
    v_first_day           date;

    v_last_week_opt       varchar2(32) := 'GPRS_U';

    type t_stat2 is record
      (
        phone           varchar2(10),
        initvalue       integer,
        currvalue       integer,
        curr_check_date timestamp
      );
    type t_stats is table of t_stat2 index by pls_integer;
    vt_stat t_stats;
    
    v_total_sec     number(24,3)  := 0;
    v_total_traf    number(24)    := 0;  
    v_end_month_sec number(24,3)  := 0;
    
    pSchemeWork integer; --схема работы алгоритма по подключению пакетов
    pCntTarCode integer;

  begin
    
    -- v_rec(1) - первая точка измерений 
    -- v_rec(2) - предпоследнее измерение
    -- v_rec(3) - текущее измерение, в последсвии м.б. даже только что измеренное и ещё не внесённое в БД

    begin
    
      select tariff_code into v_tariff_code from (select tariff_code from gprs_turn_log where phone=p_phone and date_off is null order by date_off desc) where rownum <2;
      
      if v_tariff_code is not null then -- сейчас подключен тариф?  
        select count(1)
          into v_num
          from tariffs
         where tariff_code=v_tariff_code
           and is_auto_internet=1;
        
        if nvl(v_num,0)>0 then  -- если тариф то пересчитываем неснижаемый остаток, иначе 0 
          select t.REST_AUTO_INTERNET*1.1 -- оставим на тарифе буферный объём трафика для отключения пакетов в конце месяца
            into v_rest_auto_internet
            from v_contracts c
                 join tariffs t 
                   on t.tariff_id=C.TARIFF_ID
           where C.CONTRACT_CANCEL_DATE is null
             and T.IS_AUTO_INTERNET<>0
             and phone_number_federal= p_phone;
        end if;
        
        select * into v_rec(1) 
          from (select * from gprs_stat where phone = p_phone and tariff_code= v_tariff_code order by curr_check_date, stat_id) where rownum <2;

        select * into v_rec(2) 
          from (select * from (select * from gprs_stat where phone = p_phone and tariff_code= v_tariff_code order by curr_check_date desc, stat_id desc) where rownum <3  order by curr_check_date, stat_id) where rownum <2;
            
        select * into v_rec(3) 
          from (select * from gprs_stat where phone = p_phone and tariff_code= v_tariff_code order by curr_check_date desc, stat_id desc) where rownum <2;

        
        -- рассчёт даты/времени следующей проверки, определить когда мы предположительно пробъём следующие 20% или 0  
        
        -- Рассчёт времени необходимого для расходования остатка трафика, если <= c_turn_tariff_immediately (10 мин по-умолчанию) то переключаемся немедленно
        v_num0 := abs(nvl(v_rec(2).currvalue,0)-nvl(v_rec(3).currvalue,0)); -- объём потраченный с последнего измерения  
        v_num  := abs(nvl(intr_to_sec(v_rec(3).curr_check_date - v_rec(2).curr_check_date),0)); -- время с последнего измерения в секундах
        -- Если остаток трафика на тарифе:
        --    > предыдущего измерения, значит это сбой билайна и пакет на самом деле выработан в "0" 
        --    <= неснижаемого остатка интернет-трафика на тарифе (v_rest_auto_internet);
        --    будет потрачен за c_turn_tariff_immediately (10 по-умолчанию) минут;
        -- то подключаем новый пакет немедленно         
        if (nvl(v_rec(3).currvalue,0)>nvl(v_rec(2).currvalue,0))
        or (nvl(v_rec(3).currvalue,0) <= nvl(v_rest_auto_internet,0)) 
        or (v_num0 <>0 and v_num <> 0 and nvl(v_rec(3).currvalue,0)*v_num/v_num0/60 <= c_turn_tariff_immediately) then -- по-умолчанию "10" (минут)
          -- подключить доп.пакет
          -- dbms_output.put_line('Подключить доп.пакет');
          -- определить предполагаемый необходимый объём трафика до конца месца
          -- текущая скорость потребления с начала месяца по настоящее время

          -- подсчёт потраченного ранее трафика (в текущем месяце)
          --  select sum(distinct initvalue) into initvalue_sum from gprs_stat where phone=p_phone;
          v_tariff_code_old := v_tariff_code; -- сохранить старый для записи лога
          begin
            -- Общий потребленный трафик интернет
            select
                    total_sec,
                    total_traff
              into
                    v_total_sec,
                    v_total_traf
              from
                    table(calc_traff(p_phone));
            --кол-во секунд до конца месяца считаем с момента произведения расчётов
            v_end_month_sec := intr_to_sec(to_date(to_char(last_day(sysdate),'YYYY-MM-DD')||' 23:59:59','YYYY-MM-DD hh24:mi:ss')-systimestamp); -- vt_stat(1).curr_check_date); --
            if    v_total_sec  <= 0 
              or  v_total_traf <= 0 
              then 
              --dbms_output.put_line('Обработка номера '||p_phone||' прервана: v_total_sec = 0 .');
              return(-1); 
            end if;
            --dbms_output.put_line(vt_stat(1).phone||' | за: '||round(v_total_sec/24/60/60,2)||' дн. | потрачен МБ: '||v_total_traf||' | до конца мес: '||round(v_end_month_sec/24/60/60,2)||' дн. | Потребуется МБ: '||round(v_total_traf*v_end_month_sec/v_total_sec,0));
            -- До конца месяца потребуется (МБ)
            v_num := v_total_traf*v_end_month_sec/v_total_sec;
          exception
            when no_data_found then 
              --dbms_output.put_line('Нет данных для обработки');
              return(-1);
          end;                  
          -- dbms_output.put_line('До конца месяца потребуется: '||v_num);

          -- opt_id подходящего пакета
          --после того как определено количество трафика, которое потребуется до конца месяца (v_num), необходимо учесть схемы подключения
          --на данный момент имеется 3 схемы подключения: 
          --Схема 1. - Безлим. 990, 1290, 980, 1280. Подключаются пакеты GPRS_20 и GPRS_U. Пакет GPRS_20 подкл. максимум 2 раза/месяц
              --  1) расчитываем стоимость безлимита от текущего момента времени до конца месяца;
              --  2) расчитываем стоимость пакетов 20ГБ в зависимости от количества подкл. пакетов, которые перекроют расчетный трафик до конца месяца. Количество пакетов округляется всегда в большую сторону.
              --  3) если стоимость безлимита <= стоимости суммарных пакетов 20ГБ или пакет 20ГБ уже подкл. 2 раза, то подключаем GPRS_U, иначе 20ГБ.
          --Схема 2. - Безлим. 1590. Подключаются пакеты FSG_TT2, FSG_TT3 и GPRS_U. Остается старая логика
              --  1) отбираются все пакеты с объёмом трафика более требуемого расчётного;
              --  2) рассчитывается стоимость безлимита от текущего момента времени до конца месяца; 
              --  3) из стоимостей безлимита по п.2 и отобранных в п.1 пакетов выбираем наименьшую;
              --  4) подключаемым назначается опция соответствующая стоимости выбранной в п.3
          --Схема 3. - Безлим. 1580. Подключаются пакеты GPRS_30 и GPRS_U. Пакет GPRS_30 подкл. максимум 1 раз/месяц. По сути сохраняется старая логика
              --  1) отбираются все пакеты с объёмом трафика более требуемого расчётного;
              --  2) рассчитывается стоимость безлимита от текущего момента времени до конца месяца; 
              --  3) из стоимостей безлимита по п.2 и отобранных в п.1 пакетов выбираем наименьшую;
              --  4) если наименьшая стоимость у пакета 30 ГБ и он еще не подкл., то подключаем его, иначе GPRS_U
          --
          pSchemeWork := 0;
          begin
            select nvl(ATR.INT_TYPE, 0)
              into pSchemeWork
             from congr_tarif cn,
                     tariffs_attrs atr
            where CN.TARIFFS_ATTRIBUTES_ID = ATR.TARIFFS_ATTRIBUTES_ID
                and ATR.ATTRIBUTES_NAME = 'SCHEME_AUTO_CONNECT_PCKG'
                and CN.TARIFF_ID = GET_CURR_PHONE_TARIFF_ID(p_phone);   
          exception
            when others then 
              return(-1);
          end;
          --если не выбрана схема подкл. пакета, то ничего не подключаем а то натворим хаус в подключениях
          if nvl(pSchemeWork, 0) = 0 then
            return(-1);
          end if;
          --выбираем пакет
          begin
            select
                    code,
                    VOLUME
              into
                    v_tariff_code,
                    v_num0
              from
                    (
                      select
                              TF.OPTION_CODE      code,
                              nvl(TF.INTERNET_VOLUME,0)  volume,
                              case nvl(TF.DISCR_SPISANIE,0)
                                when 0 then 
                                            nvl(TC.MONTHLY_COST,0)
                                            * 
                                              ceil(beeline_rest_api_pckg.intr_to_sec
                                              (
                                                  trunc(add_months(sysdate,1),'mm')
                                                - systimestamp
                                              )/24/60/60)/
                                                to_number(to_char(last_day(sysdate),'dd'))
                                else
                                  case 
                                    when (nvl(pSchemeWork, 0) = 1) then --если схема 1, то смотрим сколько понадобится пакетов, чтобы перекрыть расчетный трафик до конца месяца
                                      nvl(TC.MONTHLY_COST,0) *ceil(v_num/TF.INTERNET_VOLUME)
                                    else --для схемы 2 и 3
                                      nvl(TC.MONTHLY_COST,0)
                                  end
                              end 
                              cost_for_month_rest
                        from
                              tariff_options  tf,
                              TARIFF_OPTION_COSTS tc
                       where
                              TF.IS_AUTO_INTERNET=1
                         and  TF.INTERNET_VOLUME >= 
                                                                       (
                                                                           CASE
                                                                              WHEN (nvl(pSchemeWork, 0) = 1) THEN --для схемы 1
                                                                                 1
                                                                              ELSE --для схемы 2 и 3
                                                                                 nvl(v_num,0)
                                                                           END
                                                                       )
                         and  TC.TARIFF_OPTION_ID = TF.TARIFF_OPTION_ID
                         and  sysdate between TC.BEGIN_DATE and TC.END_DATE
                         and exists (
                                            select 1
                                             from congr_tarif cn,
                                                     tariffs_attrs atr
                                           where CN.TARIFFS_ATTRIBUTES_ID = ATR.TARIFFS_ATTRIBUTES_ID
                                               and ATR.ATTRIBUTES_NAME = 'ATR_OPTION'
                                               and CN.TARIFF_ID = GET_CURR_PHONE_TARIFF_ID(p_phone)
                                               and nvl(ATR.INT_TYPE, 0) = TC.TARIFF_OPTION_ID
                                         )
                       order  by
                              cost_for_month_rest
                    )
             where
                    rownum < 2;
          exception
            when no_data_found then
              if ((nvl(pSchemeWork, 0) = 2) or (nvl(pSchemeWork, 0) = 3)) then
                begin
                  select
                      code,
                      VOLUME
                  into
                      v_tariff_code,
                      v_num0
                  from
                      (
                        select
                                TF.OPTION_CODE      code,
                                TF.INTERNET_VOLUME  volume,
                                case nvl(TF.DISCR_SPISANIE,0)
                                  when 0 then 
                                              nvl(TC.MONTHLY_COST,0)
                                              * 
                                                ceil(beeline_rest_api_pckg.intr_to_sec
                                                (
                                                    trunc(add_months(sysdate,1),'mm')
                                                  - systimestamp
                                                )/24/60/60)/
                                                  to_number(to_char(last_day(sysdate),'dd'))
                                  else nvl(TC.MONTHLY_COST,0)
                                end 
                                cost_for_month_rest
                          from
                                tariff_options  tf,
                                TARIFF_OPTION_COSTS tc
                         where
                                TF.IS_AUTO_INTERNET=1
                           and  TF.INTERNET_VOLUME > 0
                           and  TF.INTERNET_VOLUME < nvl(v_num,0)
                           and  TC.TARIFF_OPTION_ID = TF.TARIFF_OPTION_ID
                           and  sysdate between TC.BEGIN_DATE and TC.END_DATE
                           and exists (
                                            select 1
                                             from congr_tarif cn,
                                                     tariffs_attrs atr
                                           where CN.TARIFFS_ATTRIBUTES_ID = ATR.TARIFFS_ATTRIBUTES_ID
                                               and ATR.ATTRIBUTES_NAME = 'ATR_OPTION'
                                               and CN.TARIFF_ID = GET_CURR_PHONE_TARIFF_ID(p_phone)
                                               and nvl(ATR.INT_TYPE, 0) = TC.TARIFF_OPTION_ID
                                          )
                         order  by
                                volume desc, 
                                cost_for_month_rest
                      )
                  where
                      rownum < 2;
                exception
                  when others then
                    return(-1);
                end;
              else
                return(-1);
              end if;
          end;        
          --для схемы подкл. 1 и 3 делаем дополнительные действия
          if nvl(pSchemeWork, 0) = 1 then
            --для данной схемы имеется ограничение того, что пакт 20ГБ подкл. максимум 2 раза, т.е.
            --если v_tariff_code = 20ГБ, то проверяем их количество. Если = 2, то вкл. GPRS_U
            pCntTarCode := 0;
            select count(*)
               into pCntTarCode
              from TARIFF_OPTIONS tr
            where TR.OPTION_CODE = v_tariff_code
                and TR.TARIFF_OPTION_ID = 1419; --код опции GPRS_20GB
            
            if nvl(pCntTarCode, 0) > 0 then
              --проверяем количество подключений
              pCntTarCode := 0;
              SELECT count(*)
                 INTO pCntTarCode
                FROM GPRS_TURN_LOG lg
              WHERE LG.TARIFF_CODE = v_tariff_code
                   AND LG.PHONE = p_phone;
              --
              if nvl(pCntTarCode,0) > 1 then
                begin
                  --подключаем безлимит
                  select OP.OPTION_CODE
                     into v_tariff_code
                    from TARIFF_OPTIONS op
                  where nvl(OP.IS_UNLIM_INTERNET, 0) = 1
                      and OP.TARIFF_OPTION_ID = 68; --код опции GPRS_U
                exception
                  when others then
                    return(-1);
                end; 
              end if;
            end if;
          else
            if nvl(pSchemeWork, 0) = 3 then
              --для данной схемы имеется ограничение того, что пакт 30ГБ подкл. максимум 1 раза, т.е.
              --если v_tariff_code = 30ГБ, то проверяем их количество. Если = 1, то вкл. GPRS_U
              pCntTarCode := 0;
              select count(*)
                 into pCntTarCode
                from TARIFF_OPTIONS tr
              where TR.OPTION_CODE = v_tariff_code
                  and TR.TARIFF_OPTION_ID = 1437; --код опции GPRS_30GB
              
              if nvl(pCntTarCode, 0) > 0 then
                --проверяем количество подключений
                pCntTarCode := 0;
                SELECT count(*)
                   INTO pCntTarCode
                  FROM GPRS_TURN_LOG lg
                WHERE LG.TARIFF_CODE = v_tariff_code
                     AND LG.PHONE = p_phone;
                --
                if nvl(pCntTarCode, 0) > 0 then
                  begin
                    --подключаем безлимит
                    select OP.OPTION_CODE
                       into v_tariff_code
                      from TARIFF_OPTIONS op
                    where nvl(OP.IS_UNLIM_INTERNET, 0) = 1
                        and OP.TARIFF_OPTION_ID = 68; --код опции GPRS_U
                  exception
                    when others then
                      return(-1);
                  end; 
                end if;
              end if;
            end if;
          end if;  
          -- dbms_output.put_line('Новый пакет имеет ид.: '||new_opt_id);
          -- dbms_output.put_line('Код : '||v_tariff_code);
                  
          -- Отключить старый пакет, но не тарифный план
          SELECT -- доп.пакет не отключен
                 count(1)
            into
                 v_is_no_turn_on
            FROM
                 DB_LOADER_ACCOUNT_PHONE_OPTS
            join 
                 tariff_options opt on opt.option_code=DB_LOADER_ACCOUNT_PHONE_OPTS.option_code 
           WHERE
                 OPT.OPTION_CODE = v_tariff_code_old and
                 OPT.IS_AUTO_INTERNET = 1 and
                 DB_LOADER_ACCOUNT_PHONE_OPTS.PHONE_NUMBER=p_phone and
                 DB_LOADER_ACCOUNT_PHONE_OPTS.turn_off_date is null;

          if nvl(v_is_no_turn_on,0)<>0 then
            if gprs_opts_turn_off(p_phone,v_tariff_code_old,'gprs_check_turn_tariff') <0 then 
              --return(-1);
              null;
            end if;
          end if;
            
          -- конец истории наблюдений предыдущей опции
          select log_id -- id записи о последнем переключении, учитываем что код опции может повторяться в течении месяца
            into v_grs 
            from (
                  select 
                         log_id 
                    from 
                         gprs_turn_log 
                   where 
                         phone = p_phone and 
                         tariff_code = v_tariff_code_old 
                   order by 
                         date_off desc nulls first
                  ) 
            where rownum <2;
          if nvl(v_grs,0)<>0 then  
            update gprs_turn_log set date_off = systimestamp where log_id = v_grs;
          end if;
          update gprs_stat set is_checked = 1  where stat_id in (v_rec(1).stat_id, v_rec(2).stat_id) and nvl(is_checked,0)=0;

          -- Подключить новый пакет с указанием даты автоматического отключения 22:00 последнего дня месяца
          for i in 1..3 loop -- дадим 3 попытки
            v_str0  := beeline_api_pckg.turn_tariff_option(p_phone,v_tariff_code, 1, null, null, 'AUTO_GPRS');
            v_str   := upper(substr(v_str0,1,5));

            v_grs  := get_resp_stat(-9000,'LogReqResp',case when v_str = 'ERROR' then 'Error turn tariff.' else 'Success turn tariff.' end, p_phone, 0,'gprs_check_turn_tariff',0
                                      ,'Phone number: '||p_phone||' | Tariff: '||v_tariff_code||' | User: '||user
                                      , v_str0);
            if v_str = 'ERROR' then 
              DBMS_LOCK.SLEEP(30);
            else
              exit;
            end if;
          end loop;
          if v_str = 'ERROR' then return(-1); end if;
                   
          update gprs_stat set is_checked = 1  where stat_id = v_rec(3).stat_id and nvl(is_checked,0)=0;

          -- Добавить запись в gprs_stat о первой опорной точке и времени следующего измерения на основании предыдущих измерений
          v_num := NEW_gprs_turn_log_id;
          insert into gprs_turn_log
              (
                LOG_ID,
                PHONE,
                TARIFF_CODE,
                DATE_ON,
                DATE_OFF
              ) 
            values 
              (
                v_num, 
                p_phone, v_tariff_code, 
                systimestamp, 
                null
              );
          --Добавить первую запись и инициировать первый сбор данных
          insert into gprs_stat
            (
              STAT_ID,
              TURN_LOG_ID,
              PHONE,
              TARIFF_CODE,
              INITVALUE,
              CURRVALUE,
              CURR_CHECK_DATE,
              NEXT_CHECK_DATE,
              CTRL_PNT,
              IS_CHECKED
            ) 
            values 
            (
              new_gprs_stat_id,
              v_num, 
              p_phone, 
              v_tariff_code, 
              v_num0, 
              v_num0, 
              systimestamp, 
              trunc(sysdate+c_turn_tariff_checktime_min/24/60,'MI'),
              1,
              0
            );
        else 
          --Проверка на пробой 20%
          -------------------------------
          -- подсчёт количества контрольных точек для множителя контрольного интервала, для сохранения линейности параметра
          -- учитываем возможность пробоя нескольких контрольных точек 
          select nvl(sum(ctrl_pnt),1) into ctrl_pnt_cnt from gprs_stat where phone = p_phone and tariff_code = v_tariff_code and ctrl_pnt<>0 and stat_id <>v_rec(3).stat_id;
          -- dbms_output.put_line('Число контрольных точек: '||ctrl_pnt_cnt);
          -- dbms_output.put_line('20% Check');
          if v_rec(3).currvalue <= v_rec(3).initvalue*(1-c_turn_tariff_ctrlpnt_inc*ctrl_pnt_cnt)  then -- по-умолчанию 0.2, текущее измерение меньше либо равно чем init-20%*число_контрольных_точек
            -- ставим метку контрольной точки - расчёт точки учитывает возможность пробоя более одного контрольного значения (20% по умолчанию)
            v_rec(3).ctrl_pnt := ceil((1-v_rec(3).currvalue/v_rec(3).initvalue)/c_turn_tariff_ctrlpnt_inc) - ctrl_pnt_cnt; -- вычитаем уже посчитанные опорные точки
          else -- иначе сбрасываем метку контрольной точки
            v_rec(3).ctrl_pnt := 0;
          end if;
              
          -- Определить дату следующей проверки
          ----------------------------------------------
          -- Время в секундах с последней проверки
          v_num := abs(intr_to_sec(v_rec(3).curr_check_date-v_rec(2).curr_check_date));
          if v_num <=300 then v_num:= 600; end if; -- если вдруг время с последнй проверки прошло 0 сек или менее 5 мин, то присваиваем 10 мин
          -- Определить объём трафика израсходованного с последней проверки, если 0. то даём 60 мин
          v_num0 := abs(v_rec(2).currvalue-v_rec(3).currvalue);
          --dbms_output.put_line('Израсходовано трафика : '||v_num0||' за '||v_num||' секунд');
          --dbms_output.put_line('Остаток трафика неизрасходованного: '||v_rec(3).currvalue);
          if v_num0 = 0 then
            delta_time_sec := c_turn_tariff_checktime_max*60;  -- по-умолчанию 60 мин;
          else 
            -- ориентировочное время пробоя контрольной точки
            delta_time_sec :=v_rec(3).initvalue*c_turn_tariff_ctrlpnt_inc*ctrl_pnt_cnt*v_num/v_num0;  -- c_turn_tariff_ctrlpnt_inc (по-умолчанию 0.2)
            -- ориентировочное время пробоя нуля трафика
            v_num0 := v_rec(3).currvalue*v_num/v_num0;
            --dbms_output.put_line('Пробой 20% через секунд: '||delta_time_sec);
            --dbms_output.put_line('Пробой нуля через секунд: '||v_num0);
            
            -- если пробой нуля произойдёт быстрее пробоя 20% то ориентируемся на него
            if delta_time_sec > v_num0 then 
              delta_time_sec := v_num0; 
              -- приведение приращения к наименьшему целому кратному минимальному интервалу 
              if delta_time_sec < c_turn_tariff_checktime_min then 
                delta_time_sec := c_turn_tariff_checktime_min;
              else                
                delta_time_sec := floor(delta_time_sec/(c_turn_tariff_checktime_min*60))*c_turn_tariff_checktime_min*60;
              end if;
            end if;            
            -- dbms_output.put_line('Приращение даты проверки в секундах: '||delta_time_sec);
            -- если расчётное время потребления 20% трафика от предыдкщей опорной точки более 1 часа, то следующее измерение назначаем через 1 час
            if delta_time_sec/60/60 > 1 then delta_time_sec := c_turn_tariff_checktime_max*60; end if;
          end if;
          -- Зафиксируем дату следующей проверки, контрольную метку
          update gprs_stat set is_checked = 1  where stat_id in (v_rec(1).stat_id, v_rec(2).stat_id) and nvl(is_checked,0)=0;
          update gprs_stat set next_check_date = trunc(sysdate+delta_time_sec/24/60/60,'MI'), ctrl_pnt = v_rec(3).ctrl_pnt  where stat_id=v_rec(3).stat_id;
              
        end if;
        commit;
      else
        -- dbms_output.put_line('v_tariff_code получил пустое значение, считать нечего! ');
        return(-1);
      end if;  
     exception
      when no_data_found then
        -- Последний тариф в REST - текущий - Макс Skype TeleTie 2015-02-19 14:17
        select tariff_code, stat_id into v_tariff_code,v_num from (select tariff_code, stat_id from gprs_stat where phone=p_phone order by stat_id desc) where rownum<2;
        
        if v_tariff_code is null then return(-1); end if; -- если статистик тоже нет то выход с (-1)
        
        -- ctrl_pnt Учитываем возможность пробоя контрольной точки  более чем на один порог контрольного значения (20% по умолчанию)
        update gprs_stat set ctrl_pnt=ceil((1-currvalue/initvalue)/c_turn_tariff_ctrlpnt_inc), next_check_date = trunc(sysdate+c_turn_tariff_checktime_min/24/60,'MI') where stat_id = v_num;
        -- Заполним gprs_turn_log данными из статистик.
        select 
               count(1)
          into
               i 
          from (
                select
                       distinct
                       tariff_code, 
                       turn_log_id 
                  from 
                       gprs_stat 
                 where 
                       phone=p_phone
               );
        j :=0; 
        for rec in (
                    select 
                           distinct
                           tariff_code, 
                           turn_log_id 
                      from 
                           (
                            select 
                                   tariff_code, 
                                   turn_log_id 
                              from 
                                   gprs_stat 
                             where 
                                   phone=p_phone
                               and not exists(
                                              select 
                                                     1 
                                                from 
                                                     gprs_turn_log 
                                               where 
                                                     log_id = turn_log_id
                                              ) 
                             order by 
                                   stat_id
                            )
                    ) 
        loop
          j := j + 1;
          if j = i then v_date := null; else v_date := systimestamp; end if;
          begin
            insert into gprs_turn_log
              ( 
                LOG_ID,
                PHONE,
                TARIFF_CODE,
                DATE_ON,
                DATE_OFF
              )
              values 
              (
                rec.turn_log_id, 
                p_phone, 
                rec.tariff_code, 
                sysdate, 
                v_date
              );
          exception
            when DUP_VAL_ON_INDEX then 
              v_grs  := get_resp_stat(-9000,'DUP_VAL_ON_INDEX','Error adding record in gprs_turn_log with turn_log_id from gprs_stat.', p_phone, 0,'gprs_check_turn_tariff',0
                                        ,'Phone number: '||p_phone||' | Tariff: '||rec.tariff_code||' | User: '||user
                                        , 'Error adding record in gprs_turn_log with turn_log_id from gprs_stat.');
          end;
        end loop;
        commit;
    end;

    return(0);
  end; 
--   gprs_check_turn_tariff ----  END  ------------------------------------------------------------------------------------

--   gprs_get_rest ----  BEGIN  ------------------------------------------------------------------------------------
  function gprs_get_rest (p_phone varchar2) return number as
    v_rests TRests;
    v_cnt  number(12) := 0;
    v_cnt2 number(12) := 0;
    v_res  number(1)  := 0;
  begin

--      v_rests := beeline_api_pckg.rest_info_rests(p_phone);

      for i in 1..v_rests.count() loop

        -- Добавляем остатки только для неотключенных тарифов/доп.пакетов
        select 
               count(1)
          into v_cnt                
          from (
                select 1 
                  from gprs_turn_log 
                 where phone = p_phone and 
                       date_off is null and
                       tariff_code=v_rests(i).soc
                 order by date_off desc  nulls first)
         where rownum <2;
        
        -- Добавляем если измерений не было вовсе
        select 
               count(1)
          into v_cnt2
          from gprs_stat
         where phone = p_phone;
                          
        if (nvl(v_cnt,0) <> 0 or nvl(v_cnt2,0) = 0) and v_rests(i).unittype = 'INTERNET' and v_rests(i).resttype = 'AS' then
          -- Вычисляем ID записи в логе переключений тарифов/пакетов
          v_cnt := null;
          if nvl(v_cnt2,0) <> 0 then
            select log_id
              into v_cnt 
              from (
                    select * 
                      from gprs_turn_log 
                     where phone=p_phone
                     order by log_id desc
                   )
             where 
                   tariff_code = v_rests(i).soc 
               and rownum <2;
          end if;
          insert into gprs_stat
            (
              STAT_ID,
              TURN_LOG_ID,
              PHONE,
              TARIFF_CODE,
              INITVALUE,
              CURRVALUE,
              CURR_CHECK_DATE,
              NEXT_CHECK_DATE,
              CTRL_PNT,
              IS_CHECKED
            ) 
            values
            (
              new_gprs_stat_id,
              nvl(v_cnt,NEW_gprs_turn_log_id),
              v_rests(i).phone,  
              v_rests(i).soc,
              v_rests(i).initialsize,
              v_rests(i).currvalue,
              systimestamp,
              null,
              1,
              0  
            );
          v_res:=1;
        end if;
      end loop;
      return(v_res);
  end;  
--   gprs_get_rest ----  END  ------------------------------------------------------------------------------------

--   gprs_check_tariff ----  BEGIN  ------------------------------------------------------------------------------------
  procedure gprs_check_tariff_test(p_flow_code varchar2) as -- Запуск обслуживания указанного потока GPRS_FLOWS (TEST)
    v_flow_id varchar2(32);
  begin
    select flow_id into v_flow_id from gprs_flows where flow_code=p_flow_code;
    
    if v_flow_id is not null then
      for rec in (select * from gprs_test_phone where flow_id = v_flow_id) loop
        gprs_check_phone_tariff(rec.phone);      
      end loop;
      
      update gprs_flows set last_check = systimestamp where flow_code = p_flow_code;
    end if; 
  end;
--   gprs_check_tariff ----  END  ------------------------------------------------------------------------------------

  procedure gprs_check_tariff_all_test as -- Запуск обслуживания всех номеров (TEST)
  begin
    for rec in (select * from gprs_test_phone) loop
      gprs_check_phone_tariff(rec.phone);      
    end loop;
    update gprs_flows set last_check = systimestamp;
  end;

  procedure gprs_check_phone_all as -- Запуск обслуживания всех номеров (из CONTRACTS)
    v_tariff_code gprs_turn_log.tariff_code%type;
  begin
    for rec in (
                 select 
                   distinct phone_number_federal 
                 from 
                   v_contracts c 
                   join tariffs t on C.TARIFF_ID=t.tariff_id 
                 where C.CONTRACT_CANCEL_DATE is null
                   and t.is_auto_internet=1
                   and nvl((select phone_is_active from db_loader_account_phones where phone_number=c.phone_number_federal and year_month=to_char(sysdate,'yyyymm')),0) = 1
                   and nvl((select count(1) from mnp_remove mnp where mnp.temp_phone_number=c.phone_number_federal and mnp.date_created>=sysdate-1),0)=0 
                ) 
    loop
      -- dbms_output.put_line(rec.phone_number_federal||' | '||rec2.tariff_code);                
      gprs_check_phone_tariff(rec.phone_number_federal);      
    end loop;
  end;

  procedure gprs_check_phone_flow(p_STREAM_ID integer) as -- Запуск обслуживания номеров в потоке (из CONTRACTS)
    v_tariff_code gprs_turn_log.tariff_code%type;
    c_STREAM_COUNT constant INTEGER := 5;
  begin
    for rec in (
                select
                        phone_number_federal
                 from
                        (
                           select 
                             distinct phone_number_federal 
                           from 
                             v_contracts c 
                             join tariffs t on C.TARIFF_ID=t.tariff_id 
                           where C.CONTRACT_CANCEL_DATE is null
                             and t.is_auto_internet=1
                             and nvl((select phone_is_active from db_loader_account_phones where phone_number=c.phone_number_federal and year_month=to_char(sysdate,'yyyymm')),0) = 1
                             and nvl((select count(1) from mnp_remove mnp where mnp.temp_phone_number=c.phone_number_federal and mnp.date_created>=sysdate-1),0)=0
                        )
                 where                           
                        MOD(TO_NUMBER(phone_number_federal), c_STREAM_COUNT) = p_STREAM_ID
                ) 
    loop
      -- dbms_output.put_line(rec.phone_number_federal||' | '||rec2.tariff_code);    
      begin            
        gprs_check_phone_tariff(rec.phone_number_federal); 
      exception
        when others then
            NULL;
      end;     
    end loop;
  end;

  procedure gprs_check_phone_tariff(p_phone varchar2) as -- Проверка телефона на необходимость измерений и автоподключения
    v_num0          number;
    v_num1          number;
    v_is_speed3b2b  number := 0;
    v_cnt_internet  number := 0;
    v_is_unlim_internet number := 0;
  begin

    -- Не обрабатывать если не авто-интернет   
    select
            count(1)
      into  
            v_num0
      from 
            v_contracts ct,
            tariffs tf
     where CT.PHONE_NUMBER_FEDERAL=p_phone
       and  CT.CONTRACT_CANCEL_DATE is null
       and  TF.TARIFF_ID=CT.TARIFF_ID
       and  TF.IS_AUTO_INTERNET = 1;
    if nvl(v_num0,0) = 0 then return; end if;
    
    -- Номер обрабатывать, если текущая тарифная опция НЕ имеет флаг IS_UNLIM_INTERNET (=0)
    select sum(opt.is_unlim_internet) 
      into v_is_unlim_internet 
      from gprs_turn_log gtl
      join tariff_options opt on opt.option_code=gtl.tariff_code
     where phone=p_phone 
       and date_off is null 
     order by date_off desc;

    -- Номер обработать, если он НЕ заблокирован PHONE_IS_ACTIVE (=1)
    select sum(phone_is_active) 
      into v_num0 
      from db_loader_account_phones 
     where phone_number=p_phone 
       and year_month=to_char(sysdate,'yyyymm');
       
    -- и не MNP 
    select count(1) 
      into v_num1 
      from mnp_remove 
     where temp_phone_number=p_phone
       and date_created>=sysdate-1;
    
    if nvl(v_is_unlim_internet,0)=0 and 
       nvl(v_num0,0) <> 0 and 
       nvl(v_num1,0) = 0
    then                                 
      select count(1) into v_num0 from gprs_stat where phone = p_phone and curr_check_date between trunc(sysdate,'MM') and sysdate;
      if v_num0=0 then -- если нет измерений в текущем месяце
        --dbms_output.put_line('Новичок: '||p_phone);
        if gprs_get_rest(p_phone)=1 then -- инициировать первое измерение, если запись об остатке была добавлена;
          v_num0 := gprs_check_turn_tariff(p_phone); -- запустить обработку статистики
        end if;
      else
        -- Проверить что номер попадает в интервал обработки (номер с подходящей датой next_check_date для текущего опроса),
        --  т.е. попадающей в интервал между текущим и прошлым измерениями потока обслужиавния
        select count(1) into v_num0 from (select 1 from gprs_stat gs
                                            where gs.phone = p_phone and gs.is_checked=0 
                                              and GS.NEXT_CHECK_DATE is not null 
                                              and GS.NEXT_CHECK_DATE <= sysdate 
                                            order by stat_id desc
                                         ) 
                                    where rownum <2;
        if nvl(v_num0,0) >0 -- номер попадает в интервал обработки
        then
          
          if gprs_get_rest(p_phone)=1  then -- и запись об остатке была добавлена
            -- dbms_output.put_line('Обработка 1: '||p_phone);
          
            v_num0 := gprs_check_turn_tariff(p_phone); -- запустить обработку статистики
          
          else -- проверить наличие подключенного доп.пакета
            -- dbms_output.put_line('Переподключение: '||p_phone);
            select -- включено ограничение скорости интернет (<>0)
                   count(1)
              into
                   v_is_speed3b2b
              from 
                   db_loader_account_phone_opts
             where
                   phone_number=p_phone
               and option_code='SPEED3B2B'
               and turn_off_date is null
               and year_month=to_char(sysdate,'yyyymm');
               
            SELECT -- кол-во доп.пакетов авто-интернет (<>0)
                   count(1)
              into
                   v_cnt_internet
              FROM
                   DB_LOADER_ACCOUNT_PHONE_OPTS
              join 
                   tariff_options opt on opt.option_code=DB_LOADER_ACCOUNT_PHONE_OPTS.option_code 
             WHERE
                   OPT.IS_AUTO_INTERNET = 1 and
                   DB_LOADER_ACCOUNT_PHONE_OPTS.PHONE_NUMBER=p_phone;

            if 
              nvl(v_is_speed3b2b,0)  <>0 and
              nvl(v_cnt_internet,0)  <>0 
            then
              v_num0 := gprs_check_turn_tariff(p_phone); 
            end if;
          end if;
        end if; 
      end if;
    end if;
  end;

  procedure gprs_init_new_month as -- Инициализация нового месяца
  begin
    -- Перенос в архив данных за прошедший месяц
    for rec in (select distinct phone from gprs_stat) loop
        insert into gprs_stat_hist 
            (
              STAT_ID,
              TURN_LOG_ID,
              PHONE,
              TARIFF_CODE,
              INITVALUE,
              CURRVALUE,
              CURR_CHECK_DATE,
              NEXT_CHECK_DATE,
              CTRL_PNT,
              IS_CHECKED,
              IS_TARIFF
            ) 
          select 
              gs.STAT_ID,
              gs.TURN_LOG_ID,
              gs.PHONE,
              gs.TARIFF_CODE,
              gs.INITVALUE,
              gs.CURRVALUE,
              gs.CURR_CHECK_DATE,
              gs.NEXT_CHECK_DATE,
              gs.CTRL_PNT,
              gs.IS_CHECKED,
              nvl((case when exists(select 1 from tariffs c where c.tariff_code=gs.TARIFF_CODE) then 1 else 0 end),0)
            from 
              gprs_stat gs
            where 
                  phone=rec.phone
              and CURR_CHECK_DATE<trunc(sysdate);
        delete from gprs_stat where phone=rec.phone and CURR_CHECK_DATE<trunc(sysdate);
    end loop;
    
    for rec in (select distinct phone from gprs_turn_log) loop
        insert into gprs_turn_log_hist
          ( 
            LOG_ID,
            PHONE,
            TARIFF_CODE,
            DATE_ON,
            DATE_OFF
          )
          select 
            LOG_ID,
            PHONE,
            TARIFF_CODE,
            DATE_ON,
            DATE_OFF
          from 
            gprs_turn_log 
          where 
            phone=rec.phone and date_on<trunc(sysdate);
        delete from gprs_turn_log where phone=rec.phone and date_on<trunc(sysdate);
    end loop;
    -- Очистка устаревших данных (старше 3-х месяцев)
    -- delete from gprs_stat_hist     where curr_check_date < to_date(to_char(trunc(add_months(sysdate,-3),'MM'),'YYYY-MM-DD ')||'00:00','YYYY-MM-DD HH24:MI');
    -- delete from gprs_turn_log_hist where date_on < to_date(to_char(trunc(add_months(sysdate,-3),'MM'),'YYYY-MM-DD ')||'00:00','YYYY-MM-DD HH24:MI');
  end;
 
  function gprs_opts_turn_off(p_phone varchar2, p_opts_code varchar2, p_note varchar2) return number as -- Отключить опцю
    v_str  varchar2(1024);
    v_str0 varchar2(1024);
    v_grs  number(12);
    i      number(12) := 0;
  begin
    -- Не обрабатывать если не авто-интернет   
    select
            count(1)
      into  
            v_grs
      from 
            v_contracts ct,
            tariffs tf
     where CT.PHONE_NUMBER_FEDERAL=p_phone
       and  CT.CONTRACT_CANCEL_DATE is null
       and  TF.TARIFF_ID=CT.TARIFF_ID
       and  TF.IS_AUTO_INTERNET = 1;
    if nvl(v_grs,0) = 0 then return(-1); end if;

    -- Отключить старый пакет, но не тарифный план
    select count(1) into i from tariff_options where option_code = p_opts_code; 
    if i<>0 then -- если это доп.пакет (не тариф), то отключаем его
      --dbms_output.put_line('Is option.');
      v_str0 := beeline_api_pckg.turn_tariff_option(p_phone,p_opts_code, 0, null, null, 'AUTO_GPRS');
      v_str  := upper(substr(v_str0,1,5));

      v_grs  := get_resp_stat(-9001,'LogReqResp',case when v_str = 'ERROR' then 'Error turn off option.' else 'Success turn off option.' end, p_phone, 0, p_note,0
                                ,'Phone number: '||p_phone||' | Tariff: '||p_opts_code||' | User: '||user
                                , v_str0);
      if v_str = 'ERROR' then return(-1); end if;
      -- конец истории наблюдений предыдущей опции
      begin
        select log_id -- id записи о последнем переключении, учитываем что код опции может повторяться в течении месяца
          into v_grs 
          from (
                select 
                       log_id 
                  from 
                       gprs_turn_log 
                 where 
                       phone = p_phone and 
                       tariff_code = p_opts_code 
                 order by 
                       date_off desc nulls first
                ) 
          where rownum <2;
        if nvl(v_grs,0)<>0 then  
          update gprs_turn_log set date_off = systimestamp where log_id = v_grs;
        end if;
        update gprs_stat set is_checked = 1  where phone=p_phone and tariff_code = p_opts_code and is_checked=0;
        commit;
      exception
        when others then
          null;
      end;
    end if;
    return (0);
  end;

  procedure  gprs_opts_turn_off_all(p_phone varchar2, p_note varchar2) as -- Отключить все доп.опции, кроме тарифного плана, на указанном номере
    v_grs  number(12);
  begin
    for rec in (select distinct phone, tariff_code from gprs_turn_log where phone = p_phone and date_off is null) loop    
      -- dbms_output.put_line(rec.phone||' | '||rec.tariff_code||' | ');
      v_grs:=gprs_opts_turn_off(p_phone, rec.tariff_code,nvl(p_note,'gprs_opts_turn_off_all'));
    end loop;
  end;

  procedure  gprs_opts_turn_off_all_phones as -- Отключить все доп.опции, кроме тарифного плана, на всех номерах
    v_grs  number(12);
  begin
    for rec in (select distinct phone, tariff_code from gprs_turn_log where date_off is null) loop    
--      dbms_output.put_line(rec.phone||' | '||rec.tariff_code||' | ');
      v_grs:=gprs_opts_turn_off(rec.phone, rec.tariff_code,'gprs_opts_turn_off_all_phones - End of month.');
    end loop;
  end;

  function rep_gprs_autoturn_mon(p_phone varchar2 default null) return tbl_rep_gprs_autoturn_1 pipelined as -- ОТЧЕТ ТЕКУЩИЙ. Используется на текущий месяц на момент выгрузки.
                                                                                                            -- (если не задавать параметр выдаст данные по всем номерам)
    /*  
    #2674
    ОТЧЕТ ТЕКУЩИЙ. Используется на текущий месяц на момент выгрузки.
    номер телефона
    тарифный план
    баланс
    абон.плата по тариферу
    FIVIP400Z - сумма за эти пакеты
    FIVIP600Z - сумма за эти пакеты
    FIVIP800Z - сумма за эти пакеты
    GPRS_U - сумма за эти пакеты
    Общий потребленный трафик интернет
    Общее количество исходящих минут
    Сумма пополнений за месяц
    SPEED3B2B - ограничение, если подключено, выводить.

    */
    type vt_phone is table of beeline_rest_api_pckg.Trow_rep_gprs_autoturn_1 index by pls_integer;
    v_rec         vt_phone;
    v_stmt        varchar2(4000);
    v_num         number(18);
    v_sum         number(18,2);
    v_first_day   date := to_date(to_char(trunc(sysdate,'MM'),'YYYYMM')||'01 00:00:00','YYYYMMDD hh24:mi:ss');
    v_last_day    date := to_date(to_char(sysdate,'YYYYMMDD')||' 23:59:59','YYYYMMDD hh24:mi:ss');

    type t_stat2 is record
      (
        phone           varchar2(10),
        initvalue       integer,
        currvalue       integer,
        curr_check_date timestamp
      );
    type t_stats is table of t_stat2 index by pls_integer;
    vt_stat t_stats;
    res_opt varchar2(5000);

  begin
  v_stmt :=
    'select
        distinct 
              gs.phone,  
              C.CONTRACT_NUM,
              C.CONTRACT_DATE,
              case when lap.PHONE_IS_ACTIVE=0 then ''Блокирован'' else '''' end,
              lap.PHONE_IS_ACTIVE,            
              (select case when phone_is_active=0 then begin_date else null end from DB_LOADER_ACCOUNT_PHONE_HISTS where PHONE_NUMBER=gs.phone and end_date =to_date(''30000101'',''yyyymmdd'')) BEGIN_DATE,
              (select DOP_STATUS_NAME from CONTRACT_DOP_STATUSES where DOP_STATUS_ID = C.DOP_STATUS and rownum <2 ) DOP_STATUS,
              C.TARIFF_ID,               
              TF.TARIFF_CODE,
              TF.TARIFF_NAME,
              nvl(ICB.BALANCE,0) BALANCE,
              nvl(TF.MONTHLY_PAYMENT,0),
              nvl(TF.OPERATOR_MONTHLY_ABON_ACTIV,0),
              0,            
              0,            
              0,
              0,
              0,               
              0,               
              0,            
              0,
              0,            
              null,
              0,
              0,            
              0,            
              0,
              0,            
              0,            
              '''',
              0  
      from
          gprs_stat gs
          join v_contracts c on C.PHONE_NUMBER_FEDERAL=GS.PHONE
          left outer join tariffs tf  on TF.TARIFF_ID=C.TARIFF_ID
          left outer join iot_current_balance icb on icb.phone_number = GS.PHONE
          join db_loader_account_phones lap on lap.PHONE_NUMBER=GS.PHONE
      where
              nvl(c.CONTRACT_CANCEL_DATE,to_date(''31.01.3000'',''dd.mm.yyyy'')) >= trunc(sysdate,''MM'')
          and lap.year_month=to_char(sysdate,''yyyymm'')
          and C.TARIFF_ID >0';
          
  if p_phone is not null then v_stmt := v_stmt||' and gs.phone = '''||p_phone||''''; end if;
  
  execute immediate v_stmt bulk collect INTO v_rec ;
  
  for i in 1..v_rec.count 
    loop

      -- Общий потребленный трафик интернет
      select
              total_traff
        into
              v_rec(i).total_traff
        from
              table(calc_traff(v_rec(i).phone));

      -- Подсчёт количества пождключенных пакетов и суммы по каждому виду
      v_sum:=0;
      for r_opt in (select distinct tariff_code from gprs_stat where phone=v_rec(i).phone and tariff_code in (select option_code from tariff_options where is_auto_internet=1) order by tariff_code)
      loop
        select count(1) into v_sum from gprs_turn_log where phone=v_rec(i).phone and tariff_code = r_opt.tariff_code;
        
        select 
               r.monthly_cost
          into v_num
          from
               (
                select tc.tariff_option_cost_id,max(tc.date_created)
                  from tariff_option_costs tc
                  join tariff_options t on t.TARIFF_option_id=tc.tariff_option_id
                  where OPTION_CODE=r_opt.tariff_code
                            and v_last_day between tc.begin_date and tc.end_date
                  group by tc.tariff_option_cost_id
                  order by max(tc.date_created) desc
               ) q
               join tariff_option_costs r on r.tariff_option_cost_id=q.tariff_option_cost_id
         where rownum <2;

        v_sum := v_sum*nvl(v_num,0);  
        case r_opt.tariff_code 
          when 'FI550Z' then v_rec(i).FI550Z :=v_sum;
          when 'FI850Z' then v_rec(i).FI850Z :=v_sum;
          when 'FI1150Z'then v_rec(i).FI1150Z:=v_sum;
          when 'FSG_TT1'then v_rec(i).FSG_TT1:=v_sum;
          when 'FSG_TT2'then v_rec(i).FSG_TT2:=v_sum;
          when 'FSG_TT3'then v_rec(i).FSG_TT3:=v_sum;
          when 'GPRS_20GB' then v_rec(i).GPRS_20GB:=v_sum;
          when 'GPRS_30GB' then v_rec(i).GPRS_30GB:=v_sum;
          when 'GPRS_U' then 
            begin
              for rec_gprs in (
                                select -- пересчёт GPRS_U на денщину
                                       ceil(beeline_rest_api_pckg.intr_to_sec(nvl(date_off,trunc(add_months(sysdate,1),'mm'))-g.date_on)/24/60/60) use_days,
                                       g.date_on date_on
                                  from 
                                       gprs_turn_log g
                                 where 
                                       phone=v_rec(i).phone 
                                   and tariff_code = 'GPRS_U'
                              ) loop
                v_rec(i).GPRS_U     := nvl(v_rec(i).GPRS_U,0)+nvl(rec_gprs.use_days,0);
                v_rec(i).GPRS_U_ON  := rec_gprs.date_on;
              end loop;
              v_rec(i).GPRS_U := nvl(v_num,0)*nvl(v_rec(i).GPRS_U,0)/to_number(to_char(last_day(sysdate),'dd'));
            end;
          else v_rec(i).unknown:=v_rec(i).unknown+v_sum;
        end case;  
      end loop;

      
      -- Подсчет пополнений (реальных и виртуальных)    
      select 
         sum(payment_sum)
       into
         v_sum
       from
         db_loader_payments
        where
          phone_number=v_rec(i).phone and 
          payment_date between v_first_day and v_last_day 
         ;
      select 
         sum(payment_sum)
       into
         v_rec(i).payments
       from
           received_payments
        where
          phone_number=v_rec(i).phone and 
          payment_date_time between v_first_day and v_last_day 
         ;
      v_rec(i).payments := nvl(v_rec(i).payments,0)+nvl(v_sum,0);

      -- Количество исходящих минут    
      select
          sum(ZEROCOST_OUTCOME_MINUTES+CALLS_MINUTES)
        into
          v_rec(i).outcom_mi 
        from 
          db_loader_phone_stat
        where
          phone_number=v_rec(i).phone and 
          year_month=to_char(sysdate,'yyyymm')
         ;
      
      -- Наличие ограничения скорости tariff_options.OPTION_CODE = 'SPEED3B2B'      
      select
          count(1)
        into 
          v_rec(i).SPEED3B2B
        from 
         db_loader_account_phone_opts
        where
          phone_number=v_rec(i).phone and  
          option_code='SPEED3B2B' and
          turn_off_date is null and  
          year_month=to_char(sysdate,'yyyymm')
         ; 
         
      --если имеется наличие ограничения скорости, то обновляем услуги и проверяем заново наличие
      if (nvl(v_rec(i).SPEED3B2B,0))<>0 then
        res_opt := beeline_api_pckg.phone_options(to_number(v_rec(i).phone));
        
        -- Наличие ограничения скорости tariff_options.OPTION_CODE = 'SPEED3B2B'      
        select count(1)
           into v_rec(i).SPEED3B2B
          from db_loader_account_phone_opts
        where phone_number=v_rec(i).phone 
            and option_code='SPEED3B2B' 
            and turn_off_date is null 
            and year_month=to_char(sysdate,'yyyymm');  
      end if;   

      case when (nvl(v_rec(i).SPEED3B2B,0))<>0 then v_rec(i).SPEED3B2B_WORD:='Включено'; else v_rec(i).SPEED3B2B_WORD:=''; end case;
           
      -- Наличие ограничения скорости tariff_options.OPTION_CODE = 'DTM41'      
      select
          count(1)
        into 
          v_rec(i).DTM41
        from 
         db_loader_account_phone_opts
        where
          phone_number=v_rec(i).phone and  
          option_code='DTM41' and
          turn_off_date is null and  
          year_month=to_char(sysdate,'yyyymm')
         ;    
      case when nvl(v_rec(i).DTM41,0) <> 0 then v_rec(i).DTM41 := 1; else v_rec(i).DTM41 := 0; end case;
      
      --наличие пакета MGN500MIN
      select count(1)
         into v_rec(i).MGN500MIN
       from db_loader_account_phone_opts op
       where op.phone_number= v_rec(i).phone
           and op.option_code='MGN500MIN' 
           and op.year_month=to_char(sysdate,'yyyymm');
      --если имеется наличие пакета межгород то расчитываем сумму
      if (nvl(v_rec(i).MGN500MIN,0) <> 0)  then
        select SUM(ceil(nvl(OP.TURN_OFF_DATE,trunc(add_months(OP.TURN_ON_DATE,1),'mm'))-OP.TURN_ON_DATE)*(nvl(TC.MONTHLY_COST, 0)/to_number(to_char(last_day(OP.TURN_ON_DATE),'dd'))))
           into v_rec(i).MGN500MIN
          from db_loader_account_phone_opts op,
                  tariff_options  tf,
                  TARIFF_OPTION_COSTS tc
        where OP.OPTION_CODE = TF.OPTION_CODE
           and TC.TARIFF_OPTION_ID = tf.TARIFF_OPTION_ID
           and OP.TURN_ON_DATE between TC.BEGIN_DATE and TC.END_DATE
           and op.phone_number=v_rec(i).phone
           and op.option_code='MGN500MIN' 
           and op.year_month=to_char(sysdate,'yyyymm');
      end if;
      
      --pipe row(v_rec(i)); 

    end loop;

  end;


  function rep_gprs_autoturn_prev(p_phone varchar2 default null, p_year_month varchar2 default null) return tbl_rep_gprs_autoturn_1 pipelined as 
   -- ОТЧЕТ ТЕКУЩИЙ. Используется за прошедшие месяца
   -- (если не задавать параметр выдаст данные по всем номерам за прошлый месяц)
    /*  
  
    #2703
      номер телефона
      тарифный план
      баланс
      абон.плата по тариферу
      абон.плата по билайну из счета
      Доходность - абон.плата тарифера минус абон.плату билайн из счета
      FIVIP400Z - сумма за эти пакеты
      FIVIP600Z - сумма за эти пакеты
      FIVIP800Z - сумма за эти пакеты
      GPRS_U - сумма за эти пакеты
      Общий потребленный трафик интернет
      Общее количество исходящих минут
      Сумма пополнений за месяц

    */
    type vt_phone is table of beeline_rest_api_pckg.Trow_rep_gprs_autoturn_1 index by pls_integer;
    v_rec         vt_phone;
    v_stmt        varchar2(4000);
    v_sum         number(18,2);
    v_year_month  varchar2(6);
    v_first_day   date;
    v_last_day    date;
    v_num number(18);
  begin
    if p_year_month is null then v_year_month := to_char(add_months(sysdate,-1),'yyyymm'); else v_year_month := p_year_month; end if;
    v_first_day := to_date(v_year_month||'01 00:00:00','YYYYMMDD hh24:mi:ss');
    v_last_day  := to_date(v_year_month||to_char(last_day(to_date(v_year_month,'yyyymm')),'DD')||' 23:59:59','YYYYMMDD hh24:mi:ss');
  

    v_stmt :=
      'select distinct 
              gs.phone,  
              null,
              null,
              null,            
              null,
              null,            
              null,
              0,               
              gs.TARIFF_CODE,
              null,
              0,            
              0,
              0,            
              0,            
              0,            
              0,
              0,            
              0,            
              0,               
              0,
              0,
              0,               
              null,
              0,
              0,            
              0,            
              0,
              0,            
              0,            
              null,
              0  
        from
             gprs_stat_hist gs
       where
             gs.IS_TARIFF = 1
            and gs.curr_check_date 
                between to_date('''||v_first_day||''') 
                    and to_date('''||v_last_day||''')';
            
    if p_phone is not null then v_stmt := v_stmt||' and gs.phone = '''||p_phone||''''; end if;
    
  execute immediate v_stmt bulk collect INTO v_rec ;
  for i in 1..v_rec.count loop
    begin
      select
             CONTRACT_NUM,
             CONTRACT_DATE
        into
             v_rec(i).CONTRACT_NUM,
             v_rec(i).CONTRACT_DATE
        from
             (
              select *
                from contracts
               where phone_number_federal = v_rec(i).phone
                 and NVL(curr_tariff_id, GET_CURR_PHONE_TARIFF_ID(phone_number_federal)) > 0
               order by date_last_updated desc
              )
       where                   
             rownum<2;
    exception
      when no_data_found then 
        v_rec(i).CONTRACT_NUM  := null;
        v_rec(i).CONTRACT_DATE := null;
    end;

      -- баланс
      begin
        select
               bhr.balance
          into
               v_rec(i).balance
          from
               (
                select  
                       phone_number,
                       max(bh.last_update) last_update
                  from iot_balance_history bh
                 where
                       phone_number=v_rec(i).phone
                       and to_char(bh.last_update,'mm')=substr(201504,5,2)
                 group by
                       phone_number      
               ) cc
               join iot_balance_history bhr 
                 on bhr.phone_number=cc.phone_number
         where cc.last_update = bhr.last_update;
      exception
        when no_data_found then 
          v_rec(i).balance:=0;
      end;
      
      -- абон.плата по тариферу
      for rec in (select abon_tp
                   from tarifer_bill_for_clients
                  where
                        year_month=v_year_month
                    and phone_number=v_rec(i).phone
                 )
      loop
        v_rec(i).tariff := v_rec(i).tariff+ nvl(rec.abon_tp,0);
      end loop;
      
      -- абон.плата по билайну из счета
      for rec in (select abon_main+single_main as abon_oper
                   from db_loader_full_finance_bill
                  where
                        year_month=v_year_month
                    and phone_number=v_rec(i).phone
                 )
      loop
        v_rec(i).tariff_oper := v_rec(i).tariff_oper+ nvl(rec.abon_oper,0);
      end loop;

      -- Общий потребленный трафик интернет из архива детализации
      -- Количество исходящих минут    
      select
              nvl(INTERNET_MB,0),
              nvl(ZEROCOST_OUTCOME_MINUTES+CALLS_MINUTES,0)
        into
              v_rec(i).total_traff,
              v_rec(i).outcom_mi 
        from
              DB_LOADER_PHONE_STAT
       where
              phone_number = v_rec(i).phone
         and  year_month   = v_year_month;     


      -- Подсчёт количества пождключенных пакетов и суммы по каждому виду
      for r_opt in (select distinct tariff_code from gprs_stat_hist where phone=v_rec(i).phone and  curr_check_date between v_first_day and v_last_day and tariff_code in (select option_code from tariff_options where is_auto_internet=1) order by tariff_code)
      loop
        select count(1) into v_sum from gprs_turn_log_hist where phone=v_rec(i).phone and tariff_code = r_opt.tariff_code and date_on between v_first_day and v_last_day;
        select 
                r.monthly_cost
          into
                v_num
          from
                (
                  select 
                          tc.tariff_option_cost_id,
                          max(tc.date_created)
                    from
                          tariff_option_costs tc
                    join
                          tariff_options t 
                      on  
                          t.TARIFF_option_id=tc.tariff_option_id
                   where 
                          OPTION_CODE=r_opt.tariff_code
                     and  v_last_day between tc.begin_date and tc.end_date
                   group  by 
                          tc.tariff_option_cost_id
                   order  by 
                          max(tc.date_created) desc
                ) q
                join 
                      tariff_option_costs r 
                  on
                      r.tariff_option_cost_id=q.tariff_option_cost_id
         where 
                rownum <2;
        v_sum := v_sum*nvl(v_num,0);
          
        case r_opt.tariff_code 
          when 'FI550Z' then v_rec(i).FI550Z :=v_sum;
          when 'FI850Z' then v_rec(i).FI850Z :=v_sum;
          when 'FI1150Z'then v_rec(i).FI1150Z:=v_sum;
          when 'FSG_TT1'then v_rec(i).FSG_TT1:=v_sum;
          when 'FSG_TT2'then v_rec(i).FSG_TT2:=v_sum;
          when 'FSG_TT3'then v_rec(i).FSG_TT3:=v_sum;
          when 'GPRS_20GB'then v_rec(i).GPRS_20GB:=v_sum;
          when 'GPRS_30GB'then v_rec(i).GPRS_30GB:=v_sum;
          when 'GPRS_U' then 
            begin
              for rec_gprs in (
                                select -- пересчёт GPRS_U на денщину
                                       ceil(beeline_rest_api_pckg.intr_to_sec(nvl(date_off,v_last_day)-g.date_on)/24/60/60) use_days,
                                       g.date_on date_on
                                  from 
                                       gprs_turn_log_hist g
                                 where 
                                       phone=v_rec(i).phone 
                                   and tariff_code = 'GPRS_U'
                              ) loop
                v_rec(i).GPRS_U     := nvl(v_rec(i).GPRS_U,0)+nvl(rec_gprs.use_days,0);
                v_rec(i).GPRS_U_ON  := rec_gprs.date_on;
              end loop;
              v_rec(i).GPRS_U := nvl(v_num,0)*nvl(v_rec(i).GPRS_U,0)/to_number(to_char(v_last_day,'dd'));
            end;
          else v_rec(i).unknown:=v_rec(i).unknown+v_sum;
        end case;  
      end loop;
 

      -- Подсчет пополнений (реальных и виртуальных)    
      select 
         sum(payment_sum)
       into
         v_sum
       from
         db_loader_payments
        where
          phone_number=v_rec(i).phone and 
          payment_date between v_first_day and v_last_day 
         ;
      select 
         sum(payment_sum)
       into
         v_rec(i).payments
       from
           received_payments
        where
          phone_number=v_rec(i).phone and 
          payment_date_time between v_first_day and v_last_day 
         ;
      v_rec(i).payments := nvl(v_rec(i).payments,0)+nvl(v_sum,0);

      --наличие пакета MGN500MIN
      select count(1)
         into v_rec(i).MGN500MIN
       from db_loader_account_phone_opts op
       where op.phone_number= v_rec(i).phone
           and op.option_code='MGN500MIN' 
           and op.year_month=v_year_month;
      --если имеется наличие пакета межгород то расчитываем сумму
      if (nvl(v_rec(i).MGN500MIN,0) <> 0)  then
        select SUM(ceil(nvl(OP.TURN_OFF_DATE,trunc(add_months(OP.TURN_ON_DATE,1),'mm'))-OP.TURN_ON_DATE)*(nvl(TC.MONTHLY_COST, 0)/to_number(to_char(last_day(OP.TURN_ON_DATE),'dd'))))
           into v_rec(i).MGN500MIN
          from db_loader_account_phone_opts op,
                  tariff_options  tf,
                  TARIFF_OPTION_COSTS tc
        where OP.OPTION_CODE = TF.OPTION_CODE
           and TC.TARIFF_OPTION_ID = tf.TARIFF_OPTION_ID
           and OP.TURN_ON_DATE between TC.BEGIN_DATE and TC.END_DATE
           and op.phone_number=v_rec(i).phone
           and op.option_code='MGN500MIN' 
           and op.year_month=v_year_month;
      end if;
           
      --pipe row(v_rec(i));

      /*         
     dbms_output.put_line(
      v_rec(i).phone||' | '||
      v_rec(i).CONTRACT_NUM||' | '||
      v_rec(i).CONTRACT_DATE||' | '||
      v_rec(i).CURR_TARIFF_ID||' | '||
      v_rec(i).TARIFF_CODE||' | '||
      v_rec(i).TARIFF_NAME||' | '||
      v_rec(i).balance||' | '||
      v_rec(i).tariff||' | '||
      v_rec(i).tariff_oper||' | '||
      v_rec(i).FI550Z||' | '||
      v_rec(i).FI850Z||' | '||
      v_rec(i).FI1150Z||' | '||
      v_rec(i).GPRS_U||' | '||
      v_rec(i).total_traff||' | '||
      v_rec(i).outcom_mi||' | '||
      v_rec(i).payments
      );
      */
    end loop;
  end;

  function  calc_traff(p_phone varchar2)  return tbl_calc_traff pipelined as -- расчёт израсходованного трафика и затраченного на это времени
    type t_stat2 is record
      (
        phone           varchar2(10),
        initvalue       integer,
        currvalue       integer,
        curr_check_date timestamp
      );
    type t_stats is table of t_stat2 index by pls_integer;
    vt_stat t_stats;
    v_res t_calc_traff;
  begin
    begin
      -- В учет принимаются все работавшие траифы/опции
      for rec_tl in  (
                    select
                            *
                      from
                            gprs_turn_log
                     where
                            phone = p_phone
                     order  by
                            date_on                
                  ) loop
        -- В рассчёт обязательно идёт первое измерение и все остальные у которых initvalue <> currvalue
        -- , факт ошибки Билайна (initvalue(curr) > initvalue(previous) ) должен быть учтен до входа в стадию продбора нового тарифа
        select
                sq.phone,
                sq.initvalue,
                sq.currvalue,
                sq.curr_check_date
          bulk  collect into
                vt_stat
          from
                (      
                  select
                          phone,
                          initvalue,
                          currvalue,
                          curr_check_date
                    from
                          gprs_stat
                   where
                          phone = rec_tl.phone
                     and  turn_log_id = rec_tl.log_id
                   order  by
                          curr_check_date
                ) sq
         where 
                rownum=1 or (rownum>1 and sq.initvalue<>sq.currvalue)
         order  by
                sq.curr_check_date desc;

          v_res.total_sec := v_res.total_sec + intr_to_sec(vt_stat(1).curr_check_date-vt_stat(vt_stat.count).curr_check_date);
          v_res.total_traff := v_res.total_traff+(vt_stat(1).initvalue-vt_stat(1).currvalue)-(vt_stat(vt_stat.count).initvalue-vt_stat(vt_stat.count).currvalue); 
      end loop;              
      pipe row(v_res);      
    exception
      when no_data_found then 
        --dbms_output.put_line('Нет данных для обработки');
        pipe row(v_res);      
    end;                  
  end;

  procedure check_alien_opts(p_STREAM_ID integer) as -- проверка доп.опций автоинтернет подключенных не автоматом подключения
    c_STREAM_COUNT constant INTEGER := 5;
  begin
    for rec in (
                select
                        phone,
                        tariff_code
                  from
                        (
                          select   
                                  distinct
                                  phone,
                                  tariff_code
                            from 
                                  gprs_turn_log c
                           where
                                  date_off is null 
                             and  nvl((select phone_is_active from db_loader_account_phones where phone_number=c.phone and year_month=to_char(sysdate,'yyyymm')),0) = 1
                             and  nvl((select count(1) from mnp_remove mnp where mnp.temp_phone_number=c.phone and mnp.date_created>=sysdate-1),0)=0
                             --  обрабатывать только номера с автоинтернет тарифом
                             and  exists
                                  (
                                    select
                                            1
                                      from 
                                            v_contracts ct,
                                            tariffs tf
                                     where CT.PHONE_NUMBER_FEDERAL=phone
                                       and  CT.CONTRACT_CANCEL_DATE is null
                                       and  TF.TARIFF_ID=CT.TARIFF_ID
                                       and  TF.IS_AUTO_INTERNET = 1
                                  )          
                        )
                 where                           
                        MOD(TO_NUMBER(phone), c_STREAM_COUNT) = p_STREAM_ID
                ) 
    loop
      for rec_opt in  (
                        select
                                q.name  option_code
                          from
                                table(beeline_rest_api_pckg.get_serviceList(rec.phone)) q,
                                tariff_options top
                         where
                                q.name = top.option_code
                           and  top.is_auto_internet <> 0
                           and  name <> rec.tariff_code
                      ) 
      loop
        insert  into
                GPRS_ALIEN_OPTS
                (
                  opts_id,
                  phone,
                  curr_code,
                  alien_code,
                  load_date
                )
        values
                (
                  NEW_GPRS_ALIEN_OPTS_ID,
                  rec.phone,
                  rec.tariff_code,
                  rec_opt.option_code,
                  sysdate
                )
        ;
        commit;
        --        dbms_output.put_line(rec.phone||' | '||nvl(rec_opt.option_code,'N/A'));
      end loop;
    end loop;
  end;

  procedure proc_alien_phone_opts(rec_al gprs_alien_opts%rowtype) as -- отключение чужих опций с номера
    v_rests beeline_rest_api_pckg.TRests;
    v_num integer;
    v_str  varchar2(1024);
    v_str0 varchar2(1024);
    v_grs  number(12);
  begin
    -- проверка - тарифы не отключаем
    select 
            count(1)
      into
            v_num
      from
            tariffs 
     where
            tariff_code=rec_al.alien_code;
    if v_num <> 0 then
      return;
    end if;
     
    v_rests := beeline_api_pckg.rest_info_rests(rec_al.phone);
    for i in 1..v_rests.count() 
    loop
      if    v_rests(i).unitType = 'INTERNET' 
        and (
                  v_rests(i).currvalue > 0
              or  rec_al.curr_code = 'GPRS_U'
            )
      then

        -- отключить чужую доп.опцию (3 попытки)
        for i in 1..3 loop
          v_str0 := beeline_api_pckg.turn_tariff_option(rec_al.phone,rec_al.alien_code, 0, null, null, 'AUTO_GPRS');
          v_str  := upper(substr(v_str0,1,5));

          v_grs  := beeline_rest_api_pckg.get_resp_stat(-9001,'check_alien_opts',case when v_str = 'ERROR' then 'Error turn off option.' else 'Success turn off option.' end, rec_al.phone, 0, 'check_alien_opts',0
                                    ,'Phone number: '||rec_al.phone||' | Tariff: '||rec_al.alien_code||' | User: '||user
                                    , v_str0);
          if  v_str = 'ERROR' then 
            DBMS_LOCK.SLEEP(30);
          else
            exit;
          end if;
        end loop;
              
        if v_str = 'ERROR' then
          return;
        end if;
        -- внести отметку обработки в журнал
        -- записать дату отключения
        update 
                gprs_alien_opts
           set
                is_checked  = 1,
                date_off    = sysdate
         where
                opts_id = rec_al.opts_id;
        commit;
        exit;
      end if;
    end loop;
  end;
  
  
   --   mcBalance ------------ BEGIN ---------------------------------------------------------------------------------------------
  FUNCTION mcBalance (pToken     VARCHAR2,
                       pUuid      VARCHAR2,
                       phash      VARCHAR2,
                       ctn        VARCHAR2)
    RETURN TRestsMCBalance
  AS                       -- получить суммы САС и баланса, доступного для МК
      obj        json;
      tmp        json_list;
      tmpobj    json;
      v_data     db_loader_resp_log.response%TYPE;
      v_req      db_loader_resp_log.request%TYPE;
      v_hdr      VARCHAR2 (512);
      v_grs      NUMBER (12);
      v_code     db_loader_resp_log.code%TYPE;
      v_result  TInfoRestMCBalance;
      v_results  TRestsMCBalance;
      
      function getDataByName(pObj json, pName varchar2) RETURN NUMBER as
        vRes NUMBER(10, 2);
      begin
        
        IF (pObj.exist (pName)) THEN
          vRes := NVL (TO_NUMBER (json_ext.get_string(pObj, pName), '999999D99'), 0);
        ELSE
          vRes := 0;
        END IF;
        
        RETURN vRes;
      end;
      
  BEGIN
    v_req :=
            beeline_protocol
         || '://'
         || beeline_domain
         || info_get_balance
         || '?ctn='
         || ctn;
    v_hdr :=
            'Cookie: token='
         || pToken
         || '; domain='
         || beeline_domain
         || '; path='
         || info_get_balance
         || ';';
    
    v_data := get_data (v_req, v_hdr);
     
    v_grs := get_resp_stat (-9000,
                        'LogReqResp',
                        'Get balance.',
                        ctn,
                        0,
                        'info_balance',
                        0,
                        v_req || CHR (38) || 'token=' || pToken,
                        v_data);
       
      
    IF v_data IS NOT NULL THEN
      obj := json (v_data);
      
      v_code :=
            NVL (json_ext.get_json (obj, 'meta').get ('code').get_number, 0);
      
      v_grs := get_resp_stat (
                           v_code,
                           NVL (json_ext.get_json (obj, 'meta').get ('status').get_string,''),
                           NVL (json_ext.get_json (obj, 'meta').get ('message').get_string,''),
                           ctn,
                           0,
                           'info_balance',
                           0,
                           v_req || CHR (38) || 'token=' || pToken,
                           v_data
                          );
        
      if v_code = err_ok then
      
        --tmp := json_ext.get_json_list (obj, 'balance');

        --FOR i IN 1 .. tmp.COUNT
        --LOOP
          v_result := TInfoRestMCBalance
                      (
                        ctn,
                        0,
                        0
                      );

          
          
          v_result.bsasValue :=  getDataByName(obj, 'bsasValue');
          v_result.bmkValue := getDataByName(obj, 'bmkValue');
          
          v_results (1) := v_result; 
        --END loop;

      end if;

    end if;
    
    return v_results;
  END;
--   mcBalance ------------  END  ------------------------------------------------------------------------------------
  
END BEELINE_REST_API_PCKG_AFR;