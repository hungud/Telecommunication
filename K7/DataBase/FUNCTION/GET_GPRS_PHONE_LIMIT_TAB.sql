CREATE OR REPLACE FUNCTION GET_GPRS_PHONE_LIMIT_TAB
  (
    pMonth in integer, 
    pInternet in integer, 
    pMinutes in integer,
    pDateRep in date default sysdate
  ) return TAB_GPRS_PHONE_LIMIT PIPELINED AS
    
  --Version 3
  --
  --v.3 27.01.2016 Алексеев. Добавил поля по id контракта в отчет
  --v.2 21.01.2016 Алексеев. Добавил поля по доходности за месяц по номеру в отчет
  --v.1 14.01.2016 Алексеев. Функция получения номеров, на которых при автоподключении пакетов будет действовать ограничения
  
  SQLTxt  varchar2(30000);
  subquery0 varchar2(5000);
  subquery1 varchar2(5000);
  subquery2 varchar2(5000);
  subquery3 varchar2(5000);
  subquery4 varchar2(5000);
  nameTab varchar2(20);
  CALL_ROW TYPE_GPRS_PHONE_LIMIT;
  vDate date;
  TabCount integer;
  DataCount integer;
  v_tab_cursor SYS_REFCURSOR;
  pPhone_number varchar2(10 char);
  pContract_date date;
  pContract_ID integer;
  pTariff_code varchar2(30 char);
  pTariff_Name varchar2(100 char);
  pPhone_Is_Active varchar2(25);
  pBalance number;
  pInternet_Vol_1 number;
  pInternet_Vol_2 number;
  pInternet_Vol_3 number;
  pInternet_Vol_4 number;
  pInternet_Vol_5 number;
  pInternet_Vol_6 number;
  pInternet_Vol_7 number;
  pInternet_Vol_8 number;
  pInternet_Vol_9 number;
  pInternet_Vol_10 number;
  pInternet_Vol_11 number;
  pInternet_Vol_12 number;
  pCall_Minutes_1 integer;
  pCall_Minutes_2 integer;
  pCall_Minutes_3 integer;
  pCall_Minutes_4 integer;
  pCall_Minutes_5 integer;
  pCall_Minutes_6 integer;
  pCall_Minutes_7 integer;
  pCall_Minutes_8 integer;
  pCall_Minutes_9 integer;
  pCall_Minutes_10 integer;
  pCall_Minutes_11 integer;
  pCall_Minutes_12 integer;
  pProfit_1 number;
  pProfit_2 number;
  pProfit_3 number;
  pProfit_4 number;
  pProfit_5 number;
  pProfit_6 number;
  pProfit_7 number;
  pProfit_8 number;
  pProfit_9 number;
  pProfit_10 number;
  pProfit_11 number;
  pProfit_12 number;
