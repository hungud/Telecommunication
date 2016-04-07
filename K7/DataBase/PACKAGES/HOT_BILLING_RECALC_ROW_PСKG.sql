CREATE OR REPLACE PACKAGE CORP_MOBILE.HOT_BILLING_RECALC_ROW_PCKG AS

--
--Version=6
--
--v.1 09.06.2015 Е.Кочнев Добавил пакет для пересчета вызовов из делализации 
--
-- перерасчет роуминга
  FUNCTION HOT_BILLING_GET_RETARIFFING (CALL_ROW IN CALL_TYPE, pcost_koef IN number) return CALL_TYPE;
-- Для автоподключение междугроднего пакета зад.№ 2748  
  FUNCTION HOT_BILLING_AUTO_CONNECT_MG (CALL_ROW IN CALL_TYPE) return CALL_TYPE;
-- Процедура записи изменений в лог HOT_BIL_RECALC_LOG
procedure writelog_recalc(vSUBSCR_NO IN VARCHAR2, vSTART_TIME IN DATE, vDBF_ID IN NUMBER, vDURATION IN INTEGER, 
                          vTARIFF_ID IN INTEGER, vCOST_MIN IN INTEGER, vCNT_PODKL IN INTEGER, vNAME_OPCION IN VARCHAR2,
                          vTICKET_ID IN VARCHAR2, vCONTRACT_ID IN INTEGER, vDURATION2 IN INTEGER);
  
END ;
/

CREATE OR REPLACE PACKAGE BODY CORP_MOBILE.HOT_BILLING_RECALC_ROW_PCKG IS
 

 FUNCTION HOT_BILLING_GET_RETARIFFING (CALL_ROW IN CALL_TYPE, pcost_koef IN number) return CALL_TYPE 
 as
--
-- Перетарификация строки детализации
--
--     !!!!    ВЕРСИЯ ДЛЯ К7      !!!!!!!!
--
--#Version=6
--
-- 5. 23.06.2015 Алексеев. Изменил название атрибута ATTRIBUTES_NAME из табл. TARIFFS_ATTRS
-- 4. 28.07.2014 Уколов. Подключил перерасчет роуминга
-- 3. 27.07.2014 Уколов. В проверку роуминга отдаю и начальную, и пересчитанную стоимость.
--
  RESULT CALL_TYPE;
  cRECALC_SMS_2_0532_TO_2_95 VARCHAR2(100);
BEGIN
  RESULT := CALL_ROW;
  --Ретарификация
  if CALL_ROW.ServiceType = 'S' then
    -- Для SMS делаем перерасчёт в GSM-Corp с 2,05 на 2,95
    cRECALC_SMS_2_0532_TO_2_95 := DB_LOADER_PCKG.GET_CONSTANT_VALUE('RECALC_SMS_2.0532_TO_2.95');
    if (cRECALC_SMS_2_0532_TO_2_95 = '1') and (Round(CALL_ROW.CALL_COST, 2) = 2.05) then
      RESULT.CALL_COST := 2.95;
    end if;
  end if;
  if nvl(CALL_ROW.AT_FT_CODE,'1') not in ('CBIN','CBOUT') then
       RESULT.CALL_COST := trunc(CALL_ROW.CALL_COST * pcost_koef,2);
  end if;
  HOT_BILLING_UPDATE_LAST_ROAMNG(CALL_ROW, RESULT);
  -- Пересчет роуминга (перетарификация)
  HOT_BILLING_RETARIF_ROAMING(RESULT);
  RESULT.COST_CHNG := RESULT.CALL_COST - CALL_ROW.CALL_COST;
  RETURN(RESULT);
END;

