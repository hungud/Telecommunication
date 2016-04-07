CREATE OR REPLACE FUNCTION SELECTION_OPTION_AUTO_CONNECT (p_phone IN VARCHAR2) RETURN VARCHAR2 IS

  --version 4
  --
  --v4. Алексеев 2015.11.19 Изменил логику выбора пакета для схемы 1 и 3.
--                          Для схем подключения 1 и 3, убираем сравнение с расчетным потребленным трафиком, берем все пакеты, доступные для схемы подключения.
--                          Далее осуществляем сравнение суммы подключения одного пакета со суммой подкл. GPRS_U с момента подкл. до конца месяца. Берем пакет с наименьшей суммой.
--                          Если пакет 20 ГБ вкл. 3 раза, то вкл. GPRS_U. Если пакет 30 Гб вкл. 2 раза, то вкл. GPRS_U.
 --v3. 27.07.2015 Алексеев. Добавил коммит после обновления таблиц gprs_turn_log и gprs_stat
  --v1. Алексеев 2015.07.24 Добавил функцию подбора по номеру походящей интернет-опции для автоподключения.
  
  type t_stat2 is record
    (
      phone           varchar2(10),
      initvalue       integer,
      currvalue       integer,
      curr_check_date timestamp
    );
  type t_stats is table of t_stat2 index by pls_integer;
  vt_stat t_stats;
  
  v_total_sec     number(24,3)  := 0;
  v_total_traf    number(24)    := 0;  
  v_total_day     number(3)     := 0;  
  v_end_month_sec number(24,3)  := 0;

  v_num                 number(38) :=0;
  v_num0                number(38) :=0;
  v_num1                number(38) :=0;
  v_tariff_code         varchar2(30);
  pSchemeWork integer; --схема работы алгоритма по подключению пакетов
  pCntTarCode integer;
  v_res  varchar2(5000);
