CREATE OR REPLACE FUNCTION ADD_OPT_IN_AUTO_CONNECT_INET(p_phone IN VARCHAR2, p_tariff_code IN VARCHAR2) RETURN VARCHAR2 IS

 --version 3
 --
 --v3. 27.07.2015 Алексеев. Добавил коммит после обновления таблиц gprs_turn_log и gprs_stat
 --v2. 23.07.2015 Алексеев. Добавил проверку на корректность переданных в функцию параметров.
 --v1. 23.07.2015 Алексеев. Добавил функцию внесения интернет-опции в логику автоподключения. 
 --                                      Требуется когда номер сменил тп с автоподключения на автоподключение или пойман чужак, который необходимо внести в логику автоподкл.
 --                                      Объем расходуемого трафика определяется для тп по запросу остатков по рест_апи, для услуги из табл. tariff_options

  v_rests beeline_rest_api_pckg.TRests;
  p_tariff_vol  number(12);
  p_tariff_cur  number(12); 
  p_NEW_gprs_turn_log_id number(28):= NEW_gprs_turn_log_id;
  v_num integer;
begin
  if (p_phone is not null) and (LENGTH(p_phone) = 10) and (p_tariff_code is not null) then
    --определяем тп или опция
    v_num := 0;
    select count(1)
       into v_num
      from tariffs
    where tariff_code=p_tariff_code
        and nvl(is_auto_internet, 0) =1;

    begin
      if nvl(v_num, 0) = 0 then --опция
        select nvl(OP.INTERNET_VOLUME, 0)
           into p_tariff_vol
          from tariff_options op
        where OP.OPTION_CODE = p_tariff_code
           and nvl(OP.IS_AUTO_INTERNET, 0) = 1;
      else
        --если это тариф, то он подключен уже, а значит данные возьмем по рест-апи
        v_rests := beeline_api_pckg.rest_info_rests(p_phone);
        for i in 1..v_rests.count() loop
          if (v_rests(i).unittype = 'INTERNET') and (v_rests(i).resttype = 'AS') and (p_tariff_code = v_rests(i).soc) then
            p_tariff_vol := v_rests(i).initialsize;
          end if;
        end loop;
      end if;
    exception
      when others then
        p_tariff_vol := -1;
        return('Ошибка определения доступного объема трафика!');
    end;

    if nvl(p_tariff_vol, 0) > 0 then   
      --в первой записи устанавливаем расходуемый трафик равный первоначальному
      p_tariff_cur :=  p_tariff_vol;     
      --закрываем последнюю запись в логах подключения интернет-опций  
      update gprs_turn_log  
           set DATE_OFF = sysdate
      where phone = p_phone
          and date_off is null;

      --отмечаем последнюю запись в статистике использования интернет-опций обработанной    
      update gprs_stat  
           set IS_CHECKED = 1
      where phone = p_phone
         and is_checked = 0;
      commit;
      
      --создаем новую запись в логах подключения интернет-опций        
      insert into gprs_turn_log
        (
          LOG_ID,
          PHONE,
          TARIFF_CODE,
          DATE_ON,
          DATE_OFF
        ) 
      values 
        (
          p_NEW_gprs_turn_log_id, 
          p_phone,
          p_tariff_code, 
          sysdate, 
          null
        );

      --создаем новую запись в стаитстике использования интернет-опций
      insert into gprs_stat
      (
        STAT_ID,
        TURN_LOG_ID,
        PHONE,
        TARIFF_CODE,
        INITVALUE,
        CURRVALUE,
        CURR_CHECK_DATE,
        NEXT_CHECK_DATE,
        CTRL_PNT,
        IS_CHECKED
      ) 
      values 
      (
        new_gprs_stat_id,
        p_NEW_gprs_turn_log_id, 
        p_phone,
        p_tariff_code, 
        p_tariff_vol, 
        p_tariff_cur, 
        sysdate, 
        sysdate+10/24/60,
        0,
        0
      );
      --
      commit;
      return('Интернет-опция добавлена в логику автоподключения!');
    end if;
  else
    return('Некорректно указаны номер и код интернет-опции!');  
  end if;
end;

--GRANT EXECUTE ON ADD_OPT_IN_AUTO_CONNECT_INET TO CORP_MOBILE_ROLE;