FUNCTION HOT_BILLING_AUTO_CONNECT_MG (CALL_ROW IN CALL_TYPE) return CALL_TYPE
as
  -- #Version=1  
  -- Для автоподключение междугроднего пакета зад.№ 2748 
    p_TARIFF_ID       INTEGER;
    TARIF_ATTR        INTEGER;
    pch               INTEGER; 
    pmn               INTEGER; 
    psc               INTEGER;
    pCost_min         number;
    cnt_podkl         INTEGER;
    cnt_podkl2        INTEGER;
    cnt_podkl3        INTEGER;
    flag_podkl        INTEGER;
    pRes              varchar2(240);
    SUBSCR_NO         varchar2(11);
    OBNOVL            INTEGER;                                                                                                                                                                                                                                                                                                                                                                                     
    SUM_MNT           INTEGER;
    pragma autonomous_transaction;  
    RESULT            CALL_TYPE;
    pTICKET_ID        varchar2(15);
    pLimit_Min        INTEGER;
    pcontract_id      INTEGER;
    Date_Time_Podkl   date;
    date_on_podkl     date;
    date_contract     date;
    login             VARCHAR2(30 CHAR);
    new_pswd          VARCHAR2(30);
    account_number    Integer;
    uir               varchar2(32767);
    pANSWER           SOAP_API_ANSWER_TYPE := SOAP_API_ANSWER_TYPE(NULL, NULL,null); 
    option_tarif      varchar2(16 char);
    tst               Integer;
    IS_COLLECTOR      Integer;
    log_in            Integer;
    
