
  CREATE OR REPLACE PROCEDURE "SIM_TRADE"."SMS_SYSTEM_ERROR_NOTICE" is
--#Version=7
--7 16.08.2013 Павел Проверка размера табличных пространств 
--6 вызов PRC_LOG_WORK_SERVICE (логирование работы сервисов) вместо проверки кабинетов API 
--5 06.08.2013 Лев добавил проверку ответа при проверке API 
--4 04.08.2013 Павел добавил монитор сервисов 
--3 19.07.2013 Лев Добавление в мониторинг проверки работы сервиса USSD 
--2 18.07.2013 Лев Добавление в мониторинг проверки работы сервиса teletie(Apache) платежи 
  msg varchar2(300);--текст смс-сообщения;       
   
  -- 
  Sresponce varchar2(3000); 
 -- err1 varchar2(3000); 
  --       
  TYPE T_OBJNAME IS TABLE OF VARCHAR2(128);   
  OBJ1 T_OBJNAME;   
  s1 varchar2(128);   
  type Serv_table is table of varchar2(1000) INDEX BY binary_integer;TsiteAddr Serv_table;   
  TempField varchar2(600);   
  function get_type_active(type_value in varchar2)return number is   
    begin   
      return strInLike(type_value,MS_PARAMS.GET_PARAM_VALUE('SMS_SYSTEM_ERROR_NOTICE_TYPES'),';','()');   
    end;   
    --HotBilling   
  function check_HB return number is    
    result number;   
    Ssql varchar2(32000);   
   begin   
    if ms_constants.GET_CONSTANT_VALUE('SERVER_NAME')='CORP_MOBILE' then   
     ssql:='begin
     select max(t) into :result
     from ( select count(*) as t 
            from hot_billing_files hbf 
            where hbf.load_edate is null and substr(hbf.file_name,-3)=''dbf'' 
            and hbf.load_sdate<=sysdate-to_number(MS_params.GET_PARAM_VALUE(''DELAY_NOTICE_HOT_BILL_ERROR''))/24 
            union all 
            select case 
                   when max(to_date(substr(hbf.file_name, -19, 15), ''yyyymmdd-hh24miss'')) <=sysdate-to_number(MS_params.GET_PARAM_VALUE(''DELAY_NOTICE_HOT_BILL_ERROR''))/24 then 1 else 0   
                   end case  
            from hot_billing_files hbf where substr(hbf.file_name,-3)=''dbf'') ; 
      exception
       when others then :result:=1;
     end;';   
    elsif ms_constants.GET_CONSTANT_VALUE('SERVER_NAME')='GSM_CORP' then    
     ssql:='begin
     select PKG_TRF_FILEAPI.getFileCount(''D:\\ftp\\gsm\\BEELINE\\BILLING\\POSTPAID'') into :result from dual;
     end;';   
    else return 0;    
    end if;   
    execute immediate ssql using in out result;   
    if  ms_constants.GET_CONSTANT_VALUE('SERVER_NAME')='GSM_CORP' and result<4 then result:=0;end if;   
    return result;   
   end;    
    --Report data   
  function check_Report(num in number) return number is    
    result number;   
    begin   
     select case sysdate-max(load_date_time)    
            WHEN 0 then 0.00000001    
            ELSE sysdate-max(load_date_time)    
            end into result   
            from ACCOUNT_LOAD_LOGS WW    
            WHERE WW.ACCOUNT_LOAD_TYPE_ID=num AND IS_SUCCESS=1 ;    
    if result>0.1 then result:=1; else result:=0;end if;   
    return result;   
    exception   
     when others then return 1;   
    end;   
--max 1 sms per 12 h.   
  Function sms_not_exists(var in varchar2) return boolean is   
    c number;   
    begin   
      select count(*) into c from log_send_sms t where    
      t.date_send>sysdate-720/1440 and t.sms_text like '%'||var||'%';   
      if c>0 then return false; else return true;end if;   
    exception   
      when no_data_found then return true;   
      when others then return false;      
    end;    
