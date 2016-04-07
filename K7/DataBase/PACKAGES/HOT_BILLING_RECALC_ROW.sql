CREATE OR REPLACE PACKAGE HOT_BILLING_RECALC_ROW AS


  FUNCTION HOT_BILLING_GET_RETARIFFING (CALL_ROW IN CALL_TYPE, pcost_koef IN number) return CALL_TYPE;
  
  FUNCTION HOT_BILLING_AUTO_CONNECT_MG (CALL_ROW IN CALL_TYPE) return CALL_TYPE;

  
END HOT_BILLING_RECALC_ROW;

/

CREATE OR REPLACE PACKAGE BODY HOT_BILLING_RECALC_ROW IS
 

 FUNCTION HOT_BILLING_GET_RETARIFFING (CALL_ROW IN CALL_TYPE, pcost_koef IN number) return CALL_TYPE 
 as
--
-- Перетарификация строки детализации
--
--     !!!!    ВЕРСИЯ ДЛЯ К7      !!!!!!!!
--
--#Version=4
--
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
    free_min          INTEGER;
    save_min          INTEGER;
    cnt_podkl         INTEGER;
    pRes              varchar2(240);
     
    RESULT CALL_TYPE;
BEGIN
  RESULT := CALL_ROW;

  if ((CALL_ROW.SUBSCR_NO = '9660990990') or  (CALL_ROW.SUBSCR_NO = ' 9637127171')) then 
       
    p_TARIFF_ID := GET_CURR_PHONE_TARIFF_ID(CALL_ROW.SUBSCR_NO);
        -- проверяем подключено ли к этому тарифу нужное нам свойство
    select INT_TYPE into TARIF_ATTR from TARIFFS_ATTRS ta, CONGR_TARIF ct
    where upper(ta.ATTRIBUTES_NAME) = upper('Автоподключение междугороднего пакета') and 
    ta.TARIFFS_ATTRIBUTES_ID = ct.TARIFFS_ATTRIBUTES_ID and  ct.TARIFF_ID = p_TARIFF_ID;
    TARIF_ATTR := nvl(TARIF_ATTR,0);
    
    if ((TARIF_ATTR = 1) and (CALL_ROW.costnovat > 0)) then 
      pch:=0; 
      pmn:=0; 
      psc:=0;
          if (instr(CALL_ROW.DURATION, ':',1,1) = 3) and (instr(CALL_ROW.DURATION, ':',1,1) = 3) then
            pch := to_number(trim(to_char(to_date(CALL_ROW.DURATION,'HH24:MI:SS'),'HH24')));
            pmn := to_number(trim(to_char(to_date(CALL_ROW.DURATION,'HH24:MI:SS'),'MI')));
            psc := to_number(trim(to_char(to_date(CALL_ROW.DURATION,'HH24:MI:SS'),'SS'))); 
            if (psc > 3) then
              pmn := pmn + 1;
            end if;
            if (pch > 0) then
              pmn := pmn + (pch*60);
            end if;                
          end if;
          -- находим стоимость минуты
          if pmn = 0 then
            pCost_min := 0;
          else  
            pCost_min := round(CALL_ROW.costnovat / pmn * 1.18);
          end if;
              -- согласно пояснению к заданию Стоимость вызова мг :5 руб для Безлимит 990
              --                                                и 3 руб.для Безлимит 1290     
          if ((pCost_min = 5) or (pCost_min = 3)) then
            -- определяем количество бесплатных минут по тарифу
            select t.FREE_MONTH_MINUTES_CNT_FOR_RPT into free_min from TARIFFS t where t.TARIFF_ID = p_TARIFF_ID;        
            select sum(t.DURATION) into save_min from HOT_BIL_SAVE_FREE_MONTH_MIN t 
             where (t.SUBSCR_NO = CALL_ROW.SUBSCR_NO) and (trunc(t.start_time,'dd') = trunc(CALL_ROW.START_TIME,'dd'));
          
            if ((free_min - (save_min + pmn)) > 0) then 
                -- добавляем запись в накопительную таблицу
              insert into HOT_BIL_SAVE_FREE_MONTH_MIN (SUBSCR_NO, START_TIME, DBF_ID, DURATION) 
                                               values (CALL_ROW.SUBSCR_NO, CALL_ROW.START_TIME, CALL_ROW.DBF_ID, pmn);
                 -- согласно задания обнуляем стоимость минут в детализации, 
              RESULT.call_cost := 0;
              --CALL_ROW.costnovat := 0;

                --- проверим, подключена ли опция, и если нет, подключаем MGN500MIN
              select count(t.YEAR_MONTH) into cnt_podkl from DB_LOADER_ACCOUNT_PHONE_OPTS t
                    where t.PHONE_NUMBER = CALL_ROW.SUBSCR_NO and t.OPTION_CODE = 'MGN500MIN' and 
                    (((t.TURN_OFF_DATE is not null)  and (sysdate between t.TURN_ON_DATE  and t.TURN_OFF_DATE))
                     or ((t.TURN_OFF_DATE is null)  and (sysdate > t.TURN_ON_DATE)));
              if cnt_podkl = 0 then
                pRes := beeline_api_pckg.TURN_TARIFF_OPTION(CALL_ROW.SUBSCR_NO, 'MGN500MIN', 1, NULL, NULL, 'CORP_MOBILE'); 
              end if;
            
            end if;
          end if;
        
        end if;
  end if;
  
  RETURN(RESULT);
END;

END;
/