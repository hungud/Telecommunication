CREATE OR REPLACE PACKAGE LOADER_call_PCKG_N AS

--#Version=13
--
--v.13 16.02.2016  Афросин. Убрал задубливание при записи в BEELINE_LOADER_INF
--v.12 16.12.2015 Матюнин. Добавил возможность загрузки опций в несколько потоков для процедуры LOAD_PHONES_OPTIONS 
--v.11 12.08.2015 Алексеев. Внес изменения LOAD_OBJ_ID. Перед загрузкой данных по л/с добавил удаление всех номеров по данному л/с. 
--                                        Убрал обновление номера л/с, т.к. теперь производится только вставка.
--                                        Внес изменения create_conn. Добавил очищения Tloader.DELETE; Theader.DELETE;
--v.10 04.08.2015 Афросин. Добавил параметр pKOL_DAY в LOAD_ACCOUNT_PAYMENTS, задающий количество дней, за которое запрашиваем платежи
--9 08.07.2015 Алексеев. Поправил ошибку при определении интернет тарифа
--8 27.04.2015 Матюнин. Для интернет тарифов при блокировке отправляем сразу на сохранение (S1B)
--7 26.02.2014 Бакунов. Доработки:  добавлена процедура SET_OBJ_ID_BY_PHONE
--6 19.02.2015 Бакунов. Доработки:  LOAD_OBJ_ID и CREATE_CONN (добавлен необязательный параметр pPHONE_NUMBER).
--5 03.02.2014 Алексеев. В процедуру LOAD_ACCOUNT_BALANCE в случае отсутствия л/с производится вставка в табл. ACCOUNT_INFO
--4 21.01.2015 Крайнов. Отсечка переводов.
--3 17.11.2014 Крайнов. Поправка разбора детальных счетов.
--v2  29,09,2014 -Афросин А.Ю. - переделал ссылку на робота билайна с http://5.9.166.87 на parametr ROBOT_SITE_ADRESS_NEW
--
-- новый кабинет Билайна.
/*--создание соединения
function create_conn (lgn in varchar2,
                      pss in varchar2,
                      phone in varchar2 default 0,
                      report_type in  number,
                      answer out blob
                      ) return varchar2;
function  create_rpt_log_tbl (report_type in number, p_account_id in number, blFile in blob, filename in varchar2)
  return varchar2;                      
--логирует выгрузку
function create_rpt_log (report_type in number, account in varchar2, blFile in blob, filename in varchar2)
  return varchar2;*/
  
--проверяет готовность заказа на сайте Билайна.  
function get_status_complite(report_type in number,login in varchar2, pswd in varchar) return number;
--загружает отчет по текущим начислениям по л\с
  PROCEDURE LOAD_REPORT_DATA(
    pACCOUNT_ID IN INTEGER
    );
--закружает текущие начисления по всем л\с
Procedure load_report_data_all;

--загружает платежи по л\с
procedure LOAD_ACCOUNT_PAYMENTS(pACCOUNT_ID in number, pKOL_DAY in INTEGER default 3);

--Блокировка номера
function lock_phone(pACCOUNT_ID in varchar2,  
                    pPHONE_NUMBER in varchar2)
                    return varchar2;
--Разблокировка номера                    
function unlock_phone(pACCOUNT_ID in varchar2, 
                    pPHONE_NUMBER in varchar2)
                    return varchar2;      
--Загрузка статусов
procedure LOAD_ACCOUNT_PHONES_STATE(pACCOUNT_ID in number); 
--Тарифы загрузка
procedure UPDATE_ACCOUNT_TARIFFS(pACCOUNT_ID in number);
--обновление статусов
procedure UPDATE_ACCOUNT_PHONES_STATE(pACCOUNT_ID in number) ;
--Загрузка услуг
PROCEDURE LOAD_PHONES_OPTIONS(
  pACCOUNT_ID IN INTEGER,
  p_STREAM_ID in integer default null, 
  pCountSTREAM in integer default null    
);
--Загрузка OBJ_ID
PROCEDURE LOAD_OBJ_ID(
    pACCOUNT_ID IN INTEGER,
    pPHONE_NUMBER VARCHAR2 DEFAULT NULL
    );
--Загрузка списка готовых cчетов.    
procedure UPDATE_ACCOUNT_BILLS_PERIOD(pACCOUNT_ID in number);  
--
PROCEDURE LOAD_ALL_ACCOUNT_BALANCES;
--
PROCEDURE LOAD_ACCOUNT_BALANCE(
  pACCOUNT_ID IN INTEGER
  );
--Рзбор записей счёта
procedure PARSE_ACCOUNT_BILLS_API(pACCOUNT_ID IN INTEGER,pYearMonth in number,Pxml_file_id in number default 0);  
--Загрузка счетов старого образца    
    procedure LOAD_ACCOUNT_BILLS(
    pACCOUNT_ID IN INTEGER
    ,pYearMonth in number
    );
--Загрузка детальных счетов по номеру    
    procedure LOAD_PHONE_DETAIL_BILL(
    pPhone_number in varchar2
    ,pYearMonth in number
    );
    --загрузка детального счёта 
procedure LOAD_DETAIL_BILL(
    pAccount_id in number
    ,pYearMonth in number
    ,obj_list in varchar2
    );
--Добавление информации по коллектору
procedure pre_collector_acc;
procedure load_collector_acc(Pphone_number in varchar2,pban in varchar2,paccount_id in integer);
function post_collector_acc return varchar2;    
--Обновление полей статусов в db_loader_account_phones
procedure update_collector_state(Paccount_id in number, Pphone_number in varchar2,Pplan_code in varchar2, Pstate in varchar2, Pvalid_state in varchar2);

procedure SET_OBJ_ID_BY_PHONE( pPHONE_NUMBER VARCHAR2 );                            
END;
/

CREATE OR REPLACE PACKAGE BODY LOADER_call_PCKG_N AS
  
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
  TsiteAddr         loader_table;TempField varchar2(300);ServerCount integer;--Сайты для загрузки
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
                      phone in varchar2 default 0
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
      Tloader.DELETE;
      Theader.DELETE;
      
      case report_type
       when 10 then --разблокировка
       urls:= TsiteAddr(mod(SQ_Value,ServerCount)+1)||'/lock?bill='||lgn||chr(38)||'pas='||pss||chr(38)||'phone_number='||phone||chr(38)||'locking=false';
       when 9 then --блокировка
       urls:= TsiteAddr(mod(SQ_Value,ServerCount)+1)||'/lock?bill='||lgn||chr(38)||'pas='||pss||chr(38)||'phone_number='||phone||chr(38)||'locking=true';
       when 6 then --Report Data
       urls:= TsiteAddr(mod(SQ_Value,ServerCount)+1)||'/order?bill='||lgn||chr(38)||'pas='||pss;
       when 1 then--Payments
       urls :=TsiteAddr(mod(SQ_Value,ServerCount)+1)||'/payments?bill='||lgn||chr(38)||'pas='||pss||chr(38)||'start_date='||to_char(sysdate-nvl(MS_PARAMS.GET_PARAM_VALUE('LOADER_N_PAYMENTS_DAY'),0),'DD.MM.YY')||chr(38)||'end_date='||to_char(sysdate,'DD.MM.YY');
       when 3 then--Phone_states
       urls :=TsiteAddr(mod(SQ_Value,ServerCount)+1)||'/phone_states?bill='||lgn||chr(38)||'pas='||pss||chr(38)||'num_rep='||Snum_rep;
       when 31 then--Phone_statuses
       urls :=TsiteAddr(mod(SQ_Value,ServerCount)+1)||'/phone_statuses?bill='||lgn||chr(38)||'pas='||pss;
       when 4 then--Phone_options
       urls :=TsiteAddr(mod(SQ_Value,ServerCount)+1)||'/services_and_plans?bill='||lgn||chr(38)||'pas='||pss;
       when 5 then--AccountBills
       urls :=TsiteAddr(mod(SQ_Value,ServerCount)+1)||'/account_bill?bill='||lgn||chr(38)||'pas='||pss;
       when 51 then--Phone_OBJ_ID
        if  phone is not null  and  phone <> 0  then
              urls := TsiteAddr(mod(SQ_Value, ServerCount)+1) || '/bills?bill=' || lgn || chr(38) || 'pas=' || pss || chr(38) || 'phone=' || phone;
          else
              urls := TsiteAddr(mod(SQ_Value,ServerCount)+1) || '/bills?bill=' || lgn || chr(38) || 'pas=' || pss;
          end if;
       when 52 then--AccountBillsPeriods
       urls :=TsiteAddr(mod(SQ_Value,ServerCount)+1)||'/bills_period_ready?bill='||lgn||chr(38)||'pas='||pss;
       when 53 then--AccountTariffs
       urls :=TsiteAddr(mod(SQ_Value,ServerCount)+1)||'/account_tariff?bill='||lgn||chr(38)||'pas='||pss;
       when 7 then--PhoneDetailBill
       urls :=TsiteAddr(mod(SQ_Value,ServerCount)+1)||'/detail_bills?bill='||lgn||chr(38)||'pas='||pss||chr(38)||'year_month='||Syear_month||chr(38)||'obj='||Sobj_ids;
       when 17 then--AccountBalanses
       --urls :=TsiteAddr(mod(SQ_Value,ServerCount)+1)||'/balance?bill='||lgn||chr(38)||'pas='||pss;
--       urls :='http://5.9.166.87/balance?bill='||lgn||chr(38)||'pas='||pss;
--        urls :='http://beeline-api.tarifer.ru/balance?bill='||lgn||chr(38)||'pas='||pss;
        urls :=TsiteAddr(mod(SQ_Value,ServerCount)+1)||'/balance?bill='||lgn||chr(38)||'pas='||pss;
      end case;

          begin
          utl_http.set_transfer_timeout(MS_PARAMS.GET_PARAM_VALUE('USS_BEELINE_LOADER_TIME_OUT'));--установка таймаута 5 минут. ( под ? )
          req:= utl_http.begin_request(urls);
          utl_http.set_body_charset(req,'UTF-8');
          resp := utl_http.get_response(req);
          if resp.status_code>0 then exit;end if;--если есть результат соединения выходим
          exception
          when others then --если соединение не прошло, пробуем ещё 2 раза, с паузой 20 сек.
                      if c<3 then dbms_lock.sleep(20);else
                      err:=resp.status_code||' Error! Соединение сорвалось! '||chr(13)||sqlerrm;
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
      err:=err||'Код:'||nvl(resp.status_code,0);
      if nvl(resp.status_code,0)>0 then UTL_HTTP.END_RESPONSE(resp);end if;
      err:=err||' Error! Соединение не случилось, файл не создан! '||chr(13)||sqlerrm;
      return(err);
    end;--подключение создалось


  begin --забираем приложенные данные в blob для логирования
        -- и временную таблицу для внесения в базу
  read_headers;
    dbms_lob.createtemporary(answer, true );
    i:=0;
    loop
     utl_http.read_line(resp,line);--чтение varchar2
       if report_type in (1,9,10,31)--для лога
         then raw_buf:=utl_raw.cast_to_raw(convert(line,'CL8MSWIN1251','UTF8'));--преобразуем в raw-bufer
       else raw_buf:=utl_raw.cast_to_raw(line);
       end if;
     i:=i+1;
       if report_type in (3,4) --для массива записей
         then Tloader(i):=convert(line,'utf8','CL8MSWIN1251');
       elsif report_type=5 and i>1
         then Tloader(i):=replace(convert(line,'AL32UTF8','CL8MSWIN1251'),';;','; ;');
       else Tloader(i):=line;  
       end if;
     dbms_lob.append(answer,raw_buf);--в blob
    end loop;
  exception
      when others then--в любом случае закрываем соединение
      UTL_HTTP.END_RESPONSE(resp);
  end;
   if dbms_lob.getlength(answer)!=0 and (not nvl(resp.status_code,999)>200) then return('OK'); --для добавления в базу
     elsif dbms_lob.getlength(answer)=0 then Return('Нет содержимого! Код:'||resp.status_code||' '||sqlerrm);
     elsif nvl(resp.status_code,999)>200 then Return('Ошибка соединения! Код:'||resp.status_code);
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

/*=======================================*/
/*===== Проверка готовности отчета ======*/-- НЕ ИСПОЛЬЗУЕТСЯ
/*=======================================*/
function get_status_complite(report_type in number,login in varchar2, pswd in varchar) return number is
  req        utl_http.req;--запрос
  resp       utl_http.resp;--ответ
  url varchar2 (200);
  ord_rn varchar2(50);
  result number;
begin
  case report_type
    when 6 then url:=MS_PARAMS.GET_PARAM_VALUE('ROBOT_SITE_ADRESS') ||'/order_last?bill='||login||'&'||'pas='||pswd;
  end case;
  req  := utl_http.begin_request(url);
  utl_http.set_body_charset(req, 'UTF-8');
  resp := utl_http.get_response(req);
  utl_http.get_header_by_name(resp,'Order-Number',ord_rn);
  select 0 into result from dual where --если такой уже грузили, то возвращаем 1
  exists (select * from account_load_logs l where l.beeline_rn=ord_rn and l.is_success=1 and l.account_load_type_id=report_type);
  UTL_HTTP.END_RESPONSE(resp);
  return(result);
exception
  when others then UTL_HTTP.END_RESPONSE(resp); return(1); --если что-то загружаем
end;

/*=======================================*/
/*==== 6 ОТЧЁТ О ТЕКУЩИХ НАЧИСЛЕНИЯХ ====*/
/*=======================================*/
PROCEDURE LOAD_REPORT_DATA(
    pACCOUNT_ID IN INTEGER
    ) IS

method            varchar2(50);--проверка включения
--
log_EXCEPTION       EXCEPTION;
err                 varchar2(1000);
--
answer_mes blob;--выгрузка
--
plogin     VARCHAR2(30 CHAR);
pPASSWORD  VARCHAR2(30 CHAR);
account    number;
--
Snext_RN   varchar2(60);--номер заказанного отчёта
SRN        varchar2(60);--номер загружаемого отчёта
S_file_RN  varchar2(200);--загружаемый файл
counter    number:=0;
--
account_sum number:=0;--сумма по л\с для проверки перехода на сл. месяц

 --Парсинг строки и Вставка в таблицу через db_loader_pckg.SET_REPORT_DATA
          function insertstr(item varchar2, pars_type number) return varchar2  is
            rcReportData db_loader_report_data%rowtype;
            sMSG varchar2(200);
            sTMP varchar2(3000);
            sFld varchar2(200);
            nPozDivider number;
            nIndexField number;
          begin
            sTMP:=item||divider;
            nIndexField:=0;
            dbms_output.enable;
            loop--парсинг строки
              nPozDivider:=instr(sTMP,divider,1,1);
              sFld:= substr(sTMP,1,nPozDivider-1);
              sTMP:= substr(sTMP,nPozDivider+1);
              case nIndexField
                when 2 then rcReportData.Phone_Number:=trim(sFLD);--фед.номер
                when 3 then rcReportData.Detail_Sum:=to_number(replace(rtrim(sfld,chr(10)||chr(13)||chr(9)),',','.'), '9999999999.99')*nds;--сумма*НДС
                else null;
              end case;
              nIndexField:=nIndexField+1;
              exit when nPozDivider is null;
            end loop;
            --доп.поля
            rcReportData.Year_Month:=const_year_month;
            rcReportData.Date_Last_Update:=to_char(sysdate);
            /* вставляем  запись */
            if pars_type=1 then
              smsg:=(to_char(rcReportData.Year_Month)||','||to_char(rcReportData.Phone_Number)||','||
                to_char(rcReportData.Detail_Sum)||','||to_char(rcReportData.Date_Last_Update));
              db_loader_pckg.SET_REPORT_DATA(rcReportData.Phone_Number,rcReportData.Detail_Sum,to_char(sysdate,'DD.MM.YYYY-HH24:MI:SS'));
              return(sMSG);
            elsif pars_type=0 then
              return(rcReportData.Detail_Sum);
            end if;
          end;
  BEGIN
    counter:=0;
    SELECT login,nvl(new_pswd,password) password, ACCOUNT_NUMBER,n_method
      INTO plogin, ppassword                    ,ACCOUNT        ,method
      FROM ACCOUNTS WHERE ACCOUNT_ID=pACCOUNT_ID;
    --проверяем можно ли формировать...
    if strInLike(6,method,';','()')=0 then 
      err:=' Формирование отчета отключено! '; 
      raise log_EXCEPTION;
    end if;
   /* if get_status_complite(6,plogin,ppassword)=0
      then
    err:='Нет нового отчета!';
    raise log_EXCEPTION;end if;--если последний уже загружен - вылазим . */
    err:=create_conn(plogin,ppassword,6,answer_mes);--открываем соединение
    for i in Theader.first..theader.last loop--перебираем header
      if Theader(i).h_name='Next-Order-Number' then Snext_RN:= Theader(i).h_value;end if;--следующий
      if Theader(i).h_name='Order-Number' then SRN:= Theader(i).h_value;end if;
      if Theader(i).h_name='Order-Time' then
         if (sysdate-to_date(replace(Theader(i).h_value,' '),'DD HH24:MI'))>0.5 then
           err:='Error:Возраст загруженного отчёта больше 12 часов.';
           raise log_EXCEPTION;
         end if;
      end if;
    end loop;
    if Snext_RN is null then Snext_RN:='ЗАКАЗ НЕ ПРОИЗВЕДЁН!'; end if;
    if (length(trim(SRN)) is not null)
       then  S_file_RN:=SRN||'.csv'; else S_file_RN:='Err_'||to_char(nvl(pACCOUNT_ID,0));
    end if;
    if err='OK' then
      begin  --ПРОВЕРКА ГОТОВНОСТИ ОТЧЁТА - ЕСЛИ ТАКОЙ УЖЕ ГРУЗИЛИ ВЫЛЕТАЕМ
        select 0 into err 
          from dual 
          where exists (select * 
                          from account_load_logs l
                          where l.beeline_rn=SRN 
                            and l.is_success=1 
                            and l.account_load_type_id=6);
        if err='0' then 
          err:='Нет нового отчета!'; 
          raise log_EXCEPTION;
        end if;
      exception 
        when no_data_found then null;
      end;  --ПРОВЕРКА ГОТОВНОСТИ конец
      err:='';
    -- err:=create_rpt_log(6,account,answer_mes,S_file_RN);--создаём копию на диске
      err:=create_rpt_log_tbl(6,pACCOUNT_ID,answer_mes,S_file_RN);--создаём копию в базу
      if err!='OK' then 
        raise log_EXCEPTION;
      end if;
    else --если не прошло соединение вылетаем
      err:=err||' Ошибка соединения '||' LOG-'||create_rpt_log_tbl(6,pACCOUNT_ID,answer_mes,nvl(S_file_RN,'Error_'||pACCOUNT_ID));--создаём копию в базу
      raise log_EXCEPTION;
    end if;--соединение завершилось
  -------------------------------------
    --проверяем , если сообщение об ошибке или подобие xml то вылетаем
    if (instr(Tloader(1),'Error')>0)or(instr(Tloader(1),'<')>0) then
      err:=Tloader(1); raise log_exception;
    end if;
    --ЗАГРУЗКА ДАННЫХ
    --формирование журнала перехода на новый месяц
    for i in Tloader.first+1..Tloader.last loop
      if trim(Tloader(i))is not null then
        account_sum:=account_sum+to_number(replace(rtrim(insertstr(Tloader(i),0),chr(10)||chr(13)||chr(9)),',','.'), '9999999999.99');
        counter:=counter+1;
      end if;
    end loop;
        --добавление записи в журнал перехода на новый месяц
    pragma autonomous_transaction;
    begin
      UPDATE iot_acc_report_data_temp
        SET nsum = account_sum,load_date_time=sysdate
        WHERE account_id = pACCOUNT_ID and year_month=const_year_month;
      IF ( sql%rowcount = 0 ) THEN
        insert into iot_acc_report_data_temp(account_id, year_month, nsum, load_date_time)
          values(pACCOUNT_ID, const_year_month, account_sum,sysdate);
      END IF;
      commit;
    end;
    --сбрасываю счётчик
    counter:=0;
    --Загрузка данных в базу
    for c in (select distinct t.account_id from iot_acc_report_data_temp t
              where t.account_id=pACCOUNT_ID and t.can_load=1 and t.year_month=const_year_month)
    loop
      for i in Tloader.first+1..Tloader.last 
      loop--пропускаем заголовок
      --ищем информацию об ошибке в первой строке на случай если код ошибки был не 400
        if insertstr(Tloader(i),1)is not null then 
          counter:=counter+1;
        end if;
      end loop i;
    end loop c;
  --логируем успешное выполнение
    INSERT INTO ACCOUNT_LOAD_LOGS(ACCOUNT_LOAD_LOG_ID, ACCOUNT_ID, LOAD_DATE_TIME,
                           IS_SUCCESS, ERROR_TEXT, ACCOUNT_LOAD_TYPE_ID,BEELINE_RN)
      VALUES(NEW_ACCOUNT_LOAD_LOG_ID, pACCOUNT_ID, SYSDATE,
       1,'Ok! Add '||counter||' rows.'||' Заказан:'||Snext_RN, 6,SRN);commit;

  EXCEPTION --логируем неудачу
    when others then  --log_EXCEPTION в частности
      err:=err||' -- '||SQLERRM||'--'|| case
                                          when SQ_Value is null then ''
                                          else TsiteAddr(mod(SQ_Value,ServerCount)+1)
                                        end;
      INSERT INTO ACCOUNT_LOAD_LOGS(ACCOUNT_LOAD_LOG_ID, ACCOUNT_ID, LOAD_DATE_TIME,
                                 IS_SUCCESS, ERROR_TEXT, ACCOUNT_LOAD_TYPE_ID,BEELINE_RN)
        VALUES(NEW_ACCOUNT_LOAD_LOG_ID, pACCOUNT_ID, SYSDATE,
             0,err||decode(Snext_RN,null,'',' Заказан:')||Snext_RN, 6,SRN);
      commit;
  END;
