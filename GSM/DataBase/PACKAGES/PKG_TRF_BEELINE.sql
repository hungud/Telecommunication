CREATE OR REPLACE package PKG_TRF_BEELINE
is

  /* Константы пакета */

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
  
  procedure LOAD_DETAIL;
  /*

  \* Функция получения  страницы "Ежемесячный счет"  *\
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


  \* Функция - Сервис-Гид - Статус телефона) *\
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

  \* Процедура получения страницы "Изменение настроек" *\
  function GET_PHONE_OPTIONS
  (
    pPHONE_NUMBER     in varchar2,
    pSITE_PASSWORD    in varchar2,
    pLOADER_NAME      in varchar2,
    nFLAG             in number,
    nNUMB             in integer default 1
   )
   return clob;


  \* Загрузка Мегофон - Сервис-Гид - Подключение опции *\
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


  \* Загрузка Мегофон - Сервис-Гид - Отключение опции *\
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
*/
end PKG_TRF_BEELINE;
/

CREATE OR REPLACE package body PKG_TRF_BEELINE
is

  /* Процедура подключения к https://uslugi.beeline.ru */
  function CONNECTED
  (
    sLOGIN     in varchar2, -- AS412374248
    sPASSWORD  in varchar2  -- 32503250
  )
  return boolean
  is
    cTEMP          clob := null;
    nPAUSED        integer := 0;
    Result         boolean := true;
    sPASS          varchar2(20) := '32503250';
  begin

    ----------------------------- 1 ---------------------------------------
    /* Инициализация параметров */
    PKG_TRF_HTTPCLIENT.Init;

    PKG_TRF_HTTPCLIENT.sURL := 'https://uslugi.beeline.ru';

    /* Подготовка запроса */
    PKG_TRF_HTTPCLIENT.Begin_Request(PKG_TRF_HttpClient.sURL, 'GET');
    
    PKG_TRF_HTTPCLIENT.sLOGIN := 'AS412374248';    --sLOGIN;
    sPASS := '32503250';

    /* Подготовка параметров заголовка запроса */
    PKG_TRF_HTTPCLIENT.Set_Header;

    /* Получение ответа с сайта по запросу */
    PKG_TRF_HTTPCLIENT.Get_Response;
    
    nPAUSED := DB_LOADER_PCKG.IS_ACCOUNT_LOGON_PAUSED(PKG_TRF_HTTPCLIENT.sLOGIN);
    
    /* Сохранение куков */
    PKG_TRF_HTTPCLIENT.nSESSION := PKG_TRF_HttpClient.SaveCookies;
    
    /* Установка подкаталога */
    PKG_TRF_HTTPCLIENT.sSUBFOLDER := 'Connect';
    
    /* Построковое формирование clob по полученному htlm */
    --PKG_TRF_HTTPCLIENT.SaveFile;
    
    --PKG_TRF_HTTPCLIENT.InsertTable;

    /* Завершение запроса */
    utl_http.end_response(PKG_TRF_HTTPCLIENT.uRESPONSE);
    
    ----------------------------------------------------
    
    ----------------------------- 2 ---------------------------------------
    /* Инициализация параметров */
    PKG_TRF_HTTPCLIENT.Init(false);
    
    PKG_TRF_HttpClient.RestoreCookies(PKG_TRF_HTTPCLIENT.nSESSION);
    
    PKG_TRF_HTTPCLIENT.sURL := 'https://uslugi.beeline.ru/loginPage.do';

    /* Подготовка запроса */
    PKG_TRF_HTTPCLIENT.Begin_Request(PKG_TRF_HttpClient.sURL);
    
    /* Формирование параметров запроса */
    PKG_TRF_HTTPCLIENT.AddRequestParameter('_stateParam','eCareLocale.currentLocale%3Dru_RU__Georgian');
    PKG_TRF_HTTPCLIENT.AddRequestParameter('_forwardName','null');
    PKG_TRF_HTTPCLIENT.AddRequestParameter('_resetBreadCrumbs','false');
    PKG_TRF_HTTPCLIENT.AddRequestParameter('_expandStatus','');
    PKG_TRF_HTTPCLIENT.AddRequestParameter('userName',PKG_TRF_HTTPCLIENT.sLOGIN);
    PKG_TRF_HTTPCLIENT.AddRequestParameter('password',sPASS/*WORD*/);
    PKG_TRF_HTTPCLIENT.AddRequestParameter('ecareAction','login');
    
    /* Подготовка параметров заголовка запроса */
    PKG_TRF_HTTPCLIENT.Set_Header(sREFEREF => 'https://uslugi.beeline.ru/');

    /* Получение ответа с сайта по запросу */
    PKG_TRF_HTTPCLIENT.Get_Response;
    
    nPAUSED := DB_LOADER_PCKG.IS_ACCOUNT_LOGON_PAUSED(PKG_TRF_HTTPCLIENT.sLOGIN);
    
    /* Сохранение куков */
    /*PKG_TRF_HTTPCLIENT.nSESSION := PKG_TRF_HttpClient.SaveCookies;*/
    
    /* Установка подкаталога */
    --PKG_TRF_HTTPCLIENT.sSUBFOLDER := 'Connect';
    
    /* Построковое формирование clob по полученному htlm */
    --PKG_TRF_HTTPCLIENT.SaveFile(nNUMB => 2);
    
    --PKG_TRF_HTTPCLIENT.InsertTable;

    /* Завершение запроса */
    utl_http.end_response(PKG_TRF_HTTPCLIENT.uRESPONSE);
    
    ----------------------------- 3 -----------------------
    /* Инициализация параметров */
    PKG_TRF_HTTPCLIENT.Init(false);
    
    PKG_TRF_HttpClient.RestoreCookies(PKG_TRF_HTTPCLIENT.nSESSION);
    
    PKG_TRF_HTTPCLIENT.sURL := 'https://uslugi.beeline.ru/navigateMenu.do';

    /* Подготовка запроса */
    PKG_TRF_HTTPCLIENT.Begin_Request(PKG_TRF_HttpClient.sURL, 'GET');
    
    PKG_TRF_HTTPCLIENT.sREQUEST_TEXT := null;
    
    /* Подготовка параметров заголовка запроса */
    PKG_TRF_HTTPCLIENT.Set_Header(sREFEREF => 'https://uslugi.beeline.ru/');

    begin
      /* Получение ответа с сайта по запросу */
      PKG_TRF_HTTPCLIENT.Get_Response;
    exception
     when others then
      dbms_output.put_line('Упали на Get_Response 3.');
    end;
    
    /* Установка подкаталога */
    PKG_TRF_HTTPCLIENT.sSUBFOLDER := 'Connect';
    
    /* Построковое формирование clob по полученному htlm */
    --PKG_TRF_HTTPCLIENT.SaveFile(nNUMB => 3);
    
    --PKG_TRF_HTTPCLIENT.InsertTable;

    if instr(PKG_TRF_HTTPCLIENT.cHTML,'loginPage.do') >0 then
      Result := false;
    end if;
    
    /* Завершение запроса */
    begin
      utl_http.end_response(PKG_TRF_HTTPCLIENT.uRESPONSE);
    exception
     when others then
      dbms_output.put_line('Упали на end_response 3.');
    end;
    
    return Result;
    
  end CONNECTED;    
    
  /* Процедура подключения к https://uslugi.beeline.ru */
  procedure LOAD_DETAIL
  is
    nCONNECT  boolean;
    cTEMP          clob := null;
    nPAUSED        integer := 0;
    Result         boolean := true;
    sPASS          varchar2(20) := '32503250';
  begin    
    
    nCONNECT := CONNECTED(null, null);
    
    ----------------------------- 4 -----------------------
    /* Инициализация параметров */
    PKG_TRF_HTTPCLIENT.Init(false);
        
    /* Установка подкаталога */
    PKG_TRF_HTTPCLIENT.sSUBFOLDER := 'Connect';
    
    PKG_TRF_HttpClient.RestoreCookies(PKG_TRF_HTTPCLIENT.nSESSION);
    
    PKG_TRF_HTTPCLIENT.sURL := 'https://uslugi.beeline.ru/OnLoadSubscriberProfileFilterAction.do';

    /* Подготовка запроса */
    PKG_TRF_HTTPCLIENT.Begin_Request(PKG_TRF_HttpClient.sURL);
    
    PKG_TRF_HTTPCLIENT.sREQUEST_TEXT := null;
    
    /* Подготовка параметров заголовка запроса */
    PKG_TRF_HTTPCLIENT.Set_Header(sREFEREF => 'https://uslugi.beeline.ru/navigateMenu.do');

    /* Получение ответа с сайта по запросу */
    begin
      PKG_TRF_HTTPCLIENT.Get_Response;
    exception
     when others then
      dbms_output.put_line('Упали на Get_Response 4.');
    end;
    
    /* Построковое формирование clob по полученному htlm */
    PKG_TRF_HTTPCLIENT.SaveFile(nNUMB => 1);
    
    PKG_TRF_HTTPCLIENT.InsertTable;

    /* Завершение запроса */
    begin
      utl_http.end_response(PKG_TRF_HTTPCLIENT.uRESPONSE);
      cTEMP := PKG_TRF_HTTPCLIENT.ExtractDataFromString(PKG_TRF_HTTPCLIENT.cHTML, 'Информация</td></tr>','</tr></table>');
    exception
     when others then
      dbms_output.put_line('Упали на end_response 4.');
    end;
    
    
    -----------------------------4.2 страница номеров--------------------------------------
    /* Инициализация параметров */
    PKG_TRF_HTTPCLIENT.Init(false);
        
    /* Установка подкаталога */
    PKG_TRF_HTTPCLIENT.sSUBFOLDER := 'Connect';
    
    PKG_TRF_HttpClient.RestoreCookies(PKG_TRF_HTTPCLIENT.nSESSION);
    
    PKG_TRF_HTTPCLIENT.sURL := 'https://uslugi.beeline.ru/OnLoadSubscriberProfileFilterAction.do';

    /* Подготовка запроса */
    PKG_TRF_HTTPCLIENT.Begin_Request(PKG_TRF_HttpClient.sURL);
    
    PKG_TRF_HTTPCLIENT.sREQUEST_TEXT := null;
    
    /* Формирование параметров запроса */
    PKG_TRF_HTTPCLIENT.AddRequestParameter('_stateParam','SubscriberService.SubscriberStateDataFilter=0_;Tree:orgRepl.selected=0;breadCrumbs.breadCrumbDO1=0_1_;hierarchyTree:orgRepl.effectiveDate=1348410575555;hierarchyTree:orgRepl.pointLogicalId=0;Tree:orgRepl.treeExpandedList=3_;SubscriberService.subscriberListtableSelections=0_;multi-level:menu.pointLogicalId=4;eCareLocale.currentLocale=ru_RU__Russian;breadCrumbs.breadCrumbsSize=1;hierarchies:hierarchiesRepl1.pointLogicalId=1');
    PKG_TRF_HTTPCLIENT.AddRequestParameter('_forwardName','');
    PKG_TRF_HTTPCLIENT.AddRequestParameter('_resetBreadCrumbs','');
    PKG_TRF_HTTPCLIENT.AddRequestParameter('_expandStatus','');
    PKG_TRF_HTTPCLIENT.AddRequestParameter('status.code','G');
    PKG_TRF_HTTPCLIENT.AddRequestParameter('subscriberNumber','');
    PKG_TRF_HTTPCLIENT.AddRequestParameter('pricePlan','');
    PKG_TRF_HTTPCLIENT.AddRequestParameter('subscriberListExtExportVar','');
    PKG_TRF_HTTPCLIENT.AddRequestParameter('ctrla','subscriberListExt=Page=1');

    /* Подготовка параметров заголовка запроса */
    PKG_TRF_HTTPCLIENT.Set_Header(sREFEREF => 'https://uslugi.beeline.ru/OnLoadSubscriberProfileFilterAction.do');
    
    /* Получение ответа с сайта по запросу */
    begin
      PKG_TRF_HTTPCLIENT.Get_Response;
    exception
     when others then
      dbms_output.put_line('Упали на Get_Response 4.2');
    end;
    
    /* Построковое формирование clob по полученному htlm */
    PKG_TRF_HTTPCLIENT.SaveFile(nNUMB => 1);
    
    PKG_TRF_HTTPCLIENT.InsertTable;

    /* Завершение запроса */
    begin
      utl_http.end_response(PKG_TRF_HTTPCLIENT.uRESPONSE);
      cTEMP := PKG_TRF_HTTPCLIENT.ExtractDataFromString(PKG_TRF_HTTPCLIENT.cHTML, 'Информация</td></tr>','</tr></table>');
    exception
     when others then
      dbms_output.put_line('Упали на end_response 4.2');
    end;
  
    
    PKG_TRF_HTTPCLIENT.DropDirectory;    
    
    
    ----------------------------- 5 -----------------------
    /* Цикл по активным номерам (не заблокированным) */
    /*for rec in (select substr(z.str,1,length(z.str)-1) as str,
                       substr(replace(substr(z.typ, instr(z.typ,'<td>')),'<td>',''),1,10) as phone,
                       instr(z.typ,'Активный') as typ,
                       instr(z.typ,'Блокированный') as mtyp
                 from (select replace(replace(utl_url.escape(to_char(regexp_substr(cTEMP, 'name=\S+', 1, level))),'+','%2B'),'name=''','') str,
                              to_char(regexp_substr(cTEMP, '<tr \S+ \S+ \S+ \S+ \S+ \S+ \S+ \S+ \S+ \S+ \S+ \S+ \S+ \S+ \S+ ', 1, level)) typ
                       from dual
                        connect by level <= regexp_count(cTEMP, 'name=\S+')) z
                  \*where instr(z.typ,'Активный') > 0*\)
    loop
      
    if rec.typ = 0 and rec.mtyp > 0 then
      dbms_output.put_line('Блок: '||rec.phone);
    elsif rec.typ = 0 and rec.mtyp = 0 then
      dbms_output.put_line('Ошибка статуса номера: '||rec.phone);
    else
      dbms_output.put_line('Актив: '||rec.phone);
      
      \* Инициализация параметров *\
      PKG_TRF_HTTPCLIENT.Init(false);
          
      PKG_TRF_HttpClient.RestoreCookies(PKG_TRF_HTTPCLIENT.nSESSION);
      
      PKG_TRF_HTTPCLIENT.sURL := 'https://uslugi.beeline.ru/SubscriberProfileFilterSwitchingAction.do';
  
      \* Подготовка запроса *\
      PKG_TRF_HTTPCLIENT.Begin_Request(PKG_TRF_HttpClient.sURL);
      
      PKG_TRF_HTTPCLIENT.sREQUEST_TEXT := null;
      
      \* Формирование параметров запроса *\
      PKG_TRF_HTTPCLIENT.AddRequestParameter('_stateParam','SubscriberService.SubscriberStateDataFilter%3D0_%3BTree%3AorgRepl.selected%3D0%3BbreadCrumbs.breadCrumbDO1%3D0_1_%3BhierarchyTree%3AorgRepl.effectiveDate%3D1345909844390%3BhierarchyTree%3AorgRepl.pointLogicalId%3D0%3BTree%3AorgRepl.treeExpandedList%3D3_%3BSubscriberService.subscriberListtableSelections%3D0_%3Bmulti-level%3Amenu.pointLogicalId%3D4%3BeCareLocale.currentLocale%3Dru_RU__Russian%3BbreadCrumbs.breadCrumbsSize%3D1%3Bhierarchies%3AhierarchiesRepl1.pointLogicalId%3D1');
      PKG_TRF_HTTPCLIENT.AddRequestParameter('_forwardName','manageServices');
      PKG_TRF_HTTPCLIENT.AddRequestParameter('_resetBreadCrumbs','null');
      PKG_TRF_HTTPCLIENT.AddRequestParameter('_expandStatus','');
      PKG_TRF_HTTPCLIENT.AddRequestParameter('status.code','G');
      PKG_TRF_HTTPCLIENT.AddRequestParameter('subscriberNumber','');
      PKG_TRF_HTTPCLIENT.AddRequestParameter('pricePlan','');
      PKG_TRF_HTTPCLIENT.AddRequestParameter('subscriberListExtExportVar','null%21%CD%EE%EC%E5%F0+%F2%E5%EB%E5%F4%EE%ED%E0%21%C4%E0%F2%E0+%E0%EA%F2%E8%E2%E0%F6%E8%E8%21%D2%E5%EA%F3%F9%E8%E9+%F2%E0%F0%E8%F4%ED%FB%E9+%EF%EB%E0%ED%21%C1%F3%E4%F3%F9%E8%E9+%F2%E0%F0%E8%F4%ED%FB%E9+%EF%EB%E0%ED%21%C4%E0%F2%E0+%F1%EC%E5%ED%FB+%F2%E0%F0%E8%F4%ED%EE%E3%EE+%EF%EB%E0%ED%E0%21%D1%F2%E0%F2%F3%F1%21%C4%E0%F2%E0+%F1%EC%E5%ED%FB+%F1%F2%E0%F2%F3%F1%E0%21%CF%F0%E8%F7%E8%ED%E0+%EF%EE%F1%EB%E5%E4%ED%E5%E3%EE+%E8%E7%EC%E5%ED%E5%ED%E8%FF%21%C8%ED%F4%EE%F0%EC%E0%F6%E8%FF%3DEMPTY_PROPERTY%21subscriberNumber%21initActDate%21currentPP%21futurePP%21futurePPDate%21subStatusDesc%21subStatusDate%21actCodeRsnDesc%21viewLinkStr%3Dcom.cc.framework.ui.model.imp.ColumnCheckboxDesignModelImp%21com.cc.framework.ui.model.imp.ColumnTextDesignModelImp%21com.amdocs.css.core.infra.table.EcareColumnHtmlDesignModelImp%21com.cc.framework.ui.model.imp.ColumnTextDesignModelImp%21com.cc.framework.ui.model.imp.ColumnTextDesignModelImp%21com.amdocs.css.core.infra.table.EcareColumnHtmlDesignModelImp%21com.cc.framework.ui.model.imp.ColumnTextDesignModelImp%21com.amdocs.css.core.infra.table.EcareColumnHtmlDesignModelImp%21com.cc.framework.ui.model.imp.ColumnTextDesignModelImp%21com.cc.framework.ui.model.imp.ColumnLinkDesignModelImp%3Dnull%21null%21com.amdocs.css.vip.infra.table.VIPDateDecorator%21null%21null%21com.amdocs.css.vip.infra.table.VIPDateDecorator%21null%21com.amdocs.css.vip.infra.table.VIPDateDecorator%21null%21null');
      PKG_TRF_HTTPCLIENT.AddRequestParameter(rec.str,'on');
      
      \* Подготовка параметров заголовка запроса *\
      PKG_TRF_HTTPCLIENT.Set_Header(sREFEREF => 'https://uslugi.beeline.ru/OnLoadSubscriberProfileFilterAction.do');
  
      \* Получение ответа с сайта по запросу *\
      begin
        PKG_TRF_HTTPCLIENT.Get_Response;
      exception
       when others then
        dbms_output.put_line('Упали на Get_Response 5.');
      end;
      
      \* Установка подкаталога *\
      PKG_TRF_HTTPCLIENT.sSUBFOLDER := 'Connect';
      
      \* Построковое формирование clob по полученному htlm *\
      PKG_TRF_HTTPCLIENT.SaveFile(nNUMB => 2);
      
      PKG_TRF_HTTPCLIENT.InsertTable;
  
      \* Завершение запроса *\
      begin
        utl_http.end_response(PKG_TRF_HTTPCLIENT.uRESPONSE);
      exception
       when others then
        dbms_output.put_line('Упали на end_response 5.');
      end;

    end if;
    
    end loop;*/
    
  end LOAD_DETAIL;

end PKG_TRF_BEELINE;
/

