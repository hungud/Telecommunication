CREATE OR REPLACE PROCEDURE HANDLE_ERR_AUTOCONNECT_INET_PH(pPHONE_NUMBER IN VARCHAR2) IS 

  --Version 2
  --
  --v.2 Алексеев. 2015.11.24 При проверке услуг по рест апи, проверяем наличие лубой услуги с признаком автоподключения.
  --v.1 Алексеев. 2015.11.20 Процедура подключения интернет опции на номер, по которому была ошибка подключения.
  --                                      При ошибке подключения пакета на номере необходимо пробовать подключить данный пакет повторно
  --                                      Данная процедура вызывается для номеров, по которым были ошибки подключения пакетов - 
  --                                      имеется запись в таблице db_loader_resp_log  с типом примечания "gprs_check_turn_tariff" и по данному номеру
  --                                      отсутствует успешное подкл. пакетов.
  --                                      Осуществляем подключение если:
  --                                      - по номеру имеется открытая запись в таблице gprs_turn_log
  --                                      - текущая открытая запись имеет максимальный id лога подключения
  --                                      - открытый период именно по пакету, а не тарифу
  --                                      - на номере тариф с автоподключением пакетов
  --                                      - номер не МНП
  --                                      - номер активен
  --                                      - в списке подключенных услуг отсутствуют интернет-опции с автоподключением пакетов 
  
  CURSOR C IS
  select 
       GP.PHONE, 
       GP.TARIFF_CODE
    from gprs_turn_log gp
  where GP.PHONE = pPHONE_NUMBER
      --только открытый период
      and GP.DATE_OFF is null
      --с максимальным id, исключаем ошибки
      and GP.LOG_ID = (
                                   select max(LG.LOG_ID)
                                     from gprs_turn_log lg
                                   where lg.phone = GP.PHONE
                                )
      --крайнее подключения - подключение пакета, а не тарифа
      and not exists (
                               select 1
                                 from tariffs tr
                               where TR.TARIFF_CODE = GP.TARIFF_CODE
                                  and nvl(TR.IS_AUTO_INTERNET, 0) = 1
                           )
      --тариф на номере с автоподкл. пакетов
      and exists (
                        select 1
                          from v_contracts ct,
                                  tariffs tf
                        where CT.PHONE_NUMBER_FEDERAL=GP.PHONE
                            and  CT.CONTRACT_CANCEL_DATE is null
                            and  TF.TARIFF_ID=CT.TARIFF_ID
                            and  nvl(TF.IS_AUTO_INTERNET, 0) = 1
                     )
      --не MNP  
      and not exists (
                              select 1 
                                from mnp_remove mnp 
                              where mnp.temp_phone_number = GP.PHONE 
                                  and mnp.date_created >= sysdate-1
                           )
      --номер активен
      and exists (
                         select 1 
                           from db_loader_account_phones db 
                         where db.phone_number = gp.phone 
                            and db.year_month = to_char(sysdate,'yyyymm')
                            and nvl(db.phone_is_active, 0) = 1 
                     );

  C_DUMMY C%ROWTYPE; 
  pCntPhone INTEGER;
  v_str varchar2(1024);
  v_str0 varchar2(1024);
  v_grs number(12);
begin   
  OPEN C;
  FETCH C INTO C_DUMMY;
  --если есть данные по номеру
  IF C%FOUND THEN
    --проверяем наличие опций с автоподключением пакетов в списке подключенных услуг по rest_api
    begin
      select count(*)
         into pCntPhone
        from table(corp_mobile.beeline_rest_api_pckg.get_serviceList(C_DUMMY.PHONE))
      where exists (
                            select 1
                              from TARIFF_OPTIONS op
                            where OP.OPTION_CODE = name
                                and nvl(OP.IS_AUTO_INTERNET, 0) = 1
                         );
      
      if nvl(pCntPhone, 0) = 0 then
        --подключаем опцию
        v_str0  := beeline_api_pckg.turn_tariff_option(C_DUMMY.PHONE, C_DUMMY.TARIFF_CODE, 1, null, null, 'AUTO_GPRS');
        v_str   := upper(substr(v_str0,1,6));

        v_grs  := beeline_rest_api_pckg.get_resp_stat(-9000,'LogReqResp',case when v_str = 'ЗАЯВКА' then 'Success turn tariff.' else 'Error turn tariff.' end, C_DUMMY.PHONE, 0,'gprs_check_turn_tariff',0
                              ,'Phone number: '||C_DUMMY.PHONE||' | Tariff: '||C_DUMMY.TARIFF_CODE||' | User: '||user
                              , v_str0);
      end if;    
    exception
      when others then
        null;
    end;
  END IF;
  CLOSE C;         
end;