--отчет о текущих начислениях по всем л\с
Procedure load_report_data_all is begin
  for c in (select distinct t.account_id idn from ACCOUNTS t)
  loop
    LOAD_REPORT_DATA(c.idn);
  end loop;
end;

procedure LOAD_ACCOUNT_PAYMENTS(
    pACCOUNT_ID in number,
    pKOL_DAY in INTEGER default 3
    ) is

method            varchar2(50);--проверка включения
--
log_EXCEPTION       EXCEPTION;
err                 varchar2(1000);
--
answer_mes blob;--выгрузка
--
plogin     VARCHAR2(30 CHAR);
pPASSWORD  VARCHAR2(30 CHAR);
account    number;
--
SRN        varchar2(30);--номер загружаемого отчёта
S_file_RN  varchar2(200);--загружаемый файл
NBalance   number; -- баланс по л\с.
counter    number:=0;

 --Парсинг строки и Вставка в таблицу через db_loader_pckg.SET_REPORT_DATA
          function insertstr(item varchar2) return varchar2  is
           rcLoaderPayments db_loader_payments%rowtype;
           sMSG varchar2(200);
              sTMP varchar2(3000);
              sFld varchar2(200);
            nPozDivider number;
            nIndexField number;
            paysign number;-- "1" взнос , "-1" съём
          begin
            sTMP:=replace(
                  replace(
                  replace(item,' ')--ТУТ НЕ ПРОБЕЛ А ВОЛШЕБНЫЙ СИМВОЛ HEX(A000)
                         ,'"')
                         ,',',divider)||divider;
            nIndexField:=0;
            dbms_output.enable;
            loop--парсинг строки
              nPozDivider:=instr(sTMP,divider,1,1);
              sFld:= substr(sTMP,1,nPozDivider-1);
              sTMP:= substr(sTMP,nPozDivider+1);
              case nIndexField
                when 0 then rcLoaderPayments.Payment_Date:=to_date(sFld,'DD.MM.YYYY');
                when 1 then select decode(sFld,
                                               'Платеж зачислен',1,
                                               'Перенос платежа c другого клиента',1,
                                               'Отмена возврата платежа',1,
                                               'Отмена платежа',-1,
                                               'Перенос платежа на другого клиента',-1,
                                               'Возврат платежа',-1)
                                               into paysign from dual;
                            select decode(paysign,-1,sfld,'')into rcLoaderPayments.Payment_Status_Text from dual;
                when 5 then rcLoaderPayments.Payment_Sum:=to_number(replace(rtrim(sfld,chr(10)||chr(13)||chr(9)),',','.'), '9999999999.99')*paysign;
                when 7 then rcLoaderPayments.Payment_Number:=sFld;
                when 8 then
                 sfld:=nvl(sfld,'0000000000');
                 select decode(sfld,'','0000000000',sfld) into sfld from dual;
                 rcLoaderPayments.Phone_Number:=rtrim(sfld,chr(10)||chr(13)||chr(9));
                else
                  null;
              end case;
              nIndexField:=nIndexField+1;
              exit when nPozDivider is null;
            end loop;
            /* доп. поля */
            select decode(paysign,-1,0,1) into rcLoaderPayments.Payment_Status_Is_Valid from dual;
            /*вставляем запись to_char(sysdate,'DD.MM.YYYY-HH24:MI:SS')*/        
            if rcLoaderPayments.Payment_Status_Text <> 'Перенос платежа на другого клиента' then        
              db_loader_pckg.ADD_PAYMENT(substr(to_char(const_year_month),1,4),to_char(rcLoaderPayments.Payment_Date,'MM'),plogin,rcLoaderPayments.Phone_Number
                ,rcLoaderPayments.Payment_Date,to_char(rcLoaderPayments.Payment_Sum),rcLoaderPayments.Payment_Number,rcLoaderPayments.Payment_Status_Is_Valid
                ,rcLoaderPayments.Payment_Status_Text); 
            end if;         
            smsg:='OK';
            return(sMSG);
          exception
            when others then 
              err:=err||' ParsErr^:nIndexField='||nIndexField||';
              sFld='||sFld||';
              sTMP='||sTMP||' Counter#'||counter;
          end;
BEGIN
    counter:=0;
    SELECT t.login,nvl(t.new_pswd,t.password) password, t.ACCOUNT_NUMBER,t.n_method
      INTO plogin, ppassword                    ,ACCOUNT        ,method
    FROM ACCOUNTS t WHERE t.ACCOUNT_ID=pACCOUNT_ID;
    
    --Проверяем нужно ли обновлять через АПИ
    if strInLike(111,nvl(method,'0;'),';','()')=1 
    then 
     EXECUTE IMMEDIATE  'begin :err := beeline_api_pckg.account_phone_payments(:pAccount_id, :pKOL_DAY); end;' USING OUT err, IN pACCOUNT_ID, pKOL_DAY;
    if regexp_instr(err,'Ok! Add \d+')>0 then 
      return;end if; --Если удача - вылетаем
 
    end if;
    
    --проверяем можно ли формировать...
    if strInLike(1,method,';','()')=0 then err:=' Формирование отчета отключено! '; raise log_EXCEPTION;end if;
   /* if get_status_complite(6,plogin,ppassword)=0
      then
    err:='Нет нового отчета!';
    raise log_EXCEPTION;end if;--если последний уже загружен - вылазим . */

    err:=create_conn(plogin,ppassword,1,answer_mes);--открываем соединение

    for i in Theader.first..theader.last 
    loop--перебираем header
      case Theader(i).h_name
        when 'Content-Disposition' then S_file_RN:= Theader(i).h_value;
        when 'Balance' then
          if upper(rtrim(Theader(i).h_value,chr(10)||chr(13)||chr(9)))='NULL' then 
            NBalance:=null;
          else
            null;--ниже не работает
            -- Nbalance:=to_number(replace(rtrim(Theader(i).h_value,chr(10)||chr(13)||chr(9)),',','.'), '9999999999.99');
          end if;
        else null;
      end case;
    end loop;

     if err='OK' then
       BEGIN
           --фиксируем баланс по л\с
          /* if nbalance is not null then
              DB_LOADER_PCKG.SAVE_BALANCE_CHANGE(plogin,NBalance);
           end if;*/
      ---
         if instr(S_file_RN,'attachment')>0 then --приложен файл
            S_file_RN:=ltrim(S_file_RN,'attachment; filename=');
            S_file_RN:=trim('"' from S_file_RN);
            S_file_RN:=ltrim(S_file_RN,'"RPT_UBC');-- срезаем системные символы
            SRN:=substr(s_file_rn,1,instr(s_file_rn,'_')-1);--номер заказа
         else--Ничего не приложено
         raise log_EXCEPTION;
         end if;
       exception
         when others then
         SRN:='Н\Д'||to_char(sysdate,'MMDD-MMSS');
         S_file_RN:=account||'_err.txt';--будет файл с ошибкой
       end;

     err:='';
       -- err:=create_rpt_log(6,account,answer_mes,S_file_RN);--создаём копию на диске
        err:=create_rpt_log_tbl(1,pACCOUNT_ID,answer_mes,S_file_RN);--создаём копию в базу
        if err!='OK' then raise log_EXCEPTION;end if;

     else --если не прошло соединение вылетаем
        raise log_EXCEPTION;
     end if;--соединение завершилось
  -------------------------------------
    --загрузка данных
     for i in Tloader.first..Tloader.last loop
       --ищем информацию об ошибке в первой строке на случай если код ошибки был не 400
       if ((instr(Tloader(i),'Error')>0) or (Tloader.last<2)) and (i=1) then err:=Tloader(i); raise log_exception;
       elsif i>1--опускаем заголовок таблицы
              then --добавляем в таблицу
              if insertstr(Tloader(i))is not null then counter:=counter+1;
                else raise log_EXCEPTION;
              end if;
       end if;
     end loop;
  --логируем успешное выполнение
  INSERT INTO ACCOUNT_LOAD_LOGS(ACCOUNT_LOAD_LOG_ID, ACCOUNT_ID, LOAD_DATE_TIME,
                         IS_SUCCESS, ERROR_TEXT, ACCOUNT_LOAD_TYPE_ID,BEELINE_RN)
  VALUES(NEW_ACCOUNT_LOAD_LOG_ID, pACCOUNT_ID, SYSDATE,
   1,'Ok! Add '||counter||' rows.', 1,SRN);commit;

  EXCEPTION --логируем неудачу
    when others then  --log_EXCEPTION в частности
      IF SUBSTR(err, 2, 12)='Дата платежа' THEN
        err:='Ok! Add 0 rows. New site. '||err;
        INSERT INTO ACCOUNT_LOAD_LOGS(ACCOUNT_LOAD_LOG_ID, ACCOUNT_ID, LOAD_DATE_TIME, IS_SUCCESS, ERROR_TEXT, ACCOUNT_LOAD_TYPE_ID,BEELINE_RN)
          VALUES(NEW_ACCOUNT_LOAD_LOG_ID, pACCOUNT_ID,SYSDATE,1,err, 1,SRN);
      ELSE
        err:=err||' -- '||SQLERRM||'--'|| case
                                            when SQ_Value is null then ''
                                            else TsiteAddr(mod(SQ_Value,ServerCount)+1)
                                          end;
        INSERT INTO ACCOUNT_LOAD_LOGS(ACCOUNT_LOAD_LOG_ID, ACCOUNT_ID, LOAD_DATE_TIME, IS_SUCCESS, ERROR_TEXT, ACCOUNT_LOAD_TYPE_ID,BEELINE_RN)
          VALUES(NEW_ACCOUNT_LOAD_LOG_ID, pACCOUNT_ID,SYSDATE,0,err, 1,SRN);
      END IF;                                        
      commit;
end;

function lock_phone(pACCOUNT_ID in varchar2,
                    pPHONE_NUMBER in varchar2)
                    return varchar2 is
    result varchar2(100);
    err varchar2(1000);
    answer blob;
    method varchar2(50);
    plogin     VARCHAR2(30 CHAR);
    pPASSWORD  VARCHAR2(30 CHAR);
    p_is_collector number;
    IS_INTERNET_TARIFF number(1); -- Признак, является ли ТП номера интеренет тарифом. Предназанчен для блокировки номера сразу на "S1B"
begin
    SELECT login,nvl(new_pswd,password) password,n_method,is_collector
      INTO plogin, ppassword,method,p_is_collector
    FROM ACCOUNTS WHERE ACCOUNT_ID=pACCOUNT_ID;
 
    -- v8 
    -- определяем является ли тариф интернет тарифом если да то отправляем его сразу на сохранение (S1B)
     IS_INTERNET_TARIFF := 0;
--    BEGIN      
        SELECT count(*)
          INTO IS_INTERNET_TARIFF
        FROM V_CONTRACTS v
            ,TARIFFS tar
        WHERE V.PHONE_NUMBER_FEDERAL = pPHONE_NUMBER
          and V.CONTRACT_CANCEL_DATE IS NULL
          and V.TARIFF_ID = TAR.TARIFF_ID
          and nvl(TAR.IS_INTERNET_TARIFF, 0) = 1;
--    EXCEPTION 
--      WHEN OTHERS  THEN 
--         IS_INTERNET_TARIFF := 0;
--    END;
      
  if strInLike(91,nvl(method,'0;'),';','()')=1 then 
    IF NVL(IS_INTERNET_TARIFF, 0) = 0 THEN -- если не интернет тариф
      EXECUTE IMMEDIATE  'begin :err :=beeline_api_pckg.LOCK_PHONE(:pPHONE_NUMBER,0,''WIO''); end;' USING OUT err, IN pPHONE_NUMBER;
    ELSE
      EXECUTE IMMEDIATE  'begin :err :=beeline_api_pckg.LOCK_PHONE(:pPHONE_NUMBER,0,''S1B''); end;' USING OUT err, IN pPHONE_NUMBER; --v8
    END IF;
     
    if regexp_instr(err,'Заявка на блок №\d+')>0 then 
      return('API '||Err);
    end if;
  end if; 
       
    
 if p_is_collector=1 then return('Error'); end if;--если не коллекторский, то идём по кабинету.
   
   for c in 1..3 loop --пробуем 3 раза
      err:=create_conn(plogin,ppassword,9,answer,pPHONE_NUMBER);
         --Ожидаем что ответ будет типа : Запрос №9999999999 на блокировку успешно отправлен
         if (Tloader.count>0  and instr(Tloader(1),'блокиров')>0) then
           INSERT INTO AUTO_BLOCKED_PHONE(PHONE_NUMBER, BALLANCE, NOTE, BLOCK_DATE_TIME, ABONENT_FIO)
              VALUES (pPHONE_NUMBER, null,Tloader(1) , SYSDATE, null);
           commit;   
           create_rpt_log_tbl(9,pACCOUNT_ID,answer,'lock_'||pPHONE_NUMBER||'_OK');--логируем ответ от сервера.
             if pACCOUNT_ID=93 and instr(Tloader(1),'уже заблокирован')>0 then 
               update db_loader_account_phones acc_p set acc_p.phone_is_active=0
               where acc_p.account_id=pACCOUNT_ID and acc_p.phone_number=pPHONE_NUMBER
               and acc_p.year_month=const_year_month and acc_p.phone_is_active=1;
               commit;
             end if;
           return(Tloader(1));--вылетаем с положительным ответом
         else -- если иначе логируем косяк
           if dbms_lob.istemporary(answer)is null then  dbms_lob.createtemporary(answer, true ); end if;
           for i in Theader.first..Theader.last loop
             dbms_lob.append(answer,utl_raw.cast_to_raw(convert(Theader(i).h_name||':'||Theader(i).h_value||chr(13),'CL8MSWIN1251','UTF8')));
           end loop;
           dbms_lob.append(answer,utl_raw.cast_to_raw(convert('Ответ соединения:'||err,'CL8MSWIN1251','UTF8')));--дописываем в blob
           create_rpt_log_tbl(9,pACCOUNT_ID,answer,'lock_'||pPHONE_NUMBER||'_ERR');
           result:='Error';
         end if;
   end loop;
return(result);--если трижды неудача возвращаем печальку.
exception
when others then
       if dbms_lob.istemporary(answer)is null then  dbms_lob.createtemporary(answer, true ); end if;
       dbms_lob.append(answer,utl_raw.cast_to_raw('Ответ соединения:'||err));--дописываем в blob
       create_rpt_log_tbl(9,pACCOUNT_ID,answer,'lock_'||pPHONE_NUMBER||'_ERR');
       return('Error');
end;

function unlock_phone(pACCOUNT_ID in varchar2,
                    pPHONE_NUMBER in varchar2)
                    return varchar2 is
