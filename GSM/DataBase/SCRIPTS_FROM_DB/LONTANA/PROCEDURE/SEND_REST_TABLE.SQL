
  CREATE OR REPLACE PROCEDURE "LONTANA"."SEND_REST_TABLE" AS
--
--Version=9
--
--v9. Соколов 08.02.2016 По просьбе менеджеров GSM, для Tariff_id=2277 добавлено исключение
--v.8 Алексеев 15.01.2015 Убрал "Добавляем 10% к платежу при пополнении через сайт www.gsmcorporacia.ru/oplata_uslug и через приложение www.gsmcorp.ru/m"  из смс
--v.7 Матюнин 28.12.2015 По просьбе менеджеров GSM, для Tariff_id=1758 добавлено исключение по голосу
--v.6 Алексеев 25.11.2015 Добавил текст "Добавляем 10% к платежу при пополнении через сайт www.gsmcorporacia.ru/oplata_uslug и через приложение www.gsmcorp.ru/m" к смс
--v.5 Афросин  05.10.2015 - на тарифах
--                           ЗАКРЫТ!   Москва на связи NEW (1300)
--                           ЗАКРЫТ!   Москва на связи NEW (гор) (1500)
--      
--v.4 Афросин  01.10.2015 - на тарифах
--                            ЗАКРЫТ! ULTRA VIP (1400)
--                            Формула Свободы ВИП (1180) NEW
--                            Формула Свободы ВИП (1300) NEW
--                            Привилегированный 1500
--                            ЗАКРЫТ! ULTRA VIP (гор) (1600)
--                            Привилегированный СП (1100)
--                            ЗАКРЫТ! Полный безлимит 1300(NEW)
--
--                            нужно изменить инфу в остатках пакетов на следующую :
--                            местные вызовы на номера других операторов сотовой и фиксированной связи- без ограничения
--v.3 Кочнев  08.09.2015 - Для тарифа ULTRA VIP 2015 (1400) ИД = 1978 всегда выдаватьь "*Без ограничения*"
--v.2 Афросин 20.05.2015 - Необходимо убрать из USSD команды остатки по пакетам Полный безлимит 1300 и Ультра 1400 новый
--v.1 Афросин 20.02.2015 - Добавил процедуру
--
  CURSOR phones is
    select PHONE_NUMBER from USSD_TARIFF_REST_QUEUE;
    

  res VARCHAR2(1000);
  vCURR_PHONE_TARIFF_ID INTEGER;

BEGIN

    
  for ph in phones loop
    
    vCURR_PHONE_TARIFF_ID := nvl(GET_CURR_PHONE_TARIFF_ID(ph.phone_number), -1);
    
    if vCURR_PHONE_TARIFF_ID = 1978 or vCURR_PHONE_TARIFF_ID = 2277 then -- tariff_id = 1978 ULTRA VIP 2015 (1400), tariff_id = 2277 ULTRA VIP 1400(Spirit Telecom)
      res := 'Ваш пакет без ограничений'||chr(13);
    else
      res := 'Остаток по пакетам:'||chr(13);
      for c in (
          select 
          --SOC_NAME,  -- Услуга
          trim(REST_NAME) REST_NAME,
          
          case 
            when CURR_VALUE < 0 then 0
            else
              CURR_VALUE
          end       
          
          ||
          
          CASE UNIT_TYPE
                when 'INTERNET' then 'Мб;'
                when 'SMS_MMS' then 'шт.;'
                when 'VOICE' then 'мин.;'
              else
                  ''
              end CURR_VALUE --Остаток,
              
          from table (TARIFF_RESTS_TABLE(ph.phone_number))
          where 
                UPPER(MS_PARAMS.GET_PARAM_VALUE('TARIFF_NAME_NO_SHOW_VOICE') ) not like 
                      UPPER('%;'|| 
                            TRIM (
                                    (select TARIFF_NAME from tariffs where tariff_id = vCURR_PHONE_TARIFF_ID) 
                                 )
                            ||';%'
                           ) 
               OR UNIT_TYPE <> 'VOICE'
              ) 
      loop
        
        if upper(c.REST_NAME) = 'МЕСТНЫЕ ВЫЗОВЫ НА НОМЕРА ДРУГИХ ОПЕРАТОРОВ' 
          and vCURR_PHONE_TARIFF_ID in (1133,--  ЗАКРЫТ!   ULTRA VIP (1400)
                                        1134,--  Формула Свободы ВИП (1180) NEW
                                        1135,--  Формула Свободы ВИП (1300) NEW
                                        1156,--  Привилегированный 1500
                                        1178,--  ЗАКРЫТ!   ULTRA VIP (гор) (1600)
                                        1338,--  Привилегированный СП (1100)
                                        1956,--  ЗАКРЫТ! Полный безлимит 1300(NEW)
                                        1758 --ЗАКРЫТ!!! Полный безлимит (1300)
                                      ) --Ид тарифных планов на которых безлимит
        then   
          c.CURR_VALUE := 'без ограничения;';
        elsif upper(c.REST_NAME) = 'МЕСТНЫЕ ВЫЗОВЫ'
              AND vCURR_PHONE_TARIFF_ID IN (1758) --ЗАКРЫТ!!! Полный безлимит (1300)
        then
          c.CURR_VALUE := 'без ограничения;';
        elsif upper(c.REST_NAME) = 'МЕСТНЫЕ ВЫЗОВЫ'
              AND vCURR_PHONE_TARIFF_ID IN (1075, --ЗАКРЫТ!   Москва на связи NEW (1300)
                                            1179 --ЗАКРЫТ!   Москва на связи NEW (гор) (1500)
                                           )
        then
          c.CURR_VALUE := 4000 - GET_CALL_OUT_MINUTE_NOTBEE (ph.phone_number)||'мин.;';  
        end if;
        
        res := res ||c.REST_NAME||' - '||c.CURR_VALUE||chr(13);
        
      end loop;
    
    end if;
    
    --res := res||' Добавляем 10% к платежу при пополнении через сайт www.gsmcorporacia.ru/oplata_uslug и через приложение www.gsmcorp.ru/m';
    
    res := LOADER3_PCKG.SEND_SMS(ph.phone_number, 'Остаток по пакетам', res );
    
    
    delete
      from USSD_TARIFF_REST_QUEUE
    where
      PHONE_NUMBER =ph.phone_number;
    commit;
  end loop;
END;