BEGIN
  tst          := 0;
  OBNOVL       := 0;  
  RESULT       := CALL_ROW;
  SUBSCR_NO    := RESULT.SUBSCR_NO;       
  pLimit_Min   := 4;
  option_tarif := 'MGN500MIN';             
  pTICKET_ID   := ''; 
  pcontract_id := 0; 
  pch          := 0; 
  pmn          := 0; 
  psc          := 0;
  pCost_min    := 0;               
  SUM_MNT      := 0;          
  cnt_podkl    := 0;
  cnt_podkl2   := 0;
  cnt_podkl3   := 0;
  flag_podkl   := 0;
  IS_COLLECTOR := 0;
  log_in       := 0; 
  
  if RESULT.servicetype = 'C' and RESULT.costnovat > 0 and RESULT.at_ft_de  not like 'Моя страна%' then
    IS_COLLECTOR := nvl(GET_IS_COLLECTOR_BY_PHONE (RESULT.SUBSCR_NO), 0);
    
    if IS_COLLECTOR = 1 then  
      if to_char(RESULT.START_TIME, 'MM') = to_char(sysdate, 'MM') then -- работаем только со звонками за текущий месяц
        
        p_TARIFF_ID := GET_CURR_PHONE_TARIFF_ID(RESULT.SUBSCR_NO);
        
        -- проверяем подключено ли к этому тарифу нужное нам свойство
        select COUNT(ta.INT_TYPE) into TARIF_ATTR 
          from TARIFFS_ATTRS ta, CONGR_TARIF ct
         where upper(ta.ATTRIBUTES_NAME) = upper('AUTO_CONNECT_MGN500MIN')
          and ta.TARIFFS_ATTRIBUTES_ID = ct.TARIFFS_ATTRIBUTES_ID 
          and  ct.TARIFF_ID = p_TARIFF_ID 
          AND TA.INT_TYPE = 1;
        
        TARIF_ATTR := nvl(TARIF_ATTR,0);

        -- тариф наш, определяем минуты
        if TARIF_ATTR > 0 then 
          if instr(RESULT.DURATION, ':',1,1) = 3 and instr(RESULT.DURATION, ':',1,2) = 6 then
            pch := to_number(trim(to_char(to_date(RESULT.DURATION,'HH24:MI:SS'),'HH24')));
            pmn := to_number(trim(to_char(to_date(RESULT.DURATION,'HH24:MI:SS'),'MI')));
            psc := to_number(trim(to_char(to_date(RESULT.DURATION,'HH24:MI:SS'),'SS'))); 
            
            if psc > 3 then
              pmn := pmn + 1;
            end if;
            if pch > 0 then
              pmn := pmn + (pch*60);
            end if;   
          end if; -- (instr(CALL_ROW.DURATION, ':',1,1) = 3) and (instr(CALL_ROW.DURATION, ':',1,2) = 6)
         
         -- находим стоимость минуты
          if pmn > 0 then
            pCost_min := round(CALL_ROW.costnovat * 1.18 / pmn );
          end if;
          -- согласно пояснению к заданию Стоимость вызова мг :5 руб для Безлимит 990 и 3 руб.для Безлимит 1290     
          if pCost_min = 5 or pCost_min = 3 then
            -- определяем контракт и дату
            pcontract_id := GET_ID_LAST_CONTRACT_BY_PHONE(RESULT.SUBSCR_NO);
            select t.contract_date into date_contract from CONTRACTS t where t.contract_id = pcontract_id;
            -- проверяем было ли уже подключение 3 раза
            -- первая проверка
        
            select count(t.YEAR_MONTH), max(t.turn_on_date) into cnt_podkl, date_on_podkl from DB_LOADER_ACCOUNT_PHONE_OPTS t
             where t.PHONE_NUMBER = SUBSCR_NO and t.OPTION_CODE = option_tarif ; 
            
            if cnt_podkl > 0 then       
              flag_podkl := 1;
            end if;   
          
           if cnt_podkl = 0 then       
            -- вторая проверка
              select t.login, t.new_pswd, t.account_number into login, new_pswd, account_number from ACCOUNTS t 
               where t.account_number = get_account_number_by_phone(SUBSCR_NO);
              
              select BEELINE_SOAP_API_PCKG.auth(login, new_pswd) into uir from dual;
              
              pANSWER := BEELINE_SOAP_API_PCKG.getServiceList(BEELINE_SOAP_API_PCKG.auth(login, new_pswd),SUBSCR_NO, account_number,'');
              
              if pANSWER.Err_text='OK' then  
                select count(serviceName) into cnt_podkl2 from
                  (select substr(extractvalue (value(d) ,'servicesList/ctn'),-10) ctn,
                            trim(extractvalue (value(d) ,'/servicesList/serviceId')) serviceId,
                            CONVERT_PCKG.TIMESTAMP_TZ_TO_DATE(extractvalue (value(d) ,'/servicesList/startDate')) startDate,
                            CONVERT_PCKG.TIMESTAMP_TZ_TO_DATE(extractvalue (value(d) ,'/servicesList/endDate')) endDate,
                            trim(extractvalue (value(d) ,'/servicesList/serviceName')) serviceName
                        from table(XmlSequence(pANSWER.ANSWER.extract('S:Envelope/S:Body/ns0:getServicesListResponse/servicesList'
                                                                    ,'xmlns:S="http://schemas.xmlsoap.org/soap/envelope/" xmlns:ns0="urn:uss-wsapi:Subscriber"')
                                              )
                                  ) d
                  ) where serviceName = option_tarif;           
              else
                cnt_podkl2 := 0;
              end if;
            end if;
            
            if cnt_podkl2 > 0 then       
              flag_podkl := flag_podkl +1;
            end if;
            
            if cnt_podkl = 0 and cnt_podkl2 = 0 then       
            -- третья проверка
              select count(r.soc) into cnt_podkl3 from table(TARIFF_RESTS_TABLE(SUBSCR_NO)) r where r.soc = option_tarif;
            end if;
            
            if cnt_podkl3 > 0 then       
              flag_podkl := flag_podkl +1;
            end if;  
            
            if flag_podkl > 0 then 
             -- определяем первую дату подключения . 
             select MIN(nvl(tol.EFF_DATE, tol.REQUEST_DATE_TIME)) into Date_Time_Podkl 
               from TARIFF_OPTIONS_REQ_LOG tol, BEELINE_TICKETS bt
              where tol.PHONE_NUMBER = SUBSCR_NO  
                and tol.OPTION_CODE = option_tarif
                and tol.REQUEST_ID = bt.TICKET_ID(+) 
                and bt.ANSWER = 1 
                and tol.request_initiator <> 'RETARIF';
             -- это только для теста 
             login := to_char(Date_Time_Podkl, 'dd.mm.yyyy HH24:MI:SS');
             uir := to_char(RESULT.START_TIME, 'dd.mm.yyyy HH24:MI:SS');

             
             if Date_Time_Podkl > RESULT.START_TIME then
               flag_podkl := 0;
             end if;
             
           end if;
           
            if flag_podkl = 0 then 
            -- подключения не было, обнуляем, более лимита подключаем
              if pmn > pLimit_Min then
              -- надо ли подключать пакет?
                OBNOVL := 1;
              else -- проверим были ли ранее обнуленные звонки межгорода
                
                SUM_MNT := 0;
                
                execute immediate 
                'select sum(r.mnt) from (
                                         select to_number(trim(to_char(to_date(t.DURATION,''HH24:MI:SS''),''HH24'')))  * 60 + 
                                                to_number(trim(to_char(to_date(t.DURATION,''HH24:MI:SS''),''MI''))) +   
                                                case when to_number(trim(to_char(to_date(t.DURATION,''HH24:MI:SS''),''SS''))) > 2 then 1 else 0 end mnt 
                                           from call_'||to_char(sysdate,'mm_yyyy')||' t 
                                          where t.subscr_no = '''|| SUBSCR_NO ||'''  
                                            and t.start_time < :cur_time
                                            and t.call_cost = 0 
                                            and to_char(t.start_time, ''MM'') = to_char(sysdate, ''MM'') 
                                            and t.at_ft_de  not like ''Моя страна%'' 
                                            and t.servicetype = ''C'' 
                                            and nvl(GET_IS_COLLECTOR_BY_PHONE (t.SUBSCR_NO), 0) = 1
                                            and GET_CURR_PHONE_TARIFF_ID(t.SUBSCR_NO) in (
                                                                                          select ct.TARIFF_ID 
                                                                                            from TARIFFS_ATTRS ta, CONGR_TARIF ct 
                                                                                           where upper(ta.ATTRIBUTES_NAME) = upper(''AUTO_CONNECT_MGN500MIN'') 
                                                                                             and ta.TARIFFS_ATTRIBUTES_ID = ct.TARIFFS_ATTRIBUTES_ID 
                                                                                             AND TA.INT_TYPE = 1
                                                                                         )
                                            and to_number(trim(to_char(to_date(t.DURATION,''HH24:MI:SS''),''HH24'')))  * 60 + 
                                                to_number(trim(to_char(to_date(t.DURATION,''HH24:MI:SS''),''MI''))) +   
                                                case when to_number(trim(to_char(to_date(t.DURATION,''HH24:MI:SS''),''SS''))) > 2 then 1 else 0 end > 0 
                                            and round(t.costnovat * 1.18 / (to_number(trim(to_char(to_date(t.DURATION,''HH24:MI:SS''),''HH24'')))  * 60 +  
                                                                            to_number(trim(to_char(to_date(t.DURATION,''HH24:MI:SS''),''MI''))) +   
                                                                            case when to_number(trim(to_char(to_date(t.DURATION,''HH24:MI:SS''),''SS''))) > 2 then 1 else 0 end
                                                                           ) 
                                                     ) in (5, 3)
                                        ) r' into SUM_MNT USING RESULT.START_TIME;
                
                SUM_MNT := nvl(SUM_MNT,0); 
                
                if (pmn + SUM_MNT) > pLimit_Min then  
                  OBNOVL := 1;
                end if;
              end if;  -- (pmn > pLimit_Min)
              if (OBNOVL = 1) and  (Date_Time_Podkl is null)  then
              begin
                pRes := beeline_api_pckg.TURN_TARIFF_OPTION(SUBSCR_NO, option_tarif, 1, NULL, NULL, 'AUTOMAT');
                pTICKET_ID :=  substr(pRes, 10, 15);
              
              exception 
                when others then 
                 RESULT.call_cost := 0;
                 insert  into HOT_BIL_RECALC_LOG2(SUBSCR_NO, START_TIME, SERVICETYPE, COSTNOVAT, AT_FT_DE, IS_COLLECTOR, MM, TARIFF_ID, 
                                        TARIF_ATTR, COST_MIN, CONTRACT_ID, DATE_TIME_PODKL, CNT_PODKL, CNT_PODKL2, CNT_PODKL3)
                         values(SUBSCR_NO, RESULT.START_TIME, RESULT.servicetype, RESULT.costnovat, RESULT.at_ft_de, IS_COLLECTOR, to_char(RESULT.START_TIME, 'MM'), p_TARIFF_ID,
                                      TARIF_ATTR, pCost_min, pcontract_id, Date_Time_Podkl, cnt_podkl, cnt_podkl2, cnt_podkl3);                       
                  commit;                                 
               
              end;
              end if;
              
              RESULT.call_cost := 0;
              
              -- в журнал пишем все обнуленные записи для отчетности 
              if tst = 0 then --tst - только для теста
                writelog_recalc(SUBSCR_NO , RESULT.START_TIME, RESULT.DBF_ID, pmn, p_TARIFF_ID, pCost_min, cnt_podkl, option_tarif, pTICKET_ID, pcontract_id, SUM_MNT);
                log_in := 1;
              end if;
            end if; --if (flag_podkl = 0) 
            --- вариант при новом контракте
            
            if  cnt_podkl > 0 then
              -- если подключение уже было, проверяем дату контракта
              if date_contract > date_on_podkl then
                -- контракт новый и по нему еще не было подключений
                -- проверим, надо ли подключать пакет?  
                if pmn > pLimit_Min then
                  OBNOVL := 1;
                else -- проверим были ли ранее обнуленные звонки межгорода
                  SUM_MNT := 0;
                  execute immediate 
                  'select sum(r.mnt) from (
                                           select ((to_number(trim(to_char(to_date(t.DURATION,''HH24:MI:SS''),''HH24'')))  * 60) + 
                                                    to_number(trim(to_char(to_date(t.DURATION,''HH24:MI:SS''),''MI''))) +   
                                                    case when to_number(trim(to_char(to_date(t.DURATION,''HH24:MI:SS''),''SS''))) > 2 then 1 else 0 end) mnt 
                                             from call_'||to_char(sysdate,'mm_yyyy')||' t 
                                            where t.subscr_no = '''|| SUBSCR_NO ||'''  
                                              and (t.start_time between :cur_time and :time_dog)
                                              and (t.call_cost = 0) 
                                              and (to_char(t.start_time, ''MM'') = to_char(sysdate, ''MM'')) 
                                              and t.at_ft_de  not like ''Моя страна%'' 
                                              and (t.servicetype = ''C'') 
                                              and (nvl(GET_IS_COLLECTOR_BY_PHONE (t.SUBSCR_NO), 0) = 1)
                                              and (GET_CURR_PHONE_TARIFF_ID(t.SUBSCR_NO) in (
                                                                                             select ct.TARIFF_ID 
                                                                                               from TARIFFS_ATTRS ta, CONGR_TARIF ct 
                                                                                              where (upper(ta.ATTRIBUTES_NAME) = upper(''AUTO_CONNECT_MGN500MIN'')) 
                                                                                                and (ta.TARIFFS_ATTRIBUTES_ID = ct.TARIFFS_ATTRIBUTES_ID) 
                                                                                                AND (TA.INT_TYPE = 1)))
                                              and (((to_number(trim(to_char(to_date(t.DURATION,''HH24:MI:SS''),''HH24'')))  * 60) + 
                                                     to_number(trim(to_char(to_date(t.DURATION,''HH24:MI:SS''),''MI''))) +   
                                                     case when to_number(trim(to_char(to_date(t.DURATION,''HH24:MI:SS''),''SS''))) > 2 then 1 else 0 end) > 0) 
                                              and (round(t.costnovat * 1.18 / ((to_number(trim(to_char(to_date(t.DURATION,''HH24:MI:SS''),''HH24'')))  * 60) +  
                                                                                to_number(trim(to_char(to_date(t.DURATION,''HH24:MI:SS''),''MI''))) +   
                                                                                 case when to_number(trim(to_char(to_date(t.DURATION,''HH24:MI:SS''),''SS''))) > 2 then 1 else 0 end
                                                        )
                                                  ) in (5, 3))                    
                                          ) r' into SUM_MNT USING RESULT.START_TIME, date_contract ;
                                          
                  SUM_MNT := nvl(SUM_MNT,0);
                 
                 if (pmn + SUM_MNT) > pLimit_Min then  
                    OBNOVL := 1;
                  end if;
                end if;  -- (pmn > pLimit_Min)
                if OBNOVL = 1 then
                  pRes := beeline_api_pckg.TURN_TARIFF_OPTION(SUBSCR_NO, option_tarif, 1, NULL, NULL, 'AUTOMAT');
                  pTICKET_ID :=  substr(pRes, 10, 15);
                end if;
                --RESULT.call_cost := 0;
                -- в журнал пишем все обнуленные записи для отчетности 
                if (tst = 0) then
                  writelog_recalc(SUBSCR_NO , RESULT.START_TIME, RESULT.DBF_ID, pmn, p_TARIFF_ID, pCost_min, cnt_podkl, option_tarif, pTICKET_ID, pcontract_id, SUM_MNT);
                  log_in := 1;
                end if;
              end if; -- if (date_contract >= date_on_podkl)
            end if; -- if (cnt_podkl > 0)
          end if; -- if ((pCost_min = 5) or (pCost_min = 3)) 
        end if;  -- if (TARIF_ATTR > 0)  
      end if; -- ((to_char(RESULT.START_TIME, 'MM') = to_char(sysdate, 'MM'))
    end if;  -- nvl(GET_IS_COLLECTOR_BY_PHONE (CALL_ROW.SUBSCR_NO), 0) = 1
  end if;    -- ((CALL_ROW.servicetype = 'C') and (CALL_ROW.costnovat > 0)
  /*
  if  log_in = 0 and (Date_Time_Podkl is not null) then 
    begin
      insert into HOT_BIL_RECALC_LOG2(SUBSCR_NO, START_TIME, SERVICETYPE, COSTNOVAT, AT_FT_DE, IS_COLLECTOR, MM, TARIFF_ID, 
                                      TARIF_ATTR, COST_MIN, CONTRACT_ID, DATE_TIME_PODKL, CNT_PODKL, CNT_PODKL2, CNT_PODKL3)
                         values(SUBSCR_NO, RESULT.START_TIME, RESULT.servicetype, RESULT.costnovat, RESULT.at_ft_de, IS_COLLECTOR, to_char(RESULT.START_TIME, 'MM'), p_TARIFF_ID,
                                      TARIF_ATTR, pCost_min, pcontract_id, Date_Time_Podkl, cnt_podkl, cnt_podkl2, cnt_podkl3);                       
      commit;                            
    exception 
     when others then 
     null;
    end;  
  end if;
  */
  RETURN(RESULT);
END;

procedure writelog_recalc(vSUBSCR_NO IN VARCHAR2, vSTART_TIME IN DATE, vDBF_ID IN NUMBER, vDURATION IN INTEGER, vTARIFF_ID IN INTEGER, 
                          vCOST_MIN IN INTEGER, vCNT_PODKL IN INTEGER, vNAME_OPCION IN VARCHAR2, vTICKET_ID IN VARCHAR2, 
                          vCONTRACT_ID IN INTEGER, vDURATION2 IN INTEGER) AS
     pragma autonomous_transaction;                          
begin
  
     insert into HOT_BIL_RECALC_LOG (SUBSCR_NO, START_TIME, DBF_ID, DURATION, TARIFF_ID, COST_MIN, CNT_PODKL, NAME_OPCION, RECORD_TIME, TICKET_ID, CONTRACT_ID, DURATION2)
                              values (vSUBSCR_NO, vSTART_TIME, vDBF_ID, vDURATION, vTARIFF_ID, vCOST_MIN, vCNT_PODKL, vNAME_OPCION, sysdate, vTICKET_ID, vCONTRACT_ID, vDURATION2);
     commit;   
     exception 
     when others then 
       rollback;
                     
   
end;

END;
/