CREATE OR REPLACE PROCEDURE P_GET_PHONE_WITHOUT_TRAFFIC (p_STREAM_ID in integer, pCountSTREAM in integer) AS

    --version 1  
    --
    --version 1. Алексеев. Создана процедура получения номеров без трафика (для отчета номера без трафика).
    --                               Ранее номера без трафика получались с помощью pipe функции, но из за долгой загрузки деталки по номерам, решили разбить получение деталок по АПИ на потоки и сделать процедуру.
    --                               Номера без трафика записываются в таблицу PHONE_WITHOUT_TRAFFIC.
    --                               Алгоритм: Удаляем из таблицы PHONE_WITHOUT_TRAFFIC номера в зависимости от потока. Делаем первоначальный отбор номеров без трафика по потокам (по данным, имеющимися в базе). 
    --                               Затем по каждому номеру продергиваем деталку по АПИ и вновь делаем выборку. Полученные номера пишем в таблицу.

    subqueryCALL varchar2(10000);
    v_tab_cursor_Rep SYS_REFCURSOR;
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
    v_phone varchar2(10 char);
BEGIN
    --удаляем из таблица с номерами без трафика номера по потокам
    DELETE FROM PHONE_WITHOUT_TRAFFIC tr
    WHERE mod(tr.PHONE_NUMBER_FEDERAL,pCountSTREAM)=p_STREAM_ID;
    commit; 
    
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
    
    --получаем номера первой выборки и запрашиваем по ним детализацию по АПИ
    open v_tab_cursor_Rep for '  select act.phone_number_federal
                                                from V_PHONE_INACTIVE act 
                                             where mod(act.phone_number_federal, :pCountSTREAM) = :p_STREAM_ID 
                                                 and act.contract_cancel_date is null 
                                                 and act.YEAR_MONTH =  TO_NUMBER(TO_CHAR(SYSDATE, ''YYYYMM''))
                                                 and NVL(act.PHONE_IS_ACTIVE_VALUE, 0) = 1
                                                 and NVL(NOT_USE_REP_PHONE_WITHOUT_TRAF, 0) <> 1 
                                                 and (0 =  ('||subqueryCALL||')) ' using pCountSTREAM, p_STREAM_ID;
    loop
      FETCH v_tab_cursor_Rep INTO v_phone;
      EXIT WHEN v_tab_cursor_Rep%NOTFOUND; 
      LOAD_DETAILS_FROM_API_BY_PHONE(v_phone); 
    end loop;
    
    --делаем выборку второго приближения и пишем в таблицу
    EXECUTE IMMEDIATE 
      'INSERT INTO PHONE_WITHOUT_TRAFFIC 
       (
         LOGIN, 
         PHONE_NUMBER_FEDERAL, 
         CONTRACT_DATE, 
         BALANCE, 
         PHONE_IS_ACTIVE, 
         DOP_STATUS_NAME, 
         LAST_CHECK_DATE_STATUS, 
         DATE_CREATED, 
         TARIFF_NAME, 
         ERROR_LOAD_API
       ) 
       select 
         act.login, 
         act.phone_number_federal, 
         act.contract_date, 
         act.balance, 
         act.PHONE_IS_ACTIVE, 
         act.Dop_status_name, 
         act.LAST_CHECK_DATE_TIME, 
         sysdate, 
         act.TARIFF_NAME,
         (
           SELECT ERROR_TEXT
             FROM API_GET_UNBILLED_CALLS_LOG lg
           WHERE LG.PHONE_NUMBER = act.phone_number_federal
                AND TRUNC (LG.DATE_INSERT) = TRUNC (SYSDATE)
                AND LG.DATE_INSERT = (
                                                       SELECT MAX (AP.DATE_INSERT)
                                                         FROM API_GET_UNBILLED_CALLS_LOG ap
                                                       WHERE AP.PHONE_NUMBER = LG.PHONE_NUMBER
                                                    )
                AND LG.DATE_INSERT >= (
                                                         SELECT B.INSERT_DATE
                                                           FROM BEELINE_SOAP_API_LOG B
                                                         WHERE B.LOAD_TYPE = 2
                                                              AND B.PHONE = LG.PHONE_NUMBER
                                                              AND B.INSERT_DATE = (
                                                                                                    SELECT MAX (BL.INSERT_DATE)
                                                                                                      FROM BEELINE_SOAP_API_LOG bl
                                                                                                    WHERE BL.PHONE = B.PHONE
                                                                                                         AND BL.LOAD_TYPE = 2
                                                                                                )
                                                      )
         ) ERROR_LOAD_API
       from V_PHONE_INACTIVE act 
       where mod(act.phone_number_federal, :pCountSTREAM)=:p_STREAM_ID
           and act.contract_cancel_date is null 
           and act.YEAR_MONTH =  TO_NUMBER(TO_CHAR(SYSDATE, ''YYYYMM''))
           and NVL(act.PHONE_IS_ACTIVE_VALUE, 0) = 1
           and NVL(NOT_USE_REP_PHONE_WITHOUT_TRAF, 0) <> 1 
           and (0 =  ('||subqueryCALL||'))' USING pCountSTREAM, p_STREAM_ID;
    commit;
END;