CREATE OR REPLACE package PKG_TRF_HttpClient
is

  /* Константы пакета */
  sWALLET_DIR     constant  varchar2(100) := 'file:D:\Work\WALLET';
  sWALLET_PASS    constant  varchar2(100) := 'qwerty12345';
  sDBROOT         constant  varchar2(100) := 'D:\Work\HTTP_LOG';         -- корневая директория
  sTEMPERRORMESS  constant  varchar2(100) := 'Сессия закрыта';

  /* Блок оописания используемых объектов массива параметров запроса */
  type arr is record
  (
    id     binary_integer,
    name   varchar2(32000),
    value  varchar2(32000)
  );
  type arr_table is table of arr index by binary_integer;
  cARR   arr_table;
  IndexParams     integer := 1;          -- счетчик записей массива

  /* Переменный пакета */
  sLOADERNAME     varchar2(40);          -- имя обработчика
  dDATE           date;                  -- текущие дата и время
  sHTTP_DIR       varchar2(1000);        --
  sDATESTAMP      varchar2(100);         -- поддиректория (текущая дата)
  sTIMESTAMP      varchar2(100);         -- поддиректория (текущая время)
  sDBCATALOG      varchar2(1000);        -- директория ???
  sDEBUGFOLDER    varchar2(1000);        -- директория ошибок
  sSUBFOLDER      varchar2(100);         -- поддиректория
  sURL            varchar2(100);         -- адрес страницы (URL)
  nSESSION        integer;               -- идентификатор текущий сессии
  nID             integer;               -- идентификатор текущий сессии

  uREQUEST        utl_http.req;          -- запрос на сайт
  uRESPONSE       utl_http.resp;         -- ответ с сайта
  sREQUEST_TEXT   varchar2(32000);        -- параметизированный запрос

  sLOGIN          varchar2(1000);        -- логин
  sFILE           utl_file.file_type;    -- имя файла выгрузки
  sFILE_TYPE      varchar2(20);          -- Success/Failed

  sNAME           varchar2(1000);        -- имя параметра ответа
  sVALUE          varchar2(32000);        -- значение параметра ответа

  sLINE           varchar2(32767);       -- строка html
  cCLOB           clob;                  -- текст сайта с заголовком
  cHTML           clob;                  -- текст сайта html

  sLOGERROR       varchar2(100);         -- текст ошибки
  sERRORTEXT      varchar2(100);         -- текст ошибки

   /* Функция возврата значения параметра из XML */
  function ExtractDataFromXML
  (
    sXML   in varchar2,
    sPARAM in varchar2
  )
  return varchar2;


  /* Функция возврата подстроки */
  function ExtractDataFromString
  (
    sTEXT  clob,
    sBEG   in varchar2,
    sEND   in varchar2,
    nSTART  in integer default 1
  )
  return clob;


  /* Процедура инициализации параметров */
  procedure Init
  (
    nFLAG  in boolean default true
  );


  /* Процедура заполнения таблицы */
  procedure InsertTable;


  /* Процедура инициализации записи в файл */
  procedure SaveFile
  (
    sIN   in varchar2 default null,
    sOUT  in varchar2 default null,
    nNUMB in integer default 1
  );


  /* Процедура подготовки запроса */
  procedure Begin_Request
  (
    sURL  in varchar2,
    sMETHOD  in varchar default 'POST'
  );

  /* Процедура подготовки заголовка запроса */
  procedure Set_Header
  (
    sREFEREF  in varchar2 default null
  );


  /* Процедура формирования строки запроса */
  procedure AddRequestParameter
  (
   sNAME   in varchar2,
   sVALUE  in varchar2
  );


  /* Процедура получения ответа */
  procedure Get_Response;


  /* Процедура завершения запроса */
  procedure End_Response;


  /* Функция проверки возврата clob страницы */
  function IsValidResult
  return boolean;

  /* Функция сохранения куков */
  function SaveCookies
  return binary_integer;


  /* Процедура воостановления куков */
  procedure RestoreCookies
  (
    nSESSION  in binary_integer
  );


  /* Процедура формирования каталога */
  procedure MakeLoader;
  
  /* Процедура удаления каталога из directory */
  procedure DropDirectory;