begin
  begin
    -- В учет принимаются все работавшией траифы/опции
    for rec_tl in  (
                           select *
                            from gprs_turn_log
                           where phone = p_phone
                           order  by date_on                
                      ) 
    loop
      -- В рассчёт обязательно идёт первое измерение и все остальные у которых initvalue <> currvalue
      -- , факт ошибки Билайна (initvalue(curr) > initvalue(previous) ) должен быть учтен до входа в стадию продбора нового тарифа
      select
              sq.phone,
              sq.initvalue,
              sq.currvalue,
              sq.curr_check_date
        bulk  collect into
              vt_stat
        from
              (      
                select
                        phone,
                        initvalue,
                        currvalue,
                        curr_check_date
                  from
                        gprs_stat
                 where
                        phone = rec_tl.phone
                   and  turn_log_id = rec_tl.log_id
                 order  by
                        curr_check_date
              ) sq
       where 
              rownum=1 or (rownum>1 and sq.initvalue<>sq.currvalue)
       order  by
              sq.curr_check_date desc;

        v_total_sec := v_total_sec + corp_mobile.beeline_rest_api_pckg.intr_to_sec(vt_stat(1).curr_check_date-vt_stat(vt_stat.count).curr_check_date);
        
        v_total_day := v_total_day + to_number(to_char(vt_stat(1).curr_check_date,'dd'))-to_number(to_char(vt_stat(vt_stat.count).curr_check_date,'dd'))+1;
        v_total_traf := v_total_traf+(vt_stat(1).initvalue-vt_stat(1).currvalue)-(vt_stat(vt_stat.count).initvalue-vt_stat(vt_stat.count).currvalue); 
    end loop; 
    --             
    v_end_month_sec := corp_mobile.beeline_rest_api_pckg.intr_to_sec(to_date(to_char(last_day(sysdate),'YYYY-MM-DD')||' 23:59:59','YYYY-MM-DD hh24:mi:ss')-systimestamp);
    -- до конца месяца потребуется
    if v_total_sec = 0 then 
      return('Обработка номера '||p_phone||' прервана: время расхода трафика = 0!');
    end if;
    v_num := nvl(round(v_total_traf*v_end_month_sec/v_total_sec,0),0); 
    v_res := 'Номер: '||vt_stat(1).phone||chr(13)||chr(10)||'За '||ceil(v_total_sec/24/60/60)||' суток ('||v_total_day||' календарных дней) потрачено: '||v_total_traf||' МБ'||chr(13)||chr(10)||'До конца месяца '||ceil(v_end_month_sec/24/60/60)||' календарных дней и потребуется: '||v_num||' МБ'||chr(13)||chr(10);
  exception
    when no_data_found then 
      return('Отсутствуют данные для обработки!');
      null;
  end;                  
  --после того как определено количество трафика, которое потребуется до конца месяца (v_num), необходимо учесть схемы подключения
  --на данный момент имеется 3 схемы подключения: 
          --Схема 1. - Безлим. 990, 1290, 980, 1280. Подключаются пакеты GPRS_20 и GPRS_U. Пакет GPRS_20 подкл. максимум 3 раза/месяц
              --  1) расчитываем стоимость безлимита от текущего момента времени до конца месяца;
              --  2) берем стоимость единичного пакетов 20ГБ;
              --  3) если стоимость безлимита <= стоимости единичного пакета 20ГБ или пакет 20ГБ уже подкл. 3 раза, то подключаем GPRS_U, иначе 20ГБ.
          --Схема 2. - Безлим. 1590. Подключаются пакеты FSG_TT2, FSG_TT3 и GPRS_U. Остается старая логика
              --  1) отбираются все пакеты с объёмом трафика более требуемого расчётного;
              --  2) рассчитывается стоимость безлимита от текущего момента времени до конца месяца; 
              --  3) из стоимостей безлимита по п.2 и отобранных в п.1 пакетов выбираем наименьшую;
              --  4) подключаемым назначается опция соответствующая стоимости выбранной в п.3
          --Схема 3. - Безлим. 1580. Подключаются пакеты GPRS_30 и GPRS_U. Пакет GPRS_30 подкл. максимум 2 раз/месяц
              --  1) расчитываем стоимость безлимита от текущего момента времени до конца месяца;
              --  2) берем стоимость единичного пакетов 30ГБ;
              --  3) если стоимость безлимита <= стоимости единичного пакета 30ГБ или пакет 30ГБ уже подкл. 3 раза, то подключаем GPRS_U, иначе 30ГБ.
  pSchemeWork := 0;
  begin
    select nvl(ATR.INT_TYPE, 0)
      into pSchemeWork
     from congr_tarif cn,
             tariffs_attrs atr
    where CN.TARIFFS_ATTRIBUTES_ID = ATR.TARIFFS_ATTRIBUTES_ID
        and ATR.ATTRIBUTES_NAME = 'SCHEME_AUTO_CONNECT_PCKG'
        and CN.TARIFF_ID = GET_CURR_PHONE_TARIFF_ID(p_phone);   
  exception
    when others then 
      return('Ошибка в выборе схемы работы автоподключения интернет-опций!');
  end;
  --если не выбрана схема подкл. пакета, то ничего не подключаем
  if nvl(pSchemeWork, 0) = 0 then
    return('Ошибка в выборе схемы работы автоподключения интернет-опций!');
  end if;
  -- opt_id подходящего пакета
  begin
    for rec_tf in (
                    select
                            code,
                            VOLUME,
                            cost_for_month_rest
                      from
                            (
                              select
                                      TF.OPTION_CODE      code,
                                      TF.INTERNET_VOLUME  volume,
                                      case nvl(TF.DISCR_SPISANIE,0)
                                        when 0 then 
                                                    nvl(TC.MONTHLY_COST,0)
                                                    * 
                                                      ceil(beeline_rest_api_pckg.intr_to_sec
                                                      (
                                                          trunc(add_months(sysdate,1),'mm')
                                                        - systimestamp
                                                      )/24/60/60)/
                                                        to_number(to_char(last_day(sysdate),'dd'))
                                        else 
                                          nvl(TC.MONTHLY_COST,0)
                                      end cost_for_month_rest
                                from
                                      tariff_options  tf,
                                      TARIFF_OPTION_COSTS tc
                               where
                                      TF.IS_AUTO_INTERNET=1
                                 and  nvl(TF.INTERNET_VOLUME, 0) >= 
                                                                                          (
                                                                                               CASE
                                                                                                  WHEN ((nvl(pSchemeWork, 0) = 1) or (nvl(pSchemeWork, 0) = 3)) THEN
                                                                                                     1
                                                                                                  ELSE
                                                                                                     nvl(v_num,0)
                                                                                               END
                                                                                           )
                                 and  TC.TARIFF_OPTION_ID = TF.TARIFF_OPTION_ID
                                 and  sysdate between TC.BEGIN_DATE and TC.END_DATE
                                 and exists (
                                                    select 1
                                                     from congr_tarif cn,
                                                             tariffs_attrs atr
                                                   where CN.TARIFFS_ATTRIBUTES_ID = ATR.TARIFFS_ATTRIBUTES_ID
                                                       and ATR.ATTRIBUTES_NAME = 'ATR_OPTION'
                                                       and CN.TARIFF_ID = GET_CURR_PHONE_TARIFF_ID(p_phone)
                                                       and nvl(ATR.INT_TYPE, 0) = TC.TARIFF_OPTION_ID
                                                 )
                               order  by
                                      cost_for_month_rest
                            )
                  )
    loop
      if v_num0 = 0 then
        v_tariff_code := rec_tf.code;
        v_num0 := rec_tf.volume;
        v_num1 := rec_tf.cost_for_month_rest;
      end if;
      v_res := v_res||'Интернет-опция '||rec_tf.code||': стоимость - '||round(rec_tf.cost_for_month_rest,0)||' руб.'||', объём - '||rec_tf.volume||' МБ'||chr(13)||chr(10);
    end loop;
  exception
    when no_data_found then
      if (nvl(pSchemeWork, 0) = 2) then
        for rec_tf in (
                        select
                                code,
                                VOLUME,
                                cost_for_month_rest
                          from
                                (
                                  select
                                          TF.OPTION_CODE      code,
                                          TF.INTERNET_VOLUME  volume,
                                          case nvl(TF.DISCR_SPISANIE,0)
                                            when 0 then 
                                                        nvl(TC.MONTHLY_COST,0)
                                                        * 
                                                          ceil(beeline_rest_api_pckg.intr_to_sec
                                                          (
                                                              trunc(add_months(sysdate,1),'mm')
                                                            - systimestamp
                                                          )/24/60/60)/
                                                            to_number(to_char(last_day(sysdate),'dd'))
                                            else 
                                              nvl(TC.MONTHLY_COST,0)
                                          end cost_for_month_rest
                                    from
                                          tariff_options  tf,
                                          TARIFF_OPTION_COSTS tc
                                   where
                                          TF.IS_AUTO_INTERNET=1
                                     and  TF.INTERNET_VOLUME > 0
                                     and  TF.INTERNET_VOLUME < nvl(v_num,0)
                                     and  TC.TARIFF_OPTION_ID = TF.TARIFF_OPTION_ID
                                     and  sysdate between TC.BEGIN_DATE and TC.END_DATE
                                     and exists (
                                                        select ATR.INT_TYPE
                                                         from congr_tarif cn,
                                                                 tariffs_attrs atr
                                                       where CN.TARIFFS_ATTRIBUTES_ID = ATR.TARIFFS_ATTRIBUTES_ID
                                                           and ATR.ATTRIBUTES_NAME = 'ATR_OPTION'
                                                           and CN.TARIFF_ID = GET_CURR_PHONE_TARIFF_ID(p_phone)
                                                           and nvl(ATR.INT_TYPE, 0) = TC.TARIFF_OPTION_ID
                                                     )                                 
                                   order  by
                                          volume desc, 
                                          cost_for_month_rest
                                )
                        )
        loop
          if v_num0 = 0 then
            v_tariff_code := rec_tf.code;
            v_num0 := rec_tf.volume;
            v_num1 := rec_tf.cost_for_month_rest;
          end if;
          v_res := v_res||'Интернет-опция '||rec_tf.code||': стоимость - '||round(rec_tf.cost_for_month_rest,0)||' руб.'||', объём - '||rec_tf.volume||' МБ'||chr(13)||chr(10);     
        end loop;
      else
        return('Ошибка в выборе интернет-опции для подключения!');
      end if;
  end; 
  --для схемы подкл. 1 и 3 делаем дополнительные действия
  if nvl(pSchemeWork, 0) = 1 then
    --для данной схемы имеется ограничение того, что пакт 20ГБ подкл. максимум 2 раза, т.е.
    --если v_tariff_code = 20ГБ, то проверяем их количество. Если = 2, то вкл. GPRS_U
    pCntTarCode := 0;
    select count(*)
       into pCntTarCode
      from TARIFF_OPTIONS tr
    where TR.OPTION_CODE = v_tariff_code
        and TR.TARIFF_OPTION_ID = 1419; --код опции GPRS_20GB
    
    if nvl(pCntTarCode, 0) > 0 then
      --проверяем количество подключений
      pCntTarCode := 0;
      SELECT count(*)
         INTO pCntTarCode
        FROM GPRS_TURN_LOG lg
      WHERE LG.TARIFF_CODE = v_tariff_code
           AND LG.PHONE = p_phone;
      --
      if nvl(pCntTarCode,0) > 2 then
        begin
          v_res := v_res||'Количество подключений интернет-опции '||v_tariff_code||': 3'||chr(13)||chr(10);
          --подключаем безлимит
          select OP.OPTION_CODE, nvl(OP.INTERNET_VOLUME, 0)
             into v_tariff_code, v_num0
            from TARIFF_OPTIONS op
          where nvl(OP.IS_UNLIM_INTERNET, 0) = 1
              and OP.TARIFF_OPTION_ID = 68; --код опции GPRS_U
        exception
          when others then
            return('Ошибка в выборе интернет-опции для подключения!');
        end; 
      end if;
    end if;
  else
    if nvl(pSchemeWork, 0) = 3 then
      --для данной схемы имеется ограничение того, что пакт 30ГБ подкл. максимум 1 раза, т.е.
      --если v_tariff_code = 30ГБ, то проверяем их количество. Если = 1, то вкл. GPRS_U
      pCntTarCode := 0;
      select count(*)
         into pCntTarCode
        from TARIFF_OPTIONS tr
      where TR.OPTION_CODE = v_tariff_code
          and TR.TARIFF_OPTION_ID = 1437; --код опции GPRS_30GB
      
      if nvl(pCntTarCode, 0) > 0 then
        --проверяем количество подключений
        pCntTarCode := 0;
        SELECT count(*)
           INTO pCntTarCode
          FROM GPRS_TURN_LOG lg
        WHERE LG.TARIFF_CODE = v_tariff_code
             AND LG.PHONE = p_phone;
        --
        if nvl(pCntTarCode, 0) > 1 then
          begin
            v_res := v_res||'Количество подключений интернет-опции '||v_tariff_code||': 2'||chr(13)||chr(10);
            --подключаем безлимит
            select OP.OPTION_CODE, nvl(OP.INTERNET_VOLUME, 0)
               into v_tariff_code, v_num0
              from TARIFF_OPTIONS op
            where nvl(OP.IS_UNLIM_INTERNET, 0) = 1
                and OP.TARIFF_OPTION_ID = 68; --код опции GPRS_U         
          exception
            when others then
              return('Ошибка в выборе интернет-опции для подключения');
          end; 
        end if;
      end if;
    end if;
  end if;
  v_res := v_res||chr(13)||chr(10)||'Наиболее подходящияя интернет-опция для подключения: '||v_tariff_code;          
  return(v_res);
end;

GRANT EXECUTE ON SELECTION_OPTION_AUTO_CONNECT TO CORP_MOBILE_ROLE;