result varchar2(100);
err varchar2(1000);
answer blob;
method varchar2(50);
plogin     VARCHAR2(30 CHAR);
pPASSWORD  VARCHAR2(30 CHAR);
p_is_collector number;
begin
    SELECT login,nvl(new_pswd,password) password,n_method,is_collector
      INTO plogin, ppassword,method,p_is_collector
    FROM ACCOUNTS WHERE ACCOUNT_ID=pACCOUNT_ID;
 
 if strInLike(11,nvl(method,'0;'),';','()')=1 
   then 
     EXECUTE IMMEDIATE  'begin :err :=beeline_api_pckg.UNLOCK_PHONE(:pPHONE_NUMBER,0); end;' USING OUT err, IN pPHONE_NUMBER;
     if regexp_instr(err,'Заявка на разблок №\d+')>0 then return('API '||Err);end if;
 end if; 
 
 if p_is_collector=1 then return('Error');end if;--если не коллекторский, то идём по кабинету.
   
   for c in 1..3 loop --пробуем 3 раза
   err:=create_conn(plogin,ppassword,10,answer,pPHONE_NUMBER);
         --Ожидаем что ответ будет типа : Запрос №9999999999 на разблокировку успешно отправлен
         if (Tloader.count>0  and instr(Tloader(1),'блокиров')>0) then
             if pACCOUNT_ID=93 and instr(Tloader(1),'уже разблокирован')>0 then 
               update db_loader_account_phones acc_p set acc_p.phone_is_active=1
               where acc_p.account_id=pACCOUNT_ID and acc_p.phone_number=pPHONE_NUMBER
               and acc_p.year_month=const_year_month and acc_p.phone_is_active=0;
               commit;
             end if;
           create_rpt_log_tbl(10,pACCOUNT_ID,answer,'unlock_'||pPHONE_NUMBER||'_OK');--логируем ответ от сервера.
           return(Tloader(1));--вылетаем с положительным ответом
         else
           if dbms_lob.istemporary(answer)is null then  dbms_lob.createtemporary(answer, true ); end if;
           for i in Theader.first..Theader.last loop--сохраняем заголовки в темп
             dbms_lob.append(answer,utl_raw.cast_to_raw(convert(Theader(i).h_name||':'||Theader(i).h_value||chr(13),'CL8MSWIN1251','UTF8')));
           end loop;
           dbms_lob.append(answer,utl_raw.cast_to_raw(convert('Ответ соединения:'||err,'CL8MSWIN1251','UTF8')));--дописываем в blob
           create_rpt_log_tbl(10,pACCOUNT_ID,answer,'unlock_'||pPHONE_NUMBER||'_ERR');
           result:='Error';
         end if;
   end loop;  
 --если трижды облом- вылетаем
return(result);
exception
when others then
  if dbms_lob.istemporary(answer)is null then  dbms_lob.createtemporary(answer, true ); end if;
  dbms_lob.append(answer,utl_raw.cast_to_raw('Ответ соединения:'||err));--дописываем в blob
  return('Error');
end;


/*=======================================*/
/*=== 3 СТАТУСЫ АБОНЕНТОВ КОНСТРУКТОР ===*/
/*=======================================*/
procedure LOAD_ACCOUNT_PHONES_STATE(pACCOUNT_ID in number)
    is

    method            varchar2(50);--проверка включения
--
log_EXCEPTION       EXCEPTION;
err                 varchar2(1000);
--
answer_mes blob;--выгрузка
--
plogin     VARCHAR2(30 CHAR);
pPASSWORD  VARCHAR2(30 CHAR);
account    number;
--
Snext_RN   varchar2(60);--номер заказанного отчёта
SRN        varchar2(60);--номер загружаемого отчёта
S_file_RN  varchar2(200);--загружаемый файл
counter    number:=0;

 --Парсинг строки и Вставка в таблицу через db_loader_pckg.SET_REPORT_DATA
          function insertstr(item varchar2) return varchar2  is
           rcStates db_loader_account_phones%rowtype;
           sMSG varchar2(200);
              sTMP varchar2(3000);
              sFld varchar2(200);
            nPozDivider number;
            nIndexField number;
          begin
          sTMP:=item||divider;
          nIndexField:=0;
          dbms_output.enable;
          loop--парсинг строки
          nPozDivider:=instr(sTMP,divider,1,1);
          sFld:= substr(sTMP,1,nPozDivider-1);
          sTMP:= substr(sTMP,nPozDivider+1);
          sFld:=trim(sFld);
          case nIndexField
            
            when 2 then rcStates.Organization_Id:=to_number(replace(rtrim(sfld,chr(10)||chr(13)||chr(9)),',','.'), '9999999999.99');
            when 8 then select decode(sFld,'Заблокированный',0,'Активный',1) into rcStates.Phone_Is_Active from dual; --активность
            when 9 then rcStates.Phone_Number:=to_number(sFld);
            when 10 then rcStates.Cell_Plan_Code:=sFld;
            when 13 then select decode(sFld,'Блокировка',1,'Пользовательская блокировка',0,0) into rcStates.Conservation from dual; --Тип блокировки
            else
              null;
          end case;
          nIndexField:=nIndexField+1;
            exit when nPozDivider is null;
          end loop;

          /* вставляем  запись */
          Db_Loader_Pckg.ADD_ACCOUNT_PHONE(
            substr(to_char(const_year_month),1,4),
            substr(to_char(const_year_month),5,2),
            plogin,
            rcStates.Phone_Number ,
            rcStates.Phone_Is_Active,             /* 0 - НЕАКТИВНЫЙ, 1 - АКТИВНЫЙ */
            rcStates.Cell_Plan_Code,              /* КОД ТАРИФНОГО ПЛАНА*/
            null,                                 /* КОД НОВОГО ТАРИФНОГО ПЛАНА*/
            null,                                 /* ДАТА СМЕНЫ ТАРИФНОГО ПЛАНА*/
            rcStates.Organization_Id,             /* Код организации */
            0,                                    /* Нужно сбрасывать описание услуг (будем загружать заново) */
            rcStates.Conservation,                /* 0 - НЕТ, 1 - НА СОХРАНЕНИИ */
            0                                     /* 0 - НЕТ, 1 - СИСТЕМНЫЙ БЛОК ЗА МОШЕННИЧЕСТВО */
            );
          smsg:=(to_char(rcStates.Phone_Number)||','||to_char(rcStates.Phone_Is_Active)||','||
          to_char(rcStates.Cell_Plan_Code)||','||to_char(rcStates.Organization_Id));
          return(sMSG);
          exception
            when others then err:=err||' ParsErr^:nIndexField='||nIndexField||';sFld='||sFld||';sTMP='||sTMP;
          end;

/*phone_statuses begin now*/
begin
 counter:=0;
    SELECT login,nvl(new_pswd,password) password, ACCOUNT_NUMBER,n_method
      INTO plogin, ppassword                    ,ACCOUNT        ,method
    FROM ACCOUNTS WHERE ACCOUNT_ID=pACCOUNT_ID;
    --проверяем можно ли формировать...
    if strInLike(3,nvl(method,'0;'),';','()')=0 then err:=' Формирование отчета отключено! '; raise log_EXCEPTION;end if;
    -- запрос следующего номера отчёта
     begin
      select max(trim(both '#' from regexp_substr(e.error_text,'#[^#]+#'))) into Snum_Rep
      from account_load_logs e where e.load_date_time in (select MAX(r.load_date_time)
                                                          from  account_load_logs r
                                                          where r.account_load_type_id=3 and regexp_instr(r.error_text,'#\d+#')>0
                                                          and r.account_id=pACCOUNT_ID)
      and e.account_load_type_id=3 and e.account_id=pACCOUNT_ID;
     exception
      when others then Snum_Rep:=0;
     end;
    --

    err:=create_conn(plogin,ppassword,3,answer_mes);--открываем соединение

        for i in Theader.first..theader.last loop--перебираем header
          if Theader(i).h_name='Next-Order-Number' then Snext_RN:= Theader(i).h_value;end if;--следующий
          if Theader(i).h_name='Order-Number' then SRN:= Theader(i).h_value;end if;
          if Theader(i).h_name='Order-Time' then
             if (sysdate-to_date(replace(Theader(i).h_value,' '),'DD HH24:MI'))>0.5 then
               err:='Error:Возраст загруженного отчёта больше 12 часов.';
               raise log_EXCEPTION;
             end if;
          end if;
        end loop;
        if Snext_RN is null then Snext_RN:='ЗАКАЗ НЕ ПРОИЗВЕДЁН!'; end if;
        if (length(trim(SRN)) is not null)
           then  S_file_RN:=SRN||'.csv'; else S_file_RN:='Err '||account||to_char(sysdate,'MMDDmiss');
        end if;

     if err='OK' then
        err:=create_rpt_log_tbl(3,pACCOUNT_ID,answer_mes,S_file_RN);--создаём копию в базу
        if err!='OK' then raise log_EXCEPTION;end if;
     else --если не прошло соединение вылетаем
        raise log_EXCEPTION;
     end if;--соединение завершилось
    --проверяем , если сообщение об ошибке или подобие xml то вылетаем
    if (Tloader is null) or (instr(Tloader(1),'Error')>0)or(instr(Tloader(1),'<')>0) then
      err:=Tloader(1); raise log_exception;
    end if;
    --ПРОЛОГ
    db_loader_pckg.START_LOAD_ACCOUNT_PHONES(substr(to_char(const_year_month),1,4),substr(to_char(const_year_month),5,2),plogin);

    --ЗАГРУЗКА ДАННЫХ

     for i in Tloader.first+1..Tloader.last loop--пропускаем заголовок
     --ищем информацию об ошибке в первой строке на случай если код ошибки был не 400
           if insertstr(Tloader(i))is not null then counter:=counter+1;
           else raise log_EXCEPTION;
           end if;
     end loop i;
     commit;
    --ЭПИЛОГ
    db_loader_pckg.COMMIT_LOAD_ACCOUNT_PHONES(substr(to_char(const_year_month),1,4),substr(to_char(const_year_month),5,2),plogin);
  --логируем успешное выполнение
  INSERT INTO ACCOUNT_LOAD_LOGS(ACCOUNT_LOAD_LOG_ID, ACCOUNT_ID, LOAD_DATE_TIME,
                         IS_SUCCESS, ERROR_TEXT, ACCOUNT_LOAD_TYPE_ID,BEELINE_RN)
  VALUES(NEW_ACCOUNT_LOAD_LOG_ID, pACCOUNT_ID, SYSDATE,
   1,'Ok! Add '||counter||' rows.'||' Заказан:#'||Snext_RN||'#', 3,SRN);
   commit;

  EXCEPTION --логируем неудачу
      when others then  --log_EXCEPTION в частности
      err:=err||' -- '||SQLERRM||'--Записей прогрузилось:'||nvl(counter,0)||'--'
                                     ||case
                                          when SQ_Value is null then ''
                                          else TsiteAddr(mod(SQ_Value,ServerCount)+1)
                                        end;

      rollback;--удаление старых записей не должно закоммититься

      INSERT INTO ACCOUNT_LOAD_LOGS(ACCOUNT_LOAD_LOG_ID, ACCOUNT_ID, LOAD_DATE_TIME,
                                 IS_SUCCESS, ERROR_TEXT, ACCOUNT_LOAD_TYPE_ID,BEELINE_RN)
      VALUES(NEW_ACCOUNT_LOAD_LOG_ID, pACCOUNT_ID, SYSDATE,
           0,err||decode(Snext_RN,null,'',' Заказан:#')||Snext_RN||'#', 3,SRN);
      commit;



null;
end;

/*= 17 Загрузка балансов лицевых счетов   */
/*========================================*/
--
PROCEDURE LOAD_ACCOUNT_BALANCE(
  pACCOUNT_ID IN INTEGER
  ) IS
method            varchar2(50);--проверка включения
--
log_EXCEPTION       EXCEPTION;
err                 varchar2(1000);
--
answer_mes blob;--выгрузка
--
plogin     VARCHAR2(30 CHAR);
pPASSWORD  VARCHAR2(30 CHAR);
account    number;
--
SRN        varchar2(30);--номер загружаемого отчёта
S_file_RN  varchar2(200);--загружаемый файл
NBalance   number; -- баланс по л\с.
counter    number:=0;
 --Парсинг строки и Вставка в таблицу через db_loader_pckg.SET_REPORT_DATA
          function insertstr(item varchar2) return varchar2  is
           rcAccInfo account_info%rowtype;
           sMSG varchar2(200);
              sTMP varchar2(3000);
              sFld varchar2(200);
            nPozDivider number;
            nIndexField number;
            STEP INTEGER;
      vAcc_id integer;
          begin
            sTMP:=replace(
                  replace(item,' ')--ТУТ НЕ ПРОБЕЛ А ВОЛШЕБНЫЙ СИМВОЛ HEX(A000)
                         ,'"');
            nIndexField:=0;
            --dbms_output.enable;
            /*sTMP:=rtrim(sTMP,chr(10)||chr(13)||chr(9));
            sTMP:=replace(sTMP,',','.');*/
            /*
            insert into temp8(str7, str5)
              values(plogin,sTMP);
            COMMIT;
            */   
            rcAccInfo.balance:=to_number(replace(rtrim(sTMP,chr(10)||chr(13)||chr(9)),',','.'), '9999999999.99');
            --NBalance:=to_number(sTMP);
            --NBalance:=to_number(replace(rtrim(sTMP,chr(10)||chr(13)||chr(9)),',','.'), '9999999999.99');
            /*вставляем запись to_char(sysdate,'DD.MM.YYYY-HH24:MI:SS')*/
            --db_loader_pckg.SAVE_BALANCE_CHANGE(plogin,NBalance);     
      
      --проверяем наличие л/с
      SELECT count(ACCOUNT_ID) AccCount
      INTO vAcc_id
            FROM ACCOUNTS
            WHERE ACCOUNT_ID = pACCOUNT_ID;
      
      --если л/с существует, то обновляем данные, иначе вставляем данные
      IF vAcc_id > 0 THEN
              UPDATE ACCOUNT_INFO AI
              SET AI.BALANCE = rcAccInfo.balance
              WHERE AI.ACCOUNT_ID = pACCOUNT_ID;
      ELSE
        INSERT INTO ACCOUNT_INFO (account_id, Balance) VALUES (pACCOUNT_ID, rcAccInfo.balance);
      END IF;
        
            COMMIT;         
            smsg:='OK';
            return(sMSG);
          exception
            when others then 
              err:=err||' ParsErr^:nIndexField='||nIndexField||';sFld='||sFld||';sTMP='||sTMP||' Counter#'||counter;
          end;
BEGIN
  counter:=0;
  SELECT t.login,nvl(t.new_pswd,t.password) password, t.ACCOUNT_NUMBER,t.n_method
    INTO plogin, ppassword                    ,ACCOUNT        ,method
  FROM ACCOUNTS t WHERE t.ACCOUNT_ID=pACCOUNT_ID;
  --проверяем можно ли формировать...
  if strInLike(17,method,';','()')=0 then err:=' Формирование отчета отключено! '; raise log_EXCEPTION;end if;
 /* if get_status_complite(6,plogin,ppassword)=0
    then
  err:='Нет нового отчета!';
  raise log_EXCEPTION;end if;--если последний уже загружен - вылазим . */
  err:=create_conn(plogin,ppassword,17,answer_mes);--открываем соединение
  for i in Theader.first..theader.last loop--перебираем header
     case Theader(i).h_name
       when 'Content-Disposition' then S_file_RN:= Theader(i).h_value;
       when 'Balance' then
         if upper(rtrim(Theader(i).h_value,chr(10)||chr(13)||chr(9)))='NULL' then 
           NBalance:=null;
         else
           null;--ниже не работает
        -- Nbalance:=to_number(replace(rtrim(Theader(i).h_value,chr(10)||chr(13)||chr(9)),',','.'), '9999999999.99');
         end if;
       else null;
     end case;
  end loop;
  if err='OK' then
    BEGIN
    ---
      if instr(S_file_RN,'attachment')>0 then --приложен файл
         S_file_RN:=ltrim(S_file_RN,'attachment; filename=');
         S_file_RN:=trim('"' from S_file_RN);
         S_file_RN:=ltrim(S_file_RN,'"RPT_UBC');-- срезаем системные символы
         SRN:=substr(s_file_rn,1,instr(s_file_rn,'_')-1);--номер заказа
      else--Ничего не приложено
      raise log_EXCEPTION;
      end if;
    exception
      when others then
      SRN:='Н\Д'||to_char(sysdate,'MMDD-MMSS');
      S_file_RN:=account||'_err.txt';--будет файл с ошибкой
    end;
    err:='';
     -- err:=create_rpt_log(6,account,answer_mes,S_file_RN);--создаём копию на диске
    err:=create_rpt_log_tbl(17,pACCOUNT_ID,answer_mes,S_file_RN);--создаём копию в базу
    if err!='OK' then raise log_EXCEPTION;end if;
  else --если не прошло соединение вылетаем
    raise log_EXCEPTION;
  end if;--соединение завершилось
  -------------------------------------
    --загрузка данных
  for i in Tloader.first..Tloader.last loop
    --ищем информацию об ошибке в первой строке на случай если код ошибки был не 400
    if (instr(Tloader(i),'Error')>0) and (i=1) then err:=Tloader(i); raise log_exception;
    elsif i>=1--опускаем заголовок таблицы
           then --добавляем в таблицу
           if insertstr(Tloader(i))is not null then counter:=counter+1;
             else raise log_EXCEPTION;
           end if;
    end if;
  end loop;
  --логируем успешное выполнение
  INSERT INTO ACCOUNT_LOAD_LOGS(ACCOUNT_LOAD_LOG_ID, ACCOUNT_ID, LOAD_DATE_TIME,
                                IS_SUCCESS, ERROR_TEXT, ACCOUNT_LOAD_TYPE_ID,BEELINE_RN)
    VALUES(NEW_ACCOUNT_LOAD_LOG_ID, pACCOUNT_ID, SYSDATE,
           1,'Ok! Add '||counter||' rows.', 17,SRN);
  commit;
EXCEPTION --логируем неудачу
  when others then  --log_EXCEPTION в частности
    IF SUBSTR(err, 2, 12)='Дата платежа' THEN
      err:='Ok! Add 0 rows. New site. '||err;
      INSERT INTO ACCOUNT_LOAD_LOGS(ACCOUNT_LOAD_LOG_ID, ACCOUNT_ID, LOAD_DATE_TIME,
                              IS_SUCCESS, ERROR_TEXT, ACCOUNT_LOAD_TYPE_ID,BEELINE_RN)
        VALUES(NEW_ACCOUNT_LOAD_LOG_ID, pACCOUNT_ID,SYSDATE,1,err, 17,SRN);
    ELSE
      err:=err||' -- '||SQLERRM||'--'|| case
                                        when SQ_Value is null then ''
                                        else TsiteAddr(mod(SQ_Value,ServerCount)+1)
                                      end;
      INSERT INTO ACCOUNT_LOAD_LOGS(ACCOUNT_LOAD_LOG_ID, ACCOUNT_ID, LOAD_DATE_TIME,
                              IS_SUCCESS, ERROR_TEXT, ACCOUNT_LOAD_TYPE_ID,BEELINE_RN)
        VALUES(NEW_ACCOUNT_LOAD_LOG_ID, pACCOUNT_ID,SYSDATE,0,err, 17,SRN);
    END IF;                                        
    commit;
