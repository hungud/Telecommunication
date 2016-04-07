
  CREATE OR REPLACE PACKAGE "CORP_MOBILE"."RUBY_ROBOT_PCKG_AFR" 
AS
   --#Version=2
   --
   --v1  17,10,2014 -Афросин А.Ю. - вынес роботов Ruby в один пакет
   --
   -- новый кабинет Билайна.
   --v2 03.12.2014 Алексеев. Дабавлены функции определения количества считанных строк файла и самих данных

   --СОЗДАЕМ СОЕДИНЕНИЕ
   FUNCTION create_conn (lgn           IN     VARCHAR2,
                         pss           IN     VARCHAR2,
                         report_type   IN     NUMBER,
                         answer           OUT BLOB,
                         phone         IN     VARCHAR2 DEFAULT 0,
                         year_month in varchar2 default 0
                         )
      RETURN VARCHAR2;

   --ПИШЕМ В ЛОГИ
   PROCEDURE create_rpt_log_tbl (report_type    IN NUMBER,
                                 p_account_id   IN NUMBER,
                                 blFile         IN BLOB,
                                 filename       IN VARCHAR2);
    
   --определяем количество считанных из файла записей
   function Get_Count_Loader return integer;
   
   --считываем данные файла
   function Get_Loader(pLoad number) return varchar2;
END;
CREATE OR REPLACE PACKAGE BODY "CORP_MOBILE"."RUBY_ROBOT_PCKG_AFR" AS
  
  Divider varchar2(1):=chr(59);--разделитель
  NDS number:=1.18; --Ставка НДС
  const_year_month number; -- текущий месяц-год
  SQ_Value integer;  --Текущее значение Sequnce
  type Rheader is record (h_name varchar2(50)
                         ,h_value varchar2(200));
  type header_table is table of Rheader INDEX BY binary_integer;
  type loader_table is table of varchar2(1000) INDEX BY binary_integer;
  Tloader           loader_table;--данные аттачмента html
  Theader           header_table;--заголовки html
  TsiteAddr         loader_table;
  TempField varchar2(300);
  ServerCount integer;--Сайты для загрузки
/*======для технических загрузок======*/
  type Rcollector is record(p_n varchar2(15)
                           ,ban varchar2(15)
                           ,acc integer);
  type Tcollector_table is table of Rcollector INDEX BY binary_integer; 
  collector_table   Tcollector_table;                                                   
/*===переменные для частных случаев===*/
  Snum_Rep varchar2(15); --для передачи параметра
  Sobj_ids varchar2(500);
  Syear_month varchar2(200);
/*=======*/

/**/
/*=======================================*/
/*=============== Подключение ===========*/
/*=======================================*/
function create_conn (lgn in varchar2,
                      pss in varchar2,
                      report_type in  number,--6 ReportData,1 Payments ,7 Lock Phone
                      answer out blob,
                      phone in varchar2 default 0,
                      year_month in varchar2 default 0
                      ) return varchar2
is
  err        varchar2(1000);
  req        utl_http.req;--запрос
  resp       utl_http.resp;--ответ
  urls       varchar2(1000);
  header     Rheader;
  i          number;
  --
  raw_buf raw(32767);
  line    varchar2(1000);
  pSourceCharSetRaw varchar2(30);
  pTargetCharSetRaw varchar2(30);
  pSourceCharSetTLoad varchar2(30);
  pTargetCharSetTLoad varchar2(30);
  pCountSourceSetRaw integer;
  pCountTargetSetRaw Integer;
  pCountSourceSetTLoad integer;
  pCountTargetSetTLoad integer;
  pFileType INTEGER;

  procedure read_headers is --читаем заголовки
    begin
      for n in 1..utl_http.get_header_count(resp)
        loop
           utl_http.get_header(resp, n,header.h_name , header.h_value);
           Theader(n).h_name:=header.h_name;
           Theader(n).h_value:=header.h_value;
        end loop;
    exception when others  then null;
    end;-- заголовки закончились

