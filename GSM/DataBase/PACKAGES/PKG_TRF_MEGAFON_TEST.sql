CREATE OR REPLACE package PKG_TRF_MEGAFON_TEST is

  /* Константы пакета */
  /*sREGION         constant  varchar2(100) := 'https://volgasg.';*/
  /*sREGION        constant  varchar2(100) := 'https://moscowsg.';*/

  /* Описание массива */
  type arr is record
  (
    id     binary_integer,
    bill   varchar2(100),
    per    varchar2(100),
    summ   varchar2(100),
    sch    varchar2(100),
    dsch   varchar2(100)
  );

  type arr_table is table of arr index by binary_integer;
  cARR   arr_table;


  /* Переменный пакета */
  sSESSION_ID     varchar2(1000);        -- идентификатор текущий сессии (для коннекта)
  sLANG_ID        varchar2(100);         -- прочий параметр сессии
  sCHANNEL        varchar2(100);         -- прочий параметр сессии
  sAUTH_MODE      varchar2(100);         -- прочий параметр сессии

  cCLOB           varchar2(4000);
  nBILL1          number(17,2);
  nBILL2          number(17,2);
  nBILL3          number(17,2);

  
  /* Функция подключения к https://moscowsg.megafon.ru/ */
  function CONNECTED
  (
    sLOGIN       in varchar2,
    sPASSWORD    in varchar2
  )
  return boolean;
  
  /* Функция получения  страницы "Ежемесячный счет"  */
  function GET_PHONE_BILLS
  (
    pSITE_PASSWORD  in varchar2,
    pLOADER_NAME    in varchar2,
    pDB_DATA_SOURCE in varchar2,
    pDB_USER_NAME   in varchar2,
    pDB_PASSWORD    in varchar2,
    pPHONE_NUMBER   in varchar2
  )
  return clob;


  /* Функция - Сервис-Гид - Статус телефона) */
  function GET_PHONE_STATUS
  (
    pSITE_PASSWORD   in varchar2,
    pLOADER_NAME     in varchar2,
    pDB_DATA_SOURCE  in varchar2,
    pDB_USER_NAME    in varchar2,
    pDB_PASSWORD     in varchar2,
    pPHONE_NUMBER    in varchar2,
    pFULL_CHECK      in boolean    -- (FullCheck - только баланс(false) или еще подключенные опции(true)
   )
   return clob;

  /* Процедура получения страницы "Изменение настроек" */
  function GET_PHONE_OPTIONS
  (
    pPHONE_NUMBER     in varchar2,
    pSITE_PASSWORD    in varchar2,
    pLOADER_NAME      in varchar2,
    nFLAG             in number,
    nNUMB             in integer default 1
   )
   return clob;


  /* Загрузка Мегофон - Сервис-Гид - Подключение опции */
  function SET_PHONE_OPTION_ON
  (
    pSITE_PASSWORD   in varchar2,
    pLOADER_NAME     in varchar2,
    pDB_DATA_SOURCE  in varchar2,
    pDB_USER_NAME    in varchar2,
    pDB_PASSWORD     in varchar2,
    pPHONE_NUMBER    in varchar2,
    pOPTION_NAME     in varchar2
   )
   return clob;


  /* Загрузка Мегофон - Сервис-Гид - Отключение опции */
  function SET_PHONE_OPTION_OFF
  (
    pSITE_PASSWORD   in varchar2,
    pLOADER_NAME     in varchar2,
    pDB_DATA_SOURCE  in varchar2,
    pDB_USER_NAME    in varchar2,
    pDB_PASSWORD     in varchar2,
    pPHONE_NUMBER    in varchar2,
    pOPTION_NAME     in varchar2
   )
   return clob;

end PKG_TRF_MEGAFON_TEST;
/

CREATE OR REPLACE package body PKG_TRF_MEGAFON_TEST
is

 
 /* Процедура подключения к https://moscowsg.megafon.ru/ */
 function CONNECTED
 (
 sLOGIN in varchar2,
 sPASSWORD in varchar2
 )
 return boolean
 is
 sXML varchar2(4000) := null;
 Result boolean := true;
 begin

 /* Инициализация параметров */
 PKG_TRF_HTTPCLIENT.Init;

 PKG_TRF_HTTPCLIENT.sURL := 'https://volgasg.megafon.ru/ps/scc/php/check.php';

 /* Подготовка запроса */
 PKG_TRF_HTTPCLIENT.Begin_Request(PKG_TRF_HttpClient.sURL);

 /* Формирование параметров запроса */
 PKG_TRF_HTTPCLIENT.AddRequestParameter('LOGIN', sLOGIN);
 PKG_TRF_HTTPCLIENT.AddRequestParameter('PASSWORD', sPASSWORD);

 /* Подготовка параметров заголовка запроса */
 PKG_TRF_HTTPCLIENT.Set_Header;

 /* Получение ответа с сайта по запросу */
 PKG_TRF_HTTPCLIENT.Get_Response;
 --PKG_TRF_HTTPCLIENT.uRESPONSE := utl_http.get_response(PKG_TRF_HTTPCLIENT.uREQUEST, true);

 /* Получение ответа */
 utl_http.read_text(PKG_TRF_HttpClient.uRESPONSE, sXML, 4000);

 /* Сохранение куков */
 PKG_TRF_HTTPCLIENT.nSESSION := PKG_TRF_HttpClient.SaveCookies;

 /* Получение значения параметров сессии */
 sSESSION_ID := PKG_TRF_HTTPCLIENT.ExtractDataFromXML(sXML, 'SESSION_ID');
 sLANG_ID := PKG_TRF_HTTPCLIENT.ExtractDataFromXML(sXML, 'LANG_ID');
 sCHANNEL := PKG_TRF_HTTPCLIENT.ExtractDataFromXML(sXML, 'CHANNEL');
 sAUTH_MODE := PKG_TRF_HTTPCLIENT.ExtractDataFromXML(sXML, 'AUTH_MODE');

 /* Завершение запроса */
 utl_http.end_response(PKG_TRF_HTTPCLIENT.uRESPONSE);

 /* Построковое формирование clob по полученному htlm */
 begin
 loop
 utl_http.read_line(PKG_TRF_HTTPCLIENT.uRESPONSE, PKG_TRF_HTTPCLIENT.sLINE, true);
 PKG_TRF_HTTPCLIENT.sLINE := utl_i18n.unescape_reference(PKG_TRF_HTTPCLIENT.sLINE);
 PKG_TRF_HTTPCLIENT.cHTML:=PKG_TRF_HTTPCLIENT.cHTML||CHR(10)||PKG_TRF_HTTPCLIENT.sLINE;
 end loop;
 exception
 when others then
 null;
 end;

 if instr(PKG_TRF_HTTPCLIENT.cHTML,'Сессия закрыта') >0 then
 Result := false;
 end if;

 Return Result;

 end CONNECTED;


 /* Функция получения страницы "Ежемесячный счет" */
 function GET_PHONE_BILLS
 (
 pSITE_PASSWORD in varchar2,
 pLOADER_NAME in varchar2,
 pDB_DATA_SOURCE in varchar2,
 pDB_USER_NAME in varchar2,
 pDB_PASSWORD in varchar2,
 pPHONE_NUMBER in varchar2
 )
 return clob
 is
 cTMP clob := null;
 nCOUNT integer := 0;
 sBILLID varchar2(100) := null; -- Номер счета
 sDATEBEGINEND varchar2(100) := null; -- Расчетный период
 sBILLSUM varchar2(100) := null; -- Сумма начислений
 Result clob := null;
 begin

 /* Инициализация переменных */
 PKG_TRF_HTTPCLIENT.Init;
 PKG_TRF_HTTPCLIENT.sLOADERNAME := pLOADER_NAME;
 PKG_TRF_HTTPCLIENT.sLOGIN := pPHONE_NUMBER;

 /* Создание соединения с сайтом "Сервис-Гид" */
 if not CONNECTED(pPHONE_NUMBER, pSITE_PASSWORD) then
 PKG_TRF_HTTPCLIENT.sERRORTEXT := 'Ошибка подключения к Сервис-Гиду';
 Result := PKG_TRF_HTTPCLIENT.sERRORTEXT;
 else

 /* Установка подкаталога */
 PKG_TRF_HTTPCLIENT.sSUBFOLDER := 'GetPhoneBills';

 /* Установка страницы */
 PKG_TRF_HTTPCLIENT.sURL := 'https://volgasg.megafon.ru/SCWWW/BILLS_ORDER_FORM';

 /* Подготовка заголовка запроса */
 PKG_TRF_HTTPCLIENT.Begin_Request(PKG_TRF_HTTPCLIENT.sURL);

 /* Формируем параметры запроса */
 PKG_TRF_HTTPCLIENT.AddRequestParameter('CHANNEL',sCHANNEL);
 PKG_TRF_HTTPCLIENT.AddRequestParameter('SESSION_ID',sSESSION_ID);
 PKG_TRF_HTTPCLIENT.AddRequestParameter('P_USER_LANG_ID',sLANG_ID);

 /* Подготовка параметров заголовка запроса */
 PKG_TRF_HTTPCLIENT.Set_Header;

 /* Блок отправки запроса и получение ответа */
 begin
 /* Получение ответа с сайта по запросу */
 PKG_TRF_HTTPCLIENT.Get_Response;

 /* Формируем текст страницы и записываем в файл */
 PKG_TRF_HTTPCLIENT.SaveFile('Заказ ежемесячного счета', 'Не получены счета');
 dbms_output.put_line(PKG_TRF_HTTPCLIENT.sERRORTEXT);
 
 /* Завершение запроса */
 PKG_TRF_HTTPCLIENT.End_Response;

 exception
 /* если ошибка в блоке - тогда генерация сообщения */
 when others then
 PKG_TRF_HTTPCLIENT.sERRORTEXT := 'Ошибка GET_PHONE_BILLS';
 --dbms_output.put_line(sqlerrm);
 end;

 /* Проверка на наличие ошибок станицы */
 if PKG_TRF_HTTPCLIENT.sERRORTEXT is null then

 /* Вставка html-кода в таблицу */
 --PKG_TRF_HTTPCLIENT.InsertTable;

 /* Блок выделения подстрок из html для получения сумм счетов */
 cTMP := PKG_TRF_HTTPCLIENT.ExtractDataFromString(PKG_TRF_HTTPCLIENT.cHTML,'table_not_scroll_default','PRINT_ACT');
 cTMP := PKG_TRF_HTTPCLIENT.ExtractDataFromString(cTMP,'tbody','/tbody');

 /* Расчет количества записей счетов */
 nCOUNT := case
 when cTMP is null then 0
 else (length(cTMP) - length(replace(cTMP, 'trBillID')))/length('trBillID')
 end ;

 /* Проверка на наличие строк со счетами */
 if nCOUNT >0 then

 /* Цикл по записям счетов */
 for i in 1..nCOUNT
 loop
 /* Цикл по счетам */
 for rec in (select rownum,
 z.str
 from (select rownum rn,
 replace(replace(to_char(regexp_substr(cTMP,'<div>(.+?)</div>',1,level, '')),'<div>',''),'</div>','') as str
 from dual
 connect by level <= nCOUNT*5) z
 where z.rn between (i-1)*5+1 and (i-1)*5+5)
 loop

 if rec.rownum = 1 then
 sBILLID := rec.str;
 elsif rec.rownum = 2 then
 sDATEBEGINEND := rec.str;
 elsif rec.rownum = 3 then
 sBILLSUM := rec.str;
 --DB_LOADER_SIM_PCKG.ADD_PHONE_BILL(sBILLID, pPHONE_NUMBER, sBILLSUM, sDATEBEGINEND);
 dbms_output.put_line('sBILLID-'||sBILLID||', pPHONE_NUMBER-'||pPHONE_NUMBER||', sBILLSUM-'||sBILLSUM||', sDATEBEGINEND-'||sDATEBEGINEND);
 sBILLID := null;
 sBILLSUM := null;
 sDATEBEGINEND := null;
 end if;

 end loop;

 end loop;

 end if;

 /* Если ошибок нет, тогда результат функции html-страница с заголовком */
 Result := PKG_TRF_HTTPCLIENT.cCLOB;

 else

 /* Если были ошибки, тогда результат функции текст ошибки */
 Result := PKG_TRF_HTTPCLIENT.sERRORTEXT;

 end if;

 end if;
 
 /* Удаление директории */
 PKG_TRF_HTTPCLIENT.DropDirectory;

 /* Возврат результата */
 return Result;

 end GET_PHONE_BILLS;


 /* Функция - Сервис-Гид - Статус телефона) */
 function GET_PHONE_STATUS
 (
 pSITE_PASSWORD in varchar2,
 pLOADER_NAME in varchar2,
 pDB_DATA_SOURCE in varchar2,
 pDB_USER_NAME in varchar2,
 pDB_PASSWORD in varchar2,
 pPHONE_NUMBER in varchar2,
 pFULL_CHECK in boolean -- (FullCheck - только баланс(false) или еще подключенные опции(true)
 )
 return clob
 is
 sNEWSTATUS varchar2(1000) := null;
 nBALANCE number(17,2) := 0;
 Result clob := null;
 begin

 /* Инициализация переменных */
 PKG_TRF_HTTPCLIENT.Init;
 PKG_TRF_HTTPCLIENT.sLOADERNAME := pLOADER_NAME;
 PKG_TRF_HTTPCLIENT.sLOGIN := pPHONE_NUMBER;

 /* Создание соединения с сайтом "Сервис-Гид" */
 if not CONNECTED(pPHONE_NUMBER, pSITE_PASSWORD) then
 PKG_TRF_HTTPCLIENT.sERRORTEXT := 'Ошибка подключения к Сервис-Гиду';
 Result := PKG_TRF_HTTPCLIENT.sERRORTEXT;

 else

 /* Установка подкаталога */
 PKG_TRF_HTTPCLIENT.sSUBFOLDER := 'Balances';

 /* Установка страницы */
 PKG_TRF_HTTPCLIENT.sURL := 'https://volgasg.megafon.ru/SCWWW/ACCOUNT_INFO';

 /* Подготовка заголовка запроса */
 PKG_TRF_HTTPCLIENT.Begin_Request(PKG_TRF_HTTPCLIENT.sURL);

 /* Формируем параметры запроса */
 PKG_TRF_HTTPCLIENT.AddRequestParameter('find',null);
 PKG_TRF_HTTPCLIENT.AddRequestParameter('CHANNEL',sCHANNEL);
 PKG_TRF_HTTPCLIENT.AddRequestParameter('SESSION_ID',sSESSION_ID);
 PKG_TRF_HTTPCLIENT.AddRequestParameter('P_USER_LANG_ID',sLANG_ID);
 PKG_TRF_HTTPCLIENT.AddRequestParameter('CUR_SUBS_MSISDN',pPHONE_NUMBER);
 PKG_TRF_HTTPCLIENT.AddRequestParameter('SUBSCRIBER_MSISDN',pPHONE_NUMBER);

 /* Подготовка параметров заголовка запроса */
 PKG_TRF_HTTPCLIENT.Set_Header;

 /* Блок отправки запроса и получение ответа */
 begin
 /* Получение ответа с сайта по запросу */
 PKG_TRF_HTTPCLIENT.Get_Response;
 
 /* Формируем текст страницы и записываем в файл */
 PKG_TRF_HTTPCLIENT.SaveFile('Статус абонента', 'Не получен баланс.');

 /* Вставка html-кода в таблицу */
 PKG_TRF_HTTPCLIENT.InsertTable;

 /* Завершение запроса */
 PKG_TRF_HTTPCLIENT.End_Response;

 exception
 /* если ошибка в блоке - тогда генерация сообщения */
 when others then
 PKG_TRF_HTTPCLIENT.sERRORTEXT := 'Ошибка GET_PHONE_STATUS';
 end;

 /* Проверка на наличие ошибок станицы */
 if PKG_TRF_HTTPCLIENT.sERRORTEXT is null then

 /* Вставка html-кода в таблицу */
 --PKG_TRF_HTTPCLIENT.InsertTable;

 /* Проверка страницы */
 if not PKG_TRF_HTTPCLIENT.IsValidResult then
 PKG_TRF_HTTPCLIENT.sERRORTEXT := 'Не получен баланс';
 else

 /* Получение статуса абонента */
 sNEWSTATUS := PKG_TRF_HTTPCLIENT.ExtractDataFromString(PKG_TRF_HTTPCLIENT.cHTML,'<div>Статус абонента','Текущий тарифный план');
 sNEWSTATUS := PKG_TRF_HTTPCLIENT.ExtractDataFromString(sNEWSTATUS,'<div class="td_def">','</div>');


 if sNEWSTATUS is not null then
 		 --DB_LOADER_SIM_PCKG.UPDATE_PHONE_STATUS(pPHONE_NUMBER, sNEWSTATUS);
 dbms_output.put_line('DB_LOADER_SIM_PCKG.UPDATE_PHONE_STATUS(pPHONE_NUMBER => '||pPHONE_NUMBER||', sNEWSTATUS => '||sNEWSTATUS||')');

 /* Получение текущего баланса */
 begin
 nBALANCE := to_number(replace(PKG_TRF_HTTPCLIENT.ExtractDataFromString(PKG_TRF_HTTPCLIENT.cHTML,'<div class="balance_good td_def">',' руб.</div>'),'.',','));
 --DB_LOADER_SIM_PCKG.UPDATE_PHONE_BALANCE(pPHONE_NUMBER, nBALANCE);
 dbms_output.put_line('DB_LOADER_SIM_PCKG.UPDATE_PHONE_BALANCE(pPHONE_NUMBER => '||pPHONE_NUMBER||', nBALANCE => '||nBALANCE||')');

 /* Формирование выходного clob страницы */
 Result := PKG_TRF_HTTPCLIENT.cCLOB;

 if pFULL_CHECK then
 dbms_output.put_line(substr(GET_PHONE_OPTIONS(pPHONE_NUMBER, pSITE_PASSWORD, pLOADER_NAME, 1, 2),1,1000));
 --GET_PHONE_OPTIONS(pPHONE_NUMBER, pSITE_PASSWORD, 1)
 end if;

 exception
 when others then
 dbms_output.put_line('Ошибка получения nBALANCE');
 PKG_TRF_HTTPCLIENT.sERRORTEXT := 'Ошибка получения nBALANCE';
 Result:= PKG_TRF_HTTPCLIENT.sERRORTEXT;
 end;

 else
 PKG_TRF_HTTPCLIENT.sERRORTEXT := 'Статус абоненета не определен';
 Result:= PKG_TRF_HTTPCLIENT.sERRORTEXT;
 end if;

 end if;

 end if;

 end if;
 
 /* Удаление директории */
 PKG_TRF_HTTPCLIENT.DropDirectory;

 return Result;

 end GET_PHONE_STATUS;

 /* Процедура получения страницы "Изменение настроек" */
 function GET_PHONE_OPTIONS
 (
 pPHONE_NUMBER in varchar2,
 pSITE_PASSWORD in varchar2,
 pLOADER_NAME in varchar2,
 nFLAG in number,
 nNUMB in integer default 1
 )
 return clob
 is
 Result clob := null;
 begin

 /* Инициализация параметров */
 PKG_TRF_HTTPCLIENT.Init(false);

 /* Запуск процедуры подключения и запроса параметров сессии */
 if nFLAG = 0 then

 /* Инициализация параметров */
 PKG_TRF_HTTPCLIENT.sLOADERNAME := pLOADER_NAME;
 PKG_TRF_HTTPCLIENT.sLOGIN := pPHONE_NUMBER;

 /* Создание соединения с сайтом "Сервис-Гид" */
 if not CONNECTED(pPHONE_NUMBER, pSITE_PASSWORD) then
 PKG_TRF_HTTPCLIENT.sERRORTEXT := 'Ошибка подключения к Сервис-Гиду';
 Result := PKG_TRF_HTTPCLIENT.sERRORTEXT;
 end if;
 end if;

 /* Если нет ошибок подключения */
 if PKG_TRF_HTTPCLIENT.sERRORTEXT is null then

 /* Установка страницы */
 PKG_TRF_HTTPCLIENT.sURL := 'https://volgasg.megafon.ru/SCWWW/ORDER_SERVICE_FORM';

 /* Подготовка заголовка запроса */
 PKG_TRF_HTTPCLIENT.Begin_Request(PKG_TRF_HTTPCLIENT.sURL);

 /* Формируем параметры запроса */
 PKG_TRF_HTTPCLIENT.AddRequestParameter('find',null);
 PKG_TRF_HTTPCLIENT.AddRequestParameter('CHANNEL',sCHANNEL);
 PKG_TRF_HTTPCLIENT.AddRequestParameter('SESSION_ID',sSESSION_ID);
 PKG_TRF_HTTPCLIENT.AddRequestParameter('P_USER_LANG_ID',sLANG_ID);
 PKG_TRF_HTTPCLIENT.AddRequestParameter('CUR_SUBS_MSISDN',pPHONE_NUMBER);
 PKG_TRF_HTTPCLIENT.AddRequestParameter('SUBSCRIBER_MSISDN',pPHONE_NUMBER);

 /* Подготовка параметров заголовка запроса */
 PKG_TRF_HTTPCLIENT.Set_Header;

 /* Блок отправки запроса и получение ответа */
 begin
 /* Получение ответа с сайта по запросу */
 PKG_TRF_HTTPCLIENT.Get_Response;

 /* Формируем текст страницы и записываем в файл */
 PKG_TRF_HTTPCLIENT.SaveFile(nNUMB => nNUMB);

 /* Завершение запроса */
 PKG_TRF_HTTPCLIENT.End_Response;
 exception
 /* если ошибка в блоке - тогда генерация сообщения */
 when others then
 PKG_TRF_HTTPCLIENT.sERRORTEXT := 'Ошибка GET_PHONE_OPTIONS';
 Result := PKG_TRF_HTTPCLIENT.sERRORTEXT;
 end;

 /* Проверка на наличие ошибки */
 if PKG_TRF_HTTPCLIENT.sERRORTEXT is null then

 /* Вставка html-кода в таблицу */
 --PKG_TRF_HTTPCLIENT.InsertTable;

 /* Цикл по сервисам */
 for rec in (select z.*
 from (select replace(replace(to_char(regexp_substr(PKG_TRF_HTTPCLIENT.cHTML,'name="SERVICE_ID" value="\S+',1,level)),'name="SERVICE_ID" value="',''),'"','') serviceid,
 to_char(regexp_substr(PKG_TRF_HTTPCLIENT.cHTML,'name="SERVICE_ID" value=*= */S+ .\S+ */S+>',1,level)) str
 from dual
 connect by level <= 20) z
 where instr(z.str,'disabled')=0)
 loop
 --DB_LOADER_SIM_PCKG.UPDATE_PHONE_OPTION(pPHONE_NUMBER, rec.serviceid);
 dbms_output.put_line('DB_LOADER_SIM_PCKG.UPDATE_PHONE_OPTION(pPHONE_NUMBER => '||pPHONE_NUMBER||', pOPTION_CODE => '||rec.serviceid||')');
 end loop;

 if not PKG_TRF_HTTPCLIENT.IsValidResult then
 PKG_TRF_HTTPCLIENT.sERRORTEXT := 'Не получен список услуг.';
 else
 Result := PKG_TRF_HTTPCLIENT.cCLOB;
 end if;

 end if;

 end if;

 return Result;

 end GET_PHONE_OPTIONS;


 /* Загрузка Мегофон - Сервис-Гид - Подключение опции */
 function SET_PHONE_OPTION_ON
 (
 pSITE_PASSWORD in varchar2,
 pLOADER_NAME in varchar2,
 pDB_DATA_SOURCE in varchar2,
 pDB_USER_NAME in varchar2,
 pDB_PASSWORD in varchar2,
 pPHONE_NUMBER in varchar2,
 pOPTION_NAME in varchar2
 )
 return clob
 is
 Result clob := null;
 cTMP clob := null;
 sTYPESET varchar2(100) := 'подключение';
 begin

 /* ************** Получение списка опций ************** */

 /* Инициализация переменных */
 PKG_TRF_HTTPCLIENT.Init;
 PKG_TRF_HTTPCLIENT.sLOADERNAME := pLOADER_NAME;
 PKG_TRF_HTTPCLIENT.sLOGIN := pPHONE_NUMBER;

 /* Создание соединения с сайтом "Сервис-Гид" */
 if not CONNECTED(pPHONE_NUMBER, pSITE_PASSWORD) then
 PKG_TRF_HTTPCLIENT.sERRORTEXT := 'Ошибка подключения к Сервис-Гиду';
 Result := PKG_TRF_HTTPCLIENT.sERRORTEXT;
 else

 /* Установка подкаталога */
 PKG_TRF_HTTPCLIENT.sSUBFOLDER := 'OptionsOn';

 /* Установка страницы */
 PKG_TRF_HTTPCLIENT.sURL := 'https://volgasg.megafon.ru/SCWWW/ORDER_SERVICE_FORM';

 /* Подготовка заголовка запроса */
 PKG_TRF_HTTPCLIENT.Begin_Request(PKG_TRF_HTTPCLIENT.sURL);

 /* Формируем параметры запроса */
 PKG_TRF_HTTPCLIENT.AddRequestParameter('find',null);
 PKG_TRF_HTTPCLIENT.AddRequestParameter('CHANNEL',sCHANNEL);
 PKG_TRF_HTTPCLIENT.AddRequestParameter('SESSION_ID',sSESSION_ID);
 PKG_TRF_HTTPCLIENT.AddRequestParameter('P_USER_LANG_ID',sLANG_ID);
 PKG_TRF_HTTPCLIENT.AddRequestParameter('CUR_SUBS_MSISDN',pPHONE_NUMBER);
 PKG_TRF_HTTPCLIENT.AddRequestParameter('SUBSCRIBER_MSISDN',pPHONE_NUMBER);

 /* Подготовка параметров заголовка запроса */
 PKG_TRF_HTTPCLIENT.Set_Header;

 /* Блок отправки запроса и получение ответа */
 begin
 /* Получение ответа с сайта по запросу */
 PKG_TRF_HTTPCLIENT.Get_Response;

 /* Формируем текст страницы и записываем в файл */
 PKG_TRF_HTTPCLIENT.SaveFile;

 /* Вставка html-кода в таблицу */
 --PKG_TRF_HTTPCLIENT.InsertTable;

 /* Завершение запроса */
 PKG_TRF_HTTPCLIENT.End_Response;

 exception
 when others then
 PKG_TRF_HTTPCLIENT.sERRORTEXT := 'Ошибка SET_PHONE_OPTION_ON';
 Result := PKG_TRF_HTTPCLIENT.sERRORTEXT;
 end;

 /* Проверка на наличие ошибки */
 if PKG_TRF_HTTPCLIENT.sERRORTEXT is null then

 /* Проверка страницы */
 if not PKG_TRF_HTTPCLIENT.IsValidResult then
 PKG_TRF_HTTPCLIENT.sERRORTEXT := 'Не получен список услуг';
 Result := PKG_TRF_HTTPCLIENT.sERRORTEXT;

 else

 /* ************** Изменение списка опций ************** */

 cTMP := PKG_TRF_HTTPCLIENT.cHTML;
 PKG_TRF_HTTPCLIENT.cCLOB := null;
 PKG_TRF_HTTPCLIENT.cHTML := null;
 PKG_TRF_HTTPCLIENT.uRESPONSE := null;
 PKG_TRF_HTTPCLIENT.uREQUEST := null;
 PKG_TRF_HTTPCLIENT.sFILE_TYPE := null;
 PKG_TRF_HTTPCLIENT.sREQUEST_TEXT := null;

 /* Установка страницы */
 PKG_TRF_HTTPCLIENT.sURL := 'https://volgasg.megafon.ru/SCWWW/ORDER_SERVICE_CONFIRM';

 /* Подготовка заголовка запроса */
 PKG_TRF_HTTPCLIENT.Begin_Request(PKG_TRF_HTTPCLIENT.sURL);

 /* Формируем параметры запроса */
 PKG_TRF_HTTPCLIENT.AddRequestParameter('GROUP_ID','1');

 /* Цикл по сервисам */
 for rec in (select z.*
 from (select replace(replace(to_char(regexp_substr(cTMP,'name="SERVICE_ID" value="\S+',1,level)),'name="SERVICE_ID" value="',''),'"','') serviceid,
 to_char(regexp_substr(cTMP,'name="SERVICE_ID" value=*= */S+ .\S+ */S+>',1,level)) str
 from dual
 connect by level <= 20) z
 where instr(z.str,'disabled')=0)
 loop
 --DB_LOADER_SIM_PCKG.UPDATE_PHONE_OPTION(pPHONE_NUMBER, rec.serviceid);
 --dbms_output.put_line('DB_LOADER_SIM_PCKG.UPDATE_PHONE_OPTION(pPHONE_NUMBER => '||pPHONE_NUMBER||', pOPTION_CODE => '||rec.serviceid||')');

 /* Формируем параметры запроса */
 PKG_TRF_HTTPCLIENT.AddRequestParameter('SERVICE_ID',rec.serviceid);

 if rec.serviceid = pOPTION_NAME then
 PKG_TRF_HTTPCLIENT.sERRORTEXT := nvl(PKG_TRF_HTTPCLIENT.sERRORTEXT,'Ошибка: Опция уже подключена');
 Result := PKG_TRF_HTTPCLIENT.sERRORTEXT;
 dbms_output.put_line('Ошибка: Опция '||pOPTION_NAME||' уже подключена');
 exit;
 end if;

 end loop;

 /* Проверка на наличие ошиибок изменения списка услуг */
 if PKG_TRF_HTTPCLIENT.sERRORTEXT is null then

 /* Формируем параметры запроса */
 PKG_TRF_HTTPCLIENT.AddRequestParameter('SERVICE_ID',pOPTION_NAME);
 PKG_TRF_HTTPCLIENT.AddRequestParameter('CHANNEL',sCHANNEL);
 PKG_TRF_HTTPCLIENT.AddRequestParameter('SESSION_ID',sSESSION_ID);
 PKG_TRF_HTTPCLIENT.AddRequestParameter('P_USER_LANG_ID',sLANG_ID);
 PKG_TRF_HTTPCLIENT.AddRequestParameter('CUR_SUBS_MSISDN',pPHONE_NUMBER);
 PKG_TRF_HTTPCLIENT.AddRequestParameter('SUBSCRIBER_MSISDN',pPHONE_NUMBER);

 /* Подготовка параметров заголовка запроса */
 PKG_TRF_HTTPCLIENT.Set_Header;

 /* Блок отправки запроса и получение ответа */
 begin
 /* Получение ответа с сайта по запросу */
 PKG_TRF_HTTPCLIENT.Get_Response;
 exception
 when others then
 PKG_TRF_HTTPCLIENT.sERRORTEXT := 'Ошибка ORDER_SERVICE_CONFIRM';
 Result := PKG_TRF_HTTPCLIENT.sERRORTEXT;
 end;

 /* Формируем текст страницы и записываем в файл */
 PKG_TRF_HTTPCLIENT.SaveFile;

 --PKG_TRF_HTTPCLIENT.InsertTable;

 /* Завершение запроса */
 PKG_TRF_HTTPCLIENT.End_Response;



 /* ************** Подтверждение запроса на изменение списка опций ************** */

 cTMP := PKG_TRF_HTTPCLIENT.cHTML;
 PKG_TRF_HTTPCLIENT.cCLOB := null;
 PKG_TRF_HTTPCLIENT.cHTML := null;
 PKG_TRF_HTTPCLIENT.uRESPONSE := null;
 PKG_TRF_HTTPCLIENT.uREQUEST := null;
 PKG_TRF_HTTPCLIENT.sFILE_TYPE := null;
 PKG_TRF_HTTPCLIENT.sREQUEST_TEXT := null;

 begin
 /* Установка страницы */
 PKG_TRF_HTTPCLIENT.sURL := 'https://volgasg.megafon.ru/SCWWW/ORDER_SERVICE_ACTION';

 /* Подготовка заголовка запроса */
 PKG_TRF_HTTPCLIENT.Begin_Request(PKG_TRF_HTTPCLIENT.sURL);

 /* Формируем параметры запроса */
 PKG_TRF_HTTPCLIENT.AddRequestParameter('GROUP_ID','1');
 PKG_TRF_HTTPCLIENT.AddRequestParameter('SERVICES_TO_APPEND',pOPTION_NAME);
 PKG_TRF_HTTPCLIENT.AddRequestParameter('CHANNEL',sCHANNEL);
 PKG_TRF_HTTPCLIENT.AddRequestParameter('SESSION_ID',sSESSION_ID);
 PKG_TRF_HTTPCLIENT.AddRequestParameter('P_USER_LANG_ID',sLANG_ID);
 PKG_TRF_HTTPCLIENT.AddRequestParameter('CUR_SUBS_MSISDN',pPHONE_NUMBER);
 PKG_TRF_HTTPCLIENT.AddRequestParameter('SUBSCRIBER_MSISDN',pPHONE_NUMBER);

 /* Подготовка параметров заголовка запроса */
 PKG_TRF_HTTPCLIENT.Set_Header;

 /* Получение ответа с сайта по запросу */
 PKG_TRF_HTTPCLIENT.Get_Response;

 /* Формируем текст страницы и записываем в файл */
 PKG_TRF_HTTPCLIENT.SaveFile;

 --PKG_TRF_HTTPCLIENT.InsertTable;

 /* Завершение запроса */
 PKG_TRF_HTTPCLIENT.End_Response;

 exception
 when others then
 PKG_TRF_HTTPCLIENT.sERRORTEXT := nvl(PKG_TRF_HTTPCLIENT.sERRORTEXT,'Ошибка ORDER_SERVICE_ACTION');
 end;

 if not PKG_TRF_HTTPCLIENT.IsValidResult then
 PKG_TRF_HTTPCLIENT.sERRORTEXT := nvl(PKG_TRF_HTTPCLIENT.sERRORTEXT,'Нет ответа на подтверждение');
 end if;

 --DB_LOADER_SIM_PCKG.LOG_SET_PHONE_OPTION_ADD_REC(pPHONE_NUMBER, pOPTION_NAME, sTYPESET, PKG_TRF_HTTPCLIENT.sERRORTEXT);
 dbms_output.put_line('DB_LOADER_SIM_PCKG.LOG_SET_PHONE_OPTION_ADD_REC(pPHONE_NUMBER => '||pPHONE_NUMBER
 ||', pOPTION_NAME => '||pOPTION_NAME
 ||', pTYPE_SET => '||sTYPESET
 ||', pNOTE => '||PKG_TRF_HTTPCLIENT.sERRORTEXT||')');

 if PKG_TRF_HTTPCLIENT.sERRORTEXT is null then
 Result := PKG_TRF_HTTPCLIENT.sERRORTEXT;
 else
 Result := PKG_TRF_HTTPCLIENT.cCLOB;
 end if;

 end if;

 end if;

 end if;

 end if;
 
 /* Удаление директории */
 PKG_TRF_HTTPCLIENT.DropDirectory; 
 
 Return Result;

 end SET_PHONE_OPTION_ON;


 /* Загрузка Мегофон - Сервис-Гид - Отключение опции */
 function SET_PHONE_OPTION_OFF
 (
 pSITE_PASSWORD in varchar2,
 pLOADER_NAME in varchar2,
 pDB_DATA_SOURCE in varchar2,
 pDB_USER_NAME in varchar2,
 pDB_PASSWORD in varchar2,
 pPHONE_NUMBER in varchar2,
 pOPTION_NAME in varchar2
 )
 return clob
 is
 Result clob := null;
 cTMP clob := null;
 sTYPESET varchar2(100) := 'отключение';
 nFLAG integer := 0;
 begin

 /* ************** Получение списка опций ************** */

 /* Инициализация переменных */
 PKG_TRF_HTTPCLIENT.Init;
 PKG_TRF_HTTPCLIENT.sLOADERNAME := pLOADER_NAME;
 PKG_TRF_HTTPCLIENT.sLOGIN := pPHONE_NUMBER;

 /* Создание соединения с сайтом "Сервис-Гид" */
 if not CONNECTED(pPHONE_NUMBER, pSITE_PASSWORD) then
 PKG_TRF_HTTPCLIENT.sERRORTEXT := 'Ошибка подключения к Сервис-Гиду';
 Result := PKG_TRF_HTTPCLIENT.sERRORTEXT;
 else

 /* Установка подкаталога */
 PKG_TRF_HTTPCLIENT.sSUBFOLDER := 'OptionsOff';

 /* Установка страницы */
 PKG_TRF_HTTPCLIENT.sURL := 'https://volgasg.megafon.ru/SCWWW/ORDER_SERVICE_FORM';

 /* Подготовка заголовка запроса */
 PKG_TRF_HTTPCLIENT.Begin_Request(PKG_TRF_HTTPCLIENT.sURL);

 /* Формируем параметры запроса */
 PKG_TRF_HTTPCLIENT.AddRequestParameter('find',null);
 PKG_TRF_HTTPCLIENT.AddRequestParameter('CHANNEL',sCHANNEL);
 PKG_TRF_HTTPCLIENT.AddRequestParameter('SESSION_ID',sSESSION_ID);
 PKG_TRF_HTTPCLIENT.AddRequestParameter('P_USER_LANG_ID',sLANG_ID);
 PKG_TRF_HTTPCLIENT.AddRequestParameter('CUR_SUBS_MSISDN',pPHONE_NUMBER);
 PKG_TRF_HTTPCLIENT.AddRequestParameter('SUBSCRIBER_MSISDN',pPHONE_NUMBER);

 /* Подготовка параметров заголовка запроса */
 PKG_TRF_HTTPCLIENT.Set_Header;

 begin
 /* Получение ответа с сайта по запросу */
 PKG_TRF_HTTPCLIENT.Get_Response;

 /* Формируем текст страницы и записываем в файл */
 PKG_TRF_HTTPCLIENT.SaveFile;

 /* Вставка html-кода в таблицу */
 --PKG_TRF_HTTPCLIENT.InsertTable;

 /* Завершение запроса */
 PKG_TRF_HTTPCLIENT.End_Response;

 exception
 when others then
 PKG_TRF_HTTPCLIENT.sERRORTEXT := 'Ошибка SET_PHONE_OPTION_OFF';
 end;

 if not PKG_TRF_HTTPCLIENT.IsValidResult then
 PKG_TRF_HTTPCLIENT.sERRORTEXT := 'Не получен список услуг';
 end if;


 /* Проверка на наличие ошибок получения списка услуг */
 if PKG_TRF_HTTPCLIENT.sERRORTEXT is null then

 /* ************** Изменение списка опций ************** */

 cTMP := PKG_TRF_HTTPCLIENT.cHTML;
 PKG_TRF_HTTPCLIENT.cCLOB := null;
 PKG_TRF_HTTPCLIENT.cHTML := null;
 PKG_TRF_HTTPCLIENT.uRESPONSE := null;
 PKG_TRF_HTTPCLIENT.uREQUEST := null;
 PKG_TRF_HTTPCLIENT.sFILE_TYPE := null;
 PKG_TRF_HTTPCLIENT.sREQUEST_TEXT := null;

 /* Установка страницы */
 PKG_TRF_HTTPCLIENT.sURL := 'https://volgasg.megafon.ru/SCWWW/ORDER_SERVICE_CONFIRM';

 /* Подготовка заголовка запроса */
 PKG_TRF_HTTPCLIENT.Begin_Request(PKG_TRF_HTTPCLIENT.sURL);

 /* Формируем параметры запроса */
 PKG_TRF_HTTPCLIENT.AddRequestParameter('GROUP_ID','1');

 /* Цикл по сервисам */
 for rec in (select z.*
 from (select replace(replace(to_char(regexp_substr(cTMP,'name="SERVICE_ID" value="\S+',1,level)),'name="SERVICE_ID" value="',''),'"','') serviceid,
 to_char(regexp_substr(cTMP,'name="SERVICE_ID" value=*= */S+ .\S+ */S+>',1,level)) str
 from dual
 connect by level <= 20) z)
 loop

 if instr(rec.str,'disabled')=0 then
 -- список подключенных опций
 if rec.serviceid = pOPTION_NAME then
 --dbms_output.put_line('Отключаем опцию '||rec.serviceid);
 nFLAG := 1;
 else
 /* Формируем параметры запроса */
 PKG_TRF_HTTPCLIENT.AddRequestParameter('SERVICE_ID',rec.serviceid);
 --dbms_output.put_line('Не отключаем опцию '||rec.serviceid);
 end if;
 else
 -- список отключенных опций
 if rec.serviceid = pOPTION_NAME then
 PKG_TRF_HTTPCLIENT.sERRORTEXT := 'Ошибка: Опция уже отключена';
 nFLAG := 1;
 end if;
 --dbms_output.put_line('Отключенная опция '||rec.serviceid);
 end if;

 end loop;

 if nFLAG = 0 then
 PKG_TRF_HTTPCLIENT.sERRORTEXT := 'Ошибка: Данная опция не найдена в списке';
 end if;

 /* Проверка на наличие ошиибок изменения списка услуг */
 if PKG_TRF_HTTPCLIENT.sERRORTEXT is null then

 /* Формируем параметры запроса */
 PKG_TRF_HTTPCLIENT.AddRequestParameter('CHANNEL',sCHANNEL);
 PKG_TRF_HTTPCLIENT.AddRequestParameter('SESSION_ID',sSESSION_ID);
 PKG_TRF_HTTPCLIENT.AddRequestParameter('P_USER_LANG_ID',sLANG_ID);
 PKG_TRF_HTTPCLIENT.AddRequestParameter('CUR_SUBS_MSISDN',pPHONE_NUMBER);
 PKG_TRF_HTTPCLIENT.AddRequestParameter('SUBSCRIBER_MSISDN',pPHONE_NUMBER);

 /* Подготовка параметров заголовка запроса */
 PKG_TRF_HTTPCLIENT.Set_Header;

 /* Получение ответа с сайта по запросу */
 PKG_TRF_HTTPCLIENT.Get_Response;

 /* Формируем текст страницы и записываем в файл */
 PKG_TRF_HTTPCLIENT.SaveFile;

 PKG_TRF_HTTPCLIENT.InsertTable;

 /* Завершение запроса */
 PKG_TRF_HTTPCLIENT.End_Response;



 /* ************** Подтверждение запроса на изменение списка опций ************** */

 cTMP := PKG_TRF_HTTPCLIENT.cHTML;
 PKG_TRF_HTTPCLIENT.cCLOB := null;
 PKG_TRF_HTTPCLIENT.cHTML := null;
 PKG_TRF_HTTPCLIENT.uRESPONSE := null;
 PKG_TRF_HTTPCLIENT.uREQUEST := null;
 PKG_TRF_HTTPCLIENT.sFILE_TYPE := null;
 PKG_TRF_HTTPCLIENT.sREQUEST_TEXT := null;

 begin
 /* Установка страницы */
 PKG_TRF_HTTPCLIENT.sURL := 'https://volgasg.megafon.ru/SCWWW/ORDER_SERVICE_ACTION';

 /* Подготовка заголовка запроса */
 PKG_TRF_HTTPCLIENT.Begin_Request(PKG_TRF_HTTPCLIENT.sURL);

 /* Формируем параметры запроса */
 PKG_TRF_HTTPCLIENT.AddRequestParameter('GROUP_ID','1');
 PKG_TRF_HTTPCLIENT.AddRequestParameter('SERVICES_TO_DELETE',pOPTION_NAME);
 PKG_TRF_HTTPCLIENT.AddRequestParameter('CHANNEL',sCHANNEL);
 PKG_TRF_HTTPCLIENT.AddRequestParameter('SESSION_ID',sSESSION_ID);
 PKG_TRF_HTTPCLIENT.AddRequestParameter('P_USER_LANG_ID',sLANG_ID);
 PKG_TRF_HTTPCLIENT.AddRequestParameter('CUR_SUBS_MSISDN',pPHONE_NUMBER);
 PKG_TRF_HTTPCLIENT.AddRequestParameter('SUBSCRIBER_MSISDN',pPHONE_NUMBER);

 /* Подготовка параметров заголовка запроса */
 PKG_TRF_HTTPCLIENT.Set_Header;

 /* Получение ответа с сайта по запросу */
 PKG_TRF_HTTPCLIENT.Get_Response;

 /* Формируем текст страницы и записываем в файл */
 PKG_TRF_HTTPCLIENT.SaveFile;

 --PKG_TRF_HTTPCLIENT.InsertTable;

 /* Завершение запроса */
 PKG_TRF_HTTPCLIENT.End_Response;

 exception
 when others then
 PKG_TRF_HTTPCLIENT.sERRORTEXT := nvl(PKG_TRF_HTTPCLIENT.sERRORTEXT,'Ошибка ORDER_SERVICE_ACTION');
 end;

 if not PKG_TRF_HTTPCLIENT.IsValidResult then
 PKG_TRF_HTTPCLIENT.sERRORTEXT := nvl(PKG_TRF_HTTPCLIENT.sERRORTEXT,'Нет ответа на подтверждение');
 end if;

 --DB_LOADER_SIM_PCKG.LOG_SET_PHONE_OPTION_ADD_REC(pPHONE_NUMBER, pOPTION_NAME, sTYPESET, PKG_TRF_HTTPCLIENT.sERRORTEXT);
 dbms_output.put_line('DB_LOADER_SIM_PCKG.LOG_SET_PHONE_OPTION_ADD_REC(pPHONE_NUMBER => '||pPHONE_NUMBER
 ||', pOPTION_NAME => '||pOPTION_NAME
 ||', pTYPE_SET => '||sTYPESET
 ||', pNOTE => '||PKG_TRF_HTTPCLIENT.sERRORTEXT||')');

 Result := PKG_TRF_HTTPCLIENT.cCLOB;
 end if;

 end if;

 end if;

 /* Удаление директории */
 PKG_TRF_HTTPCLIENT.DropDirectory;
 
 Return Result;

 end SET_PHONE_OPTION_OFF;

end PKG_TRF_MEGAFON_TEST;
/