begin       
  --получаем данные в зависимости от получаемых параметров
  --для использования calls необходимо определить исп. месяца в зависимости от количества наблюдаемых месяцев
  FOR I IN 1..pMonth LOOP
    --определяем месяца моделирования
    vDate := add_months(pDateRep, -I);

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
      subquery0 := subquery0||
        ' INTERNET_VOL_'||to_char(vDate, 'MM_YYYY')||',
          CALL_MINUTES_'||to_char(vDate, 'MM_YYYY')||', 
          (
            SELECT MV.PROFIT_'||to_char(vDate, 'MM')||'
              FROM MV_PROFIT_BY_PHONES_YEAR MV
            WHERE MV.PHONE_NUMBER = cal.SUBSCR_NO
                 AND MV.BILL_YEAR = '||to_char(vDate, 'YYYY')||'
          ) PROFIT_'||to_char(vDate, 'MM_YYYY')||', ';
                           
      --часть запроса 1
      subquery1 := subquery1||
        ' NVL(SUM(INTERNET_'||to_char(vDate, 'MM_YYYY')||'), 0) INTERNET_VOL_'||to_char(vDate, 'MM_YYYY')||',
         NVL(SUM(MINUTES_'||to_char(vDate, 'MM_YYYY')||'), 0) CALL_MINUTES_'||to_char(vDate, 'MM_YYYY')||',';

      --часть запроса 2
      subquery2 := subquery2||
        ' CASE
            WHEN (to_number(to_char(CL.START_TIME, ''YYYYMM'')) = '||to_char(vDate, 'YYYYMM')||') AND (CL.SERVICETYPE = ''G'') THEN
              SUM(to_number(NVL(to_number(CL.DATA_VOL, ''99999999999D99'', '' NLS_NUMERIC_CHARACTERS = '''',.''''''), 0)))    
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

  --добиваем поля в зависимости от месяцев
  if (36-pMonth*3) > 0 then
    FOR I IN (pMonth*3)+1..36 LOOP
      subquery0 := subquery0||' null FIELD_'||I||',';
    END LOOP;
  end if;
  
  --отсекаем последний символ из части запроса
  subquery0 := SUBSTR(subquery0, 1, LENGTH(subquery0)-1);
  subquery1 := SUBSTR(subquery1, 1, LENGTH(subquery1)-1);
  subquery2 := SUBSTR(subquery2, 1, LENGTH(subquery2)-1);

  --весь запрос
  SQLTxt :=
    'select SUBSCR_NO, 
              vc.CONTRACT_DATE,
              vc.CONTRACT_ID,
              tr.TARIFF_CODE,
              tr.TARIFF_NAME,
              case
                when nvl(DB.PHONE_IS_ACTIVE, 0) = 0 then
                  case
                    when nvl(DB.CONSERVATION,0) = 1 then
                      ''По сохранению''
                    else 
                      ''По желанию''
                  end
                else
                  ''Активный''
              end
              PHONE_IS_ACTIVE,
              GET_ABONENT_BALANCE(SUBSCR_NO) BALANCE, '
              ||subquery0||
    ' from
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
                                     from v_contracts vc,
                                             tariffs tr
                                    where VC.PHONE_NUMBER_FEDERAL = CL.SUBSCR_NO
                                        and VC.CONTRACT_CANCEL_DATE is null
                                        and VC.TARIFF_ID = TR.TARIFF_ID
                                        and nvl(TR.IS_AUTO_INTERNET, 0) = 1  
                               )             
                and (
                        (CL.SERVICETYPE = ''G'')
                        or
                        ((CL.SERVICETYPE = ''C'') and (CL.SERVICEDIRECTION = 1))
                      )
            group by CL.SUBSCR_NO, to_number(to_char(CL.START_TIME, ''YYYYMM'')), CL.SERVICETYPE
        ) v
        group by v.SUBSCR_NO   
     ) cal,
     v_contracts vc,
     tariffs tr,
     DB_LOADER_ACCOUNT_PHONES db
     where VC.PHONE_NUMBER_FEDERAL = cal.SUBSCR_NO
         and VC.CONTRACT_CANCEL_DATE is null
         and VC.TARIFF_ID = TR.TARIFF_ID
         and cal.SUBSCR_NO = DB.PHONE_NUMBER
         and DB.YEAR_MONTH = (
                                                 select max(DB1.YEAR_MONTH)
                                                  from DB_LOADER_ACCOUNT_PHONES db1
                                                where DB1.PHONE_NUMBER = DB.PHONE_NUMBER
                                            )
         and '||subquery4;

  --заносим номера в таблицу исключений, если их там нет
  OPEN  v_tab_cursor  FOR  SQLTxt; 
  LOOP
    FETCH v_tab_cursor 
      INTO pPhone_number,
              pContract_date,
              pContract_ID,
              pTariff_code,
              pTariff_Name,
              pPhone_Is_Active,
              pBalance,        
              pInternet_Vol_1,
              pCall_Minutes_1,
              pProfit_1,
              pInternet_Vol_2,
              pCall_Minutes_2,
              pProfit_2,
              pInternet_Vol_3,
              pCall_Minutes_3,
              pProfit_3,
              pInternet_Vol_4,
              pCall_Minutes_4,
              pProfit_4,
              pInternet_Vol_5,
              pCall_Minutes_5,
              pProfit_5,
              pInternet_Vol_6,
              pCall_Minutes_6,
              pProfit_6,
              pInternet_Vol_7,
              pCall_Minutes_7,
              pProfit_7,
              pInternet_Vol_8,
              pCall_Minutes_8,
              pProfit_8,
              pInternet_Vol_9,
              pCall_Minutes_9,
              pProfit_9,
              pInternet_Vol_10,
              pCall_Minutes_10,
              pProfit_10,
              pInternet_Vol_11,
              pCall_Minutes_11,
              pProfit_11,
              pInternet_Vol_12,
              pCall_Minutes_12,
              pProfit_12; 

    EXIT WHEN v_tab_cursor%NOTFOUND;
            
    CALL_ROW := TYPE_GPRS_PHONE_LIMIT(pPhone_number,
                                                                 pContract_date,
                                                                 pContract_ID,
                                                                 pTariff_code,
                                                                 pTariff_Name,
                                                                 pPhone_Is_Active,
                                                                 pBalance,        
                                                                 pInternet_Vol_1,
                                                                 pCall_Minutes_1,
                                                                 pProfit_1,
                                                                 pInternet_Vol_2,
                                                                 pCall_Minutes_2,
                                                                 pProfit_2,
                                                                 pInternet_Vol_3,
                                                                 pCall_Minutes_3,
                                                                 pProfit_3,
                                                                 pInternet_Vol_4,
                                                                 pCall_Minutes_4,
                                                                 pProfit_4,
                                                                 pInternet_Vol_5,
                                                                 pCall_Minutes_5,
                                                                 pProfit_5,
                                                                 pInternet_Vol_6,
                                                                 pCall_Minutes_6,
                                                                 pProfit_6,
                                                                 pInternet_Vol_7,
                                                                 pCall_Minutes_7,
                                                                 pProfit_7,
                                                                 pInternet_Vol_8,
                                                                 pCall_Minutes_8,
                                                                 pProfit_8,
                                                                 pInternet_Vol_9,
                                                                 pCall_Minutes_9,
                                                                 pProfit_9,
                                                                 pInternet_Vol_10,
                                                                 pCall_Minutes_10,
                                                                 pProfit_10,
                                                                 pInternet_Vol_11,
                                                                 pCall_Minutes_11,
                                                                 pProfit_11,
                                                                 pInternet_Vol_12,
                                                                 pCall_Minutes_12,
                                                                 pProfit_12);
                             
    PIPE ROW(CALL_ROW);
  END LOOP;

  -- Close cursor
  CLOSE v_tab_cursor;
end;