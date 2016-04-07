CREATE OR REPLACE PROCEDURE GET_GPRS_PHONE_LIMIT (pMonth in integer, pInternet in integer, pMinutes in integer) AS

  --Version 1
  --
  --v.1 14.01.2016 Алексеев. Процедура получения номеров, на которых при автоподключении пакетов будет действовать ограничения
  
  SQLTxt  varchar2(30000);
  subquery1 varchar2(5000);
  subquery2 varchar2(5000);
  subquery3 varchar2(5000);
  subquery4 varchar2(5000);
  nameTab varchar2(20);
  vDate date;
  vDateForm date; --дата формирования отчета
  TabCount integer;
  DataCount integer;
  v_tab_cursor SYS_REFCURSOR;
  pPhone_number varchar2(10 char);
begin
  --запоминаем переданные параметры
  TabCount := MS_params.SET_PARAM_VALUE('MONTH_4_GPRS_PHONE_LIMIT', pMonth);  --количество наблюдаемых месяцев
  TabCount := MS_params.SET_PARAM_VALUE('INTERNET_GPRS_PHONE_LIMIT', pInternet);  --количество интернета Гб
  TabCount := MS_params.SET_PARAM_VALUE('MINUTES_GPRS_PHONE_LIMIT', pMinutes);  --минимальное количество потраченных/исходящих минут
  
  --удаляем из ограничений все данные, меньшие текущей даты - 2 месяца
  --так как эти данные будем переформировывать
  delete from GPRS_PHONE_LIMIT lm
  where lm.year_month >= to_number(to_char(add_months(sysdate, -2), 'YYYYMM'));
  commit;
  
  --считаем за 3 месяца (за текущий и 2 предыдущих)
  for L in 0..2 loop
    --зануляем параметры
    SQLTxt := '';
    subquery1 := '';
    subquery2 := '';
    subquery3 := '';
    subquery4 := '';
    
    --определяем дату, которую будем считать началом периода расчета
    vDateForm := add_months(sysdate, -L);
    
    --получаем данные в зависимости от получаемых параметров
    --для использования calls необходимо определить исп. месяца в зависимости от количества наблюдаемых месяцев
    FOR I IN 1..pMonth LOOP
      --определяем месяца моделирования
      vDate := add_months(vDateForm, -I);

      --определяем имя таблицы
      nameTab :=  'CALL_'||to_char(vDate, 'MM_YYYY');

      --проверяем существование таблицы
      TabCount := 0;
      SELECT count(*) 
         INTO TabCount
        FROM all_tables 
      WHERE table_name = nametab;
      
      --если таблица есть, то проверяем наличие данных в таблице
      if nvl(TabCount, 0) > 0 then
        DataCount := 0;
        --проверяем наличие данных в таблице
        EXECUTE IMMEDIATE 
          'select count(*)
             from '||nameTab into DataCount;
      end if;
      
      --если нет таблицы или данных в таблице, то берем данные из внешней таблицы при ее наличии
      if (nvl(TabCount, 0) = 0) or (nvl(DataCount, 0) = 0) then
        --определяем имя внешней таблицы
        nameTab :=  'EXT_CALL_'||to_char(vDate, 'MM_YYYY');
        
        --проверяем существование внешней таблицы
        SELECT count(*) 
           INTO TabCount
          FROM all_tables 
        WHERE table_name = nametab;
        
        --проверяем наличие данных во внешней таблице
        if nvl(TabCount, 0) > 0 then
          begin
            DataCount := 0;
            --проверяем наличие данных в таблице
            EXECUTE IMMEDIATE 
              'select count(*)
                 from '||nameTab into DataCount;
          exception
            when others then
              DataCount := 0; 
          end;
        end if;
      end if;
      

      --если есть таблица и данные в ней присутствуют
      if (nvl(TabCount, 0) > 0) and (nvl(DataCount, 0) > 0) then                      
        --часть запроса 1
        subquery1 := subquery1||
          ' NVL(SUM(INTERNET_'||to_char(vDate, 'MM_YYYY')||'), 0) INTERNET_VOL_'||to_char(vDate, 'MM_YYYY')||',
           NVL(SUM(MINUTES_'||to_char(vDate, 'MM_YYYY')||'), 0) CALL_MINUTES_'||to_char(vDate, 'MM_YYYY')||',';

        --часть запроса 2
        subquery2 := subquery2||
          ' CASE
              WHEN (to_number(to_char(CL.START_TIME, ''YYYYMM'')) = '||to_char(vDate, 'YYYYMM')||') AND (CL.SERVICETYPE = ''G'') THEN
                SUM(CL.DATA_VOL)    
           END
           INTERNET_'||to_char(vDate, 'MM_YYYY')||',
           CASE
             WHEN (to_number(to_char(CL.START_TIME, ''YYYYMM'')) = '||to_char(vDate, 'YYYYMM')||') AND (CL.SERVICETYPE = ''C'') THEN
               SUM(to_number(substr(CL.DURATION, -8, 2)) * 60 + to_number(substr(CL.DURATION, -5, 2)) + ceil(to_number(substr(CL.DURATION, -2, 2)/60)))
           END
           MINUTES_'||to_char(vDate, 'MM_YYYY')||',';

        --часть запроса 3
        if I = 1 then
         subquery3 := subquery3||
           ' select *
              from '||nameTab;
        else
          subquery3 := subquery3||
           ' union all
             select *
              from '||nameTab;
        end if;

        --часть запроса 4
        if I = 1 then
          subquery4 := subquery4||
            ' INTERNET_VOL_'||to_char(vDate, 'MM_YYYY')||' >= '||pInternet||'*1024
              and CALL_MINUTES_'||to_char(vDate, 'MM_YYYY')||' <= '||pMinutes;
        else
          subquery4 := subquery4||
            ' and INTERNET_VOL_'||to_char(vDate, 'MM_YYYY')||' >= '||pInternet||'*1024
              and CALL_MINUTES_'||to_char(vDate, 'MM_YYYY')||' <= '||pMinutes;
        end if;
      end if;
    END LOOP;

    --отсекаем последний символ из части запроса
    subquery1 := SUBSTR(subquery1, 1, LENGTH(subquery1)-1);
    subquery2 := SUBSTR(subquery2, 1, LENGTH(subquery2)-1);

    --весь запрос
    SQLTxt :=
      'select SUBSCR_NO
       from
       (   
          select 
            v.SUBSCR_NO, ' 
            ||subquery1||
        ' from
          (   
              select 
                CL.SUBSCR_NO, 
                to_number(to_char(CL.START_TIME, ''YYYYMM'')) YEAR_MONTH, '
                ||subquery2|| 
            ' from ( '  
                       ||subquery3||
                    ' ) cl
              where exists (
                                    select 1
                                      from v_contracts v,
                                              tariffs tr
                                    where V.TARIFF_ID = TR.TARIFF_ID
                                        and V.CONTRACT_CANCEL_DATE is null
                                        and nvl(TR.IS_AUTO_INTERNET, 0) = 1
                                        and V.PHONE_NUMBER_FEDERAL = CL.SUBSCR_NO
                                 )
                  and (
                          (CL.SERVICETYPE = ''G'')
                          or
                          ((CL.SERVICETYPE = ''C'') and (CL.SERVICEDIRECTION = 1))
                        )
              group by CL.SUBSCR_NO, to_number(to_char(CL.START_TIME, ''YYYYMM'')), CL.SERVICETYPE       
          ) v
          group by v.SUBSCR_NO    
       )
       where '||subquery4;

    --заносим номера в таблицу исключений, если их там нет
    OPEN  v_tab_cursor  FOR  SQLTxt;
    LOOP
      FETCH v_tab_cursor 
         INTO pPhone_number;
      EXIT WHEN v_tab_cursor%NOTFOUND;
            
      --проверяем наличие номера в таблице
      select count(*)
         into TabCount
        from GPRS_PHONE_LIMIT lm
      where LM.PHONE_NUMBER = pPhone_number;
      
      if nvl(TabCount, 0) = 0 then
        INSERT INTO GPRS_PHONE_LIMIT (YEAR_MONTH, PHONE_NUMBER, DATE_CREATED)
          VALUES (to_number(to_char(vDateForm, 'YYYYMM')), pPhone_number, sysdate);
        commit;
      end if;
    END LOOP;

    -- Close cursor
    CLOSE v_tab_cursor;  
  end loop;
end;