END;  
--
--Загрузка балансов по всем лицевым счетам
PROCEDURE LOAD_ALL_ACCOUNT_BALANCES IS
BEGIN
  FOR rec IN (SELECT ACCOUNT_ID FROM ACCOUNTS) LOOP
    LOAD_ACCOUNT_BALANCE(rec.ACCOUNT_ID);
  END LOOP;
END;
/*=======================================*/
/*===== 3 СТАТУСЫ АБОНЕНТОВ UPDATE ======*/
/*=======================================*/
procedure UPDATE_ACCOUNT_PHONES_STATE(pACCOUNT_ID in number)
    is
    method            varchar2(50);--проверка включения
--
log_EXCEPTION       EXCEPTION;
err                 varchar2(1000);
--
answer_mes blob;--выгрузка
--
plogin     VARCHAR2(30 CHAR);
pPASSWORD  VARCHAR2(30 CHAR);
account    number;
--
S_file_RN  varchar2(200);--загружаемый файл
counter    number:=0;

 --Парсинг строки и Вставка в таблицу через db_loader_pckg.SET_REPORT_DATA
          function insertstr(item varchar2) return varchar2  is
           rcStates db_loader_account_phones%rowtype;
           sMSG varchar2(200);
              sTMP varchar2(3000);
              sFld varchar2(200);
            nPozDivider number;
            nIndexField number;
          begin
          sTMP:=replace(
                replace(
                replace(
                replace(item,' ')--ТУТ НЕ ПРОБЕЛ А ВОЛШЕБНЫЙ СИМВОЛ HEX(A000)
                       ,', ','.')                
                       ,'"')
                       ,',',divider)||divider;

          nIndexField:=0;
          dbms_output.enable;
          loop--парсинг строки
          nPozDivider:=instr(sTMP,divider,1,1);
          sFld:= substr(sTMP,1,nPozDivider-1);
          sTMP:= substr(sTMP,nPozDivider+1);
          sFld:=trim(sFld);
          case nIndexField
--"9031111593","361826161","Группа счетов 1","Нет группы",,"Формула Свободы. Москва (FS_UNL_F )",,"Заблокированный","26.04.2012","Блокировка","20.09.2011",
            when 0 then rcStates.Phone_Number:=trim(sFld);
            when 2 then rcStates.Organization_Id:=to_number(regexp_substr(sFld,'\d+'));
            when 5 then rcStates.Cell_Plan_Code:=trim(rtrim(ltrim(regexp_substr(sFld,'\([^(А-Я,а-я)]+\)',1,1),'('),')'));
                        /*регулярка достаёт значение без русских букв, в скобках, для кода тарифа первое попадание, для нового кода - второе*/
                        rcStates.New_Cell_Plan_Code:=trim(rtrim(ltrim(regexp_substr(sFld,'\([^(А-Я,а-я)]+\)',1,2),'('),')'));
                        if rcStates.New_Cell_Plan_Code is not null then 
                                                       rcStates.New_Cell_Plan_Date:=to_date(regexp_substr(sFld,'\d+\.\d+\.\d+',1,1),'DD.MM.YYYY'); 
                        end if;                                                       
           /*when 7 then if pACCOUNT_ID=93 then
                   select decode(sFld,'Заблокированный',0,'Активный',1) into rcStates.Phone_Is_Active from dual;end if;*/ --активность           
            when 7 then --if NOT pACCOUNT_ID=93 then
                   select decode(sFld,'Заблокированный',0,'Активный',1,2) into rcStates.Phone_Is_Active from dual;--end if; --активность
           /* when 9 then if pACCOUNT_ID=93 then 
                   select decode(sFld,'Блокировка',1,0) into rcStates.Conservation from dual;END IF;*/ --Тип блокировки
            when 9 then --if NOT pACCOUNT_ID=93 then 
                   select decode(sFld,'Блокировка',1,0) into rcStates.Conservation from dual;--END IF; --Тип блокировки
            else
              null;
          end case;

          nIndexField:=nIndexField+1;
            exit when nPozDivider is null;
          end loop;
           if trim(rcStates.Cell_Plan_Code)is null or rcStates.Phone_Is_Active=2 then err:='Shift_Fields!'; raise log_EXCEPTION;end if;          /* вставляем  запись */
          Db_Loader_Pckg.ADD_ACCOUNT_PHONE(
            substr(to_char(const_year_month),1,4),
            substr(to_char(const_year_month),5,2),
            plogin,
            rcStates.Phone_Number ,
            rcStates.Phone_Is_Active,             /* 0 - НЕАКТИВНЫЙ, 1 - АКТИВНЫЙ */
            rcStates.Cell_Plan_Code,              /* КОД ТАРИФНОГО ПЛАНА*/
            rcStates.New_Cell_Plan_Code,          /* КОД НОВОГО ТАРИФНОГО ПЛАНА*/
            rcStates.New_Cell_Plan_Date,          /* ДАТА СМЕНЫ ТАРИФНОГО ПЛАНА*/
            rcStates.Organization_Id,             /* Код организации */
            0,                                    /* Нужно сбрасывать описание услуг (будем загружать заново) */
            rcStates.Conservation,                /* 0 - НЕТ, 1 - НА СОХРАНЕНИИ */
            0                                     /* 0 - НЕТ, 1 - СИСТЕМНЫЙ БЛОК ЗА МОШЕННИЧЕСТВО */
            );
          smsg:=(to_char(rcStates.Phone_Number)||','||to_char(rcStates.Phone_Is_Active)||','||
          to_char(rcStates.Cell_Plan_Code)||','||to_char(rcStates.Organization_Id));
          return(sMSG);
          exception
            when others then err:=err||' ParsErr^:nIndexField='||nIndexField||';sFld='||sFld||';sTMP='||sTMP;
          end;

/*phone_statuses begin now*/
begin
 counter:=0;
    SELECT login,nvl(new_pswd,password) password, ACCOUNT_NUMBER,n_method
      INTO plogin, ppassword                    ,ACCOUNT        ,method
    FROM ACCOUNTS WHERE ACCOUNT_ID=pACCOUNT_ID;
    --Проверяем нужно ли обновлять через АПИ
    if strInLike(31,nvl(method,'0;'),';','()')=1 
    then 
     EXECUTE IMMEDIATE  'begin :err :=beeline_api_pckg.account_phone_status(:pAccount_id); end;' USING OUT err, IN pACCOUNT_ID;
    if regexp_instr(err,'Update \d+')>0 then 
      return;end if; --Если удача - вылетаем
 
    end if;
    
    
    
    --проверяем можно ли формировать...
    if strInLike(3,nvl(method,'0;'),';','()')=0 then err:=' Формирование отчета отключено! '; raise log_EXCEPTION;end if;

    err:=create_conn(plogin,ppassword,31,answer_mes);--открываем соединение


    S_file_RN:='States'||'.csv';


     if err='OK' then
        err:=create_rpt_log_tbl(3,pACCOUNT_ID,answer_mes,S_file_RN);--создаём копию в базу
        if err!='OK' then raise log_EXCEPTION;end if;
     else --если не прошло соединение вылетаем
        raise log_EXCEPTION;
     end if;--соединение завершилось
    --проверяем , если сообщение об ошибке или подобие xml то вылетаем
    if (Tloader is null) or (instr(Tloader(1),'Error')>0)or(instr(Tloader(1),'<')>0) then
      err:=Tloader(1); raise log_exception;
    end if;

    --ЗАГРУЗКА ДАННЫХ

    --ПРОЛОГ
    db_loader_pckg.START_LOAD_ACCOUNT_PHONES(substr(to_char(const_year_month),1,4),substr(to_char(const_year_month),5,2),plogin);

     for i in Tloader.first+1..Tloader.last loop--пропускаем заголовок
     --ищем информацию об ошибке в первой строке на случай если код ошибки был не 400
           if insertstr(Tloader(i))is not null then counter:=counter+1;
           else raise log_EXCEPTION;
           end if;
     end loop i;

    --ЭПИЛОГ
    db_loader_pckg.COMMIT_LOAD_ACCOUNT_PHONES(substr(to_char(const_year_month),1,4),substr(to_char(const_year_month),5,2),plogin);
  
   --Удаляем дубликаты по текущей загрузке

     delete from db_loader_account_phones r
            where 
            r.account_id=pACCOUNT_ID
            and r.year_month=const_year_month
            and exists (        select 1
                                from db_loader_account_phones t
                                where t.account_id=r.account_id and t.year_month=r.year_month and t.phone_number=r.phone_number
                                and t.rowid>r.rowid
                               );
     
     commit;
  --логируем успешное выполнение
  INSERT INTO ACCOUNT_LOAD_LOGS(ACCOUNT_LOAD_LOG_ID, ACCOUNT_ID, LOAD_DATE_TIME,
                         IS_SUCCESS, ERROR_TEXT, ACCOUNT_LOAD_TYPE_ID)
  VALUES(NEW_ACCOUNT_LOAD_LOG_ID, pACCOUNT_ID, SYSDATE,
   1,'Ok! Update '||counter||' rows.', 3);
   commit;

  EXCEPTION --логируем неудачу
      when others then  --log_EXCEPTION в частности
      err:=err||' -- '||SQLERRM||'--Записей обновлено:'||nvl(counter,0)||'--'
                                     ||case
                                          when SQ_Value is null then ''
                                          else TsiteAddr(mod(SQ_Value,ServerCount)+1)
                                        end;

      rollback;--удаление старых записей не должно закоммититься

      INSERT INTO ACCOUNT_LOAD_LOGS(ACCOUNT_LOAD_LOG_ID, ACCOUNT_ID, LOAD_DATE_TIME,
                                 IS_SUCCESS, ERROR_TEXT, ACCOUNT_LOAD_TYPE_ID)
      VALUES(NEW_ACCOUNT_LOAD_LOG_ID, pACCOUNT_ID, SYSDATE,
           0,'Update '||err, 3);
      commit;
end;

/*=======================================*/
/*========= 4 УСЛУГИ АБОНЕНТОВ ==========*/
/*=======================================*/
PROCEDURE LOAD_PHONES_OPTIONS(
    pACCOUNT_ID IN INTEGER,
    p_STREAM_ID in integer default null, 
    pCountSTREAM in integer default null  
) IS

method            varchar2(50);--проверка включения
--
log_EXCEPTION       EXCEPTION;
err                 varchar2(1000);
--
answer_mes blob;--выгрузка
--
plogin     VARCHAR2(30 CHAR);
pPASSWORD  VARCHAR2(30 CHAR);
account    number;
Nyear_month number:=const_year_month;
--
Snext_RN   varchar2(60);--номер заказанного отчёта
SRN        varchar2(60);--номер загружаемого отчёта
S_file_RN  varchar2(200);--загружаемый файл
counter    number:=0;
--

  VTopts Topts:=Topts();

 --Парсинг строки и Вставка в таблицу через db_loader_pckg.SET_REPORT_DATA
          function insertstr(item varchar2) return varchar2  is
           rcOpts db_loader_account_phone_opts%rowtype;
           sMSG varchar2(200);
              sTMP varchar2(3000);
              sFld varchar2(200);
            nPozDivider number;
            nIndexField number;
          begin
                      sTMP:=replace(
                replace(
                replace(item,' ')--ТУТ НЕ ПРОБЕЛ А ВОЛШЕБНЫЙ СИМВОЛ HEX(A000)
                       ,'"')
                       ,',',divider)||divider;
         -- sTMP:=item||divider;
          nIndexField:=0;
          dbms_output.enable;
          loop--парсинг строки
          nPozDivider:=instr(sTMP,divider,1,1);
          sFld:= substr(sTMP,1,nPozDivider-1);
          sTMP:= substr(sTMP,nPozDivider+1);
          case nIndexField
          --  9670103613 ;;;Активный;06.06.2013;Разблокировка;Мультипасс;31.01.2013;;BVISAEXT2;17.05.2012
            when 0 then rcOpts.Phone_Number:=trim(sFLD);--фед.номер
            when 6 then rcOpts.Option_Name:=trim(sFLD);--Наименование услуги
            when 7 then rcOpts.Turn_On_Date:=to_date(trim(sFLD),'DD.MM.YYYY');--Дата начала действия
            when 8 then rcOpts.Turn_Off_Date:=to_date(trim(sFLD),'DD.MM.YYYY');--Дата окончания действия
            when 9 then rcOpts.Option_Code:=trim(sFLD);--Код услуги
            else
              null;
          end case;
          nIndexField:=nIndexField+1;
            exit when nPozDivider is null;
          end loop;
          --доп.поля
          rcOpts.Account_Id:=pACCOUNT_ID;
          rcOpts.Year_Month:=Nyear_month;
          rcOpts.Last_Check_Date_Time:=to_char(sysdate);
          rcOpts.Monthly_Price:=ltrim(regexp_substr(rcOpts.Option_Name,'\/(\d+)'),'/');
          rcOpts.Turn_On_Cost:=ltrim(regexp_substr(rcOpts.Option_Name,'\((\d+)'),'(');
          --добавление в типизированную таблицу
          vTopts.extend;
          vTopts(vTopts.count):=topts_obj(rcOpts.Account_Id,rcOpts.Year_Month,rcOpts.Phone_Number,rcOpts.Option_Code
                                         ,rcOpts.Option_Name,rcOpts.Option_Parameters,rcOpts.Turn_On_Date,rcOpts.Turn_Off_Date
                                         ,rcOpts.Last_Check_Date_Time,rcOpts.Turn_On_Cost,rcOpts.Monthly_Price);

          /* Возвращаем порядковый номер*/
          smsg:=vTopts.count;
          return(sMSG);
          end;
BEGIN
    counter:=0;
    SELECT login,nvl(new_pswd,password) password, ACCOUNT_NUMBER,n_method
      INTO plogin, ppassword                    ,ACCOUNT        ,method
    FROM ACCOUNTS WHERE ACCOUNT_ID=pACCOUNT_ID;
    --проверяем можно ли формировать...
    if strInLike(4,method,';','()')=0 then err:=' Формирование отчета отключено! '; raise log_EXCEPTION;end if;
    
    --Проверяем нужно ли обновлять через АПИ...
    if strInLike(41,nvl(method,'0;'),';','()')=1 then 
      EXECUTE IMMEDIATE  'begin :err :=beeline_api_pckg.account_phone_options(:pAccount_id,:p_STREAM_ID, :pCountSTREAM ); end;' USING OUT err, IN pACCOUNT_ID, p_STREAM_ID, pCountSTREAM; -- v12 - для распараллеливания загрузок
      if instr(err,'Ok! Update options count')>0 then                                       
         return;
      else 
          return;
      End if; --Если удача - вылетаем
      
      /*==========================================================================*/      
      /*!!!!!    ДАЛЬШЕ АПИ НЕ ИДЁМ Т .К . В МЕТОДЕ ЧЕРЕЗ E-CARE ЕСТЬ КОСЯКИ !!!!!*/
      /*==========================================================================*/ 
    else 
      return;
    end if;


    err:=create_conn(plogin,ppassword,4,answer_mes);--открываем соединение

        for i in Theader.first..theader.last loop--перебираем header
          if Theader(i).h_name='Next-Order-Number' then Snext_RN:= Theader(i).h_value;end if;--следующий
          if Theader(i).h_name='Order-Number' then SRN:= Theader(i).h_value;end if;

        end loop;
        if Snext_RN is null then Snext_RN:='ЗАКАЗ НЕ ПРОИЗВЕДЁН!'; end if;
        if (length(trim(SRN)) is not null)
           then  S_file_RN:=SRN||'.csv'; else S_file_RN:='Err '||account||to_char(sysdate,'MMDDmiss');
        end if;

     if err='OK' then

         begin  --ПРОВЕРКА ГОТОВНОСТИ ОТЧЁТА - ЕСЛИ ТАКОЙ УЖЕ ГРУЗИЛИ ВЫЛЕТАЕМ
          select 0 into err from dual where
          exists (select * from account_load_logs l
                  where l.beeline_rn=SRN and l.is_success=1 and l.account_load_type_id=4);
          if err='0' then err:='Нет нового отчета!'; raise log_EXCEPTION;end if;
          exception when no_data_found then null;
          end;  --ПРОВЕРКА ГОТОВНОСТИ конец

         err:='';
         err:=create_rpt_log_tbl(4,pACCOUNT_ID,answer_mes,S_file_RN);--создаём копию в базу
         if err!='OK' then raise log_EXCEPTION;end if;

     else --если не прошло соединение вылетаем
        raise log_EXCEPTION;
     end if;--соединение завершилось
  -------------------------------------
    --проверяем , если сообщение об ошибке или подобие xml то вылетаем
    if (instr(Tloader(1),'Error')>0)or(instr(Tloader(1),'<')>0) then
      err:=Tloader(1); raise log_exception;
    end if;

    --ЗАГРУЗКА ДАННЫХ
    counter:=0;
    --Парсинг данных в ассоциированные массивы.
     for i in Tloader.first+1..Tloader.last loop--пропускаем заголовок
           if insertstr(Tloader(i))is not null then counter:=counter+1;end if;
     end loop i;

     update db_loader_account_phone_opts opt set opt.turn_off_date=sysdate--закрываем открытые
     where opt.account_id=pACCOUNT_ID and opt.year_month=Nyear_month and
           opt.turn_off_date is null;

         MERGE INTO db_loader_account_phone_opts opt
      USING (SELECT * FROM table(set(VTopts))) VT
      ON (opt.phone_number = vt.phone_number and opt.year_month=vt.year_month and opt.option_code=vt.option_code
          and opt.turn_on_date=vt.turn_on_date)

      WHEN MATCHED THEN
          UPDATE SET opt.last_check_date_time = vt.last_check_date_time,
                     opt.turn_off_date=vt.turn_off_date
          WHERE vt.option_code is not null
        --DELETE source1.col2 IS NULL
      WHEN NOT MATCHED THEN
           INSERT (opt.account_id,opt.year_month,opt.phone_number,opt.option_code,opt.option_name,opt.option_parameters
                  ,opt.turn_on_date,opt.turn_off_date,opt.last_check_date_time,opt.turn_on_cost,opt.monthly_price)
           VALUES (vt.account_id,vt.year_month,vt.phone_number,vt.option_code,vt.option_name,vt.option_parameters
                  ,vt.turn_on_date,vt.turn_off_date,vt.last_check_date_time,vt.turn_on_cost,vt.monthly_price)
           WHERE vt.option_code is not null;

     commit;



  --логируем успешное выполнение
  INSERT INTO ACCOUNT_LOAD_LOGS(ACCOUNT_LOAD_LOG_ID, ACCOUNT_ID, LOAD_DATE_TIME,
                         IS_SUCCESS, ERROR_TEXT, ACCOUNT_LOAD_TYPE_ID,BEELINE_RN)
  VALUES(NEW_ACCOUNT_LOAD_LOG_ID, pACCOUNT_ID, SYSDATE,
   1,'Ok! Load '||counter||' rows.'||' Заказан:'||Snext_RN, 4,SRN);commit;

  EXCEPTION --логируем неудачу
      when others then  --log_EXCEPTION в частности

      err:=err||' -- '||SQLERRM||'--'|| case
                                          when SQ_Value is null then ''
                                          else TsiteAddr(mod(SQ_Value,ServerCount)+1)
                                        end;
      INSERT INTO ACCOUNT_LOAD_LOGS(ACCOUNT_LOAD_LOG_ID, ACCOUNT_ID, LOAD_DATE_TIME,
                                 IS_SUCCESS, ERROR_TEXT, ACCOUNT_LOAD_TYPE_ID,BEELINE_RN)
      VALUES(NEW_ACCOUNT_LOAD_LOG_ID, pACCOUNT_ID, SYSDATE,
           0,err||decode(Snext_RN,null,'',' Заказан:')||Snext_RN, 4,SRN);
      commit;
