CREATE OR REPLACE function GET_PHONE_WITHOUT_TRAFFIC_TAB return TAB_PHONE_INACTIV PIPELINED AS
--version 4   
--
--version 4. Алексеев. Поправил запрос
--version 3. Алексеев. Добавил получение детализаций по АПИ для номеров первой выборки
--version 2. Алексеев. Берутся данные за последние 7 дней вместо 3
--version 1. Алексеев. Создана функция

    TYPE TParamReport IS RECORD
    (
        LOGIN VARCHAR2(30 CHAR), 
        PHONE_NUMBER_FEDERAL VARCHAR2(10 CHAR), 
        CONTRACT_DATE DATE, 
        BALANCE NUMBER, 
        PHONE_IS_ACTIVE VARCHAR2(30 CHAR), 
        DOP_STATUS_NAME VARCHAR2(100 CHAR),
        LAST_CHECK_DATE_TIME DATE,
        DATE_CREATED DATE,
        CURR_TARIFF_ID INTEGER,
        TARIFF_NAME VARCHAR2(100 CHAR)
    ); 
    type TArrayParamReport is table of TParamReport index by pls_integer;   
    vListParamReport TArrayParamReport;
    
    SQL_Txt  varchar2(20000); 
    subqueryCALL varchar2(10000);
    v_tab_cursor_Rep SYS_REFCURSOR;
    v_tab_cursor SYS_REFCURSOR;
    y_begin integer;
    m_begin integer;
    y_end integer;
    m_end integer;
    vy integer;
    vm integer;
    CALLCount integer;
    nameCALL varchar2(20);
    vDate date;
    i integer;
    CALL_ROW TYPE_PHONE_INACTIV;
    --
    pLogin varchar2(30); 
    pPhone_number_federal varchar2(10);
    pContract_date date; 
    pBalance number;
    pPHONE_IS_ACTIVE varchar2(25); 
    pDop_status_name varchar2(100);
    pLAST_CHECK_DATE_TIME date;
    pDATE_CREATED date;
    pCURR_TARIFF_ID integer;
    pTARIFF_NAME varchar2(100);
BEGIN
    --определяем начальную дату (посл. 7 дня)
    vDate := trunc(sysdate) - 7;   
    --год и месяц начальной даты 
    y_begin := to_number(to_char(vDate, 'YYYY'));
    m_begin := to_number(to_char(vDate, 'MM'));  
    --год и месяц конечной даты
    y_end := to_number(to_char(sysdate, 'YYYY'));
    m_end := to_number(to_char(sysdate, 'MM'));
    --вспомогательные переменные, начинаем с начальной даты
    vy := y_begin;
    vm := m_begin;
    subqueryCALL := '';    
    i:=0;
    
    while ((vm <= m_end) and (vy = y_end)) or (vy < y_end) loop
        --определяем имя таблицы (таблица текущего месяца и года)
        if length(vm) = 1 then
          nameCALL :=  'CALL_0'||to_char(vm)||'_'||to_char(vy);
        else
          nameCALL :=  'CALL_'||to_char(vm)||'_'||to_char(vy);
        end if;
        
        --проверяем существование таблицы
        CALLCount := 0;
        SELECT count(*) 
        INTO CALLCount
        FROM all_tables WHERE table_name = nameCALL;
        
        if CALLCount > 0 then
            if ((vm > m_begin) and (vy = y_begin)) or (vy > y_begin) then
                subqueryCALL := subqueryCALL||' + '; 
            end if;
            
            subqueryCALL := subqueryCALL||
              '(select count(*)
                from '||nameCALL||' cltr
                where CLTR.SUBSCR_NO = ACT.PHONE_NUMBER_FEDERAL 
                and CLTR.AT_FT_DE not like ''%Покупка контента%''
                and CLTR.AT_FT_DESC not like ''%Покупка контента%'' ';

            --условие по дате ввода (insert_date) целесообразно только по таблице с месяцем начальной даты
            if vm = m_begin then
                subqueryCALL := subqueryCALL||' AND CLTR.START_TIME >=  to_date('''||to_char(vDate, 'DD.MM.YYYY')||' 00:00:00'', ''DD.MM.YYYY HH24:MI:SS'')'||')';
            else
                subqueryCALL := subqueryCALL||')';
            end if; 
        end if;
        
        i := i + 1;
        vDate := add_months(to_date('01.'||m_begin||'.'||y_begin, 'DD.MM.YYYY'), i); 
        vy := to_number(to_char(vDate, 'YYYY'));
        vm := to_number(to_char(vDate, 'MM'));
    end loop;
    
    if length(trim(subqueryCALL)) > 0 then
      SQL_Txt := 
        ' select 
            act.login, act.phone_number_federal, act.contract_date, act.balance, act.PHONE_IS_ACTIVE, 
            act.Dop_status_name, act.LAST_CHECK_DATE_TIME, act.DATE_CREATED, act.CURR_TARIFF_ID, act.TARIFF_NAME
          from V_PHONE_INACTIVE act 
          where act.contract_cancel_date is null 
          and act.YEAR_MONTH =  TO_NUMBER(TO_CHAR(SYSDATE, ''YYYYMM''))
          and NVL(act.PHONE_IS_ACTIVE_VALUE, 0) = 1
          and NVL(NOT_USE_REP_PHONE_WITHOUT_TRAF, 0) <> 1
          and (0 =  ('||subqueryCALL||'))'; 
    end if;
    
    --получаем параметры отчета в первом приближении
    OPEN  v_tab_cursor_Rep  FOR SQL_Txt;
    FETCH v_tab_cursor_Rep BULK COLLECT INTO vListParamReport;
    CLOSE v_tab_cursor_Rep;
    
    --для номеров первого приближения получаем детализацию по АПИ 
    IF vListParamReport.COUNT > 0 THEN
        FOR I IN 1..vListParamReport.COUNT LOOP
            LOAD_DETAILS_FROM_API_BY_PHONE(vListParamReport(I).PHONE_NUMBER_FEDERAL);
        END LOOP;   
    END IF;
    
    OPEN  v_tab_cursor  FOR  SQL_Txt;
    LOOP
        FETCH v_tab_cursor 
          INTO pLogin, 
                  pPhone_number_federal, 
                  pContract_date, 
                  pBalance, 
                  pPHONE_IS_ACTIVE, 
                  pDop_status_name,
                  pLAST_CHECK_DATE_TIME,
                  pDATE_CREATED,
                  pCURR_TARIFF_ID,
                  pTARIFF_NAME;
        EXIT WHEN v_tab_cursor%NOTFOUND;
        
        CALL_ROW := TYPE_PHONE_INACTIV(pLogin,
                                                               pPhone_number_federal, 
                                                               pContract_date, 
                                                               pBalance,
                                                               pPHONE_IS_ACTIVE, 
                                                               pDop_status_name,
                                                               pLAST_CHECK_DATE_TIME,
                                                               pDATE_CREATED,
                                                               pCURR_TARIFF_ID,
                                                               pTARIFF_NAME);
                         
        PIPE ROW(CALL_ROW);
    END LOOP;

    -- Close cursor
    CLOSE v_tab_cursor;  
END;
/