end PKG_TRF_HttpClient;
/

CREATE OR REPLACE package body PKG_TRF_HttpClient
is

 /* Функция возврата значения параметра из XML */
 function ExtractDataFromXML
 (
 sXML in varchar2,
 sPARAM in varchar2
 )
 return varchar2
 is
 Result varchar2(4000);
 nBEG integer := 0;
 nEND integer := 0;
 begin

 /* Определение начального и конечного значения тега параметра */
 nBEG := instr(sXML,'<'||upper(sPARAM)||'>') + length(sPARAM) + 2;
 nEND := instr(sXML,'</'||upper(sPARAM)||'>');

 /* Формирование и вывод результата значения параметра */
 Result := substr(sXML, nBEG, nEND - nBEG);
 return Result;

 end ExtractDataFromXML;


 /* Функция возврата подстроки */
 function ExtractDataFromString
 (
 sTEXT in clob,
 sBEG in varchar2,
 sEND in varchar2,
 nSTART in integer default 1
 )
 return clob
 is
 Result clob;
 nBEG integer := 0;
 nEND integer := 0;
 cTMP clob := null;
 begin

 /* Определение начального и конечного значения тега параметра */
 nBEG := instr(sTEXT,sBEG,nSTART) + length(sBEG);

 cTMP := substr(sTEXT,nBEG,length(sTEXT)-nBEG+1);

 nEND := instr(cTMP,sEND);

 /* Формирование и вывод результата значения параметра */
 Result := substr(cTMP, 1, nEND-1);
 return Result;

 end ExtractDataFromString;


 /* Процедура инициализации параметров */
 procedure Init
 (
 nFLAG in boolean default true
 )
 is
 begin
 sURL := null;
 cCLOB := null;
 cHTML := null;
 uRESPONSE := null;
 uREQUEST := null;
 sFILE_TYPE := null;
 sREQUEST_TEXT := null;
 IndexParams := 1;
 nID := null;
 sLOGERROR := null;
 sERRORTEXT := null;

 /* Инициализация сертификатов */
 utl_http.set_wallet(sWALLET_DIR, sWALLET_PASS);
 
 if nFLAG = true then
 sTIMESTAMP := null;
 sDATESTAMP := null;
 sHTTP_DIR := null;
 end if;

 end Init;


 /* Процедура заполнения таблицы */
 procedure InsertTable
 is
 begin

 nID := gen_id;

 insert into pars_test(text,url,n, ses, header_param)
 values (cHTML, sURL, nID, nSESSION, cCLOB);
 commit;
 end InsertTable;


 /* Процедура записи в файл */
 procedure SaveFile
 (
 sIN in varchar2 default null,
 sOUT in varchar2 default null,
 nNUMB in integer default 1
 )
 is
 sFILENAME varchar2(40);
 begin

 if nNUMB = 1 then
 MakeLoader;
 end if;

 begin

 /* Инициализация переменных */
 cCLOB := null;
 cHTML := null;
 sLINE := null;
 dDATE := sysdate;


 /* Подготовка имени файла */
 sFILENAME := to_char(dDATE,'yyyymmdd-hhmmss')||sFILE_TYPE||'_'||trim(to_char(nNUMB))||'.htm';
 sFILE := utl_file.fopen(sHTTP_DIR, sFILENAME, 'w', 32767);

 /* Формируем заголовок страницы */
 cCLOB := '<PRE>'||CHR(10)||
 '<meta http-equiv="Content-Type" content="text/html; charset=utf-8">'||CHR(10)||
 'GET URL: '||sURL||CHR(10)||
 'Request: '||sREQUEST_TEXT||CHR(10)||
 'Status: '||uRESPONSE.status_code||CHR(10)||
 '--- Response Headers: ---';

 /* Запись в файл */
 utl_file.put_line(sFILE, cCLOB);

 /* Формируем список параметров для заголовка страницы */
 for n in 1..utl_http.get_header_count(uRESPONSE)
 loop
 utl_http.get_header(uRESPONSE, n, sNAME, sVALUE);
 cCLOB:= cCLOB||CHR(10)||sNAME||': '||sVALUE;
 utl_file.put_line(sFILE, sNAME||': '||sVALUE);
 end loop;

 /* Завершение заголовка страницы */
 cCLOB := cCLOB||CHR(10)||CHR(10)||'</PRE>';
 utl_file.put_line(sFILE, CHR(10)||CHR(10)||'</PRE>');

 /* Построковое формирование clob по полученному htlm-коду для вставки в таблицу */
 begin
 loop
 utl_http.read_line(uRESPONSE, sLINE, true);
 sLINE := utl_i18n.unescape_reference(sLINE);
 cCLOB:=cCLOB||CHR(10)||sLINE;
 cHTML:=cHTML||CHR(10)||sLINE;
 utl_file.put_line(sFILE, sLINE);
 end loop;
 exception
 when utl_http.end_of_body then
 dbms_output.put_line('!!! - '||sqlerrm);
 when others then
 dbms_output.put_line(sqlerrm);
 end;

 if sIN is not null and instr(cHTML, sIN) = 0 then
 dbms_output.put_line(sOUT);
 sERRORTEXT := sOUT;
	 end if;

 /* Завершение работы с файлом */
 utl_file.fclose(sFILE);

 dbms_output.put_line('Файл успешно сформирован: '||sFILENAME);
 
 exception
 when others then
 dbms_output.put_line('Ошибка при формировании файла: '||sqlerrm||'. '||sSUBFOLDER||'_'||sTIMESTAMP);
 utl_file.fclose(sFILE);
 end;

 end SaveFile;


 /* Процедура подготовки запроса */
 procedure Begin_Request
 (
 sURL in varchar2,
 sMETHOD in varchar default 'POST'
 )
 is
 begin
 dbms_output.put_line('*****************************************************');
 begin
 dbms_output.put_line('Начало запроса '||sURL);
 uREQUEST := utl_http.begin_request(sURL, sMETHOD, utl_http.HTTP_VERSION_1_1);
 exception
 when utl_http.request_failed then
 dbms_output.put_line('Request_Failed: '||utl_http.get_detailed_sqlerrm);
 utl_http.end_request(uREQUEST);
 when utl_http.http_server_error then
 dbms_output.put_line('Http_Server_Error: ' ||utl_http.get_detailed_sqlerrm);
 utl_http.end_request(uREQUEST);
 when utl_http.http_client_error then
 dbms_output.put_line('Http_Client_Error: '||utl_http.get_detailed_sqlerrm);
 utl_http.end_request(uREQUEST);
 when others then
 dbms_output.put_line('Ошибка запроса: '||sqlerrm);
 utl_http.end_request(uREQUEST);
 end;
 end Begin_Request;


 /* Процедура подготовки заголовка запроса */
 procedure Set_Header
 (
 sREFEREF in varchar2 default null
 )
 is
 begin
 begin
 dbms_output.put_line('Установка заголовка');
 utl_http.set_body_charset('windows-1251');
 utl_http.set_header(uREQUEST, 'Accept-Language', 'ru,en-us;q=0.5');
 utl_http.set_header(uREQUEST, 'Accept-Charset', 'windows-1251,utf-8;q=0.7,*;q=0.7');
 utl_http.set_header(uREQUEST, 'Accept', 'text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8');
 utl_http.set_header(uREQUEST, 'User-Agent', 'Mozilla/5.0 (Windows; U; Windows NT 6.1; ru; rv:1.9.2.15) Gecko/20110303 Firefox/3.6.15');
 utl_http.set_header(uREQUEST, 'Connection', 'Keep-Alive');
 utl_http.set_header(uREQUEST, 'Cache-Control', 'no-cache');
 utl_http.set_header(uREQUEST, 'Accept-Encoding', 'gzip, deflate');
 utl_http.set_header(uREQUEST, 'Content-Type', 'application/x-www-form-urlencoded');
 
 if length(sREQUEST_TEXT) > 0 then
 utl_http.set_header(uREQUEST, 'Content-Length', length(sREQUEST_TEXT));
 
 /* Добавление к заголовку параметров запроса */
 utl_http.write_text(uREQUEST, sREQUEST_TEXT);
 end if;
 
 if sREFEREF is not null then
 utl_http.set_header(uREQUEST, 'Referer', sREFEREF);
 end if;

 /* Установка количества попыток подключения */
 utl_http.set_follow_redirect(uREQUEST, 3);
 
 exception
 when others then
 dbms_output.put_line('Ошибка формирования заголовка: '||sqlerrm);
 end;
 end Set_Header;


 /* Процедура формирования строки запроса */
 procedure AddRequestParameter
 (
 sNAME in varchar2,
 sVALUE in varchar2
 )
 is
 begin

 /* Добавление символа конкатинации парамтров */
 if sREQUEST_TEXT is not null then
 sREQUEST_TEXT := sREQUEST_TEXT||'&';
 end if;

 /* Формирование строки параметра */
 sREQUEST_TEXT := sREQUEST_TEXT||sNAME||'='||sVALUE;

 /* Запись в массив параметров */
 cARR(IndexParams).id := IndexParams;
 cARR(IndexParams).name := sNAME;
 cARR(IndexParams).value := sVALUE;

 /* Инкремент счетчика записей массива параметров */
 IndexParams := IndexParams + 1;

 end AddRequestParameter;


 /* Процедура получения ответа */
 procedure Get_Response
 is
 begin
 begin
 uRESPONSE := utl_http.get_response(uREQUEST/*, true*/);
 dbms_output.put_line('Ответ получен. Статус ответа: '||uRESPONSE.status_code);
 exception
 when others then
 dbms_output.put_line('Ошибка ответа: '||sqlerrm);
 end;

 if uRESPONSE.status_code = utl_http.HTTP_OK then
 sFILE_TYPE := ' Success';
 else
 sFILE_TYPE := ' Failed';
 end if;

 end Get_Response;


 /* Процедура завершения запроса */
 procedure End_Response
 is
 begin
 utl_http.end_response(uRESPONSE);
 end;


 /* Функция проверки возврата clob страницы */
 function IsValidResult
 return boolean
 is
 Result boolean := true;
 begin

 /* Проверка clob страницы */
 if cHTML is null then
 Result := false;
 sLOGERROR := 'Нет данных.';
 -- проверка на закрытую сессию
 elsif instr(cHTML, sTEMPERRORMESS) > 0 then
 Result := false;
 sLOGERROR := sTEMPERRORMESS;
 -- проверка на
 elsif Instr(cHTML, 'Произошла ошибка при работе с системой') > 0 then
 Result := false;
 sLOGERROR := 'Произошла ошибка при работе с системой.';
 else
 Result := true;
 end if;

 return Result;

 end;


 /* Функция сохранения куков */
 function SaveCookies
 return binary_integer
 is
 cookies utl_http.cookie_table;
 secure varchar2(1);
 begin

 /* Получение куков с сайта */
 utl_http.get_cookies(cookies);

 /* Генерация идентификатора сессии */
 select session_id.nextval
 into nSESSION
 from dual;

 /* Цикл по полученным кукам с сайта */
 for i in 1..cookies.count
 loop

 /* Преобразование логического параметра в строку */
 if (cookies(i).secure) then
 secure := 'Y';
 else
 secure := 'N';
 end if;

 /* Вставка в таблицу */
 insert into my_cookies(session_id, name, value, domain, expire, path, secure, version)
 values(nSESSION, cookies(i).name, cookies(i).value,
 cookies(i).domain, cookies(i).expire, cookies(i).path, secure,
 cookies(i).version);
 end loop;
 commit; -- фиксация транзакции

 /* Возврат идентификатора текущей сессии */
 return nSESSION;
 
 end SaveCookies;


 /* Процедура воостановления куков */
 procedure RestoreCookies
 (
 nSESSION in binary_integer
 )
 as
 cookies utl_http.cookie_table;
 cookie utl_http.cookie;
 i integer := 1;
 begin
 /* Цикл по таблице куков с учетом номера текущей сессии */
 for rec in (select *
 from my_cookies t
 where t.session_id = nSESSION)
 loop

 /* Передача параметров кука */
 cookie.name := rec.name;
 cookie.value := rec.value;
 cookie.domain := rec.domain;
 cookie.expire := rec.expire;
 cookie.path := rec.path;
 cookie.version := rec.version;

 if (rec.secure = 'Y') THEN
 cookie.secure := TRUE;
 else
 cookie.secure := FALSE;
 end if;

 cookies(i) := cookie;

 /* Инкремент счетчика куков */
 i := i + 1;
 end loop;

 /* Очистка текущих куков сессии */
 utl_http.clear_cookies;

 /* Инициализация куков, полученных из таблицы */
 utl_http.add_cookies(cookies);

 end RestoreCookies;


 /* Процедура формирования каталога */
 procedure MakeLoader
 is
 nFLAG binary_integer := 0;
 dDATE date;
 sPR varchar2(1000);
 begin
 
 dDATE := sysdate;

 /* Формирование имени каталога по текущей дате и времени */
 sDATESTAMP := to_char(dDATE,'yyyy')||'_'||to_char(dDATE,'mm');
 sTIMESTAMP := to_char(dDATE,'hh')||'_'||to_char(dDATE,'mm')||'_'||to_char(dDATE,'ss');

 /* Формирование имени каталога в зависимости от оператора */
 if sLOADERNAME = 'megafon' then
 sDBCATALOG := sDBROOT||'\'||sDATESTAMP||'\Megafon\'||sLOGIN;
 sDEBUGFOLDER := sDBROOT||'\Debug\'||sDATESTAMP||
 '\Megafon\'||sLOGIN||'\'||sSUBFOLDER||'\'||sTIMESTAMP;
 else
 sDBCATALOG := sDBROOT||'\'||sDATESTAMP||'\Beeline\'||sLOGIN;
 sDEBUGFOLDER := sDBROOT||'\Debug\'||sDATESTAMP||
 '\Beeline\'||sLOGIN||'\'||sSUBFOLDER||'\'||sTIMESTAMP;
 end if;

 sDEBUGFOLDER := upper(sDEBUGFOLDER);

 /* Создание каталога */
 nFLAG := PKG_TRF_FILEAPI.mkdirs(sDEBUGFOLDER);
 sHTTP_DIR := upper(sSUBFOLDER||'_'||sTIMESTAMP);

 /* Динамическое создание директории для utl_file и раздача привелегий */
 dbms_output.put_line('sHTTP_DIR-'||sHTTP_DIR||', sDEBUGFOLDER-'||sDEBUGFOLDER);
 execute immediate 'create or replace directory '||sHTTP_DIR||' as '''||sDEBUGFOLDER||'''';
 execute immediate 'grant read, write on directory '||sHTTP_DIR||' to public';

 end MakeLoader;
 
 
 /* Процедура удаления каталога из directory */
 procedure DropDirectory
 is
 begin
 -- динамическое удаление ранее созданной директории для utl_file
 begin
 execute immediate 'drop directory '||sHTTP_DIR;
 exception
 when others then
 dbms_output.put_line('Ошибка при удалении директории '||sHTTP_DIR);
 end; 
 end;
 

end PKG_TRF_HttpClient;
/