END;
/*=================Загрузка вспомогательных данных для загрузок===================*/

/*=================OBJ-ID для счетов и формы пользователя===================*/
PROCEDURE LOAD_OBJ_ID(
    pACCOUNT_ID IN INTEGER,
    pPHONE_NUMBER VARCHAR2  DEFAULT  NULL
    ) IS

  method            varchar2(50);--проверка включения
  --
  log_EXCEPTION       EXCEPTION;
  err                 varchar2(1000);
  --
  answer_mes blob;--выгрузка
  --
  plogin     VARCHAR2(30 CHAR);
  pPASSWORD  VARCHAR2(30 CHAR);
  account    number;
  is_collector number;
  counter    number:=0;
  --

BEGIN
  counter:=0;
  SELECT login,nvl(new_pswd,password) password, ACCOUNT_NUMBER,n_method,is_collector
    INTO plogin, ppassword                    ,ACCOUNT        ,method,is_collector
  FROM ACCOUNTS WHERE ACCOUNT_ID=pACCOUNT_ID;
  
  if plogin is null then 
    err:='Не найден постоплатный счёт'||pACCOUNT_ID; 
    raise log_EXCEPTION;
  end if;
    
  IF pPHONE_NUMBER IS NULL  THEN
    err := create_conn (plogin, ppassword, 51, answer_mes);                                   --открываем соединение
  ELSE
    err := create_conn (plogin, ppassword, 51, answer_mes, pPHONE_NUMBER);                    --открываем соединение
  END IF;
        
  if err='OK' then
  -- err:=create_rpt_log(6,account,answer_mes,S_file_RN);--создаём копию на диске
   err:=create_rpt_log_tbl(51,pACCOUNT_ID,answer_mes,'OBJ_ID_'||to_char(pACCOUNT_ID));--создаём копию в базу
    if err!='OK' then raise log_EXCEPTION;end if;
  else --если не прошло соединение вылетаем
    raise log_EXCEPTION;
  end if;--соединение завершилось
  -------------------------------------
  --проверяем , если сообщение об ошибке или подобие xml то вылетаем
  if (instr(Tloader(1),'Error')>0)or(instr(Tloader(1),'<')>0) then
    err:=Tloader(1); raise log_exception;
  end if;
  --ЗАГРУЗКА ДАННЫХ

  --сбрасываю счётчик
  counter:=0;
  IF Tloader.count > 1 THEN --учитываем заголовок
    --удаляем все данные по л/с
    if pPHONE_NUMBER IS NULL then
      delete from BEELINE_LOADER_INF
      where ACCOUNT_ID =pACCOUNT_ID;       
    else
      delete from BEELINE_LOADER_INF
      where PHONE_NUMBER =pPHONE_NUMBER;
    end if;
    commit;
    --Загрузка данных в базу
    for i in Tloader.first+1..Tloader.last loop--пропускаем заголовок
      --ищем информацию об ошибке в первой строке на случай если код ошибки был не 400
      /*UPDATE BEELINE_LOADER_INF
            SET ACCOUNT_ID =pACCOUNT_ID,
                obj_id = regexp_substr(Tloader(i), '[^;]+', 1, 2),
                BAN = (case is_collector
                  when 0 then ACCOUNT
                  when 1 then BAN
                end)
            WHERE PHONE_NUMBER = regexp_substr(Tloader(i), '[^;]+', 1, 1);*/
      --IF (sql%rowcount = 0) THEN
      merge into BEELINE_LOADER_INF inf
      using 
        (select
              pACCOUNT_ID  ACCOUNT_ID,
              regexp_substr(Tloader(i), '[^;]+', 1, 1) PHONE_NUMBER,
              regexp_substr(Tloader(i), '[^;]+', 1, 2) OBJ_ID,
              case is_collector
                when 0 then ACCOUNT
              else 
                null
              end BAN
         from dual
         )t
      on
        (inf.PHONE_NUMBER = t.PHONE_NUMBER)
      when matched then
        update
          set
            INF.ACCOUNT_ID = t.ACCOUNT_ID,
            INF.OBJ_ID = t.OBJ_ID, 
            INF.BAN = t.BAN
      when not matched then
        insert (ACCOUNT_ID,PHONE_NUMBER,OBJ_ID,BAN) 
        values (t.ACCOUNT_ID,
              t.PHONE_NUMBER,
              t.OBJ_ID,
              t.BAN
             );
      --END IF;           
      counter:=counter+1;
    end loop;      
    commit;
  END IF;

  exception 
    when others then 
      err:=err||'   '||sqlerrm;
      insert into aaa(sss2) values (err); commit;  
END;
/*=======================================*/
/*===== 3 ТАРИФЫ БИ. UPDATE ======*/
/*=======================================*/
procedure UPDATE_ACCOUNT_TARIFFS(pACCOUNT_ID in number)
    is
    method            varchar2(50);--проверка включения
--
log_EXCEPTION       EXCEPTION;
err                 varchar2(1000);
--
answer_mes blob;--выгрузка
--
plogin     VARCHAR2(30 CHAR);
pPASSWORD  VARCHAR2(30 CHAR);
account    number;
--
S_file_RN  varchar2(200);--загружаемый файл
counter    number:=0;

 --Парсинг строки и Вставка в таблицу 
          function insertstr(item varchar2) return varchar2  is
           rcTariffs DB_LOADER_ACCOUNT_TARIFFS%rowtype;
           sMSG varchar2(200);
              sTMP varchar2(3000);
              sFld varchar2(200);
            nPozDivider number;
            nIndexField number;
          begin
          sTMP:=replace(
                replace(
                replace(
                replace(item,' ')--ТУТ НЕ ПРОБЕЛ А ВОЛШЕБНЫЙ СИМВОЛ HEX(A000)
                       ,', ','.')                
                       ,'"')
                       ,',',divider)||divider;

          nIndexField:=0;
          dbms_output.enable;
          loop--парсинг строки
            nPozDivider:=instr(sTMP,divider,1,1);
            sFld:= substr(sTMP,1,nPozDivider-1);
            sTMP:= substr(sTMP,nPozDivider+1);
            sFld:=trim(sFld);
              case nIndexField
                when 0 then rcTariffs.Tariff_Code:=trim(sFld);
                when 1 then rcTariffs.Tariff_Name:=trim(replace(sFld,'('||rcTariffs.Tariff_Code||')',''));--trim(regexp_substr(sFld,'^[А-ЯЁ,а-яё,A-Z,a-z,0-9 ._\+]+(\([А-ЯЁ,а-яё .]+\)|())',1,1)); 
                  else
                  null;
              end case;

            nIndexField:=nIndexField+1;
              exit when nPozDivider is null;
          end loop;
           if trim(rcTariffs.Tariff_Code)is not null 
             then  /* вставляем  запись */
           
               insert into db_loader_account_tariffs
                 (account_id, tariff_code, tariff_name, date_update)
               values
                 (pACCOUNT_ID,rcTariffs.Tariff_Code,rcTariffs.Tariff_Name, sysdate);
             sMSG:='OK';
            end if;         
          
          return(sMSG);
          exception
            when others then err:=err||' ParsErr^:nIndexField='||nIndexField||';sFld='||sFld||';sTMP='||sTMP;
          end;

/*phone_statuses begin now*/
begin
 counter:=0;
    SELECT login,nvl(new_pswd,password) password, ACCOUNT_NUMBER,n_method
      INTO plogin, ppassword                    ,ACCOUNT        ,method
    FROM ACCOUNTS WHERE ACCOUNT_ID=pACCOUNT_ID;
   
    err:=create_conn(plogin,ppassword,53,answer_mes);--открываем соединение


    S_file_RN:='TARIFFS'||'.csv';

     if err='OK' then
        err:=create_rpt_log_tbl(53,pACCOUNT_ID,answer_mes,S_file_RN);--создаём копию в базу
        if err!='OK' then raise log_EXCEPTION;end if;
     else --если не прошло соединение вылетаем
        raise log_EXCEPTION;
     end if;--соединение завершилось
    --проверяем , если сообщение об ошибке или подобие xml то вылетаем
    if (Tloader is null) or (instr(Tloader(1),'Error')>0)or(instr(Tloader(1),'<')>0) then
      err:=Tloader(1); raise log_exception;
    end if;

    --ЗАГРУЗКА ДАННЫХ

  
     for i in Tloader.first+1..Tloader.last loop--пропускаем заголовок
     --ищем информацию об ошибке в первой строке на случай если код ошибки был не 400
           if insertstr(Tloader(i))is not null then counter:=counter+1;
           else raise log_EXCEPTION;
           end if;
     end loop i;

 
   --Удаляем дубликаты по текущей загрузке

     delete from db_loader_account_tariffs r
            where 
            r.account_id=pACCOUNT_ID
            and exists ( select 1
                        from db_loader_account_tariffs t
                        where t.account_id=r.account_id and t.tariff_code=r.tariff_code and t.tariff_name=r.tariff_name
                        and t.rowid>r.rowid
                       );
     
     commit;
  --логируем успешное выполнение
  INSERT INTO ACCOUNT_LOAD_LOGS(ACCOUNT_LOAD_LOG_ID, ACCOUNT_ID, LOAD_DATE_TIME,
                         IS_SUCCESS, ERROR_TEXT, ACCOUNT_LOAD_TYPE_ID)
  VALUES(NEW_ACCOUNT_LOAD_LOG_ID, pACCOUNT_ID, SYSDATE,
   1,'Ok! Update TARIFF_CODES'||counter||' rows.', 53);
   commit;

  EXCEPTION --логируем неудачу
      when others then  --log_EXCEPTION в частности
      err:=err||' -- '||SQLERRM||'--Записей кодов тарифов:'||nvl(counter,0)||'--'
                                     ||case
                                          when SQ_Value is null then ''
                                          else TsiteAddr(mod(SQ_Value,ServerCount)+1)
                                        end;

      rollback;--удаление старых записей не должно закоммититься

      INSERT INTO ACCOUNT_LOAD_LOGS(ACCOUNT_LOAD_LOG_ID, ACCOUNT_ID, LOAD_DATE_TIME,
                                 IS_SUCCESS, ERROR_TEXT, ACCOUNT_LOAD_TYPE_ID)
      VALUES(NEW_ACCOUNT_LOAD_LOG_ID, pACCOUNT_ID, SYSDATE,
           0,'Update '||err, 53);
      commit;
end;


/*========================================*/
/*= 52 Обновление периодов готовых счетов=*/
/*========================================*/
procedure UPDATE_ACCOUNT_BILLS_PERIOD(pACCOUNT_ID in number)
    is
    method            varchar2(50);--проверка включения
--
log_EXCEPTION       EXCEPTION;
err                 varchar2(1000);
--
answer_mes blob;--выгрузка
--
plogin     VARCHAR2(30 CHAR);
pPASSWORD  VARCHAR2(30 CHAR);
account    number;
--
S_file_RN  varchar2(200);--загружаемый файл
counter    number:=0;

 --Парсинг строки и Вставка в таблицу через db_loader_pckg.SET_REPORT_DATA
          function insertstr(item varchar2) return varchar2  is
           rcPeriods db_loader_bills_period%rowtype;
           sMSG varchar2(200);
              sTMP varchar2(3000);
              sFld varchar2(200);
            nPozDivider number;
            nIndexField number;
          begin
          sTMP:=replace(
                replace(
                replace(
                replace(item,' ')--ТУТ НЕ ПРОБЕЛ А ВОЛШЕБНЫЙ СИМВОЛ HEX(A000)
                       ,', ','.')                
                       ,'"')
                       ,',',divider)||divider;

          nIndexField:=0;
          dbms_output.enable;
          loop--парсинг строки
            nPozDivider:=instr(sTMP,divider,1,1);
            sFld:= substr(sTMP,1,nPozDivider-1);
            sTMP:= substr(sTMP,nPozDivider+1);
            sFld:=trim(sFld);
              case nIndexField
                when 0 then rcPeriods.Periodid:=trim(sFld);
                when 1 then rcPeriods.St_Date:=to_date(trim(sFld),'DD.MM.YYYY');
                when 2 then rcPeriods.End_Date:=to_date(trim(sFld),'DD.MM.YYYY');
                  else
                  null;
              end case;

            nIndexField:=nIndexField+1;
              exit when nPozDivider is null;
          end loop;
           if trim(rcPeriods.Periodid)is not null 
             then  /* upsert */
               update db_loader_bills_period r set r.periodid=periodid 
                  where r.account_id=pACCOUNT_ID and r.year_month=to_char(rcPeriods.St_Date,'YYYYMM');
               if sql%rowcount=0 then 
                 insert into db_loader_bills_period
                   (account_id, year_month, st_date, end_date, periodid)
                 values
                   (pACCOUNT_ID, to_char(rcPeriods.St_Date,'YYYYMM'), rcPeriods.St_Date, rcPeriods.End_Date, rcPeriods.Periodid);
               end if;
             if sql%rowcount>0 then sMSG:='OK';end if;
            end if;         
          
          return(sMSG);
          exception
            when others then err:=err||' ParsErr^:nIndexField='||nIndexField||';sFld='||sFld||';sTMP='||sTMP;
          end;

/*phone_statuses begin now*/
begin
 counter:=0;
    SELECT login,nvl(new_pswd,password) password, ACCOUNT_NUMBER,n_method
      INTO plogin, ppassword                    ,ACCOUNT        ,method
    FROM ACCOUNTS WHERE ACCOUNT_ID=pACCOUNT_ID;
   
    err:=create_conn(plogin,ppassword,52,answer_mes);--открываем соединение


    S_file_RN:='BILL_PERIOD'||'.csv';

     if err='OK' then
        err:=create_rpt_log_tbl(52,pACCOUNT_ID,answer_mes,S_file_RN);--создаём копию в базу
        if err!='OK' then raise log_EXCEPTION;end if;
     else --если не прошло соединение вылетаем
        raise log_EXCEPTION;
     end if;--соединение завершилось
    --проверяем , если сообщение об ошибке или подобие xml то вылетаем
    if (Tloader is null) or (instr(Tloader(1),'Error')>0)or(instr(Tloader(1),'<')>0) then
      err:=Tloader(1); raise log_exception;
    end if;
    --ЗАГРУЗКА ДАННЫХ
  
     for i in Tloader.first+1..Tloader.last loop--пропускаем заголовок
     --ищем информацию об ошибке в первой строке на случай если код ошибки был не 400
           if insertstr(Tloader(i))is not null then counter:=counter+1;
           else raise log_EXCEPTION;
           end if;
     end loop i;
     
     commit;
  --логируем успешное выполнение
  INSERT INTO ACCOUNT_LOAD_LOGS(ACCOUNT_LOAD_LOG_ID, ACCOUNT_ID, LOAD_DATE_TIME,
                         IS_SUCCESS, ERROR_TEXT, ACCOUNT_LOAD_TYPE_ID)
  VALUES(NEW_ACCOUNT_LOAD_LOG_ID, pACCOUNT_ID, SYSDATE,
   1,'Ok! ADD BILLS_PERIODS '||counter||' rows.', 52);
   commit;

  EXCEPTION --логируем неудачу
      when others then  --log_EXCEPTION в частности
      err:=err||' -- '||SQLERRM||'--Записей периодов отчетности:'||nvl(counter,0)||'--'
                                     ||case
                                          when SQ_Value is null then ''
                                          else TsiteAddr(mod(SQ_Value,ServerCount)+1)
                                        end;

      rollback;--удаление старых записей не должно закоммититься

      INSERT INTO ACCOUNT_LOAD_LOGS(ACCOUNT_LOAD_LOG_ID, ACCOUNT_ID, LOAD_DATE_TIME,
                                 IS_SUCCESS, ERROR_TEXT, ACCOUNT_LOAD_TYPE_ID)
      VALUES(NEW_ACCOUNT_LOAD_LOG_ID, pACCOUNT_ID, SYSDATE,
           0,'Update '||err, 52);
      commit;
end;


procedure LOAD_ACCOUNT_BILLS(
    pACCOUNT_ID IN INTEGER
    ,pYearMonth in number
    ) IS
    
  method            varchar2(50);--проверка включения
  --
  log_EXCEPTION       EXCEPTION;
  err                 varchar2(1000);
  --
  answer_mes blob;--выгрузка
  --
  plogin     VARCHAR2(30 CHAR);
  pPASSWORD  VARCHAR2(30 CHAR);
  account    number;
  is_collector number;
  counter    number:=0;
  --