begin

  begin --создаем подключение
    for c in 1..3 loop  --три попытки соединиться
      SQ_Value:=sq_get_server.nextval;
     
      select ACCOUNT_LOAD_TYPE_URL into urls from ACCOUNT_LOAD_TYPES where ACCOUNT_LOAD_TYPE_ID = report_type;
     
      urls := TsiteAddr(mod(SQ_Value,ServerCount)+1) || urls;
     
      urls := Replace(urls, '%LOGIN%', lgn);  
      urls := Replace(urls, '%PASSWORD%', pss);
      urls := Replace(urls, '%START_DATE%', to_char(sysdate-nvl(MS_PARAMS.GET_PARAM_VALUE('LOADER_N_PAYMENTS_DAY'),0),'DD.MM.YY'));
      urls := Replace(urls, '%END_DATE%', to_char(sysdate,'DD.MM.YY'));
      urls := Replace(urls, '%NUM_REP%', Snum_rep);
      urls := Replace(urls, '%DD_MM_YYYY_-DD_MM_YYYY%', Syear_month);
      urls := Replace(urls, '%OBJ%', Sobj_ids);
      urls := Replace(urls, '%PHONE_NUMBER%', phone);
      urls := Replace(urls, '%YYYYMM%', year_month);

      begin
        utl_http.set_transfer_timeout(MS_PARAMS.GET_PARAM_VALUE('USS_BEELINE_LOADER_TIME_OUT'));--установка таймаута 5 минут. ( под ? )
        req:= utl_http.begin_request(urls);
        utl_http.set_body_charset(req,'UTF-8');
        resp := utl_http.get_response(req);
        if resp.status_code>0 then 
          exit;
        end if;--если есть результат соединения выходим
      exception
        when others then --если соединение не прошло, пробуем ещё 2 раза, с паузой 20 сек.
          if c<3 then 
            dbms_lock.sleep(20);
          else
            err := resp.status_code||' Error! Соединение сорвалось! '||chr(13)||sqlerrm;
            return(err);
          end if;
      end;
    end loop;
     
    if resp.status_code=400 then--если ошибка сервиса - вылетаем, с первой строкой.
      utl_http.read_line(resp,err);
      read_headers;
      UTL_HTTP.END_RESPONSE(resp);
      return(err||' Code:400');
    end if;
  exception  --резервное закрытие соединения, на всякий случай.
    when others then
      err := err||'Код:'||nvl(resp.status_code,0);
      if nvl(resp.status_code,0)>0 then 
       UTL_HTTP.END_RESPONSE(resp);
      end if;
     
      err:=err||' Error! Соединение не случилось, файл не создан! '||chr(13)||sqlerrm;
      return(err);
  end;--подключение создалось


  begin --забираем приложенные данные в blob для логирования
        -- и временную таблицу для внесения в базу
        
    --определяем типы файлов
    select FILES_LOAD_TYPES_ID
    into pFileType 
    from ACCOUNT_LOAD_TYPES 
    where ACCOUNT_LOAD_TYPE_ID = report_type;
    
    --определяем кодировки для лога
    select count(SOURCE_CHAR_SET_RAW) into pCountSourceSetRaw from ACCOUNT_LOAD_TYPES where ACCOUNT_LOAD_TYPE_ID = report_type;
    select count(TARGET_CHAR_SET_RAW) into pCountTargetSetRaw from ACCOUNT_LOAD_TYPES where ACCOUNT_LOAD_TYPE_ID = report_type;
    if pCountSourceSetRaw <> 0 then
      select SOURCE_CHAR_SET_RAW into pSourceCharSetRaw from ACCOUNT_LOAD_TYPES where ACCOUNT_LOAD_TYPE_ID = report_type;
    end if;
    if pCountTargetSetRaw <> 0 then
      select TARGET_CHAR_SET_RAW into pTargetCharSetRaw from ACCOUNT_LOAD_TYPES where ACCOUNT_LOAD_TYPE_ID = report_type;
    end if;
    
    --определяем кодировки для для массива записей
    select count(SOURCE_CHAR_SET_TLOAD) into pCountSourceSetTLoad from ACCOUNT_LOAD_TYPES where ACCOUNT_LOAD_TYPE_ID = report_type;
    select count(TARGET_CHAR_SET_TLOAD) into pCountTargetSetTLoad from ACCOUNT_LOAD_TYPES where ACCOUNT_LOAD_TYPE_ID = report_type;
    if pCountSourceSetTLoad <> 0 then
      select SOURCE_CHAR_SET_TLOAD into pSourceCharSetTLoad from ACCOUNT_LOAD_TYPES where ACCOUNT_LOAD_TYPE_ID = report_type;
    end if;
    if pCountTargetSetTLoad <> 0 then
      select TARGET_CHAR_SET_TLOAD into pTargetCharSetTLoad from ACCOUNT_LOAD_TYPES where ACCOUNT_LOAD_TYPE_ID = report_type;
    end if;
            
    read_headers;
    dbms_lob.createtemporary(answer, true );
    i:=0;
    loop
      if pFileType = 1 then
        utl_http.read_line(resp,line);--чтение varchar2
      elsif pFileType = 2 then
        utl_http.read_raw(resp, raw_buf, 32767);  
      end if;
      
      --для лога
      if (pCountSourceSetRaw <> 0) and (pCountTargetSetRaw <> 0) then 
        raw_buf := utl_raw.cast_to_raw(convert(line,pTargetCharSetRaw,pSourceCharSetRaw));--преобразуем в raw-bufer
      elsif pFileType = 1 then
        raw_buf := utl_raw.cast_to_raw(line);
      end if;
      
      i:=i+1;
      --для массива записей
      if report_type = 5 and i>1 then
        if (pCountSourceSetTLoad <> 0) and (pCountTargetSetTLoad <> 0) then 
          Tloader(i) := replace(convert(line,pTargetCharSetTLoad,pSourceCharSetTLoad),';;','; ;');
        end if;
      elsif (pCountSourceSetTLoad <> 0) and (pCountTargetSetTLoad <> 0) then 
        Tloader(i) := convert(line,pTargetCharSetTLoad,pSourceCharSetTLoad);
      else 
        Tloader(i) := line;  
      end if;
      
      if  pFileType = 1 then
        dbms_lob.append(answer,raw_buf);--в blob        
      elsif pFileType = 2 then
        dbms_lob.writeappend(answer, utl_raw.length(raw_buf), raw_buf);--в blob excel файла   
      end if;
    end loop;
  exception
    when others then--в любом случае закрываем соединение
      UTL_HTTP.END_RESPONSE(resp);
  end;
  
  if dbms_lob.getlength(answer)!=0 and (not nvl(resp.status_code,999)>200) then
    return('OK'); --для добавления в базу
  elsif dbms_lob.getlength(answer)=0 then 
    Return('Нет содержимого! Код:'||resp.status_code||' '||sqlerrm);
  elsif nvl(resp.status_code,999)>200 then 
    Return('Ошибка соединения! Код:'||resp.status_code);
  end if;--для логирования заголовков