--sms send   
  Procedure send_sys_msg(message in varchar2) is    
      sFld varchar2(200);   
      nPozDivider number;   
      nIndexField number;   
      sTMP varchar2(1000);   
      res varchar2(300);   
    begin    
      sTMP:=MS_PARAMS.GET_PARAM_VALUE('SMS_SYSTEM_ERROR_NOTICE_PHONES');     
      nIndexField:=0;   
      loop--парсинг строки
      IF length(sTMP)<>10 then
       nPozDivider:=instr(sTMP,';',1,1);
       sFld:= substr(sTMP,1,nPozDivider-1);
       sTMP:= substr(sTMP,nPozDivider+1);
      ELSE
       sFld:=sTMP;
      END IF; 
      
      
      if sfld is not null then
        res:=loader3_pckg.SEND_SMS(sfld,'system',message);
      end if;
      nIndexField:=nIndexField+1;
      exit when nvl(nPozDivider,0)=0;
      end loop;   
    end;   
  
  
    -- Проверка зависших job, которые выполняются больше 15 минут.   
    function check_hovering_jobs return number is   
     tmpCnt Number;   
    begin   
      select count(*) INTO tmpCnt from (select job_name, sysdate-last_start_date from DBA_SCHEDULER_JOBS where (job_name like 'J_LOAD_REPORT%' OR job_name like 'J_LOAD_PHONES%' OR job_name like 'J_LOAD_PAYMENTS%') AND STATE='RUNNING' AND (last_start_date)<sysdate-30/1440);   
      return tmpCnt;   
    end;   
      
    -- Проверка job по блоку-разблоку абонентов.   
    function check_Block_Unlock return number is   
     tmpCnt Number;   
    begin   
      select count(*) INTO tmpCnt from (select * from dba_scheduler_jobs r where r.job_name like 'J_%LOCK_CLIENT%' and r.ENABLED!='TRUE');   
      return tmpCnt;   
    end;   
    --Проверка работы серверов    
    Function check_loader_servers return varchar2   
      is    
  ServerCount integer;   
  req        utl_http.req;--запрос   
  resp       utl_http.resp;--ответ   
  urls       varchar2(100);   
  result varchar2(200);   
      begin   
      TempField:=MS_PARAMS.GET_PARAM_VALUE('ROBOT_SITE_ADRESS');   
      ServerCount:=(LENGTH(MS_PARAMS.GET_PARAM_VALUE('ROBOT_SITE_ADRESS'))   
      -LENGTH(REPLACE(MS_PARAMS.GET_PARAM_VALUE('ROBOT_SITE_ADRESS') , ';'))); --количество записей   
        for n in 1..ServerCount   
         loop   
          TsiteAddr(n):= substr(TempField,1,instr(TempField,';',1,1)-1);   
          TempField:= substr(TempField,instr(TempField,';',1,1)+1);   
         end loop;    
         
      for c in 1..ServerCount loop     
       urls :=TsiteAddr(c);   
          begin   
          utl_http.set_transfer_timeout(30);   
          req:= utl_http.begin_request(urls);   
          utl_http.set_body_charset(req,'UTF-8');   
          resp := utl_http.get_response(req);   
          if resp.status_code in (200,304) then result:=result+'';   
          else result:=result+TsiteAddr(c);   
          end if;   
          UTL_HTTP.END_RESPONSE(resp);   
          exception   
          when others then   
          if nvl(resp.status_code,0)>0 then UTL_HTTP.END_RESPONSE(resp);end if;    
          result:=result||TsiteAddr(c);     
          end;   
      end loop;   
if length(result)<2 then result:=null;end if;   
return result;   
end;  
 
--Проверка работы по отдельному адресу 
  Function check_server(s_url in varchar2) return integer   
      is      
  req        utl_http.req;--запрос   
  resp       utl_http.resp;--ответ    
  result integer;   
      begin        
          begin   
          utl_http.set_transfer_timeout(10);   
          req:= utl_http.begin_request(s_url);   
          utl_http.set_body_charset(req,'UTF-8');   
          resp := utl_http.get_response(req);   
          if resp.status_code in (200) then result:=1;   
          else result:=0;   
          end if;   
          UTL_HTTP.END_RESPONSE(resp);   
          exception   
          when others then   
          if nvl(resp.status_code,0)>0 then UTL_HTTP.END_RESPONSE(resp);end if;    
          result:=0;     
          end;     