begin
  counter:=0;
    SELECT login,nvl(new_pswd,password) password, ACCOUNT_NUMBER,n_method,is_collector
      INTO plogin, ppassword                    ,ACCOUNT        ,method,is_collector
    FROM ACCOUNTS WHERE ACCOUNT_ID=pACCOUNT_ID;
    if plogin is null then err:='Не найден постоплатный счёт'||pACCOUNT_ID; raise log_EXCEPTION;end if;  
    
    err:=create_conn(plogin,ppassword,5,answer_mes);--открываем соединение
     if err='OK' then
     -- err:=create_rpt_log(5,account,answer_mes,S_file_RN);--создаём копию на диске
       err:=create_rpt_log_tbl(5,pACCOUNT_ID,answer_mes,'ACC_BILL_'||to_char(pACCOUNT_ID));--создаём копию в базу
        if err!='OK' then raise log_EXCEPTION;end if;
     else --если не прошло соединение вылетаем
        raise log_EXCEPTION;
     end if;--соединение завершилось
  -------------------------------------
    --проверяем , если сообщение об ошибке или подобие xml то вылетаем
    if (instr(Tloader(1),'Error')>0)or(instr(Tloader(1),'<')>0) then
      err:=Tloader(1); raise log_exception;
    end if;
    --ЗАГРУЗКА ДАННЫХ

    --сбрасываю счётчик
    counter:=0;
     --подготовка
     delete from tmpdb_loader_bills dblb where dblb.year_month=pYearMonth and dblb.account_id=pACCOUNT_ID;commit;

    --Загрузка данных в базу
     for i in Tloader.first+1..Tloader.last-1 loop--пропускаем заголовок и итоги
     
/*ACCOUNT_ID    Код лицевого счёта
YEAR_MONTH    Год и месяц отчётного периода
PHONE_NUMBER    Номер телефона
DATE_BEGIN    Дата начала периода (загруженное значение)
DATE_END    Дата окончания периода (загруженное значение)
BILL_SUM    Начисленная сумма (полная)
SUBSCRIBER_PAYMENT_MAIN    Абонентская плата по тарифу
SUBSCRIBER_PAYMENT_ADD    Абонплата за дополнительные услуги
SINGLE_PAYMENTS    Разовые начисления
CALLS_LOCAL_COST    Стоимость местных звонков
CALLS_OTHER_CITY_COST    Междугородние звонки
CALLS_OTHER_COUNTRY_COST    Международные звонки
MESSAGES_COST    Стоимость сообщений (SMS, MMS)
INTERNET_COST    Стоимость интернета
OTHER_COUNTRY_ROAMING_COST    Международный роуминг
NATIONAL_ROAMING_COST    Национальный роуминг
PENI_COST    Начисленные пени
DISCOUNT_VALUE    Скидки
TARIFF_CODE    Код тарифа
OTHER_COUNTRY_ROAMING_CALLS    Международный роуминг Эфирное время (начисления партнера)
OTHER_COUNTRY_ROAMING_MESSAGES    Международный роуминг SMS (начисления партнера)
OTHER_COUNTRY_ROAMING_INTERNET    Международный роуминг GPRS (начисления партнера)
NATIONAL_ROAMING_CALLS    Национальный роуминг Эфирное время (начисления партнера)
NATIONAL_ROAMING_MESSAGES    Национальный роуминг SMS (начисления партнера)
NATIONAL_ROAMING_INTERNET    Национальный роуминг GPRS (начисления партнера)
BILL_CHECKED    Фиксация учета счетов
DATE_CREATED    Дата/время создания записи
USER_CREATED    Пользователь, создавший запись
USER_LAST_UPDATED    Пользователь, редактировавший запись последним
DATE_LAST_UPDATED    Дата/время последней редакции записи*/

                  --Загружаем только если номер телефона похож на правду (первое поле)
    if trim(regexp_substr(Tloader(i), '[^;]+', 1, 1))not in ('0','00000000000','0000000000') 
       and trim(regexp_substr(Tloader(i), '[^;]+', 1, 1))is not null 
      then
      insert into tmpdb_loader_bills
        (account_id, year_month, phone_number, date_begin, date_end, bill_sum, subscriber_payment_main, subscriber_payment_add, single_payments, calls_local_cost, calls_other_city_cost, calls_other_country_cost, messages_cost, internet_cost, other_country_roaming_cost, national_roaming_cost, peni_cost, discount_value, tariff_code, other_country_roaming_calls, other_country_roaming_messages, other_country_roaming_internet, national_roaming_calls, national_roaming_messages, national_roaming_internet, bill_checked, date_created, user_created, user_last_updated, date_last_updated)
      values
        (pACCOUNT_ID--v_account_id
        ,pYearMonth--  v_year_month
        ,trim(regexp_substr(Tloader(i), '[^;]+', 1, 1))-- v_phone_number
        ,to_date(trim(regexp_substr(Tloader(i), '[^;]+', 1, 4)),'DD.MM.YYYY')-- v_date_begin
        ,to_date(trim(regexp_substr(Tloader(i), '[^;]+', 1, 5)),'DD.MM.YYYY')-- v_date_end
        ,to_number(replace(rtrim(regexp_substr(Tloader(i), '[^;]+', 1, 25),chr(10)||chr(13)||chr(9)),',','.'), '9999999999.99')*nds-- v_bill_sum
        ,to_number(replace(rtrim(regexp_substr(Tloader(i), '[^;]+', 1, 20),chr(10)||chr(13)||chr(9)),',','.'), '9999999999.99')*nds-- v_subscriber_payment_main
        ,to_number(replace(rtrim(regexp_substr(Tloader(i), '[^;]+', 1, 21),chr(10)||chr(13)||chr(9)),',','.'), '9999999999.99')*nds-- v_subscriber_payment_add
        ,to_number(replace(rtrim(regexp_substr(Tloader(i), '[^;]+', 1, 23),chr(10)||chr(13)||chr(9)),',','.'), '9999999999.99')*nds-- v_single_payments
        ,to_number(replace(rtrim(regexp_substr(Tloader(i), '[^;]+', 1, 9),chr(10)||chr(13)||chr(9)),',','.'), '9999999999.99')*nds-- v_calls_local_cost
        ,to_number(replace(rtrim(regexp_substr(Tloader(i), '[^;]+', 1, 8),chr(10)||chr(13)||chr(9)),',','.'), '9999999999.99')*nds-- v_calls_other_city_cost
        ,to_number(replace(rtrim(regexp_substr(Tloader(i), '[^;]+', 1, 7),chr(10)||chr(13)||chr(9)),',','.'), '9999999999.99')*nds-- v_calls_other_country_cost
        ,to_number(replace(rtrim(regexp_substr(Tloader(i), '[^;]+', 1, 10),chr(10)||chr(13)||chr(9)),',','.'), '9999999999.99')*nds-- v_messages_cost
        ,to_number(replace(rtrim(regexp_substr(Tloader(i), '[^;]+', 1, 11),chr(10)||chr(13)||chr(9)),',','.'), '9999999999.99')*nds-- v_internet_cost
        ,to_number(replace(rtrim(regexp_substr(Tloader(i), '[^;]+', 1, 15),chr(10)||chr(13)||chr(9)),',','.'), '9999999999.99')*nds-- v_other_country_roaming_cost
        ,to_number(replace(rtrim(regexp_substr(Tloader(i), '[^;]+', 1, 19),chr(10)||chr(13)||chr(9)),',','.'), '9999999999.99')*nds-- v_national_roaming_cost
        ,to_number(replace(rtrim(regexp_substr(Tloader(i), '[^;]+', 1, 24),chr(10)||chr(13)||chr(9)),',','.'), '9999999999.99')*nds-- v_peni_cost
        ,to_number(replace(rtrim(regexp_substr(Tloader(i), '[^;]+', 1, 22),chr(10)||chr(13)||chr(9)),',','.'), '9999999999.99')*nds-- v_discount_value
        ,trim(regexp_substr(Tloader(i), '[^;]+', 1, 6))-- v_tariff_code
        ,to_number(replace(rtrim(regexp_substr(Tloader(i), '[^;]+', 1, 12),chr(10)||chr(13)||chr(9)),',','.'), '9999999999.99')*nds-- v_other_country_roaming_calls
        ,to_number(replace(rtrim(regexp_substr(Tloader(i), '[^;]+', 1, 13),chr(10)||chr(13)||chr(9)),',','.'), '9999999999.99')*nds-- v_other_country_roaming_messages
        ,to_number(replace(rtrim(regexp_substr(Tloader(i), '[^;]+', 1, 14),chr(10)||chr(13)||chr(9)),',','.'), '9999999999.99')*nds-- v_other_country_roaming_internet
        ,to_number(replace(rtrim(regexp_substr(Tloader(i), '[^;]+', 1, 16),chr(10)||chr(13)||chr(9)),',','.'), '9999999999.99')*nds-- v_national_roaming_calls
        ,to_number(replace(rtrim(regexp_substr(Tloader(i), '[^;]+', 1, 17),chr(10)||chr(13)||chr(9)),',','.'), '9999999999.99')*nds-- v_national_roaming_messages
        ,to_number(replace(rtrim(regexp_substr(Tloader(i), '[^;]+', 1, 18),chr(10)||chr(13)||chr(9)),',','.'), '9999999999.99')*nds-- v_national_roaming_internet
        ,0-- v_bill_checked
        ,sysdate-- v_date_created
        ,user-- v_user_created
        ,null-- v_user_last_updated
        ,null-- v_date_last_updated
        );
     end if;  
      counter:=counter+1;
      end loop;      
      commit;

  exception 
    when others then 
      err:=err||'   '||sqlerrm;
      insert into aaa(sss2) values (err||' №Записи ошибки:'||counter); commit; 

    
end;


--ЗАГРУЗКА НАЧИСЛЕНИЙ СЧЕТА ПО АПИ.

procedure PARSE_ACCOUNT_BILLS_API(
    pACCOUNT_ID IN INTEGER
    ,pYearMonth in number
    ,Pxml_file_id in number default 0
    ) IS
  
cursor xml_log(f_ID number) IS
with xmltable1 as (select w.soap_answer from BEELINE_SOAP_API_LOG w 
                       where w.bsal_id=f_ID       
                   )
               select
                extractvalue (value(d) ,'BillChargesList/ban') ban,
                extractvalue (value(d) ,'BillChargesList/ben') ben,
                substr(extractvalue (value(d) ,'BillChargesList/ctn'),-10) ctn,
                convert_pckg.TIMESTAMP_TZ_TO_DATE(extractvalue (value(d) ,'BillChargesList/startDate')) startDate,
                convert_pckg.TIMESTAMP_TZ_TO_DATE(extractvalue (value(d) ,'BillChargesList/endDate')) endDate,
                /*to_date(extractvalue (value(d) ,'BillChargesList/startDate'),'yyyy-mm-dd"T"HH24:MI:SS".0"') startDate,
                to_date(extractvalue (value(d) ,'BillChargesList/endDate'),'yyyy-mm-dd"T"HH24:MI:SS".0"') endDate,*/  -- Замена формата из-за ввода данных по часовому поясу.
                extractvalue (value(d) ,'BillChargesList/internationalCalls') internationalCalls,
                extractvalue (value(d) ,'BillChargesList/nationalCalls') nationalCalls,
                extractvalue (value(d) ,'BillChargesList/localCalls') localCalls,
                extractvalue (value(d) ,'BillChargesList/gprs') gprs,
                extractvalue (value(d) ,'BillChargesList/sms') sms,
                extractvalue (value(d) ,'BillChargesList/internationalRoamingCalls') internationalRoamingCalls,
                extractvalue (value(d) ,'BillChargesList/internationalRoamingSMS') internationalRoamingSMS,
                extractvalue (value(d) ,'BillChargesList/internationalRoamingGPRS') internationalRoamingGPRS,
                extractvalue (value(d) ,'BillChargesList/nationalRoamingCalls') nationalRoamingCalls,
                extractvalue (value(d) ,'BillChargesList/nationalRoamingSMS') nationalRoamingSMS,
                extractvalue (value(d) ,'BillChargesList/nationalRoamingGPRS') nationalRoamingGPRS,
                extractvalue (value(d) ,'BillChargesList/feePP') feePP,
                extractvalue (value(d) ,'BillChargesList/feeServices') feeServices,
                extractvalue (value(d) ,'BillChargesList/discount') discount,
                extractvalue (value(d) ,'BillChargesList/charges') charges,
                extractvalue (value(d) ,'BillChargesList/latePayment') latePayment,
                extractvalue (value(d) ,'BillChargesList/sumAmount') sumAmount
from xmltable1 t1,
table(XmlSequence(t1.soap_answer.extract('S:Envelope/S:Body/ns0:getBillChargesResponse/BillChargesList'
                 ,'xmlns:S="http://schemas.xmlsoap.org/soap/envelope/" xmlns:ns0="urn:uss-wsapi:Subscriber"'))) d;

  
  log_EXCEPTION       EXCEPTION;
  err                 varchar2(1000);
  --
  XML_file_id number;
  counter    number:=0;
  --
  Rbill db_loader_bills%rowtype;  
  rlog xml_log%rowtype;
  --
  r_c integer;
begin
  --инициализация
  counter:=0;
  
  --проверка загруженного счёта
    
   XML_file_id:=Pxml_file_id;
    for c in (
            select t.ticket_id, t.date_create,t.account_id--,regexp_substr(t.comments,'\d+') bill_year_month
            from BEELINE_TICKETS t 
            where t.ticket_type=5 and regexp_substr(t.comments,'\d+')='201401' and t.answer=1
                  and nvl(XML_file_id,0)=0
            order by t.date_create desc
             )
      loop
        begin
         select x.bsal_id into XML_file_id
          from beeline_soap_api_log x 
          where x.account_id=c.account_id and x.load_type=5 and instr(x.soap_request,c.ticket_id)>0;
         exit; -- не свалилась - есть номер
        exception
          when others then null;
        end;

    end loop;
    
    if nvl(XML_file_id,0)=0 
      then err:='Нет загруженного отчёта "Начисления счёта" за '||pYearMonth;
      raise log_EXCEPTION;
    end if;
 --подготовка
  delete from db_loader_bills dblb where dblb.year_month=pYearMonth and dblb.account_id=pACCOUNT_ID;commit;
  --добавление записей   
  OPEN xml_log(XML_file_id);
    loop
      FETCH xml_log INTO rlog;
    exit when xml_log%NOTFOUND;
      Rbill:=null;   
      if not to_number(trim(rlog.ctn))=0 then 
          null;
         Rbill.Account_Id:=pACCOUNT_ID;
         Rbill.year_month:=pYearMonth;
         Rbill.Phone_Number:=rlog.ctn;
         Rbill.Date_Begin:=rlog.startDate;
         Rbill.Date_End:=rlog.endDate;
         Rbill.bill_sum:=to_number(replace(trim(rlog.sumAmount),',','.'), '9999999999.9999')*nds;
         Rbill.Subscriber_Payment_Main:=to_number(replace(trim(rlog.feePP),',','.'), '9999999999.9999')*nds;
         Rbill.subscriber_payment_add:=to_number(replace(trim(rlog.feeServices),',','.'), '9999999999.9999')*nds;
         Rbill.single_payments:=to_number(replace(trim(rlog.charges),',','.'), '9999999999.9999')*nds;
         Rbill.calls_local_cost:=to_number(replace(trim(rlog.localCalls),',','.'), '9999999999.9999')*nds;
         Rbill.calls_other_city_cost:=to_number(replace(trim(rlog.nationalCalls),',','.'), '9999999999.9999')*nds;
         Rbill.calls_other_country_cost:=to_number(replace(trim(rlog.internationalCalls),',','.'), '9999999999.9999')*nds;
         Rbill.messages_cost:=to_number(replace(trim(rlog.sms ),',','.'), '9999999999.9999')*nds;
         Rbill.internet_cost:=to_number(replace(trim(rlog.gprs),',','.'), '9999999999.9999')*nds;
         Rbill.peni_cost:=to_number(replace(trim(rlog.latePayment),',','.'), '9999999999.9999')*nds;
         Rbill.discount_value:=to_number(replace(trim(rlog.discount),',','.'), '9999999999.9999')*nds;
         Rbill.other_country_roaming_calls:=to_number(replace(trim(rlog.internationalRoamingCalls),',','.'), '9999999999.9999')*nds;
         Rbill.other_country_roaming_messages:=to_number(replace(trim(rlog.internationalRoamingSMS),',','.'), '9999999999.9999')*nds;
         Rbill.other_country_roaming_internet:=to_number(replace(trim(rlog.internationalRoamingGPRS),',','.'), '9999999999.9999')*nds;
         Rbill.national_roaming_calls:=to_number(replace(trim(rlog.nationalRoamingCalls),',','.'), '9999999999.9999')*nds;
         Rbill.national_roaming_messages:=to_number(replace(trim(rlog.nationalRoamingSMS),',','.'), '9999999999.9999')*nds;
         Rbill.national_roaming_internet:=to_number(replace(trim(rlog.nationalRoamingGPRS),',','.'), '9999999999.9999')*nds;
         Rbill.other_country_roaming_cost:=rbill.other_country_roaming_calls+rbill.other_country_roaming_messages+rbill.other_country_roaming_internet;
         Rbill.national_roaming_cost:=rbill.national_roaming_calls+rbill.national_roaming_messages+rbill.national_roaming_internet;
         Rbill.bill_checked:=0;
         Rbill.date_created:=sysdate;
         Rbill.user_created:=USER;
         Rbill.user_last_updated:=NULL;
         Rbill.date_last_updated:=NULL;
         Rbill.tariff_code:=null;
          
          begin  
            insert into db_loader_bills values rbill;
          exception
            when DUP_VAL_ON_INDEX then 
              update db_loader_bills
                 set bill_sum = bill_sum+Rbill.bill_sum,
                     subscriber_payment_main = subscriber_payment_main+Rbill.subscriber_payment_main,
                     subscriber_payment_add = subscriber_payment_add+Rbill.subscriber_payment_add,
                     single_payments = single_payments+Rbill.single_payments,
                     calls_local_cost = calls_local_cost+Rbill.calls_local_cost,
                     calls_other_city_cost = calls_other_city_cost+Rbill.calls_other_city_cost,
                     calls_other_country_cost =calls_other_country_cost+ Rbill.calls_other_country_cost,
                     messages_cost = messages_cost+Rbill.messages_cost,
                     internet_cost = internet_cost+Rbill.internet_cost,
                     other_country_roaming_cost = other_country_roaming_cost+Rbill.other_country_roaming_cost,
                     national_roaming_cost = national_roaming_cost+Rbill.national_roaming_cost,
                     peni_cost =peni_cost+ Rbill.peni_cost,
                     discount_value =discount_value+ Rbill.discount_value,
                     other_country_roaming_calls =other_country_roaming_calls+Rbill.other_country_roaming_calls,
                     other_country_roaming_messages =other_country_roaming_messages+ Rbill.other_country_roaming_messages,
                     other_country_roaming_internet = other_country_roaming_internet+Rbill.other_country_roaming_internet,
                     national_roaming_calls =national_roaming_calls+ Rbill.national_roaming_calls,
                     national_roaming_messages =national_roaming_messages+ Rbill.national_roaming_messages,
                     national_roaming_internet =national_roaming_internet+ Rbill.national_roaming_internet
               where account_id = Rbill.Account_Id and 
                     year_month = Rbill.year_month and 
                     phone_number = Rbill.Phone_Number;
              
          end;
         counter:=counter+1;
      end if;
    end loop;
  CLOSE xml_log;
   --Добавление кода тарифа из загрузок статусов.
   update db_loader_bills t set t.tariff_code=(select distinct ph.cell_plan_code from db_loader_account_phones ph 
                                                where ph.year_month=pYearMonth and ph.phone_number=t.phone_number
                                                      and ph.account_id=pACCOUNT_ID)
    where t.account_id=pACCOUNT_ID and t.year_month=pYearMonth and t.tariff_code is null
      and t.phone_number in (select ph.phone_number from db_loader_account_phones ph 
                              where ph.year_month=pYearMonth and ph.account_id=pACCOUNT_ID);
                              
  --Занесение ушедших банов с ненулевым счётом в список ручного формирования
          insert into db_loader_ffb_except
            (account_id, year_month, phone_number, info, date_insert, resolve)
          select t.account_id,t.year_month,t.phone_number,'Нет записи (db_loader_account_phones) в отчётном периоде для не нулевого счёта'
                 ,sysdate,0 
                 from db_loader_bills t where t.account_id=Paccount_id and t.year_month=pYearMonth and t.tariff_code is null
                 and (t.bill_sum!=0 or t.calls_local_cost!=0 or t.calls_other_city_cost!=0 or t.messages_cost!=0 or t.internet_cost!=0)
                 and not exists (select 1 from db_loader_ffb_except e where e.account_id=t.account_id and e.year_month=t.year_month
                                                                        and e.phone_number=t.phone_number);
  r_c:=sql%rowcount;--фиксим 
  --Добавление кода тарифа из истории для ушедших c банов
   update db_loader_bills t set t.tariff_code=(select distinct phh.cell_plan_code from db_loader_account_phone_hists phh
                                                where phh.phone_number=t.phone_number
                                                  and phh.rowid=(
                                                      select max(phd.rowid) from db_loader_account_phone_hists phd 
                                                       where (t.date_begin between phd.begin_date and phd.end_date)
                                                       and phd.phone_number=t.phone_number
                                                      ))
    where t.account_id=pACCOUNT_ID and t.year_month=pYearMonth and t.tariff_code is null
      and t.phone_number in (select ph.phone_number from db_loader_account_phones ph 
                              where ph.year_month=pYearMonth and ph.account_id=pACCOUNT_ID);
                                                                                         
   --обновление статистики
   
       update db_loader_bills_period bp set bp.bills_count=counter, bp.bills_conflict=r_c
           where bp.account_id=pACCOUNT_ID and bp.year_month=pYearMonth; 
   commit; 
   
  INSERT INTO ACCOUNT_LOAD_LOGS(ACCOUNT_LOAD_LOG_ID, ACCOUNT_ID, LOAD_DATE_TIME,
                             IS_SUCCESS, ERROR_TEXT, ACCOUNT_LOAD_TYPE_ID)
  VALUES(NEW_ACCOUNT_LOAD_LOG_ID, pACCOUNT_ID, SYSDATE,1,'Загружено счётов:'||counter, 5);

  exception 
    when others then
      rollback; 
      err:=err||'   '||sqlerrm;
      INSERT INTO ACCOUNT_LOAD_LOGS(ACCOUNT_LOAD_LOG_ID, ACCOUNT_ID, LOAD_DATE_TIME,
                                 IS_SUCCESS, ERROR_TEXT, ACCOUNT_LOAD_TYPE_ID)
      VALUES(NEW_ACCOUNT_LOAD_LOG_ID, pACCOUNT_ID, SYSDATE,0,err||'Загрузка начислений счёта:'||counter, 5);
      commit;
    