end;
/*=======================================*/
/*= Создание лога файлов в Blob таблицу =*/
/*=======================================*/
function  create_rpt_log_tbl (report_type in number, p_account_id in number, blFile in blob, filename in varchar2)
  return varchar2
  is
pragma autonomous_transaction;
begin

insert into loader_call_n_log
  (account_id, load_date, file_name, file_body,report_type)
values
  (p_account_id, sysdate, filename, blFile,report_type)
  ;

commit;
return('OK');
exception
  when others then return('Error!'||sqlerrm);
end;
procedure  create_rpt_log_tbl(report_type in number
                            , p_account_id in number
                            , blFile in blob
                            , filename in varchar2)is
var varchar2(1000);
begin
var:=create_rpt_log_tbl(report_type,p_account_id,blFile,filename);
if var='OK' then null; end if;
end;
/*=======================================*/
/*==== Создание лога загруженных файлов==*/
/*=======================================*/
function  create_rpt_log (report_type in number, account in varchar2, blFile in blob, filename in varchar2)
  return varchar2
  is
ft  utl_file.file_type;
sTIMESTAMP varchar2(50);
sDEBUGFOLDER varchar2(120);
sHTTPdir varchar2 (100);
nFLAG binary_integer:=0;
--
folder varchar2(20);
error varchar2(500);
clob_len integer;
pos integer:=1;
raw_buf raw(32767);
amount binary_integer := 32760;--шаг чтения blob
BEGIN
 case report_type
   when 9 then folder:='lock';
   when 10 then folder:='unlock';
   when 6 then folder:='report_data';
   when 1 then folder:='payments';
 end case;