return result;   
end;  
--Проверка переполнения TableSpace
Function check_ts_size return integer
  is 
result integer;
begin  
select a.tablespace_name||' '||to_char(round(100-a.free_space/(tbs_size/100)))||'%',1 into Sresponce,result
from
(select tablespace_name, round(sum(bytes)/1024/1024 ,2) as free_space
from dba_free_space group by tablespace_name) a,
(select tablespace_name, sum(bytes)/1024/1024 as tbs_size
from dba_data_files group by tablespace_name
UNION
select tablespace_name, sum(bytes)/1024/1024 tbs_size
from dba_temp_files
group by tablespace_name ) b
where a.tablespace_name(+)=b.tablespace_name and 
a.tablespace_name not like 'CALL%' and a.tablespace_name not in ('SYSAUX','SYSTEM','UNDOTBS1') 
and(100-a.free_space/(tbs_size/100))>90; 
return result;
exception
  when others then return 0;
end;
 
-----основной блок  
begin   
  msg:=null;   

if get_type_active('TS')=1 and check_ts_size=1 and sms_not_exists('TABLESPACE TOO FAT')    
  then                
msg:=msg||';'||Sresponce||':TABLESPACE TOO FAT;';
Sresponce:=null;   
end if;     
if get_type_active('HB')=1 and check_HB>0.5 and sms_not_exists('HotBilling long pause')    
  then                
msg:=msg||';HotBilling long pause;';   
end if;    
if get_type_active('B_UB')=1 and check_Block_Unlock>0 and sms_not_exists('Block-Unlock jobs disable')    
  then                
msg:=msg||';'||check_Block_Unlock||' Block-Unlock jobs disable;';   
end if;    
if get_type_active('RD')=1 and check_Report(6)>0 and sms_not_exists('ReportData Alert')   
  then                
msg:=msg||';ReportData Alert;';   
end if;    
if get_type_active('P')=1 and check_Report(1)>0 and sms_not_exists('Payments Alert')   
  then                
msg:=msg||';Payments Alert;';   
end if;   
if get_type_active('ST')=1 and check_Report(3)>0 and sms_not_exists('State Alert')   
then                
msg:=msg||';State Alert;';   
end if;   
if get_type_active('SER')=1 then    
   TempField:=check_loader_servers;   
   if TempField is not null and sms_not_exists('Serv:%died')   
      then msg:=msg||';Serv:'||TempField||' died;';   
   end if;   
end if; 
    
 
  
if check_hovering_jobs>0 then begin   
 --select username INTO SCHEMA_ from v$session WHERE AUDSID = USERENV('sessionid');   
 --execute immediate 'select ''exec DBMS_SCHEDULER.DISABLE('''||chr(39)||job_name||chr(39)||''', TRUE);'' from DBA_SCHEDULER_JOBS where OWNER=''CORP_MOBILE''' BULK COLLECT INTO OBJ1;   
 execute immediate 'select owner||''.''||job_name from DBA_SCHEDULER_JOBS where (job_name like ''J_LOAD_REPORT%'' OR job_name like ''J_LOAD_PHONES%'' OR job_name like ''J_LOAD_PAYMENTS%'' OR job_name like ''J_BLOCK_CLIENT%'' OR job_name like ''J_UNBLOCK_CLIENT%'') AND STATE=''RUNNING'' AND (last_start_date)<sysdate-25/1440' BULK COLLECT INTO OBJ1;   
 for A IN 1..OBJ1.LAST LOOP   
  s1:=OBJ1(A);   
  s1:='begin DBMS_SCHEDULER.STOP_JOB('''||s1||''', TRUE); end; ';   
  --if not to_number(to_char(sysdate,'HH24')) between 0 and 8 then   
   --msg:=msg||';h_j:'||s1;   
  --end if;   
  begin   
   execute immediate s1;   
--   dbms_output.put_line(s1);   
  EXCEPTION   
   WHEN OTHERS THEN   
   dbms_output.put_line('Ошибка ');   
   dbms_output.put_line(s1);   
  END;    
 END LOOP;   
end;   
end if;
if msg is not null then send_sys_msg(msg);end if;   
  
if Sresponce is null then null;end if;  
  commit; 
end SMS_SYSTEM_ERROR_NOTICE;