end;


--Обёртка для номера, для загрузки детального счета...
procedure LOAD_PHONE_DETAIL_BILL(
    pPhone_number in varchar2
    ,pYearMonth in number
    )IS 
obj_id integer;
acc_id integer;
begin 
  --account_id
   select ph.account_id into acc_id
   from db_loader_account_phones ph where ph.phone_number=pPhone_number and ph.year_month=pYearMonth
     and ph.last_check_date_time=(select max(r.last_check_date_time) from db_loader_account_phones r 
                                      where r.phone_number=pPhone_number and r.year_month=pYearMonth);
  --obj_id                                    
   select regexp_substr(li.obj_id,'\d+') into obj_id 
            from beeline_loader_inf li where li.account_id=acc_id and li.phone_number=pPhone_number;
            
   load_detail_bill(acc_id,pYearMonth,obj_id);     
 exception
   when others then null; 
--   if plogin is null then err:='Не найдено пары логин-ссылка для '||pPhone_number; raise log_EXCEPTION;end if;                    
end;    
    
    

--загрузка детального счёта 
procedure LOAD_DETAIL_BILL(
    pAccount_id in number
    ,pYearMonth in number
    ,obj_list in varchar2
    ) IS
    
  method            varchar2(50);--проверка включения
  --
  log_EXCEPTION       EXCEPTION;
  err                 varchar2(1000);
  --
  answer_mes blob;--выгрузка
  --
  plogin     VARCHAR2(30 CHAR);
  pPASSWORD  VARCHAR2(30 CHAR);
  account    number;
  is_collector number;
  --
  bill_xml xmltype;
  xml_phone varchar2(10);
  ffb  db_loader_full_finance_bill%rowtype;
  ffap db_loader_full_bill_abon_per%rowtype;
  ffmn db_loader_full_bill_mn_rouming%rowtype;
  ffmg db_loader_full_bill_mg_rouming%rowtype;
  xml_err_ph varchar2(10);
  single_ediniy number(15, 4);
function get_phone_by_obj_id (obj in integer) return varchar2
  is 
  ph_n varchar2(10);
  begin
   select bli.phone_number into ph_n from beeline_loader_inf bli 
     where regexp_substr(bli.obj_id,'\d+',1,1)=obj 
       and bli.account_id=pAccount_id;
   return(ph_n);
  exception
    when others then return null;
  end;
  
  

begin
  --инициализация
  Syear_month:='';
  Sobj_ids:=obj_list;
  begin
    --select to_char(bp.st_date,'DD.MM.YYYY')||' - '||to_char(bp.end_date,'DD.MM.YYYY') into Syear_month  
    select to_char(bp.st_date,'DD.MM.YYYY')||'%20-%20'||to_char(bp.end_date,'DD.MM.YYYY') into Syear_month
      from db_loader_bills_period bp 
      where bp.year_month=pYearMonth 
        and bp.account_id=pAccount_id;
  exception
    when others then 
      err:='Не найден период для загрузки счёта.';
      raise log_exception;
    
  end;
  --
    SELECT login,nvl(new_pswd,password) password,ACCOUNT_id,n_method,is_collector
      INTO plogin, ppassword,ACCOUNT,method,is_collector
    FROM ACCOUNTS  WHERE account_id=pAccount_id;
      
    
    err:=create_conn(plogin,ppassword,7,answer_mes,null);--открываем соединение
     if err='OK' then
     -- err:=create_rpt_log(5,account,answer_mes,S_file_RN);--создаём копию на диске
       err:=create_rpt_log_tbl(7,ACCOUNT,answer_mes,'ACC_BILL_PACK.xml');--создаём копию в базу
        if err!='OK' then raise log_EXCEPTION;end if;
     else --если не прошло соединение вылетаем
        raise log_EXCEPTION;
     end if;--соединение завершилось
   --пытаемся преобразовать полученное в XML  
    bill_xml:=beeline_soap_api_pckg.blob_to_xmltype(answer_mes);
   
   --Разбор и загрузка