sTIMESTAMP := to_char(sysdate,'hh')||'_'||to_char(sysdate,'mm')||'_'||to_char(sysdate,'ss');
sDEBUGFOLDER:=MS_PARAMS.GET_PARAM_VALUE('LOADER_LOG_DIR')||'\DB\'||const_year_month||'\'||account||'\'||folder;--dir на диске
sHTTPdir:='DIR'||account||sTIMESTAMP;--dir в oracle
nFLAG := PKG_TRF_FILEAPI.mkdirs(sDEBUGFOLDER);--создаём дерево
  if nFLAG>0 then
    execute immediate 'create or replace directory '||sHTTPDIR||' as '''||sDEBUGFOLDER||'''';
    execute immediate 'grant read, write on directory '||sHTTPDIR||' to public';
  end if;
error:='DIRECTORY CREATED!';--В случае ошибки акцент на том, что засоряем раздел directory
ft:=utl_file.fopen(UPPER(sHTTPDIR),filename,'W');
        clob_len := dbms_lob.getlength(blFile);
          while pos<clob_len loop--записываем содержимое в файл частями по 32кб
            dbms_lob.read(blFile, amount, pos, raw_buf);
            utl_file.put_raw(ft,raw_buf);
            pos:=pos+amount;
          end loop;
          --в конец записываем заголовки
          for i in Theader.first..theader.last loop--перебираем header
            utl_file.put_line(ft,Theader(i).h_name);
            utl_file.put_line(ft,Theader(i).h_value);
          end loop;
          utl_file.fCLOSE(ft);
execute immediate 'drop directory '||sHTTPDIR;
return('OK');
exception
when others then
  error:=error||sqlerrm;
  if utl_file.is_open(ft) then
    utl_file.fCLOSE(ft);
  end if;
  return(error);
end;

procedure  create_rpt_log(report_type in number
                            , p_account_id in number
                            , blFile in blob
                            , filename in varchar2)is
var varchar2(1000);
begin
var:=create_rpt_log(report_type,p_account_id,blFile,filename);
if var='OK' then null; end if;
end;

--определяем количество строк, считываемых из загруженного файла
function Get_Count_Loader return integer is
begin
    if Tloader is not null then
        return Tloader.last;
    else
        return 0;
    end if;
exception 
    when others  then null;
end; 

--считываем данные из загруженного файла 
function Get_Loader(pLoad number) return varchar2 is 
begin
    if pLoad <= Tloader.last then
        return to_char(Tloader(pLoad));
    end if;
exception 
    when others  then null;
end;

begin
  -- Initialization
  --Фиксы
  const_year_month:=to_number(to_char(sysdate,'YYYYMM'));
  --заполняем список серверов !!!! НУЖНО ЧТОБЫ СЕРВЕРА БЫЛО МИН. 3 шт.иначе нужно через ';'дублировать до3-х
 TempField:=MS_PARAMS.GET_PARAM_VALUE('ROBOT_SITE_ADRESS');
 ServerCount:=(LENGTH(MS_PARAMS.GET_PARAM_VALUE('ROBOT_SITE_ADRESS'))
    -LENGTH(REPLACE(MS_PARAMS.GET_PARAM_VALUE('ROBOT_SITE_ADRESS') , ';'))); --количество записей
  for n in 1..ServerCount
   loop
    TsiteAddr(n):= substr(TempField,1,instr(TempField,divider,1,1)-1);
    TempField:= substr(TempField,instr(TempField,divider,1,1)+1);
   end loop;
END;