/*YEAR_MONTH    Месяц
PHONE_NUMBER    Номер
ABONKA    Вся абонка
CALLS    Все звонки
SINGLE_PAYMENTS    Разовые начисления
DISCOUNTS    Скидки
BILL_SUM    Сумма
COMPLETE_BILL    Флаг цельности счета
ABON_MAIN    Абон. пл. по ТП
ABON_ADD    Абон. пл. за услуги
ABON_OTHER    Прочие абонки
SINGLE_MAIN    Возврат абон. пл. по ТП
SINGLE_ADD    Возврат абон. пл. за услуги
SINGLE_PENALTI    Штраф за нарушение контракта
SINGLE_CHANGE_TARIFF    Смена ТП
SINGLE_TURN_ON_SERV    Плата за подключение услуг
SINGLE_CORRECTION_ROUMING    Корректировка роуминга
SINGLE_INTRA_WEB    Услуга ИнтраВеб(запрет кор. номеров)
SINGLE_VIEW_BLACK_LIST    Просмотр черного списка
SINGLE_OTHER    Прочие разовые начисления
DISCOUNT_YEAR    Годовые скидки на абонку
DISCOUNT_SMS_PLUS    Скидка по Акции "СМС300 и +"
DISCOUNT_CALL    Налог 1.2%
DISCOUNT_COUNT_ON_PHONES    Скидка за кол-во подкл номеров
DISCOUNT_OTHERS    Прочие скидки
CALLS_COUNTRY    М/н звонки
CALLS_SITY    М/г звонки
CALLS_LOCAL    Местные звонки
CALLS_SMS_MMS    СМС и ММС
CALLS_GPRS    Интернет
CALLS_RUS_RPP    
CALLS_ALL    Сумма звонков
ROUMING_NATIONAL    Национальный роуминг
ROUMING_INTERNATIONAL    Международный роуминг
DATE_CREATED    Дата/время создания записи
USER_CREATED    Пользователь, создавший запись
USER_LAST_UPDATED    Пользователь, редактировавший запись последним
DATE_LAST_UPDATED    Дата/время последней редакции записи
DISCOUNT_SOVINTEL    Скидка СовИнтел на гор номер
BAN    
*/ 
  for c_phones in(                  
   select trim(extractvalue(value(lvl1) ,'PhoneList/error')) xml_error
         ,trim(extractvalue(value(lvl1) ,'PhoneList/obj_id')) xml_obj_id
         ,trim(extractvalue(value(lvl1) ,'PhoneList/phone_number')) xml_phone
   from table(XmlSequence(bill_xml.extract('Bills/PhoneList'))) lvl1 )
   loop
    xml_err_ph:=null;  
   if c_phones.xml_error is not null or c_phones.xml_phone is null then 
     --Добавляем в таблицу счетов с косяками
     xml_err_ph:= get_phone_by_obj_id(c_phones.xml_obj_id);
     insert into db_loader_ffb_except
       (account_id, year_month, phone_number, info, date_insert, resolve)
     values
       (ACCOUNT, pYearMonth, nvl(xml_err_ph,0),' Ошибка:'||c_phones.xml_error
       ||nvl(c_phones.xml_error,' Номер:'||nvl(c_phones.xml_phone,'не определён')),sysdate, 0);

     
   elsif c_phones.xml_error is null then 
   
     ffb:=null;
     ffb.account_id:=ACCOUNT;
     ffb.year_month:=pYearMonth;
     ffb.phone_number:=c_phones.xml_phone;
     ffb.calls_local:=0;
     single_ediniy := 0;
     for c_charges in 
         (select rtrim(extractvalue(value(lvl2) ,'charges/ChargeName'),chr(10)||chr(13)||chr(9)||chr(32)) ChargeName,
          extractvalue(value(lvl2) ,'charges/ChargeSum') ChargeSum,
          extractvalue (value(lvl2) ,'charges/ChargeID')   ChargeID,
          lvl2.extract('//charges') Charges_xml
          from table(XmlSequence(bill_xml.extract('Bills/PhoneList'))) lvl1
               ,table(XmlSequence(lvl1.extract('PhoneList/charges'))) lvl2
           where rtrim(extractvalue(value(lvl1) ,'PhoneList/phone_number'),chr(10)||chr(13)||chr(9)||chr(32))=c_phones.xml_phone
         )loop

       case c_charges.ChargeName
       when 'Суммарные начисления' then ffb.bill_sum:=to_number(replace(rtrim(c_charges.ChargeSum,chr(10)||chr(13)||chr(9)||chr(32)),',','.'), '9999999999.99')*nds ;
       when 'Скидки' then 
         ffb.discounts:=to_number(replace(rtrim(c_charges.ChargeSum,chr(10)||chr(13)||chr(9)||chr(32)),',','.'), '9999999999.99')*nds;
         if ffb.discounts!=0 then
           for c_ds in (
                   select 
                  ltrim(extractvalue(value(dd) ,'ChargeDetailsValue'),chr(10)||chr(13)||chr(9)||chr(32)) CDV
                  from 
                  table(XmlSequence(c_charges.Charges_xml.extract('charges/ChargeDetails/ChargeDetailsValue'))) dd
                  )loop 
                    case trim(regexp_substr(c_ds.CDV, '[^;]+', 1, 1))
                      when 'Корректировка абон. платы'
                           then 
                            if ms_constants.GET_CONSTANT_VALUE('SERVER_NAME')='CORP_MOBILE' then
                              ffb.discount_sovintel:=nvl(ffb.discount_sovintel,0)
                                +to_number(replace(rtrim(regexp_substr(c_ds.CDV, '[^;]+', 1, 4),chr(10)||chr(13)||chr(9)),',','.'), '9999999999.99')*nds;
                            else
                              ffb.discount_others:=nvl(ffb.discount_others,0)    
                               + to_number(replace(rtrim(regexp_substr(c_ds.CDV, '[^;]+', 1, 4),chr(10)||chr(13)||chr(9)),',','.'), '9999999999.99')*nds; 
                            end if;
                      when 'Надбавка к тарифам на услуги связи'
                           then ffb.discount_call:=nvl(ffb.discount_call,0)
                                +to_number(replace(rtrim(regexp_substr(c_ds.CDV, '[^;]+', 1, 4),chr(10)||chr(13)||chr(9)),',','.'), '9999999999.99')*nds;
                      when 'Скидка за количество подключенных номеров'
                           then ffb.discount_count_on_phones:=nvl(ffb.discount_count_on_phones,0)
                                +to_number(replace(rtrim(regexp_substr(c_ds.CDV, '[^;]+', 1, 4),chr(10)||chr(13)||chr(9)),',','.'), '9999999999.99')*nds;
                    else
                            if instr(regexp_substr(c_ds.CDV, '[^;]+', 1, 1),'Скидка на АП')>0 then
                               ffb.discount_sms_plus:=nvl(ffb.discount_sms_plus,0)
                                +to_number(replace(rtrim(regexp_substr(c_ds.CDV, '[^;]+', 1, 4),chr(10)||chr(13)||chr(9)),',','.'), '9999999999.99')*nds;
                            elsif (instr(regexp_substr(c_ds.CDV, '[^;]+', 1, 1),'Корректировка абонентской платы')>0 )
                               or (instr(regexp_substr(c_ds.CDV, '[^;]+', 1, 1),'Скидка на абонентскую плату (15%)')>0)
                               or (instr(regexp_substr(c_ds.CDV, '[^;]+', 1, 1),'Скидка на договор (20%)')>0)
                               or (instr(regexp_substr(c_ds.CDV, '[^;]+', 1, 1),'Корректировка счета(1)')>0)                                                            
                            then
                               ffb.discount_year:=nvl(ffb.discount_year,0)
                               +to_number(replace(rtrim(regexp_substr(c_ds.CDV, '[^;]+', 1, 4),chr(10)||chr(13)||chr(9)),',','.'), '9999999999.99')*nds;
                            else
                               ffb.discount_others:=nvl(ffb.discount_others,0)    
                               + to_number(replace(rtrim(regexp_substr(c_ds.CDV, '[^;]+', 1, 4),chr(10)||chr(13)||chr(9)),',','.'), '9999999999.99')*nds;
                            end if;
                    end case;
                  
                  END LOOP;
         end if;   
       when 'Абонентская плата' then 
         ffb.abonka:=to_number(replace(rtrim(c_charges.ChargeSum,chr(10)||chr(13)||chr(9)||chr(32)),',','.'), '9999999999.99')*nds ;
         for c_abon in (
               select 
              rtrim(extractvalue(value(dd) ,'ChargeDetailsValue'),chr(10)||chr(13)||chr(9)||chr(32)) CDV
              from 
              table(XmlSequence(c_charges.Charges_xml.extract('charges/ChargeDetails/ChargeDetailsValue'))) dd
              )loop
               ffap:=null;
               ffap.account_id:=account;
               ffap.year_month:=pYearMonth;
               ffap.phone_number:=c_phones.xml_phone;
               ffap.date_begin:=to_date(trim(regexp_substr(c_abon.CDV, '[^;]+', 1, 1)),'DD.MM.YYYY');-- v_date_begin;
               ffap.date_end:=to_date(trim(regexp_substr(c_abon.CDV, '[^;]+', 1, 2)),'DD.MM.YYYY');
               ffap.tariff_code:=trim(regexp_substr(c_abon.CDV, '[^;]+', 1, 3));
               ffap.abon_main:=to_number(replace(rtrim(regexp_substr(c_abon.CDV, '[^;]+', 1, 4),chr(10)||chr(13)||chr(9)),',','.'), '9999999999.99')*nds; 
               ffap.abon_add:=to_number(replace(rtrim(regexp_substr(c_abon.CDV, '[^;]+', 1, 5),chr(10)||chr(13)||chr(9)),',','.'), '9999999999.99')*nds;
               ffap.abon_all:=to_number(replace(rtrim(regexp_substr(c_abon.CDV, '[^;]+', 1, 6),chr(10)||chr(13)||chr(9)),',','.'), '9999999999.99')*nds;
               ffap.date_created:=sysdate;
               ffap.user_created:=user;
               insert into db_loader_full_bill_abon_per values ffap;
                ffb.abon_main:=nvl(ffb.abon_main,0)+ffap.abon_main;
                ffb.abon_add:=nvl(ffb.abon_add,0)+ffap.abon_add;
                ffb.abon_other:=0; 
              end loop;                                                                                             
       when 'Звонки' then ffb.calls_all:=to_number(replace(rtrim(c_charges.ChargeSum,chr(10)||chr(13)||chr(9)||chr(32)),',','.'), '9999999999.99')*nds ;
       when 'Международные звонки' then ffb.calls_country:=to_number(replace(rtrim(c_charges.ChargeSum,chr(10)||chr(13)||chr(9)||chr(32)),',','.'), '9999999999.99')*nds;
       when 'Междугородние звонки' then ffb.calls_sity:=to_number(replace(rtrim(c_charges.ChargeSum,chr(10)||chr(13)||chr(9)||chr(32)),',','.'), '9999999999.99')*nds;
       -- 'Местные звонки' и 'Местные звонки и внутрисетевой роуминг' - все относится к местным
       when 'Местные звонки' then ffb.calls_local:=to_number(replace(rtrim(c_charges.ChargeSum,chr(10)||chr(13)||chr(9)||chr(32)),',','.'), '9999999999.99')*nds;
       when 'Местные звонки и внутрисетевой роуминг' then ffb.calls_local:=to_number(replace(rtrim(c_charges.ChargeSum,chr(10)||chr(13)||chr(9)||chr(32)),',','.'), '9999999999.99')*nds;
       when 'SMS/MMS сообщения' then ffb.calls_sms_mms:=to_number(replace(rtrim(c_charges.ChargeSum,chr(10)||chr(13)||chr(9)||chr(32)),',','.'), '9999999999.99')*nds;
       when 'GPRS' then ffb.calls_gprs:=to_number(replace(rtrim(c_charges.ChargeSum,chr(10)||chr(13)||chr(9)||chr(32)),',','.'), '9999999999.99')*nds;
       --when 'Роуминг' then ffb.c;
       when 'Международный роуминг' then 
         ffb.rouming_international:=to_number(replace(rtrim(c_charges.ChargeSum,chr(10)||chr(13)||chr(9)||chr(32)),',','.'), '9999999999.99')*nds;
         if ffb.rouming_international>0 then
             for c_mnr in (
                   select 
                  ltrim(extractvalue(value(dd) ,'ChargeDetailsValue'),chr(10)||chr(13)||chr(9)||chr(32)) CDV
                  from 
                  table(XmlSequence(c_charges.Charges_xml.extract('charges/ChargeDetails/ChargeDetailsValue'))) dd
                  )loop
                   ffmn:=null;
                   ffmn.account_id:=account;
                   ffmn.year_month:=pYearMonth;
                   ffmn.phone_number:=c_phones.xml_phone;
                   ffmn.date_begin:=to_date(trim(regexp_substr(c_mnr.CDV, '[^;]+', 1, 1)),'DD.MM.YYYY');
                   ffmn.date_end:=to_date(trim(regexp_substr(c_mnr.CDV, '[^;]+', 1, 2)),'DD.MM.YYYY');
                   ffmn.rouming_country:=trim(regexp_substr(c_mnr.CDV, '[^;]+', 1, 3));
                   ffmn.rouming_calls:=to_number(replace(rtrim(regexp_substr(c_mnr.CDV, '[^;]+', 1, 4),chr(10)||chr(13)||chr(9)),',','.'), '9999999999.99')*nds;
                   ffmn.rouming_sms:=to_number(replace(rtrim(regexp_substr(c_mnr.CDV, '[^;]+', 1, 5),chr(10)||chr(13)||chr(9)),',','.'), '9999999999.99')*nds;
                   ffmn.rouming_gprs:=to_number(replace(rtrim(regexp_substr(c_mnr.CDV, '[^;]+', 1, 6),chr(10)||chr(13)||chr(9)),',','.'), '9999999999.99')*nds;
                   ffmn.company_tax:=to_number(replace(rtrim(regexp_substr(c_mnr.CDV, '[^;]+', 1, 7),chr(10)||chr(13)||chr(9)),',','.'), '9999999999.99')*nds;
                   ffmn.rouming_sum:=nvl(ffmn.rouming_calls,0)+nvl(ffmn.rouming_sms,0)+nvl(ffmn.rouming_gprs,0)+nvl(ffmn.company_tax,0);
                   ffmn.date_created:=sysdate;
                   ffmn.user_created:=user;
                   insert into db_loader_full_bill_mn_rouming values ffmn;
                   
                  END LOOP; 
         end if;                        
       when 'Национальный и внутрисетевой роуминг' then ffb.rouming_national:=to_number(replace(rtrim(c_charges.ChargeSum,chr(10)||chr(13)||chr(9)||chr(32)),',','.'), '9999999999.99')*nds;
         if ffb.rouming_national>0 then
             for c_mgr in (
                   select 
                  ltrim(extractvalue(value(dd) ,'ChargeDetailsValue'),chr(10)||chr(13)||chr(9)||chr(32)) CDV
                  from 
                  table(XmlSequence(c_charges.Charges_xml.extract('charges/ChargeDetails/ChargeDetailsValue'))) dd
                  )loop
                   ffmg:=null;
                   ffmg.account_id:=account;
                   ffmg.year_month:=pYearMonth;
                   ffmg.phone_number:=c_phones.xml_phone;
                   ffmg.date_begin:=to_date(trim(regexp_substr(c_mgr.CDV, '[^;]+', 1, 1)),'DD.MM.YYYY');
                   ffmg.date_end:=to_date(trim(regexp_substr(c_mgr.CDV, '[^;]+', 1, 2)),'DD.MM.YYYY');
                   ffmg.rouming_country:=trim(regexp_substr(c_mgr.CDV, '[^;]+', 1, 3));
                   ffmg.rouming_calls:=to_number(replace(rtrim(regexp_substr(c_mgr.CDV, '[^;]+', 1, 4),chr(10)||chr(13)||chr(9)),',','.'), '9999999999.99')*nds;
                   ffmg.rouming_sms:=to_number(replace(rtrim(regexp_substr(c_mgr.CDV, '[^;]+', 1, 5),chr(10)||chr(13)||chr(9)),',','.'), '9999999999.99')*nds;
                   ffmg.rouming_gprs:=to_number(replace(rtrim(regexp_substr(c_mgr.CDV, '[^;]+', 1, 6),chr(10)||chr(13)||chr(9)),',','.'), '9999999999.99')*nds;
                   ffmg.company_tax:=to_number(replace(rtrim(regexp_substr(c_mgr.CDV, '[^;]+', 1, 7),chr(10)||chr(13)||chr(9)),',','.'), '9999999999.99')*nds;
                   ffmg.rouming_sum:=nvl(ffmg.rouming_calls,0)+nvl(ffmg.rouming_sms,0)+nvl(ffmg.rouming_gprs,0)+nvl(ffmg.company_tax,0);
                   ffmg.date_created:=sysdate;
                   ffmg.user_created:=user;
                   insert into db_loader_full_bill_mg_rouming values ffmg;
                  END LOOP; 
         end if; 
     --  when 'Включенные минуты' then ;
       when 'Разовые начисления' then ffb.single_payments:=to_number(replace(rtrim(c_charges.ChargeSum,chr(10)||chr(13)||chr(9)||chr(32)),',','.'), '9999999999.99')*nds;
         if ffb.single_payments!=0 then
           for c_sp in (
                   select 
                    ltrim(extractvalue(value(dd) ,'ChargeDetailsValue'),chr(10)||chr(13)||chr(9)||chr(32)) CDV
                    from 
                    table(XmlSequence(c_charges.Charges_xml.extract('charges/ChargeDetails/ChargeDetailsValue'))) dd
                  )loop 
                    case trim(regexp_substr(c_sp.CDV, '[^;]+', 1, 1))
                      when 'Абонентская плата за дополнительные услуги'
                           then ffb.single_add:=nvl(ffb.single_add,0)
                                +to_number(replace(rtrim(regexp_substr(c_sp.CDV, '[^;]+', 1, 4),chr(10)||chr(13)||chr(9)),',','.'), '9999999999.99')*nds;
                      when 'Абонентская плата по тарифному плану'
                           then ffb.single_main:=nvl(ffb.single_main,0)
                                +to_number(replace(rtrim(regexp_substr(c_sp.CDV, '[^;]+', 1, 4),chr(10)||chr(13)||chr(9)),',','.'), '9999999999.99')*nds;
                      when 'Подключение услуги'
                           then ffb.single_turn_on_serv:=nvl(ffb.single_turn_on_serv,0)
                                +to_number(replace(rtrim(regexp_substr(c_sp.CDV, '[^;]+', 1, 4),chr(10)||chr(13)||chr(9)),',','.'), '9999999999.99')*nds;
                      when 'Просмотр звонков от абонентов из черного списка'
                           then ffb.single_view_black_list:=nvl(ffb.single_view_black_list,0)
                                +to_number(replace(rtrim(regexp_substr(c_sp.CDV, '[^;]+', 1, 4),chr(10)||chr(13)||chr(9)),',','.'), '9999999999.99')*nds;
                      when 'Корректировка тарификации внутрисетевого роуминга'
                           then ffb.Single_Correction_Rouming:=nvl(ffb.Single_Correction_Rouming,0)       
                                +to_number(replace(rtrim(regexp_substr(c_sp.CDV, '[^;]+', 1, 4),chr(10)||chr(13)||chr(9)),',','.'), '9999999999.99')*nds;
                      when 'Перенос облагаемых НДС начислений в Единый счет'
                           then single_ediniy:=single_ediniy 
                                +to_number(replace(rtrim(regexp_substr(c_sp.CDV, '[^;]+', 1, 4),chr(10)||chr(13)||chr(9)),',','.'), '9999999999.99')*nds;
                    else
                            if instr(regexp_substr(c_sp.CDV, '[^;]+', 1, 1),'Цена перехода')>0 then
                               ffb.single_change_tariff:=nvl(ffb.single_change_tariff,0)
                                +to_number(replace(rtrim(regexp_substr(c_sp.CDV, '[^;]+', 1, 4),chr(10)||chr(13)||chr(9)),',','.'), '9999999999.99')*nds;
                            elsif instr(regexp_substr(c_sp.CDV, '[^;]+', 1, 1),'Нарушение')>0 then
                               ffb.single_penalti:=nvl(ffb.single_penalti,0)
                               +to_number(replace(rtrim(regexp_substr(c_sp.CDV, '[^;]+', 1, 4),chr(10)||chr(13)||chr(9)),',','.'), '9999999999.99')*nds;
                            elsif instr(regexp_substr(c_sp.CDV, '[^;]+', 1, 1),'Абонентская плата')>0 
                              and to_number(replace(rtrim(regexp_substr(c_sp.CDV, '[^;]+', 1, 4),chr(10)||chr(13)||chr(9)),',','.'), '9999999999.99')=42.37
                              then ffb.single_intra_web:=nvl(ffb.single_intra_web,0)
                               + to_number(replace(rtrim(regexp_substr(c_sp.CDV, '[^;]+', 1, 4),chr(10)||chr(13)||chr(9)),',','.'), '9999999999.99')*nds;
                            else
                               ffb.single_other:=nvl(ffb.single_other,0)    
                               + to_number(replace(rtrim(regexp_substr(c_sp.CDV, '[^;]+', 1, 4),chr(10)||chr(13)||chr(9)),',','.'), '9999999999.99')*nds;
                            end if;
                    end case;
                  
                  END LOOP;
         end if;   
         else
           null;
         end case;
   end loop;
      ffb.bill_sum:=nvl(ffb.bill_sum,0) - single_ediniy;
      ffb.single_payments:=nvl(ffb.single_payments,0) - single_ediniy;
      ffb.abon_main:=nvl(ffb.abon_main,0);
      ffb.abon_add :=nvl(ffb.abon_add,0);
      ffb.abon_other:=nvl(ffb.abon_other,0);
      ffb.single_main:=nvl(ffb.single_main,0);
      ffb.single_penalti:=nvl(ffb.single_penalti,0);
      ffb.single_add :=nvl(ffb.single_add,0);
      ffb.single_change_tariff :=nvl(ffb.single_change_tariff,0);
      ffb.single_turn_on_serv :=nvl(ffb.single_turn_on_serv,0);
      ffb.single_correction_rouming :=nvl(ffb.single_correction_rouming,0);
      ffb.single_intra_web :=nvl(ffb.single_intra_web,0);
      ffb.single_view_black_list :=nvl(ffb.single_view_black_list,0);
      ffb.single_other :=nvl(ffb.single_other,0);
      ffb.discounts :=nvl(ffb.discounts,0);
      ffb.discount_year :=nvl(ffb.discount_year,0);
      ffb.discount_sms_plus :=nvl(ffb.discount_sms_plus,0);
      ffb.discount_call :=nvl(ffb.discount_call,0);
      ffb.discount_count_on_phones :=nvl(ffb.discount_count_on_phones,0);
      ffb.discount_sovintel :=nvl(ffb.discount_sovintel,0);
      ffb.discount_others :=nvl(ffb.discount_others,0);
      ffb.calls_country :=nvl(ffb.calls_country,0);
      ffb.calls_sms_mms :=nvl(ffb.calls_sms_mms,0);
      ffb.calls_sity :=nvl(ffb.calls_sity,0);
      ffb.calls_local :=nvl(ffb.calls_local,0);
      ffb.calls_gprs :=nvl(ffb.calls_gprs,0);
      ffb.rouming_national :=nvl(ffb.rouming_national,0);
      ffb.rouming_international :=nvl(ffb.rouming_international,0);  
      ffb.calls_rus_rpp:=0;
      ffb.calls_all:=nvl(ffb.calls_all,0)+nvl(ffb.calls_sms_mms,0)+nvl(ffb.calls_gprs,0);
      ffb.calls:=nvl(ffb.calls_all,0)+nvl(ffb.rouming_national,0)+nvl(ffb.rouming_international,0);
      ffb.date_created:=sysdate;
      ffb.user_created:=user;
      ffb.complete_bill:=1;
      
   if ffb.bill_sum is null then--если счёт не корректный или сменилась кодировка
     rollback;
    insert into db_loader_ffb_except
       (account_id, year_month, phone_number, info, date_insert, resolve)
     values
       (ACCOUNT, pYearMonth, xml_err_ph,c_phones.xml_obj_id||
       ' Номер:'||nvl(c_phones.xml_phone,'не определён'),sysdate, 0);
   else--Если всё ок
    insert into db_loader_full_finance_bill values ffb;  
   end if;     
   
  end if;--проверка на ошибку из Ruby 
   commit;
  end loop;
    --логируем успешное выполнение
  INSERT INTO ACCOUNT_LOAD_LOGS(ACCOUNT_LOAD_LOG_ID, ACCOUNT_ID, LOAD_DATE_TIME,
                         IS_SUCCESS, ERROR_TEXT, ACCOUNT_LOAD_TYPE_ID,BEELINE_RN)
  VALUES(NEW_ACCOUNT_LOAD_LOG_ID, pACCOUNT_ID, SYSDATE, 1,null, 7,null);commit;
  
exception  
  
    when others then  --log_EXCEPTION в частности

      err:=err||' -- '||SQLERRM||'--'|| case
                                          when SQ_Value is null then ''
                                          else TsiteAddr(mod(SQ_Value,ServerCount)+1)
                                        end;
      INSERT INTO ACCOUNT_LOAD_LOGS(ACCOUNT_LOAD_LOG_ID, ACCOUNT_ID, LOAD_DATE_TIME,
                                 IS_SUCCESS, ERROR_TEXT, ACCOUNT_LOAD_TYPE_ID)
      VALUES(NEW_ACCOUNT_LOAD_LOG_ID, pACCOUNT_ID, SYSDATE,0,err, 7);
      commit;
    
     
end;

/*=================Загрузки из программы ТАРИФЕР===================*/
  --подготовка коллекции для загрузки настроек
procedure pre_collector_acc 
  is 
begin
 collector_table.delete;
 delete from beeline_loader_inf inf where inf.account_id=93;
 commit;
end;
--наполняет коллекцию для загрузки
procedure load_collector_acc(Pphone_number in varchar2,pban in varchar2,paccount_id in integer)
  is 
  i integer;
  begin
  i:=nvl(collector_table.last+1,1);
  collector_table(i).p_n:=Pphone_number;
  collector_table(i).ban:=pban;
  collector_table(i).acc:=paccount_id;
end;
  --добавляет коллекцию в таблицу
function post_collector_acc return varchar2
  is 
  begin
  if collector_table.count>0 then  
      for i in collector_table.first .. collector_table.last loop
        UPDATE BEELINE_LOADER_INF
            SET ACCOUNT_ID = collector_table(i).acc,
                BAN = collector_table(i).ban
            WHERE PHONE_NUMBER = collector_table(i).p_n;
        IF ( sql%rowcount = 0 )
            THEN insert into BEELINE_LOADER_INF(ACCOUNT_ID,PHONE_NUMBER,BAN) values (collector_table(i).acc,collector_table(i).p_n,collector_table(i).ban);
        END IF;
      end loop;
      commit;
      return('OK');
  end if; 
 return('Error');     
end;

 
procedure update_collector_state(Paccount_id in number, Pphone_number in varchar2,Pplan_code in varchar2, Pstate in varchar2, Pvalid_state in varchar2)  
is 
Year_m integer;
begin
 Year_m:=const_year_month;
 
  UPDATE db_loader_account_phones
              SET PHONE_IS_ACTIVE = decode(Pstate,'A',1,'S',0,0),
                  CONSERVATION = decode(Pstate,
                                        'A',0,
                                        'S',decode(Pvalid_state,'Сохранение (полная)',1,0)
                                        ,0),
                  system_block=decode(Pvalid_state,'BSB',1,'BLB',1,'DUF',1,0),
                  cell_plan_code=pPlan_code,
                  last_check_date_time=sysdate
              WHERE PHONE_NUMBER = Pphone_number and account_id=Paccount_id and year_month=Year_m;
      IF ( sql%rowcount = 0 )
      THEN 
            
            insert into db_loader_account_phones
              (account_id, year_month, phone_number, phone_is_active, cell_plan_code
              , new_cell_plan_code, new_cell_plan_date, last_check_date_time, organization_id, conservation, system_block)
            values
              (Paccount_id, Year_m, Pphone_number, decode(Pstate,'A',1,'S',0,0), Pplan_code
              , null, null, sysdate, 1, decode(Pstate,
                                        'A',0,
                                        'S',decode(Pvalid_state,'Сохранение (полная)',1,0)
                                        ,0),
                                        decode(Pvalid_state,'BSB',1,'BLB',1,'DUF',1,0));
      end if;
  TEMP_ADD_ACCOUNT_PHONE_HISTORY(Pphone_number, Pplan_code,  case Pstate when 'A' then 1 when 'S' then 0 else 0 end, SYSDATE);
  commit;
end;

PROCEDURE  SET_OBJ_ID_BY_PHONE( pPHONE_NUMBER VARCHAR2 )
IS
    vACCOUNT_ID INTEGER;
BEGIN
    vACCOUNT_ID := GET_ACCOUNT_ID_BY_PHONE( pPHONE_NUMBER );
    LOAD_OBJ_ID( vACCOUNT_ID, pPHONE_NUMBER );
END;

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
/
