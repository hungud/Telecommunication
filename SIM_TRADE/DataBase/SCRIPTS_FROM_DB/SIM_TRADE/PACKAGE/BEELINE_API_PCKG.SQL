
  CREATE OR REPLACE PACKAGE "SIM_TRADE"."BEELINE_API_PCKG" AS
--
--#Version=32
--v.32 15.12.2015 Алексеев. Поправил косяк с записью данных в таблицу REPLACE_SIM_LOG. Данные писались без указания параметров
-- v.31 26.11.2015 Афросин.Переделал получение DBF_ID в процедуре LOAD_DETAIL_FROM_API на параметр
-- v.30 27.04.2015 Крайнов. Иправление загрузки деталок по АПИ, сокращение дисковых чтений.
-- v.29 03.03.2015 Алексеев. Исправлена функция  phone_SIM
-- v.28 24.02.2015 Алексеев. Добавлены функции загрузки номеров сим карт
--     28.01.2015 Алексеев. Добавлена новая переменная определяющая загрузку, через API  (pUSE_API  = 1) или гор биллинг в функцию HOT_BILLING_GET_CALL_TAB
--     19.01.2015 Афросин. Не корректно определялся тип звонка при загрузке по API передаем UC.serviceName AT_FT_CODE в HOT_BILLING_GET_CALL_TAB
-- 20. 30.12.2014 Крайнов. Отвод переводов-платежей в отдельную таблицу
-- 19. 29.12.2014 Крайнов. Отвод переводов-платежей в отдельную таблицу
-- 18. 29.12.2014 Крайнов. Добавление автозаполнения справочника типа звонков по АПИ
-- 17. 18.12.2014 Крайнов. Загрузка статусов. Добавка удаления ушедших номеров.
-- 16. 15.10.2014 Крайнов. Оптимизация загрузки статусов. Правка МЕРЖА.
-- 15. 15.10.2014 Крайнов. Оптимизация загрузки статусов.
-- 14. 15.10.2014 Крайнов. Добавил вывод Тарифа в Статусах. Вывел из пакета Экспресс-разлок.
-- 13. 10.10.2014 Крайнов. Добавли сохранение кода статуса.
-- 12. 02.10.2014 Леонов Ю. Изменена функция ACCOUNT_PHONE_STATUS. Добавлена выгрузка значения даты последней смены статуса
--    из XML с последующим заполнением/изменением поля LAST_CHANGE_STATUS_DATE таблицы DB_LOADER_ACCOUNT_PHONES полученным значением
-- 11. 25.09.2014 Крайнов. Замена преобразований дат с часовым поясом на функцию из пакета CONVERT_PCKG
-- 10. 10.09.2014 Афросин. Переделал процедуру UNLOCK_PHONES. сделал сравнение с датой создания записи вместо даты платежа   
-- 9. 01.10.2013 Назин. Добавил загрузку статусов по л\с и коллекторским л\с.
-- 8. 29.08.14. Уколов. Исправил тип параметра в проверки тикетов.
-- 7. 24.07.14. Уколов. Добавил плановую дату и дату автоматического отключения для услуг.
-- 6. 24.07.14. Уколов. Поправил сохранение логов для подключения/отключения услуг
-- 5 21.07.14 Дементьев. Добавил Функцию TURN_TARIFF_OPTION, которая подключает или отключает тарифную опцию для номера.
-- 4.21.07.14 Дементьев. Оптимизация курсоров
--Замена SIM карты
FUNCTION REPLACE_SIM(
  pPHONE_NUMBER IN VARCHAR2,
  pICC         in varchar2
  ) RETURN VARCHAR2;
--Блокировка абонента.
--pCode - причина блокировки: WIB – блокировка по желанию, STO – блокировка по краже
FUNCTION LOCK_PHONE(
  pPHONE_NUMBER IN VARCHAR2,
  pMANUAL_BLOCK IN INTEGER DEFAULT 1,
  pCode in varchar2
  ) RETURN VARCHAR2;
--Разблокировка абонента.
FUNCTION UNLOCK_PHONE(
  pPHONE_NUMBER IN VARCHAR2,
  pMANUAL_UNLOCK IN INTEGER DEFAULT 1
  ) RETURN VARCHAR2;
Function account_phone_payments  (
  pAccount_id in number
  ) return varchar2;    
--Статус абонента
Function phone_status  (
  pPHONE_NUMBER in number
  ) return varchar2;  
--  
function account_phone_status(
  Paccount_id in number
  ) return varchar2;
--  
function account_phone_options(
  Paccount_id in number
  ) return varchar2;
function Collect_account_phone_status(
  Paccount_id in number,
  nMOD_NUM in number default 0,--модуль потока
  nMOD in number default 1--потоки
  ) return varchar2;
--Обновление списка БАН по коллектору
function Collect_account_BANS(
  Paccount_id in number
  ) return varchar2;                                     
--опции абонента
Function phone_options  (
  pPHONE_NUMBER in number
  ) return varchar2;
function Collect_account_phone_opts(
  Paccount_id in number
  ) return varchar2;
--деталка текущая
Function phone_detail_call (
  pPHONE_NUMBER in number
  ) return varchar2;
--загрузка счёта в лог
Function Get_account_bill (
  pAccount_id in number,
  pRequestID in number
  )return varchar2;
--Статус заявок билайна
Function get_ticket_status (
  pAccount_id in number,
  pRequestID in VARCHAR2
  ) return varchar2 ;
--создание отчёта по начислениям счета.
FUNCTION Create_account_bill(
  PaccountId IN VARCHAR2,
  Pyear_month IN INTEGER 
  ) RETURN VARCHAR2;
--Текущие начисления по номеру
Function phone_report_data  (
  pPHONE_NUMBER in number
  ) return varchar2;   
--Загрузка текущих начислений по Л/С 
function account_report_data(
  Paccount_id in number,
  n_mod in number
  ) return varchar2;  
-- Функция TURN_TARIFF_OPTION подключает или отключает тарифную опцию для номера.
-- Возвращается числовой код заявки или текст ошибки.
-- Заявка сохраняется в таблице BEELINE_TICKETS, статус заявки обновляет стандартный JOB проверки статуса.
FUNCTION TURN_TARIFF_OPTION(
  pPHONE_NUMBER IN VARCHAR2,
  pOPTION_CODE IN VARCHAR2,
  pTURN_ON IN INTEGER, -- 0: выключить, 1: включить
  pEFF_DATE IN DATE,   -- Дата подключения услуги (NULL - прямо сейчас)
  pEXP_DATE IN DATE,   -- Дата автоматического отключения (NULL - не отключать)
  pREQUEST_INITIATOR IN VARCHAR2 -- Инициатор запроса (до 10 знаков)
  ) RETURN VARCHAR2;        
-- Загрузка детализаций по АПИ
PROCEDURE LOAD_DETAIL_FROM_API(
  pPHONE_NUMBER IN VARCHAR2
  );   
--обновление номера сим карты по конкретному телефону
function phone_SIM(
  pPHONE_NUMBER in number
  ) return varchar2;  
--получение номера симкарты телефона по бану
function account_phone_SIM(
  Paccount_id in number
  ) return varchar2;                 
END;
CREATE OR REPLACE PACKAGE BODY "SIM_TRADE"."BEELINE_API_PCKG" AS

  const_year_month number; -- текущий месяц-год   
 ----------   
  FUNCTION REPLACE_SIM(
    pPHONE_NUMBER IN VARCHAR2, 
    pICC in varchar2
    ) RETURN VARCHAR2 IS
    --
    CURSOR C IS
      SELECT ACCOUNTS.LOGIN,
             ACCOUNTS.New_Pswd,
             ACCOUNTS.ACCOUNT_NUMBER,
             ACCOUNTS.Company_Name,
             Accounts.Account_Id
        FROM DB_LOADER_ACCOUNT_PHONES, ACCOUNTS
       WHERE DB_LOADER_ACCOUNT_PHONES.PHONE_NUMBER = pPHONE_NUMBER
         AND ACCOUNTS.ACCOUNT_ID = DB_LOADER_ACCOUNT_PHONES.ACCOUNT_ID
         AND DB_LOADER_ACCOUNT_PHONES.YEAR_MONTH = (select max(YEAR_MONTH) 
            from DB_LOADER_ACCOUNT_PHONES where PHONE_NUMBER = pPHONE_NUMBER);
    --
    vREC     C%ROWTYPE;
    V_RESULT VARCHAR2(20000);
    oICC     VARCHAR2(18);
    Respond  varchar2(5000); -- ответ
--    pbsal_id integer;
    pANSWER SOAP_API_ANSWER_TYPE := SOAP_API_ANSWER_TYPE(NULL, NULL,null);
  BEGIN
    OPEN C;
    FETCH C INTO vREC;
    CLOSE C;
    IF vREC.LOGIN IS NOT NULL THEN
      BEGIN
        Respond:=BEELINE_SOAP_API_PCKG.auth(vREC.LOGIN, vREC.New_Pswd);        
        panswer:=BEELINE_SOAP_API_PCKG.replaseSIM(Respond, pPHONE_NUMBER, pICC, '',vrec.account_id);                  
        select extractValue(pANSWER.ANSWER,'S:Envelope/S:Body/ns0:replaceSIMResponse/return'
                                          ,'xmlns:S="http://schemas.xmlsoap.org/soap/envelope/" xmlns:ns1="urn:uss-wsapi:Types" xmlns:ns0="urn:uss-wsapi:Subscriber"')
          into V_RESULT from dual;            
        if V_RESULT is null 
        then 
        select 
        nvl(pANSWER.Err_text,
        extractValue(pANSWER.ANSWER,'S:Envelope/S:Body/ns0:Fault/detail/ns1:UssWsApiException/errorDescription'
        ,'xmlns:S="http://schemas.xmlsoap.org/soap/envelope/" xmlns:ns0="http://schemas.xmlsoap.org/soap/envelope/ xmlns:ns1="urn:uss-wsapi:Types" xmlns:ns0="urn:uss-wsapi:Subscriber"')
        )
        into V_RESULT
        from dual; 
        if V_RESULT is null then  raise_application_error(-20000, 'Неопределённая ошибка Би.'); else return(V_RESULT);end if;
        else
          --Добавление в лог 
          insert into REPLACE_SIM_LOG(PHONE, OLD_SIM, NEW_SIM, REP_USER, REP_DATE, ERR, BSAL_ID, SIM_LOG_TYPE_ID)
            values(pPHONE_NUMBER, oICC, pICC, null, null,0,pANSWER.BSAL_ID, 1);
          --Добавление номера заявки на проверку                   
          insert into beeline_tickets(ticket_id, account_id, ban, ticket_type, answer, comments, phone_number, user_created, date_create)
            values(V_RESULT,vrec.account_id, vrec.account_number, 12, null, null, pPHONE_NUMBER, user, sysdate);                   
          commit;
          return V_RESULT;                  
        end if;

      EXCEPTION
        WHEN OTHERS THEN
          Respond := SQLERRM;
          insert into REPLACE_SIM_LOG(PHONE, OLD_SIM, NEW_SIM, REP_USER, REP_DATE, ERR, BSAL_ID, SIM_LOG_TYPE_ID)
           values
          (pPHONE_NUMBER, oICC, pICC, null, null,2,pANSWER.BSAL_ID, 1);
          commit;
          return Respond;
      END;        
    ELSE
      insert into REPLACE_SIM_LOG(PHONE, OLD_SIM, NEW_SIM, REP_USER, REP_DATE, ERR, BSAL_ID, SIM_LOG_TYPE_ID)
           values
          (pPHONE_NUMBER, oICC, pICC, null, null,1,null, 1);
          commit;
      RETURN pPHONE_NUMBER || ' не найден в базе данных.';
    END IF;
  END;
  --
  FUNCTION LOCK_PHONE(
    pPHONE_NUMBER IN VARCHAR2,
    pMANUAL_BLOCK IN INTEGER DEFAULT 1,
    pCode         in varchar2
    ) RETURN VARCHAR2 IS
    --
    CURSOR C IS
      SELECT ACCOUNTS.LOGIN, ACCOUNTS.New_Pswd,ACCOUNTS.Account_Id,ACCOUNTS.Account_Number
        FROM DB_LOADER_ACCOUNT_PHONES, ACCOUNTS
        WHERE DB_LOADER_ACCOUNT_PHONES.PHONE_NUMBER = pPHONE_NUMBER
          AND ACCOUNTS.ACCOUNT_ID = DB_LOADER_ACCOUNT_PHONES.ACCOUNT_ID
          AND DB_LOADER_ACCOUNT_PHONES.YEAR_MONTH = (select max(YEAR_MONTH) 
                                                       from DB_LOADER_ACCOUNT_PHONES 
                                                       where PHONE_NUMBER = pPHONE_NUMBER);
    vREC C%ROWTYPE;
  --  abREC    ABONENT%ROWTYPE;
    FIO      VARCHAR2(2000);
    V_RESULT VARCHAR2(20000);
    Respond  varchar2(5000); -- ответ
    pANSWER SOAP_API_ANSWER_TYPE := SOAP_API_ANSWER_TYPE(NULL, NULL,null);
  BEGIN
    OPEN C;
    FETCH C INTO vREC;
    CLOSE C;
    IF vREC.LOGIN IS NOT NULL THEN
      BEGIN
        Respond:=BEELINE_SOAP_API_PCKG.auth(vREC.LOGIN, vREC.New_Pswd);--получаем токен
        pANSWER:=BEELINE_SOAP_API_PCKG.suspendCTN(Respond, pPHONE_NUMBER, sysdate + 1 / 86400, '', pCode,vrec.account_id);--запрос к АПИ
        --разбор ответа
        select extractValue(pANSWER.ANSWER,'S:Envelope/S:Body/ns0:suspendCTNResponse/return'
                                            ,'xmlns:S="http://schemas.xmlsoap.org/soap/envelope/" xmlns:ns1="urn:uss-wsapi:Types" xmlns:ns0="urn:uss-wsapi:Subscriber"')
          into V_RESULT from dual;            
        if V_RESULT is null then--Если нет нормального номера заявки
          --берём номер ошибки
          if pANSWER.Err_text!='OK' then 
            V_RESULT:=pANSWER.Err_text;
          else
            select nvl(pANSWER.Err_text,    
                       extractValue(pANSWER.ANSWER,'S:Envelope/S:Body/ns0:Fault/detail/ns1:UssWsApiException/errorDescription'
                                                  ,'xmlns:S="http://schemas.xmlsoap.org/soap/envelope/" xmlns:ns0="http://schemas.xmlsoap.org/soap/envelope/ xmlns:ns1="urn:uss-wsapi:Types" xmlns:ns0="urn:uss-wsapi:Subscriber"') )
              into V_RESULT from dual; 
          end if;     
          --Нет номера ошибки возвращаем неопределённую ошибку
          if V_RESULT is null then
            raise_application_error(-20000, 'Неопределённая ошибка Би.');
          --Есть номер ошибки возвращаем его   
          else 
            return('Error_Api:'||V_RESULT); 
          end if;
        --Если всё в порядке и есть номер
        else
         --Добавление в лог 
          INSERT INTO AUTO_BLOCKED_PHONE(PHONE_NUMBER, BALLANCE, BLOCK_DATE_TIME,
                                          MANUAL_BLOCK, USER_NAME, ABONENT_FIO, note)
            VALUES(pPHONE_NUMBER, GET_ABONENT_BALANCE(pPHONE_NUMBER), SYSDATE,
                    pMANUAL_BLOCK, USER, FIO, 'Заявка на блок №'||V_RESULT);
         --Добавление номера заявки на проверку
          insert into beeline_tickets(ticket_id, account_id, ban, ticket_type, answer, comments, phone_number,user_created,date_create)
            values(V_RESULT,vrec.account_id, vrec.account_number, 9, null, null,pPHONE_NUMBER,user,sysdate);
          commit;
          --Возвращаем номер заявки на проверку
          return ('Заявка на блок №'||V_RESULT);          
        end if;
      --В случае исключения возвращаем ошибку  
      EXCEPTION
        WHEN OTHERS THEN
          Respond := SQLERRM;
          return Respond;
      END;
    ELSE
      RETURN pPHONE_NUMBER || ' не найден в базе данных.';
    END IF;
  END;
  --
  FUNCTION UNLOCK_PHONE(
    pPHONE_NUMBER  IN VARCHAR2,
    pMANUAL_UNLOCK IN INTEGER DEFAULT 1
    ) RETURN VARCHAR2 IS
    --
    CURSOR C IS
      SELECT ACCOUNTS.LOGIN, ACCOUNTS.New_Pswd,ACCOUNTS.Account_Id,ACCOUNTS.Account_Number
        FROM DB_LOADER_ACCOUNT_PHONES, ACCOUNTS
        WHERE DB_LOADER_ACCOUNT_PHONES.PHONE_NUMBER = pPHONE_NUMBER
          AND ACCOUNTS.ACCOUNT_ID = DB_LOADER_ACCOUNT_PHONES.ACCOUNT_ID
          AND DB_LOADER_ACCOUNT_PHONES.YEAR_MONTH = (select max(YEAR_MONTH) 
                                                       from DB_LOADER_ACCOUNT_PHONES 
                                                       where PHONE_NUMBER = pPHONE_NUMBER);  
    vREC     C%ROWTYPE;
    FIO      VARCHAR2(2000);
    V_RESULT VARCHAR2(20000);
    Respond  varchar2(5000); -- ответ
    pANSWER SOAP_API_ANSWER_TYPE := SOAP_API_ANSWER_TYPE(NULL, NULL,null);
  BEGIN
    OPEN C;
    FETCH C INTO vREC;
    CLOSE C;
    IF vREC.LOGIN IS NOT NULL THEN
      BEGIN
        Respond:=BEELINE_SOAP_API_PCKG.auth(vREC.LOGIN, vREC.New_Pswd);--получаем токен
        pANSWER:=BEELINE_SOAP_API_PCKG.restoreCTN(Respond, pPHONE_NUMBER, sysdate + 1 / 86400,'',vrec.account_id);--запрос к АПИ
        --разбор ответа
        select extractValue(pANSWER.ANSWER,'S:Envelope/S:Body/ns0:restoreCTNResponse/return'
                                          ,'xmlns:S="http://schemas.xmlsoap.org/soap/envelope/" xmlns:ns1="urn:uss-wsapi:Types" xmlns:ns0="urn:uss-wsapi:Subscriber"')
          into V_RESULT from dual;            
        if V_RESULT is null then --Если нет нормального номера заявки
           --берём номер ошибки
          select nvl(pANSWER.Err_text,
                     extractValue(pANSWER.ANSWER,'S:Envelope/S:Body/ns0:Fault/detail/ns1:UssWsApiException/errorDescription'
                                ,'xmlns:S="http://schemas.xmlsoap.org/soap/envelope/" xmlns:ns0="http://schemas.xmlsoap.org/soap/envelope/ xmlns:ns1="urn:uss-wsapi:Types" xmlns:ns0="urn:uss-wsapi:Subscriber"'))
            into V_RESULT from dual;                        
              --Нет номера ошибки возвращаем неопределённую ошибку
          if V_RESULT is null then  
            raise_application_error(-20000, 'Неопределённая ошибка Би.');
          --Есть номер ошибки возвращаем его   
          else 
            return('Error_Api:'||V_RESULT); 
          end if;
        --Если всё в порядке и есть номер
         else
         --Добавление в лог 
          INSERT INTO AUTO_UNBLOCKED_PHONE(PHONE_NUMBER, BALLANCE, UNBLOCK_DATE_TIME,
                                            MANUAL_BLOCK, USER_NAME, ABONENT_FIO, note)
            VALUES(pPHONE_NUMBER, GET_ABONENT_BALANCE(pPHONE_NUMBER), SYSDATE, 
                    pMANUAL_UNLOCK, USER, FIO, 'Заявка на разблок №'||V_RESULT);
          --Добавление номера заявки на проверку
          insert into beeline_tickets(ticket_id, account_id, ban, ticket_type, answer, comments, phone_number,user_created,date_create)
            values(V_RESULT,vrec.account_id, vrec.account_number, 10, null, null,pPHONE_NUMBER,user,sysdate);
          commit;
          --Возвращаем номер заявки на проверку
          return ('Заявка на разблок №'||V_RESULT); 
         
        end if;
      --В случае исключения возвращаем ошибку  
      exception
        WHEN OTHERS THEN
          Respond := SQLERRM;
          return Respond;
      end;
      return Respond;
    ELSE
      RETURN pPHONE_NUMBER || ' не найден в базе данных.';
    END IF;
  END;
  --
  Function phone_status(
    pPHONE_NUMBER in number
    ) return varchar2 is
     --
    CURSOR C IS
      SELECT ACCOUNTS.LOGIN, ACCOUNTS.New_Pswd,
             (case ACCOUNTS.Is_Collector
                when 1 then nvl(bi.ban,0)
                else accounts.account_number
              end) account_number, accounts.account_id
        FROM DB_LOADER_ACCOUNT_PHONES, ACCOUNTS, beeline_loader_inf bi
        WHERE DB_LOADER_ACCOUNT_PHONES.PHONE_NUMBER = pPHONE_NUMBER
          and bi.phone_number(+)=DB_LOADER_ACCOUNT_PHONES.Phone_Number
          AND ACCOUNTS.ACCOUNT_ID = DB_LOADER_ACCOUNT_PHONES.ACCOUNT_ID
          AND DB_LOADER_ACCOUNT_PHONES.YEAR_MONTH = ( select max(YEAR_MONTH) 
                                                        from DB_LOADER_ACCOUNT_PHONES 
                                                        where PHONE_NUMBER = pPHONE_NUMBER);                                                           
    vREC C%ROWTYPE;
    Respond  varchar2(5000); -- ответ
    Resp_code varchar2(200);-- ответ код
    Resp_plan varchar2(200);-- ответ код
    Resp_date_change varchar2(200 char);
    pANSWER SOAP_API_ANSWER_TYPE := SOAP_API_ANSWER_TYPE(NULL, NULL,null);  
    vCOMMENT VARCHAR2(1000 CHAR);
  
    procedure update_phones (ph in varchar2,ym in number,acc in number, pCODE IN VARCHAR2, pDATE_CHANGE IN DATE) as 
      PRAGMA AUTONOMOUS_TRANSACTION;
    begin
      update db_loader_account_phones q 
        set q.phone_is_active=decode(Respond,'ACTIVE',1,'BLOCKED',0)
           ,q.last_check_date_time=sysdate 
           ,q.conservation=decode(Respond, 'ACTIVE',0,'BLOCKED', decode(Resp_code,'S1B',1,'DUF',1,'BSB',1,'DOSS',1,0))
           ,q.system_block=decode(Respond, 'ACTIVE',0,'BLOCKED', decode(Resp_code,'BSB',1,'DUF',1,'DOSS',1,0))
           ,q.cell_plan_code=Resp_plan
           ,Q.LAST_CHANGE_STATUS_DATE=pDATE_CHANGE
           ,Q.STATUS_ID=CONVERT_PCKG.STATUS_CODE_TO_STATUS_ID(pCODE)                                                         
        where q.phone_number=ph 
          and q.year_month=ym 
          and q.account_id=acc
          and trim(Respond) in ('ACTIVE','BLOCKED');               
      temp_add_account_phone_history(ph, Resp_plan, case Respond when 'ACTIVE' then 1 when 'BLOCKED' then 0 end, sysdate);
      commit;
    end;      

  begin
    OPEN C;
    FETCH C INTO vREC;
    CLOSE C;
    IF vREC.LOGIN IS NOT NULL THEN
      BEGIN
        pANSWER:=BEELINE_SOAP_API_PCKG.getCTNInfoList(BEELINE_SOAP_API_PCKG.auth(vREC.LOGIN, vREC.New_Pswd), pPHONE_NUMBER,vREC.account_number, '');
        select extractValue(pANSWER.ANSWER,'S:Envelope/S:Body/ns0:getCTNInfoListResponse/CTNInfoList/status',      'xmlns:S="http://schemas.xmlsoap.org/soap/envelope/" xmlns:ns1="urn:uss-wsapi:Types" xmlns:ns0="urn:uss-wsapi:Subscriber"')
              ,extractValue(pANSWER.ANSWER,'S:Envelope/S:Body/ns0:getCTNInfoListResponse/CTNInfoList/reasonStatus','xmlns:S="http://schemas.xmlsoap.org/soap/envelope/" xmlns:ns1="urn:uss-wsapi:Types" xmlns:ns0="urn:uss-wsapi:Subscriber"') 
              ,extractValue(pANSWER.ANSWER,'S:Envelope/S:Body/ns0:getCTNInfoListResponse/CTNInfoList/pricePlan',   'xmlns:S="http://schemas.xmlsoap.org/soap/envelope/" xmlns:ns1="urn:uss-wsapi:Types" xmlns:ns0="urn:uss-wsapi:Subscriber"')   
              ,extractValue(pANSWER.ANSWER,'S:Envelope/S:Body/ns0:getCTNInfoListResponse/CTNInfoList/statusDate',  'xmlns:S="http://schemas.xmlsoap.org/soap/envelope/" xmlns:ns1="urn:uss-wsapi:Types" xmlns:ns0="urn:uss-wsapi:Subscriber"')     
        into Respond,Resp_code,Resp_plan, Resp_date_change from dual; 
--insert into beeline_soap_api_log(soap_answer) values (pANSWER.ANSWER); commit;--Включать только для отладки!
        update_phones(pPHONE_NUMBER,to_char(sysdate,'YYYYMM'),vrec.account_id, Resp_code, convert_pckg.TIMESTAMP_TZ_TO_DATE(Resp_date_change));
      EXCEPTION
        WHEN OTHERS THEN
          Respond := pANSWER.Err_text||CHR(13)||SQLERRM;
          return (Respond);
      END;
    Else
    Respond:='Не найден л\с';
    end if;
    SELECT B.COMMENT_CLENT INTO vCOMMENT
      FROM BEELINE_STATUS_CODE B
      WHERE B.STATUS_CODE = Resp_code;
    Return ('Статус: '||Respond||'. Код тарифа: '||Resp_plan||'. Код статуса: '||Resp_code||'('||vCOMMENT||')');
  end;  
  --
  Function phone_options  (pPHONE_NUMBER in number) return varchar2 is
     --
    CURSOR C IS
      SELECT ACCOUNTS.LOGIN, ACCOUNTS.New_Pswd
             ,decode(accounts.is_collector,1,li.ban,0,accounts.account_number,accounts.account_number) account_number
        FROM DB_LOADER_ACCOUNT_PHONES, ACCOUNTS, beeline_loader_inf li
       WHERE DB_LOADER_ACCOUNT_PHONES.PHONE_NUMBER = pPHONE_NUMBER
         AND ACCOUNTS.ACCOUNT_ID = DB_LOADER_ACCOUNT_PHONES.ACCOUNT_ID
         and li.phone_number(+)=DB_LOADER_ACCOUNT_PHONES.Phone_Number
         and DB_LOADER_ACCOUNT_PHONES.YEAR_MONTH = (select max(YEAR_MONTH) 
            from DB_LOADER_ACCOUNT_PHONES where PHONE_NUMBER = pPHONE_NUMBER);   

   vREC     C%ROWTYPE;
    Respond  varchar2(5000); -- ответ
    pANSWER SOAP_API_ANSWER_TYPE := SOAP_API_ANSWER_TYPE(NULL, NULL,null);  
    vStart_date date;

    procedure update_options(pctn in varchar2, pserviceId in varchar2, pserviceName in varchar2,pStDate in date,pEndDate in date) as
      pragma autonomous_transaction;
      begin
         db_loader_pckg.ADD_ACCOUNT_PHONE_OPTION2(
                      to_char(sysdate,'YYYY'),
                      to_char(sysdate,'MM'),
                      vrec.login,
                      pctn, /*номер*/
                      pserviceId,       /* Код опции */
                      pserviceName,       /* Наименование опции */
                      null, /* Параметры опции */
                      pStDate,          /* Дата подключения*/
                      pEndDate,         /* Дата отключения */
                      null,        /*Стоимость подключения*/
                      null        /*Стоимость в месяц*/
                      );
        commit;
      end;
    procedure update_option_close(pctn in varchar2, pStart_date in date) as
      pragma autonomous_transaction;
      cursor otp_select is
        select *
          from db_loader_account_phone_opts op
          where op.PHONE_NUMBER = pctn
            and op.LAST_CHECK_DATE_TIME >= pStart_date;
      o_dummy otp_select%rowtype;
      begin
        open otp_select;
        fetch otp_select into o_dummy;
        if otp_select%found then 
          update db_loader_account_phone_opts op
            set op.TURN_OFF_DATE = sysdate
            where op.PHONE_NUMBER = o_dummy.PHONE_NUMBER
              and op.YEAR_MONTH = o_dummy.YEAR_MONTH
              and op.TURN_OFF_DATE is null
              and op.LAST_CHECK_DATE_TIME < pStart_date;
        end if;
        close otp_select;
        commit;
      end;

  begin
    OPEN C;
    FETCH C INTO vREC;
    CLOSE C;
    IF vREC.LOGIN IS NOT NULL THEN
      BEGIN
        vStart_date:=sysdate;
        pANSWER:=BEELINE_SOAP_API_PCKG.getServiceList(BEELINE_SOAP_API_PCKG.auth(vREC.LOGIN, vREC.New_Pswd), pPHONE_NUMBER,vREC.account_number, '');
        For i in(
        select substr(extractvalue (value(d) ,'servicesList/ctn'),-10)ctn
                     ,extractvalue (value(d) ,'/servicesList/serviceId')   serviceId
                     ,CONVERT_PCKG.TIMESTAMP_TZ_TO_DATE(extractvalue (value(d) ,'/servicesList/startDate')) startDate
                     ,CONVERT_PCKG.TIMESTAMP_TZ_TO_DATE(extractvalue (value(d) ,'/servicesList/endDate')) endDate
                     ,extractvalue (value(d) ,'/servicesList/serviceName') serviceName
        from table(XmlSequence(pANSWER.ANSWER.extract('S:Envelope/S:Body/ns0:getServicesListResponse/servicesList'
                 ,'xmlns:S="http://schemas.xmlsoap.org/soap/envelope/" xmlns:ns0="urn:uss-wsapi:Subscriber"'))) d
        )loop
        update_options(to_char(i.ctn),i.serviceId, i.serviceName,i.startDate,i.endDate);
       
        Respond:=Respond||i.serviceId||' '||i.serviceName||chr(13);
        end loop; 
      EXCEPTION
        WHEN OTHERS THEN
          Respond := SQLERRM;
          return (Respond);
      END;
    Else
    Respond:='Не найден л\с';
    end if;
    update_option_close(pPHONE_NUMBER, vStart_date);
    Return (Respond);
  end; 
  --
  Function phone_detail_call (pPHONE_NUMBER in number) return varchar2 is
     --
    CURSOR C IS
      SELECT ACCOUNTS.LOGIN, ACCOUNTS.New_Pswd, accounts.account_number
        FROM DB_LOADER_ACCOUNT_PHONES, ACCOUNTS
       WHERE DB_LOADER_ACCOUNT_PHONES.PHONE_NUMBER = pPHONE_NUMBER
         AND ACCOUNTS.ACCOUNT_ID = DB_LOADER_ACCOUNT_PHONES.ACCOUNT_ID
         AND DB_LOADER_ACCOUNT_PHONES.YEAR_MONTH = (select max(YEAR_MONTH) 
            from DB_LOADER_ACCOUNT_PHONES where PHONE_NUMBER = pPHONE_NUMBER);   
 

   vREC     C%ROWTYPE;
    Respond  varchar2(5000); -- ответ
    pANSWER SOAP_API_ANSWER_TYPE := SOAP_API_ANSWER_TYPE(NULL, NULL,null);  

 begin
    OPEN C;
    FETCH C INTO vREC;
    CLOSE C;
    IF vREC.LOGIN IS NOT NULL THEN
      BEGIN
        pANSWER:=BEELINE_SOAP_API_PCKG.getUnbilledCallsList(BEELINE_SOAP_API_PCKG.auth(vREC.LOGIN, vREC.New_Pswd), pPHONE_NUMBER,vREC.account_number, '');
/*        For i in(        
        select substr(extractvalue (value(d) ,'UnbilledCallsList/callNumber'),-10) callNumber
                     ,extractvalue (value(d) ,'UnbilledCallsList/callDate')   callDate
                     ,substr(extractvalue (value(d) ,'UnbilledCallsList/callToNumber'),-10) callToNumber
                     ,extractvalue (value(d) ,'UnbilledCallsList/serviceName') serviceName
                     ,extractvalue (value(d) ,'UnbilledCallsList/callType') callType
                     ,extractvalue (value(d) ,'UnbilledCallsList/dataVolume') dataVolume
                     ,extractvalue (value(d) ,'UnbilledCallsList/callAmt') callAmt                                                               
                     ,extractvalue (value(d) ,'UnbilledCallsList/callDuration') callDuration  
        from table(XmlSequence(pANSWER.ANSWER.extract('S:Envelope/S:Body/ns0:getUnbilledCallsListResponse/UnbilledCallsList'
                 ,'xmlns:S="http://schemas.xmlsoap.org/soap/envelope/" xmlns:ns0="urn:uss-wsapi:Subscriber"'))) d
        )loop
        
        end loop;*/ 
        respond:=pANSWER.BSAL_ID;
      EXCEPTION
        WHEN OTHERS THEN
          Respond := SQLERRM;
          return (Respond);
      END;
    Else
    Respond:='Не найден л\с';
    end if;
  Return (Respond);
 end;
  --
function account_phone_status(
  Paccount_id in number
  ) return varchar2 is--phone_state_table  
  CURSOR C IS
    SELECT ACCOUNTS.LOGIN, ACCOUNTS.New_Pswd, accounts.account_number,accounts.account_id,accounts.is_collector
      FROM  ACCOUNTS
      WHERE ACCOUNTS.account_id = Paccount_id;  
  vREC     C%ROWTYPE;
  Respond  varchar2(5000); -- ответ
  pANSWER SOAP_API_ANSWER_TYPE := SOAP_API_ANSWER_TYPE(NULL, NULL,null); 
  vYEAR_MONTH INTEGER;
  begin
    OPEN C;
    FETCH C INTO vREC;
    CLOSE C;
    IF vREC.LOGIN IS NOT NULL and vRec.Is_Collector=0 or vRec.Is_Collector is null THEN
      BEGIN
        pANSWER:=BEELINE_SOAP_API_PCKG.getCTNInfoList(BEELINE_SOAP_API_PCKG.auth(vREC.LOGIN, vREC.New_Pswd),'',vREC.account_number,'');        
        if pANSWER.Err_text='OK' then    
          --             
          DELETE FROM API_GET_CTN_INFO_LIST;
          --
          INSERT INTO API_GET_CTN_INFO_LIST(ctn, statusDate, status, pricePlan, reasonStatus, lastActivity, activationDate, subscriberHLR)
            SELECT extractvalue (value(d) ,'CTNInfoList/ctn') ctn
                   ,extractvalue (value(d) ,'/CTNInfoList/statusDate') statusDate
                   ,extractvalue (value(d) ,'/CTNInfoList/status') status
                   ,extractvalue (value(d) ,'/CTNInfoList/pricePlan') pricePlan
                   ,extractvalue (value(d) ,'/CTNInfoList/reasonStatus') reasonStatus
                   ,extractvalue (value(d) ,'/CTNInfoList/lastActivity') lastActivity
                   ,extractvalue (value(d) ,'/CTNInfoList/activationDate') activationDate
                   ,extractvalue (value(d) ,'/CTNInfoList/subscriberHLR') subscriberHLR
              FROM TABLE(XmlSequence(pANSWER.ANSWER.extract('S:Envelope/S:Body/ns0:getCTNInfoListResponse/CTNInfoList'
                                                            ,'xmlns:S="http://schemas.xmlsoap.org/soap/envelope/" xmlns:ns0="urn:uss-wsapi:Subscriber"'))) D;
          --     
          vYEAR_MONTH:=TO_NUMBER(to_char(sysdate,'YYYYMM'));         
          MERGE INTO db_loader_account_phones ph
          -- Условие сравнения
            USING (select substr(d.ctn, -10) ctn
                         ,d.status stat
                         ,d.reasonStatus reason
                         ,d.pricePlan plan
                         ,CONVERT_PCKG.TIMESTAMP_TZ_TO_DATE(d.statusDate) statusDate
                         ,bsc.IS_CONSERVATION
                         ,bsc.IS_SYSTEM_BLOCK
                     from API_GET_CTN_INFO_LIST d
                     left outer join BEELINE_STATUS_CODE bsc on bsc.STATUS_CODE = d.reasonStatus                     
                  ) api
            ON (ph.phone_number = api.ctn 
                  and ph.year_month=vYEAR_MONTH 
                  and ph.account_id=Paccount_id)                
          WHEN MATCHED THEN
          -- Когда нашли
            UPDATE SET ph.phone_is_active=CASE WHEN API.STAT = 'ACTIVE' THEN 1 ELSE 0 END,
                       ph.cell_plan_code=api.plan,
                       ph.last_check_date_time=sysdate,
                       ph.last_change_status_date=api.statusDate,                
                       ph.conservation = CASE WHEN API.STAT = 'ACTIVE' THEN 0 ELSE API.IS_CONSERVATION END,
                       ph.system_block = CASE WHEN API.STAT = 'ACTIVE' THEN 0 ELSE API.IS_SYSTEM_BLOCK END,
                       PH.STATUS_ID = CONVERT_PCKG.STATUS_CODE_TO_STATUS_ID(API.REASON)
            WHERE (api.stat in ('ACTIVE','BLOCKED')                        -- Где есть данные по номеру из АПИ 
                    or (api.stat is null and ph.last_check_date_time<sysdate-1))-- Либо номер не обновлялся более суток и будет изменён только для того чтобы его удалило    
          WHEN NOT MATCHED THEN
          -- Когда не нашли
            INSERT (ph.account_id, ph.year_month, ph.phone_number,
                    ph.phone_is_active, ph.cell_plan_code, ph.last_check_date_time,
                    ph.organization_id, ph.conservation, ph.system_block, 
                    ph.last_change_status_date, ph.STATUS_ID  )
              VALUES (Paccount_id, vYEAR_MONTH, api.ctn,
                      CASE WHEN API.STAT = 'ACTIVE' THEN 1 ELSE 0 END, 
                      api.plan, sysdate, 1, 
                      CASE WHEN API.STAT = 'ACTIVE' THEN 0 ELSE API.IS_CONSERVATION END,
                      CASE WHEN API.STAT = 'ACTIVE' THEN 0 ELSE API.IS_SYSTEM_BLOCK END,
                      api.statusDate, convert_pckg.STATUS_CODE_TO_STATUS_ID(api.reason)  )
            WHERE api.stat in ('ACTIVE','BLOCKED');
          --- MERGE END   
          Respond:='Update '||sql%rowcount;
          -- Удалим номера, которые покинули л/с, т.е. есть в DB_LOADER_ACCOUNT_PHONES, но нет в Загрузке по АПИ
          DELETE 
            FROM DB_LOADER_ACCOUNT_PHONES PH
            WHERE PH.ACCOUNT_ID = pACCOUNT_ID
              AND PH.YEAR_MONTH = vYEAR_MONTH 
              AND PHONE_NUMBER NOT IN (select substr(d.ctn, -10) ctn                         
                                         from API_GET_CTN_INFO_LIST d);
           --добавляем записи в историю и выставляем ФРОД
          if sql%rowcount>0 then 
            for hist in(select substr(d.ctn,-10) ctn
                              ,d.status stat
                              ,d.reasonStatus reason
                              ,d.pricePlan plan
                          from API_GET_CTN_INFO_LIST d
                          where d.status in ('ACTIVE','BLOCKED'))
            loop
              temp_add_account_phone_history(hist.ctn, hist.plan, case hist.stat when 'ACTIVE' then 1 when 'BLOCKED' then 0 end, sysdate);
              --доп.статус ФРОД
              if hist.stat='BLOCKED' and hist.reason in ('BSB','DUF') AND ms_constants.GET_CONSTANT_VALUE('SERVER_NAME')='CORP_MOBILE' then 
                update contracts ct 
                  set ct.dop_status=8 --(по справочнику contracts_dop_statuses = ФРОД)
                  where not exists (select 1 from contract_cancels cc where cc.contract_id=ct.contract_id) 
                    and ct.phone_number_federal=hist.ctn;
              end if;                                                                                                                                                                                                                                                   
            end loop hist;
          end if;
          commit;
          --логирование в лог загрузок 
          insert into account_load_logs( account_load_log_id,account_id, load_date_time, is_success, error_text, account_load_type_id)
            values(s_new_account_load_log_id.nextval,Paccount_id, sysdate, 1, 'Ok!'||Respond, 3);          
          if sql%rowcount>0 then 
            commit;
          end if;
        else 
          Respond:= pANSWER.Err_text;
        end if;
      EXCEPTION
        WHEN OTHERS THEN
          Respond := SQLERRM;
          return Respond;
      END;--api_responce
    Else
      Respond:='Не найден л\с';
    end if;--vrec.login
    Return Respond;           
  end;--func
--
function account_phone_options(
  Paccount_id in number
  ) return varchar2  is--phone_state_table 
    CURSOR C IS
      SELECT ACCOUNTS.LOGIN, ACCOUNTS.New_Pswd, accounts.account_number,accounts.account_id,accounts.is_collector
        FROM ACCOUNTS
       WHERE ACCOUNTS.account_id = Paccount_id; 
   vREC     C%ROWTYPE;
   Respond  varchar2(5000); -- ответ
   pANSWER SOAP_API_ANSWER_TYPE := SOAP_API_ANSWER_TYPE(NULL, NULL,null); 
   count_good integer:=0;
   count_bad integer:=0;   
begin
  OPEN C;
  FETCH C INTO vREC;
  CLOSE C;
  IF vREC.LOGIN IS NOT NULL and (vRec.Is_Collector=0 or vRec.Is_Collector is null)  THEN
    BEGIN      
      for i in (select ph.phone_number
                     from db_loader_account_phones ph 
                     where ph.year_month=const_year_month and ph.account_id=Paccount_id
                     order by get_last_options_update(ph.phone_number) 
      ) loop
      pANSWER:=BEELINE_SOAP_API_PCKG.getServiceList(BEELINE_SOAP_API_PCKG.auth(vREC.LOGIN, vREC.New_Pswd),i.phone_number,vREC.account_number,'');            
      if pANSWER.Err_text='OK' then    
       --цикл по ответу
        for s in (select substr(extractvalue (value(d) ,'servicesList/ctn'),-10)ctn
                         ,trim(extractvalue (value(d) ,'/servicesList/serviceId'))   serviceId
                         ,CONVERT_PCKG.TIMESTAMP_TZ_TO_DATE(extractvalue (value(d) ,'/servicesList/startDate')) startDate
                         ,CONVERT_PCKG.TIMESTAMP_TZ_TO_DATE(extractvalue (value(d) ,'/servicesList/endDate')) endDate
                         ,trim(extractvalue (value(d) ,'/servicesList/serviceName')) serviceName
                   from table(XmlSequence(pANSWER.ANSWER.extract('S:Envelope/S:Body/ns0:getServicesListResponse/servicesList'
                                                                ,'xmlns:S="http://schemas.xmlsoap.org/soap/envelope/" xmlns:ns0="urn:uss-wsapi:Subscriber"'))) d)
        loop
          --вызываем процедуру опций из старого кабинета
          null;
          db_loader_pckg.ADD_ACCOUNT_PHONE_OPTION2(
               to_char(sysdate,'YYYY'),
               to_char(sysdate,'MM'),
               vrec.login,
               to_char(s.ctn), /*номер*/
               s.serviceId,       /* Код опции */
               s.serviceName,       /* Наименование опции */
               null, /* Параметры опции */
               s.startDate,          /* Дата подключения*/
               s.endDate,         /* Дата отключения */
               null,        /*Стоимость подключения*/
               null        /*Стоимость в месяц*/
               );
          count_good:=count_good+1; 
        end loop s;                                   
      else
        count_bad:=count_bad+1;
      end if;
       --удаляем услуги которых нет более суток
      DB_LOADER_PHONE_OPRT_CLOSE2(substr(to_char(const_year_month),1,4), substr(to_char(const_year_month),5,2),i.phone_number); 
      commit;
    end loop i;       
   --логирование в лог загрузок 
      if count_good>0 then --есть хоть один успех - логируем что всё хорошо.
         insert into account_load_logs
           (account_load_log_id,account_id, load_date_time, is_success, error_text, account_load_type_id)
         values
           (s_new_account_load_log_id.nextval,Paccount_id, sysdate, 1, 'Ok! Update options count '||count_good, 4);
      else 
         insert into account_load_logs
           (account_load_log_id,account_id, load_date_time, is_success, error_text, account_load_type_id)
         values
           (s_new_account_load_log_id.nextval,Paccount_id, sysdate, 0, 'Update:'||count_good||' err_count='||count_bad||',last err_txt:'||pANSWER.Err_text, 4);
      end if;
    commit;  
    EXCEPTION
      WHEN OTHERS THEN
        Respond := SQLERRM;
        return Respond;
    END;--api_responce
  Else
    Respond:='Не найден л\с';
  end if;--vrec.login
  Return Respond;
--         
end;--func 
--
  Function account_phone_payments  (pAccount_id in number) return varchar2 is
     --
    CURSOR C IS
      SELECT distinct ACCOUNTS.LOGIN, ACCOUNTS.New_Pswd,ACCOUNTS.account_number,accounts.account_id
        FROM  ACCOUNTS
       WHERE ACCOUNTS.ACCOUNT_ID = pAccount_id;   
  vREC     C%ROWTYPE;
    Respond  varchar2(5000); -- ответ

    paysign number(1);--направление платежа.
    counter number:=0;
    counter_PAYM number:=0;
    pANSWER SOAP_API_ANSWER_TYPE := SOAP_API_ANSWER_TYPE(NULL, NULL,null);       
  begin
      OPEN C;
    FETCH C
      INTO vREC;
    CLOSE C;
    IF vREC.LOGIN IS NOT NULL THEN
      BEGIN
        pANSWER:=BEELINE_SOAP_API_PCKG.getPaymentList(BEELINE_SOAP_API_PCKG.auth(vREC.LOGIN, vREC.New_Pswd),'',vREC.account_number,'',sysdate-3, sysdate);        
        if pANSWER.Err_text='OK' then    
          --
          DELETE FROM API_GET_PAYMENT_LIST;
          --
          INSERT INTO API_GET_PAYMENT_LIST(ctn, paymentDate, paymentStatus, paymentType, 
                                           paymentOriginalAmt, paymentCurrentAmt, 
                                           bankPaymentID, paymentActivateDate)
            select extractvalue (value(d) ,'/PaymentList/ctn') ctn
                  ,extractvalue (value(d) ,'/PaymentList/paymentDate') paymentDate
                  ,extractvalue (value(d) ,'/PaymentList/paymentStatus') paymentStatus
                  ,extractvalue (value(d) ,'/PaymentList/paymentType') paymentType
                  ,extractvalue (value(d) ,'/PaymentList/paymentOriginalAmt') paymentOriginalAmt
                  ,extractvalue (value(d) ,'/PaymentList/paymentCurrentAmt') paymentCurrentAmt
                  ,extractvalue (value(d) ,'/PaymentList/bankPaymentID') bankPaymentID
                  ,extractvalue (value(d) ,'/PaymentList/paymentActivateDate') paymentActivateDate
              from table(XmlSequence(pANSWER.ANSWER.extract('S:Envelope/S:Body/ns0:getPaymentListResponse/PaymentList'
                                                           ,'xmlns:S="http://schemas.xmlsoap.org/soap/envelope/" xmlns:ns0="urn:uss-wsapi:Subscriber"'))) d;       
            --Цикл по платежам
          for payments in (select substr(PL.ctn, -10) ctn
                                  ,CONVERT_PCKG.TIMESTAMP_TZ_TO_DATE(PL.paymentDate) paymentDate
                                  ,PL.paymentStatus paymentStatus
                                  ,PL.paymentType paymentType
                                  ,PL.paymentOriginalAmt paymentOriginalAmt
                                  ,PL.paymentCurrentAmt paymentCurrentAmt
                                  ,nvl(PL.bankPaymentID,0) bankPaymentID
                                  ,CONVERT_PCKG.TIMESTAMP_TZ_TO_DATE(PL.paymentActivateDate) paymentActivateDate
                              from API_GET_PAYMENT_LIST PL
          ) LOOP
             --Проверка платежей
             --Список направления платежа
             /*
             Backout Отмена платежа
             Funds transfer from Перенос платежа на другого клиента
             Funds transfer to Перенос платежа c другого клиента
             Refund Возврат платежа
             Payment Платеж зачислен
             Refund reversal Отмена возврата платежа
             */
            paysign:=case 
                       when payments.paymentStatus='Payment' then 1
                       when payments.paymentStatus='Backout' then -1
                       when payments.paymentStatus='Funds transfer from' then -1
                       when payments.paymentStatus='Funds transfer to' then 1
                       when payments.paymentStatus='Refund' then -1
                       when payments.paymentStatus='Refund reversal' then 1
                       else 0
                     end;      
            IF INSTR(payments.paymentStatus, 'Funds transfer') = 0 THEN                                         
              db_loader_pckg.add_payment(pyear => substr(to_char(const_year_month),1,4),
                                         pmonth => to_char(payments.paymentDate,'MM'),
                                         plogin => vREC.Login,
                                         pphone_number => NVL(payments.ctn, '0000000000'),
                                         ppayment_date => payments.paymentDate,
                                         ppayment_sum => to_number(replace(rtrim(payments.paymentOriginalAmt,chr(10)||chr(13)||chr(9)),',','.'), '9999999999.99')*paysign,
                                         ppayment_number => payments.bankPaymentID,
                                         ppayment_valid_flag => case
                                                                WHEN paysign=-1 THEN 0
                                                                else 1
                                                                end ,
                                         ppayment_status_text => case 
                                                                 when payments.paymentStatus='Payment' then 'Платеж зачислен'
                                                                 when payments.paymentStatus='Backout' then 'Отмена платежа'
                                                                 when payments.paymentStatus='Funds transfer from' then 'Перенос платежа на другого клиента'
                                                                 when payments.paymentStatus='Funds transfer to' then 'Перенос платежа c другого клиента'
                                                                 when payments.paymentStatus='Refund' then 'Возврат платежа'
                                                                 when payments.paymentStatus='Refund reversal' then 'Отмена возврата платежа'
                                                                 else 'Нет данных'
                                                                 end
                                        );                                
              counter:=counter+1;
            END IF;
            counter_PAYM:=counter_PAYM+1;
          end loop;   
          -- Запоминаем переводы денег    
          MERGE INTO DB_LOADER_PAYMENT_TRANSFERS PT
            USING (select substr(PL.ctn, -10) ctn
                          ,CONVERT_PCKG.TIMESTAMP_TZ_TO_DATE(PL.paymentDate) paymentDate
                          ,PL.paymentStatus paymentStatus
                          ,PL.paymentType paymentType
                          ,PL.paymentOriginalAmt paymentOriginalAmt
                          ,PL.paymentCurrentAmt paymentCurrentAmt
                          ,PL.bankPaymentID bankPaymentID
                          ,CONVERT_PCKG.TIMESTAMP_TZ_TO_DATE(PL.paymentActivateDate) paymentActivateDate
                      from API_GET_PAYMENT_LIST PL
                      WHERE INSTR(PL.paymentStatus, 'Funds transfer') > 0) API
              ON (PT.PHONE_NUMBER = API.ctn 
                    AND NVL(PT.BANK_PAYMENT_ID, 0) = NVL(API.bankPaymentID, 0)
                    AND PT.PAYMENT_STATUS = API.paymentStatus 
                    AND PT.ACCOUNT_ID = pACCOUNT_ID)
            WHEN MATCHED THEN 
              UPDATE SET PT.PAYMENT_DATE=API.paymentDate, PT.PAYMENT_TYPE=API.paymentType, PT.PAYMENT_ORIGINAL_AMT=API.paymentOriginalAmt, 
                         PT.PAYMENT_CURRENT_AMT=API.paymentCurrentAmt, PT.PAYMENT_ACTIVATE_DATE=API.paymentActivateDate               
            WHEN NOT MATCHED THEN   
              INSERT(PT.ACCOUNT_ID, PT.PHONE_NUMBER, PT.PAYMENT_DATE, PT.PAYMENT_STATUS, PT.PAYMENT_TYPE, 
                     PT.PAYMENT_ORIGINAL_AMT, PT.PAYMENT_CURRENT_AMT, PT.BANK_PAYMENT_ID, PT.PAYMENT_ACTIVATE_DATE)   
                VALUES(pACCOUNT_ID, API.ctn, API.paymentDate, API.paymentStatus, API.paymentType, 
                       API.paymentOriginalAmt, API.paymentCurrentAmt, API.bankPaymentID, API.paymentActivateDate);   
          --логируем успешное выполнение
          INSERT INTO ACCOUNT_LOAD_LOGS(ACCOUNT_LOAD_LOG_ID, ACCOUNT_ID, LOAD_DATE_TIME,
                                 IS_SUCCESS, ERROR_TEXT, ACCOUNT_LOAD_TYPE_ID,BEELINE_RN)
            VALUES(NEW_ACCOUNT_LOAD_LOG_ID, pACCOUNT_ID, SYSDATE,
             1, 'Ok! Add '||counter||' rows. All '||counter_PAYM||' rows.', 1, pANSWER.BSAL_ID);commit;
          Respond:='Ok! Add '||counter;
          commit;
        else 
          Respond:= pANSWER.Err_text;
        end if;  
      EXCEPTION
        WHEN OTHERS THEN
          Respond := SQLERRM;
          return (Respond);
      END;
    Else
    Respond:='Не найден л\с';
    end if;
    Return (Respond);
  end;  
--Обновление списка БАН по коллектору
function Collect_account_BANS(Paccount_id in number) return varchar2
  is 
  CURSOR C IS
      SELECT ACCOUNTS.LOGIN, ACCOUNTS.New_Pswd, accounts.account_number,accounts.account_id,accounts.is_collector
        FROM ACCOUNTS
       WHERE ACCOUNTS.account_id = Paccount_id; 
   vREC     C%ROWTYPE;
   err varchar2(1000);--Для логирования сообщений об ошибках+
   count_rec integer:=0;
   pANSWER SOAP_API_ANSWER_TYPE := SOAP_API_ANSWER_TYPE(NULL, NULL,null); 
  begin
    OPEN C;
    FETCH C INTO vREC;
    CLOSE C;
    IF vREC.LOGIN IS NOT NULL and vRec.Is_Collector=1 THEN
      Begin--Загрузка свежего списка подбанов
        --инициализация
        err:='';
        --обновляем список BAN-ов
        pANSWER:=BEELINE_SOAP_API_PCKG.getBANInfoList(BEELINE_SOAP_API_PCKG.auth(vREC.LOGIN, vREC.New_Pswd),vREC.Login,vREC.Account_Id,'');
    /*В этой конструкции изменения почему не коммитятся (оставил до новых версий Оракл,т.к. работает шустро)*/
     /*merge into beeline_loader_inf bi 
             using 
             (select  extractvalue (value(d) ,'BanInfoList/ban') BAN
        from table(XmlSequence
                      (pANSWER.ANSWER.extract(
                              'S:Envelope/S:Body/ns0:getBANInfoListResponse/BanInfoList'
                             ,'xmlns:S="http://schemas.xmlsoap.org/soap/envelope/" xmlns:ns0="urn:uss-wsapi:Subscriber"')
                      )
                  )d
             full outer join (select bli.ban from beeline_loader_inf bli where bli.account_id=Paccount_id) bli_out
             on bli_out.ban=extractvalue (value(d) ,'BanInfoList/ban')
             ) list 
      ON (bi.ban=list.ban and bi.account_id=Paccount_id)
      when matched then
           update set bi.obj_id=000 where list.ban is null
           delete where list.ban is null
      when not matched then
           insert (account_id,ban) values (Paccount_id,list.ban);
           commit;*/

           --проверка на количество записей а ответе
         
        select count(*) into count_rec
          from (select  extractvalue (value(d) ,'BanInfoList/ban') BAN
                  from table(XmlSequence
                              (pANSWER.ANSWER.extract(
                                      'S:Envelope/S:Body/ns0:getBANInfoListResponse/BanInfoList'
                                     ,'xmlns:S="http://schemas.xmlsoap.org/soap/envelope/" xmlns:ns0="urn:uss-wsapi:Subscriber"')))d
                 -- where not exists (select 1 from beeline_loader_inf bl where bl.ban=extractvalue (value(d) ,'BanInfoList/ban') and bl.account_id=Paccount_id)
               )xml_data;
             
        if count_rec>1 then --есть разборчивые записи                       
          -- добавление в вспомогательную таблицу новых подбанов
          Insert into beeline_loader_inf 
          select Paccount_id,null,null,xml_data.ban 
          from (select extractvalue(value(d) ,'BanInfoList/ban') BAN
                  from table(XmlSequence
                              (pANSWER.ANSWER.extract(
                                      'S:Envelope/S:Body/ns0:getBANInfoListResponse/BanInfoList'
                                     ,'xmlns:S="http://schemas.xmlsoap.org/soap/envelope/" xmlns:ns0="urn:uss-wsapi:Subscriber"') ))d
                  where not exists (select 1 
                                      from beeline_loader_inf bl 
                                      where bl.ban=extractvalue (value(d) ,'BanInfoList/ban') 
                                        and bl.account_id=Paccount_id)
               )xml_data;
           -- удаление из вспомогательной таблицы вышедших подбанов              
          delete from beeline_loader_inf bli 
            where bli.ban in (select to_char(bl.ban) 
                                from beeline_loader_inf bl 
                                where bl.account_id=Paccount_id
                              minus
                              select to_char(xml_data.ban) 
                              from (select extractvalue(value(d) ,'BanInfoList/ban') BAN
                                      from table(XmlSequence
                                                    (pANSWER.ANSWER.extract(
                                                            'S:Envelope/S:Body/ns0:getBANInfoListResponse/BanInfoList'
                                                           ,'xmlns:S="http://schemas.xmlsoap.org/soap/envelope/" xmlns:ns0="urn:uss-wsapi:Subscriber"'))) d ) xml_data );
           --фиксируем
           commit;
        else raise VALUE_ERROR; 
        end if;--проверка количества разборчивых записей.
      exception
        when VALUE_ERROR then 
          err:='Список значений инд.Л/С меньше 100.'; 
        when others then 
          err:='Не получилось обновить список подбанов.';
      return err;
      end;-- конец загрузки подбанов   
    end if;

  --логируем, что получилось
    insert into account_load_logs
           ( account_load_log_id,account_id, load_date_time, is_success, error_text, account_load_type_id)
      values(s_new_account_load_log_id.nextval,Paccount_id, sysdate,
              case err when null then 1 else 0 end , nvl(err,'OK! Get '||count_rec||' rows;'),14);
    commit;
    return nvl(err,'OK!');   
  --  
  end;         
--                 
 --обновление статусов по коллекторским Л/С 
function Collect_account_phone_status(
  Paccount_id in number,
  nMOD_NUM in number default 0,--модуль потока
  nMOD in number default 1--потоки
  ) return varchar2 is--phone_state_table 
  CURSOR C IS
      SELECT ACCOUNTS.LOGIN, ACCOUNTS.New_Pswd, accounts.account_number,accounts.account_id,accounts.is_collector
        FROM ACCOUNTS
        WHERE ACCOUNTS.account_id = Paccount_id;    
  type tBAN is table of varchar2(30) INDEX BY binary_integer;
  BANs tBAN;
  vREC     C%ROWTYPE;
  Respond  varchar2(5000); -- ответ
  pANSWER SOAP_API_ANSWER_TYPE := SOAP_API_ANSWER_TYPE(NULL, NULL,null); 
  count_good integer:=0;
  count_bad integer:=0;
  i integer:=0;
  err varchar2(1000);--Для логирования сообщений об ошибках+
  dogovor_date date;
  vYEAR_MONTH INTEGER;
begin
  OPEN C;
  FETCH C INTO vREC;
  CLOSE C;
  IF vREC.LOGIN IS NOT NULL and vRec.Is_Collector=1 THEN
    BEGIN    
       --берём список банов из базы
      For old_ban in (select bl.ban 
                        from beeline_loader_inf bl, 
                             db_loader_account_phones ph 
                        where --связи
                              bl.phone_number=ph.phone_number(+)
                          and ph.year_month(+)=const_year_month--J O I N для нового месяца                         
                          --отбор
                          and bl.account_id=Paccount_id 
                          and mod(bl.ban,nMOD)=nMOD_NUM--выборка потока
                          --Сначала новые , потом те кто давно не обновлялся
                        group by bl.ban
                        order by max(ph.last_check_date_time) asc NULLS FIRST )
      loop
        i:=i+1;
        bans(i):=old_ban.ban;
      end loop;     
      for PBAN in bans.first .. bans.last
      LOOP 
        begin 
          pANSWER:= SOAP_API_ANSWER_TYPE(NULL, NULL,null);--очищаем переменную ответа
          pANSWER:=BEELINE_SOAP_API_PCKG.getCTNInfoList(BEELINE_SOAP_API_PCKG.auth(vREC.LOGIN, vREC.New_Pswd),'',bans(PBAN),'');
        exception
          when others then 
            pANSWER.Err_text:=sqlerrm;  
        end;    
        if pANSWER.Err_text='OK' then 
          ---обновляем статусы             
          DELETE FROM API_GET_CTN_INFO_LIST;
          --
          INSERT INTO API_GET_CTN_INFO_LIST(ctn, statusDate, status, pricePlan, reasonStatus, lastActivity, activationDate, subscriberHLR)
            SELECT extractvalue (value(d) ,'CTNInfoList/ctn') ctn
                   ,extractvalue (value(d) ,'/CTNInfoList/statusDate') statusDate
                   ,extractvalue (value(d) ,'/CTNInfoList/status') status
                   ,extractvalue (value(d) ,'/CTNInfoList/pricePlan') pricePlan
                   ,extractvalue (value(d) ,'/CTNInfoList/reasonStatus') reasonStatus
                   ,extractvalue (value(d) ,'/CTNInfoList/lastActivity') lastActivity
                   ,extractvalue (value(d) ,'/CTNInfoList/activationDate') activationDate
                   ,extractvalue (value(d) ,'/CTNInfoList/subscriberHLR') subscriberHLR
              FROM TABLE(XmlSequence(pANSWER.ANSWER.extract('S:Envelope/S:Body/ns0:getCTNInfoListResponse/CTNInfoList'
                                                            ,'xmlns:S="http://schemas.xmlsoap.org/soap/envelope/" xmlns:ns0="urn:uss-wsapi:Subscriber"'))) D;
          ---обновляем статусы  
          vYEAR_MONTH:=TO_NUMBER(to_char(sysdate,'YYYYMM'));
          MERGE INTO db_loader_account_phones ph
          -- Сравнение
            USING (select substr(d.ctn, -10) acc_ctn
                         ,substr(d.ctn, -10) ctn
                         ,d.status stat
                         ,d.reasonStatus reason
                         ,d.pricePlan plan
                         ,CONVERT_PCKG.TIMESTAMP_TZ_TO_DATE(d.statusDate) statusDate
                         ,bsc.IS_CONSERVATION
                         ,bsc.IS_SYSTEM_BLOCK
                     from API_GET_CTN_INFO_LIST d
                     left outer join BEELINE_STATUS_CODE bsc on bsc.STATUS_CODE = d.reasonStatus   
                  ) api                  
              ON (ph.phone_number = api.acc_ctn 
                    and ph.year_month=vYEAR_MONTH 
                    and ph.account_id=Paccount_id)        
          WHEN MATCHED THEN
          --Когда нашли
            UPDATE SET ph.phone_is_active=CASE  WHEN API.STAT = 'ACTIVE' THEN 1 ELSE 0 END,
                       ph.cell_plan_code=api.plan,
                       ph.last_check_date_time=sysdate,
                       ph.last_change_status_date=api.statusDate,                
                       ph.conservation = CASE WHEN API.STAT = 'ACTIVE' THEN 0 ELSE API.IS_CONSERVATION END,
                       ph.system_block = CASE WHEN API.STAT = 'ACTIVE' THEN 0 ELSE API.IS_SYSTEM_BLOCK END,
                       PH.STATUS_ID = CONVERT_PCKG.STATUS_CODE_TO_STATUS_ID(API.REASON) 
              WHERE ((api.stat in('ACTIVE','BLOCKED'))
                      or (api.stat is null and ph.last_check_date_time<sysdate-1))-- Либо номер не обновлялся более суток и будет изменён только для того чтобы его удалило
            -- ДЕРЕКТИВА DELETE РАБОТАЕТ ТОЛЬКО ДЛЯ ТЕХ ЗАПИСЕЙ, КОТОРЫЕ ПОПАЛИ ПОД UPDATE
            DELETE where api.ctn is null          
          WHEN NOT MATCHED THEN
          -- Когда не нашли
            INSERT (ph.account_id, ph.year_month, ph.phone_number, ph.phone_is_active, ph.cell_plan_code, ph.last_check_date_time,
                    ph.organization_id, ph.conservation, ph.system_block, PH.LAST_CHANGE_STATUS_DATE, PH.STATUS_ID )
              VALUES (Paccount_id, vYEAR_MONTH, api.ctn,
                      CASE WHEN API.STAT = 'ACTIVE' THEN 1 ELSE 0 END, 
                      api.plan, sysdate, 1, 
                      CASE WHEN API.STAT = 'ACTIVE' THEN 0 ELSE API.IS_CONSERVATION END,
                      CASE WHEN API.STAT = 'ACTIVE' THEN 0 ELSE API.IS_SYSTEM_BLOCK END,
                      api.statusDate, convert_pckg.STATUS_CODE_TO_STATUS_ID(api.reason))
            WHERE api.stat in ('ACTIVE','BLOCKED');
          --счётчик счастья   
          count_good:=count_good+sql%rowcount;  
            --если в процессе слияния что-то изменилось-добавлось
          if sql%rowcount>0 then 
            for hist in (select substr(d.ctn,-10) ctn
                              ,d.status stat
                              ,d.reasonStatus reason
                              ,d.pricePlan plan
                          from API_GET_CTN_INFO_LIST d
                          where d.status in ('ACTIVE','BLOCKED'))
            loop
             --обновляем запись в таблице соответствия подБанов.
              update beeline_loader_inf bl 
                set bl.ban=bans(PBAN) 
                where bl.phone_number=hist.ctn;
              if sql%rowcount=0 then 
                insert into beeline_loader_inf bl (bl.account_id,bl.phone_number,bl.ban) 
                  values (Paccount_id,hist.ctn,bans(PBAN));
              end if;
             --добавляем записи в историю
              dogovor_date:=sysdate;
              for add_hist in (select count(*) as exist 
                                 from db_loader_account_phone_hists t 
                                 where t.phone_number=hist.ctn)
              loop
                --если это первая запись в истории по коллекторскому номеру ставим дату договора
                if add_hist.exist=0 then
                  --находим дату договора
                  begin
                    select trunc(ct.contract_date) into dogovor_date 
                      from contracts ct 
                      where ct.phone_number_federal=hist.ctn 
                        and not exists (select 1 from contract_cancels cc where cc.contract_id=ct.contract_id);
                    --если договор с прошлого месяца создаём для него запись в db_loader_account_phones
                    if to_number(to_char(dogovor_date,'YYYYMM'))<const_year_month then 
                      insert into db_loader_account_phones(account_id, year_month, phone_number, 
                                                           phone_is_active, cell_plan_code, new_cell_plan_code, new_cell_plan_date, 
                                                           last_check_date_time, organization_id, conservation, system_block)
                        select qph.account_id, to_number(to_char(dogovor_date,'YYYYMM')), qph.phone_number, 
                               qph.phone_is_active, qph.cell_plan_code, qph.new_cell_plan_code, qph.new_cell_plan_date, 
                               qph.last_check_date_time, qph.organization_id, qph.conservation, qph.system_block
                          from db_loader_account_phones qph 
                          where qph.phone_number=hist.ctn 
                            and qph.year_month=const_year_month
                            and qph.account_id=Paccount_id;
                    end if;
                  exception
                    when others then 
                      dogovor_date:=trunc(sysdate);
                  end;
                end if;
              end loop add_hist;
              temp_add_account_phone_history(hist.ctn,hist.plan,
                  case hist.stat 
                    when 'ACTIVE' then 1
                    when 'BLOCKED' then 0
                  end, dogovor_date);
              CHECK_MNP_ACCOUNT_PHONE_STATUS(hist.ctn);--Проверка статуса активности номеров MNP // 30.06.14
            end loop hist;                    
          end if;        
          --удаляем пустые записи из beeline_loader_inf
          delete from beeline_loader_inf t 
            where t.phone_number is null 
              and t.account_id=Paccount_id 
              and t.ban=bans(PBAN)
              AND EXISTS (SELECT 1
                            FROM BEELINE_LOADER_INF Z 
                            WHERE Z.PHONE_NUMBER IS NOT NULL 
                              AND Z.ACCOUNT_ID=PACCOUNT_ID 
                              AND Z.BAN=BANS(PBAN));  
          commit;--и для статусов и для истории       
        else
          insert into aaa(nnn1,sss1,sss2)values(pANSWER.BSAL_ID,pANSWER.Err_text,bans(PBAN));commit;
          count_bad:=count_bad+1;
        end if;                 
      END LOOP PBAN;
   --логирование в лог загрузок 
      if count_good>0 then --есть хоть один успех - логируем что всё хорошо.
        insert into account_load_logs(account_load_log_id, account_id, load_date_time, is_success, error_text, account_load_type_id)
          values(s_new_account_load_log_id.nextval, Paccount_id, sysdate, 1, 'Ok! Update '||count_good||' rows,err_count='||count_bad||';'||err, 3);
      else 
        insert into account_load_logs(account_load_log_id, account_id, load_date_time, is_success, error_text, account_load_type_id)
          values(s_new_account_load_log_id.nextval, Paccount_id, sysdate, 0, 'err_count='||count_bad||',last err_txt:'||pANSWER.Err_text||';'||err, 3);
      end if;
    EXCEPTION
      WHEN OTHERS THEN
        Respond := SQLERRM||';'||err;
        return Respond;
    END;--api_responce
  Else
    Respond:='Не найден л\с';
  end if;--vrec.login
  Return Respond;
--         
end;--func
--
function Collect_account_phone_opts(
  Paccount_id in number
  ) return varchar2  is--phone_state_table
  type Tbans is table of varchar2(20);  
  CURSOR C IS
    SELECT ACCOUNTS.LOGIN, ACCOUNTS.New_Pswd, accounts.account_number,accounts.account_id,accounts.is_collector
      FROM ACCOUNTS
      WHERE ACCOUNTS.account_id = Paccount_id;    
  CURSOR TECH is 
    select distinct bl.ban 
      from beeline_loader_inf bl 
      where bl.account_id=Paccount_id; 
   Bans Tbans;
   vREC     C%ROWTYPE;
   Respond  varchar2(5000); -- ответ
   pANSWER SOAP_API_ANSWER_TYPE := SOAP_API_ANSWER_TYPE(NULL, NULL,null); 
   count_good integer:=0;
   count_bad integer:=0;
   err varchar2(1000);
begin
  OPEN C;
  FETCH C INTO vREC;
  CLOSE C;
  IF vREC.LOGIN IS NOT NULL and vRec.Is_Collector=1 THEN
    BEGIN      
      OPEN TECH;
      FETCH TECH bulk collect into Bans;
      CLOSE TECH;
      --цикл по подбанам
      for I in Bans.first..bans.last
      LOOP
        Begin
          pANSWER:=BEELINE_SOAP_API_PCKG.getServiceList(BEELINE_SOAP_API_PCKG.auth(vREC.LOGIN, vREC.New_Pswd),'',bans(i),'');            
          if pANSWER.Err_text='OK' then      
         --цикл по ответу
          for s in (select substr(extractvalue (value(d) ,'servicesList/ctn'),-10)ctn
                           ,trim(extractvalue (value(d) ,'/servicesList/serviceId'))   serviceId
                           ,CONVERT_PCKG.TIMESTAMP_TZ_TO_DATE(extractvalue(value(d) ,'/servicesList/startDate')) startDate
                           ,CONVERT_PCKG.TIMESTAMP_TZ_TO_DATE(extractvalue(value(d) ,'/servicesList/endDate')) endDate
                           ,trim(extractvalue (value(d) ,'/servicesList/serviceName')) serviceName
                      from table(XmlSequence(pANSWER.ANSWER.extract(
                             'S:Envelope/S:Body/ns0:getServicesListResponse/servicesList'
                             ,'xmlns:S="http://schemas.xmlsoap.org/soap/envelope/" xmlns:ns0="urn:uss-wsapi:Subscriber"'))) d)
            loop
            --вызываем процедуру опций из старого кабинета
              null;
              db_loader_pckg.ADD_ACCOUNT_PHONE_OPTION2(
                  to_char(sysdate,'YYYY'),
                  to_char(sysdate,'MM'),
                  vrec.login,
                  to_char(s.ctn), /*номер*/
                  s.serviceId,       /* Код опции */
                  s.serviceName,       /* Наименование опции */
                  null, /* Параметры опции */
                  s.startDate,          /* Дата подключения*/
                  s.endDate,         /* Дата отключения */
                  null,        /*Стоимость подключения*/
                  null        /*Стоимость в месяц*/
                  );
            end loop s;                   
            commit;
            count_good:=count_good+1;                    
          else
            insert into aaa(nnn1,sss1,sss2)values(pANSWER.BSAL_ID,pANSWER.Err_text,bans(i));commit;
            count_bad:=count_bad+1;
          end if;       
        EXCEPTION
          WHEN OTHERS THEN 
            err:=sqlerrm;
            insert into aaa(sss2)values(err||' '||bans(i)||' '||to_char(i));commit;
            count_bad:=count_bad+1;
        END;        
      END LOOP I; 
      
      for u in (select * from db_loader_account_phones p where p.year_month=const_year_month and p.account_id=Paccount_id)
      loop
        --удаляем услуги которых нет более суток
        DB_LOADER_PHONE_OPRT_CLOSE2(substr(to_char(const_year_month),1,4), substr(to_char(const_year_month),5,2),u.phone_number); 
      end loop u;
          
     --логирование в лог загрузок 
      if count_good>0 then --есть хоть один успех - логируем что всё хорошо.
        insert into account_load_logs(account_load_log_id,account_id, load_date_time, is_success, error_text, account_load_type_id)
          values(s_new_account_load_log_id.nextval,Paccount_id, sysdate, 1, 'Ok! Update options on'||count_good||' ban''s,err_count='||count_bad, 4);
      else 
        insert into account_load_logs(account_load_log_id,account_id, load_date_time, is_success, error_text, account_load_type_id)
          values(s_new_account_load_log_id.nextval,Paccount_id, sysdate, 0, 'err_count='||count_bad||',last err_txt:'||pANSWER.Err_text, 4);
      end if;  
    EXCEPTION
      WHEN OTHERS THEN
        Respond := SQLERRM;
        return Respond;
    END;--api_responce
  Else
    Respond:='Не найден л\с';
  end if;--vrec.login
  Return Respond;
--         
end;--func 
--  
Function get_ticket_status (
  pAccount_id in number,
  pRequestID in VARCHAR2
  ) return varchar2 is
    CURSOR C IS
      SELECT ACCOUNTS.LOGIN, ACCOUNTS.New_Pswd,accounts.account_id
        FROM  ACCOUNTS
       WHERE ACCOUNTS.ACCOUNT_ID=pAccount_id;    

  vREC     C%ROWTYPE;
  Respond  varchar2(5000); -- ответ
  Resp_code varchar2(200);-- ответ код
  pANSWER SOAP_API_ANSWER_TYPE := SOAP_API_ANSWER_TYPE(NULL, NULL,null);      
    
procedure update_ticket (pRespond in varchar2,pResp_code in varchar2) as 
  PRAGMA AUTONOMOUS_TRANSACTION;
begin
  update beeline_tickets k 
    set k.answer=decode(Respond,'COMPLETE',1
                             ,'REJECTED',0
                             ,'CANCELED',0
                             ,'EXPIRED_REQ',0
                             ,'NULL',0
                             ,'NEED_MORE_INFORMATION',0
                             ,null                                                          
                       ),k.comments=k.comments||' '||pResp_code||' '||Resp_code,k.date_update=sysdate 
  where k.ticket_id=pRequestID and pRespond is not null;         
  commit;
end; 
 
  begin
    OPEN C;
    FETCH C INTO vREC;
    CLOSE C;
    IF vREC.LOGIN IS NOT NULL THEN
      BEGIN
        pANSWER:=BEELINE_SOAP_API_PCKG.getRequestList(BEELINE_SOAP_API_PCKG.auth(vREC.LOGIN, vREC.New_Pswd),pRequestID,vREC.LOGIN,pAccount_id);
        select extractValue(pANSWER.ANSWER, 'S:Envelope/S:Body/ns0:getRequestListResponse/requestList/requests/requestStatus',
                                            'xmlns:S="http://schemas.xmlsoap.org/soap/envelope/ xmlns:ns1="urn:uss-wsapi:Types" xmlns:ns0="urn:uss-wsapi:Subscriber"')
              ,extractValue(pANSWER.ANSWER, 'S:Envelope/S:Body/ns0:getRequestListResponse/requestList/requests/requestComments',
                                            'xmlns:S="http://schemas.xmlsoap.org/soap/envelope/ xmlns:ns1="urn:uss-wsapi:Types" xmlns:ns0="urn:uss-wsapi:Subscriber"')      
          into Respond,Resp_code from dual; 
--insert into beeline_soap_api_log(soap_answer) values (pANSWER.ANSWER); commit;--Включать только для отладки!        
        update_ticket(Respond,Resp_code);
        /*FULFILL_REQ Требуется выполнить запрос
        OPEN Открыт
        IN_PROGRESS В процессе выполнения
        COMPLETE Выполнен
        AUTO_COMPLETE Выполнен автоматически
        PARTIALLY_COMPLETE Частично выполнен
        WAITING_FOR_APPROVAL Ожидает подтверждения
        NEED_MORE_INFORMATION Требуется больше информации
        REJECTED Отклонен
        NULL Пустой запрос
        CANCELED Аннулирован
        PENDING В ожидании
        PENDING_OPEN В ожидании открытия
        PENDING_CLOSE В ожидании закрытия
        EXPIRED_REQ Время запроса истекло
        PERIODIC_IN_PROGRESS Выполняется периодически*/        
      EXCEPTION
        WHEN OTHERS THEN
          Respond := SQLERRM;
          return (Respond);
      END;
    Else
    Respond:='Не найден л\с';
    end if;
    Return (Respond||';'||Resp_code);
  end;  
  --
/*  --проверяет состояние заявок и решает что с ними делать. (либо забить либо поднять шуму)
procedure check_tickets is
 CURSOR TICKETS IS
      select * from BEELINE_TICKETS t where t.answer=0 and t.date_create>sysdate-1;--все заявки младше суток   
   recT TICKETS%ROWTYPE;
   

begin  
  --сначала закроем все заявки старше суток, т.к. разбирать их - поезд ушёл.
  update BEELINE_TICKETS t set t.answer=1,t.comments=t.comments||' Закрыта по старости.' where t.answer=0 and t.date_update<sysdate-1;
  commit;
  --теперь перебираем оставшиеся по следующим правилам
  -- 9-блоки : Проверяем статус в тарифере -> в АПИ -> если ACTIVE - то шлём СМ
  -- 10-разблоки : Проверяем статус в тарифере -> в АПИ -> если BLOCKED и не фрод - то шлём СМ
  -- 12-Смена СИМ : Сверяем номер СИМ в АПИ и журнале смены СИМ, если != шлём СМ
  for c in TICKETS loop
    fetch c into recT;
    
  end loop c;
  

end;*/

FUNCTION Create_account_bill(
  PaccountId IN VARCHAR2,
  Pyear_month IN INTEGER 
  ) RETURN VARCHAR2 IS
    --
    CURSOR C IS
      SELECT ACCOUNTS.LOGIN, ACCOUNTS.New_Pswd,ACCOUNTS.Account_Id,ACCOUNTS.Account_Number
        FROM ACCOUNTS
        WHERE ACCOUNTS.ACCOUNT_ID = PaccountId;
    vREC     C%ROWTYPE;
    Bill_Date date;
    V_RESULT VARCHAR2(20000);
    Respond  varchar2(5000); -- ответ
    pANSWER SOAP_API_ANSWER_TYPE := SOAP_API_ANSWER_TYPE(NULL, NULL,null);
  BEGIN
    OPEN C;
    FETCH C INTO vREC;
    CLOSE C;
    IF vREC.LOGIN IS NOT NULL THEN
      BEGIN
        begin
          select pr.end_date into Bill_Date from db_loader_bills_period pr where pr.account_id=PaccountId and pr.year_month=Pyear_month;
        exception
          when no_data_found then Return('Период не доступен для заказа');
        end;
        Respond:=BEELINE_SOAP_API_PCKG.auth(vREC.LOGIN, vREC.New_Pswd);--получаем токен
        pANSWER:=BEELINE_SOAP_API_PCKG.createBillChargesRequest(Respond,vrec.account_number,vrec.account_id,Bill_Date);--запрос к АПИ
        --разбор ответа
        /* 
        <?xml version="1.0" encoding="UTF-8"?>
        <S:Envelope xmlns:S="http://schemas.xmlsoap.org/soap/envelope/">
            <S:Header>
                <work:WorkContext xmlns:work="http://oracle.com/weblogic/soap/workarea/"></work:WorkContext>
            </S:Header>
            <S:Body>
                <ns0:createBillChargesRequestResponse xmlns:ns1="urn:uss-wsapi:Types" xmlns:ns0="urn:uss-wsapi:Subscriber">
                    <requestId>2185195147</requestId>
                </ns0:createBillChargesRequestResponse>
            </S:Body>
        </S:Envelope>*/                
        select extractValue(pANSWER.ANSWER,'S:Envelope/S:Body/ns0:createBillChargesRequestResponse/requestId'
                                          ,'xmlns:S="http://schemas.xmlsoap.org/soap/envelope/" xmlns:ns1="urn:uss-wsapi:Types" xmlns:ns0="urn:uss-wsapi:Subscriber"')
          into V_RESULT from dual;            
        if V_RESULT is null --Если нет нормального номера заявки
           then --берём номер ошибки
          if pANSWER.Err_text!='OK' then 
            V_RESULT:=pANSWER.Err_text;
          else
            select nvl(pANSWER.Err_text, 
                       extractValue(pANSWER.ANSWER,'S:Envelope/S:Body/ns0:Fault/detail/ns1:UssWsApiException/errorDescription'
                                                  ,'xmlns:S="http://schemas.xmlsoap.org/soap/envelope/" xmlns:ns0="http://schemas.xmlsoap.org/soap/envelope/ xmlns:ns1="urn:uss-wsapi:Types" xmlns:ns0="urn:uss-wsapi:Subscriber"'))
              into V_RESULT from dual; 
          end if;     
          --Нет номера ошибки возвращаем неопределённую ошибку
          if V_RESULT is null then  
            raise_application_error(-20000, 'Неопределённая ошибка Би.');
          --Есть номер ошибки возвращаем его   
          else 
            return('Error_Api:'||V_RESULT); 
          end if;
        --Если всё в порядке и есть номер
        else
         --Добавление номера заявки на проверку
          insert into beeline_tickets(ticket_id, account_id, ban, ticket_type, answer, comments, phone_number,user_created,date_create)
            values(V_RESULT,vrec.account_id, vrec.account_number, 5, null, Pyear_month,null,user,sysdate);
          commit;
          --Возвращаем номер заявки на проверку
          return ('Заказан отчёт '||V_RESULT);          
        end if;
      --В случае исключения возвращаем ошибку  
      EXCEPTION
        WHEN OTHERS THEN
          Respond := SQLERRM;
          return Respond;
      END;
    ELSE
      RETURN PaccountId || ' не найден в базе данных.';
    END IF;
  END;
 --Загрузка начислений по счёту.
 Function Get_account_bill(
  pAccount_id in number,
  pRequestID in number
  ) return varchar2 is
  --
    CURSOR C IS
      SELECT ACCOUNTS.LOGIN, ACCOUNTS.New_Pswd,accounts.account_id
        FROM  ACCOUNTS
        WHERE ACCOUNTS.ACCOUNT_ID=pAccount_id;    
    bill_exception exception;
    vREC     C%ROWTYPE;
    pANSWER SOAP_API_ANSWER_TYPE := SOAP_API_ANSWER_TYPE(NULL, NULL,null);   
  begin
    OPEN C;
    FETCH C INTO vREC;
    CLOSE C;
    IF vREC.LOGIN IS NOT NULL THEN
      BEGIN
        pANSWER:=BEELINE_SOAP_API_PCKG.getBillCharges(BEELINE_SOAP_API_PCKG.auth(vREC.LOGIN, vREC.New_Pswd),pRequestID,pAccount_id);
          if instr(pANSWER.Err_text,'OK')=0 then raise bill_exception;end if; 
              
      EXCEPTION
        WHEN OTHERS THEN
          return (SQLERRM);
      END;
    Else
    Return('Не найден л\с');
    end if;
    Return (pANSWER.BSAL_ID);
  end;
 
--Текущие начисления по номеру
 Function phone_report_data  (pPHONE_NUMBER in number) return varchar2 is
     --
    CURSOR C IS
      SELECT ACCOUNTS.LOGIN, ACCOUNTS.New_Pswd,
             case ACCOUNTS.Is_Collector
               when 1 then nvl(bi.ban,0)
               else accounts.account_number
             end account_number, 
             accounts.account_id
        FROM DB_LOADER_ACCOUNT_PHONES, ACCOUNTS, beeline_loader_inf bi
        WHERE DB_LOADER_ACCOUNT_PHONES.PHONE_NUMBER = pPHONE_NUMBER
          and bi.phone_number(+)=DB_LOADER_ACCOUNT_PHONES.Phone_Number
          AND ACCOUNTS.ACCOUNT_ID = DB_LOADER_ACCOUNT_PHONES.ACCOUNT_ID
          AND DB_LOADER_ACCOUNT_PHONES.YEAR_MONTH = (select max(YEAR_MONTH) 
                                                       from  DB_LOADER_ACCOUNT_PHONES 
                                                       where PHONE_NUMBER = pPHONE_NUMBER);    
    vREC     C%ROWTYPE;
    Respond  varchar2(5000); -- ответ
    pANSWER SOAP_API_ANSWER_TYPE := SOAP_API_ANSWER_TYPE(NULL, NULL,null);     
 
/*   procedure update_RD (ph in varchar2,ym in number) as 
      PRAGMA AUTONOMOUS_TRANSACTION;
    begin
                update db_loader_report_data q set q.detail_sum=to_number(replace(rtrim(Respond,chr(10)||chr(13)||chr(9)),',','.'), '9999999999.99')
               ,q.date_last_update=sysdate 
               where q.phone_number=ph and q.year_month=ym
               and to_number(replace(rtrim(Respond,chr(10)||chr(13)||chr(9)),',','.'), '9999999999.99')>=0;
               if sql%rowcount=0 then
                 insert into db_loader_report_data
                   (year_month, phone_number, detail_sum, date_last_update)
                 values
                   (ym, ph, to_number(replace(rtrim(Respond,chr(10)||chr(13)||chr(9)),',','.'), '9999999999.99'), sysdate);
               end if;                  
               commit;
    end; */
  procedure upd_RD (ph in varchar2,val in number) as 
      PRAGMA AUTONOMOUS_TRANSACTION; 
  begin
    db_loader_pckg.SET_REPORT_DATA(ph, val, to_char(sysdate,'DD.MM.YYYY-HH24:MI:SS')); 
  end;       

  begin
    OPEN C;
    FETCH C INTO vREC;
    CLOSE C;
    IF vREC.LOGIN IS NOT NULL THEN
      BEGIN
        pANSWER:=BEELINE_SOAP_API_PCKG.getUnbilledBalances(BEELINE_SOAP_API_PCKG.auth(vREC.LOGIN, vREC.New_Pswd), pPHONE_NUMBER,vREC.account_number, '');
        select extractValue(pANSWER.ANSWER,'S:Envelope/S:Body/ns0:getUnbilledBalancesResponse/unbilledBalances/uc','xmlns:S="http://schemas.xmlsoap.org/soap/envelope/" xmlns:ns1="urn:uss-wsapi:Types" xmlns:ns0="urn:uss-wsapi:Subscriber"')     
          into Respond from dual; 
/*        update_RD(pPHONE_NUMBER,to_char(sysdate,'YYYYMM'));*/
        upd_RD(pPHONE_NUMBER,to_number(replace(rtrim(Respond,chr(10)||chr(13)||chr(9)),',','.'), '9999999999.99'));
      EXCEPTION
        WHEN OTHERS THEN
          Respond := pANSWER.Err_text||CHR(13)||SQLERRM;
          return (Respond);
      END;
    Else
      Respond:='Не найден л\с';
    end if;
    Return (Respond);
  end; 
 
--Загрузка текущих начислений по Л/С 
function account_report_data(
  Paccount_id in number,
  n_mod in number
  ) return varchar2  is--phone_state_table 
    CURSOR C IS
      SELECT ACCOUNTS.LOGIN, ACCOUNTS.New_Pswd, accounts.account_number,accounts.account_id,accounts.is_collector
        FROM ACCOUNTS
        WHERE ACCOUNTS.account_id = Paccount_id;    
    vREC     C%ROWTYPE;
    Respond  varchar2(5000); -- ответ
    pANSWER SOAP_API_ANSWER_TYPE := SOAP_API_ANSWER_TYPE(NULL, NULL,null); 
    count_good integer:=0;
    count_bad integer:=0;
    token varchar2(100);
begin
  OPEN C;
  FETCH C INTO vREC;
  CLOSE C;
  IF vREC.LOGIN IS NOT NULL and vRec.Is_Collector=1  THEN
    BEGIN
      token:=BEELINE_SOAP_API_PCKG.auth(vREC.LOGIN, vREC.New_Pswd);  
      for i in (select ph.phone_number
                 from db_loader_account_phones ph 
                 where ph.year_month=const_year_month and ph.account_id=Paccount_id
                 and mod(ph.phone_number,5)=n_mod/*подразумеваем 5 потоков*/
                 order by get_last_RD_update(ph.phone_number)) 
      loop
        pANSWER:=BEELINE_SOAP_API_PCKG.getUnbilledBalances(token,i.phone_number,Paccount_id);     
        if pANSWER.Err_text='OK' then 
          select extractValue(pANSWER.ANSWER,
                  'S:Envelope/S:Body/ns0:getUnbilledBalancesResponse/unbilledBalances/uc',
                  'xmlns:S="http://schemas.xmlsoap.org/soap/envelope/" xmlns:ns1="urn:uss-wsapi:Types" xmlns:ns0="urn:uss-wsapi:Subscriber"')     
            into Respond from dual; 
          db_loader_pckg.SET_REPORT_DATA(
              i.phone_number
             ,to_number(replace(rtrim(Respond,chr(10)||chr(13)||chr(9)),',','.'), '9999999999.99')
             ,to_char(sysdate,'DD.MM.YYYY-HH24:MI:SS')); 
          count_good:=count_good+1;                     
        else
          count_bad:=count_bad+1;
        end if;
      end loop i;       
      --логирование в лог загрузок 
      if count_good>0 then --есть хоть один успех - логируем что всё хорошо.
        insert into account_load_logs(account_load_log_id,account_id, load_date_time, is_success, error_text, account_load_type_id)
          values(s_new_account_load_log_id.nextval,Paccount_id, sysdate, 1, 'Ok! Update RD count '||count_good, 6);
      else 
        insert into account_load_logs(account_load_log_id,account_id, load_date_time, is_success, error_text, account_load_type_id)
          values(s_new_account_load_log_id.nextval,Paccount_id, sysdate, 0, 'Update: err_count='||count_bad||',last err_txt:'||pANSWER.Err_text, 6);
      end if;
      commit;  
    EXCEPTION
      WHEN OTHERS THEN
        Respond := SQLERRM;
        return Respond;
    END;--api_responce
  Else
    Respond:='Не коллекторский счет.'; -- условно, т.к.на текущий момент по не коллекторским может подвесить систему
  end if;--vrec.login
  Return Respond;         
end;--func 

-- Подключает или отключает тарифную опцию для номера.
FUNCTION TURN_TARIFF_OPTION(
  pPHONE_NUMBER IN VARCHAR2,
  pOPTION_CODE IN VARCHAR2,
  pTURN_ON IN INTEGER, -- 0: выключить, 1: включить
  pEFF_DATE IN DATE,   -- Дата подключения услуги (NULL - прямо сейчас)
  pEXP_DATE IN DATE,   -- Дата автоматического отключения (NULL - не отключать)
  pREQUEST_INITIATOR IN VARCHAR2 -- Инициатор запроса (до 10 знаков)
  ) RETURN VARCHAR2 IS
    --
  CURSOR C IS
    SELECT ACCOUNTS.LOGIN, ACCOUNTS.New_Pswd,ACCOUNTS.Account_Id,ACCOUNTS.Account_Number
      FROM DB_LOADER_ACCOUNT_PHONES, ACCOUNTS
      WHERE DB_LOADER_ACCOUNT_PHONES.PHONE_NUMBER = pPHONE_NUMBER
        AND ACCOUNTS.ACCOUNT_ID = DB_LOADER_ACCOUNT_PHONES.ACCOUNT_ID
        AND DB_LOADER_ACCOUNT_PHONES.YEAR_MONTH = (select max(YEAR_MONTH) 
                                                     from DB_LOADER_ACCOUNT_PHONES 
                                                     where PHONE_NUMBER = pPHONE_NUMBER);
    --
    vREC     C%ROWTYPE;
    FIO      VARCHAR2(2000);
    V_RESULT VARCHAR2(20000);
    vTOKEN varchar2(5000); -- ответ
    vINCLUSION_TYPE VARCHAR2(1);
    pANSWER SOAP_API_ANSWER_TYPE := SOAP_API_ANSWER_TYPE(NULL, NULL,null);
  BEGIN
    OPEN C;
    FETCH C INTO vREC;
    CLOSE C;
    IF vREC.LOGIN IS NOT NULL THEN
      BEGIN
        vINCLUSION_TYPE := CASE WHEN pTURN_ON=1 THEN 'A' ELSE 'D' END;
        vTOKEN := BEELINE_SOAP_API_PCKG.auth(vREC.LOGIN, vREC.New_Pswd);--получаем токен
        pANSWER:=BEELINE_SOAP_API_PCKG.addDelSOC(vTOKEN, pPHONE_NUMBER, pOPTION_CODE, vINCLUSION_TYPE, pEFF_DATE, pEXP_DATE, vREC.ACCOUNT_ID);--запрос к АПИ
        --разбор ответа
        select extractValue(pANSWER.ANSWER,
                  'S:Envelope/S:Body/ns0:addDelSOCResponse/return'
                  ,'xmlns:S="http://schemas.xmlsoap.org/soap/envelope/" xmlns:ns1="urn:uss-wsapi:Types" xmlns:ns0="urn:uss-wsapi:Subscriber"')
          into V_RESULT from dual;
        IF V_RESULT IS NULL THEN--Если нет нормального номера заявки берём номер ошибки
          IF pANSWER.Err_text!='OK' THEN 
            V_RESULT:=pANSWER.Err_text;
          ELSE
            SELECT nvl(pANSWER.Err_text, extractValue(pANSWER.ANSWER,
                                          'S:Envelope/S:Body/ns0:Fault/detail/ns1:UssWsApiException/errorDescription'
                                          ,'xmlns:S="http://schemas.xmlsoap.org/soap/envelope/" xmlns:ns0="http://schemas.xmlsoap.org/soap/envelope/ xmlns:ns1="urn:uss-wsapi:Types" xmlns:ns0="urn:uss-wsapi:Subscriber"'))
              into V_RESULT from dual; 
          END IF;     
          --Нет номера ошибки возвращаем неопределённую ошибку
          IF V_RESULT IS NULL THEN  
            raise_application_error(-20000, 'Неопределённая ошибка Билайн.');
          ELSE --Есть номер ошибки возвращаем его
            RETURN('Error_Api:'||V_RESULT); 
          END IF;
        ELSE --Если всё в порядке и есть номер
          --Добавление в лог 
          LOG_TARIFF_OPTIONS_REQ(pPHONE_NUMBER, pOPTION_CODE, vINCLUSION_TYPE, pEFF_DATE, pEXP_DATE, V_RESULT, pREQUEST_INITIATOR);
          --Добавление номера заявки на проверку
          INSERT INTO BEELINE_TICKETS(TICKET_ID, ACCOUNT_ID, BAN, TICKET_TYPE, ANSWER, COMMENTS, PHONE_NUMBER,USER_CREATED,DATE_CREATE)
            VALUES(V_RESULT,vrec.account_id, vrec.account_number, 15, null, null,pPHONE_NUMBER,user,sysdate);
          COMMIT;
          --Возвращаем номер заявки на подключение
          return ('Заявка № '||V_RESULT); 
        END IF;
      --В случае исключения возвращаем ошибку  
      EXCEPTION
        WHEN OTHERS THEN
          RETURN SQLERRM;
      END;
    ELSE
      RETURN pPHONE_NUMBER || ' не найден в базе данных.';
    END IF;
  END;
        
-- Загрузка детализаций по АПИ
PROCEDURE LOAD_DETAIL_FROM_API(
  pPHONE_NUMBER IN VARCHAR2
  ) IS
    --
    CURSOR C IS
      SELECT ACCOUNTS.LOGIN, 
             ACCOUNTS.New_Pswd, 
             accounts.account_number
        FROM DB_LOADER_ACCOUNT_PHONES, 
             ACCOUNTS
        WHERE DB_LOADER_ACCOUNT_PHONES.PHONE_NUMBER = pPHONE_NUMBER
          AND ACCOUNTS.ACCOUNT_ID = DB_LOADER_ACCOUNT_PHONES.ACCOUNT_ID
          AND DB_LOADER_ACCOUNT_PHONES.YEAR_MONTH = (select max(YEAR_MONTH) 
                                                       from DB_LOADER_ACCOUNT_PHONES 
                                                       where PHONE_NUMBER = pPHONE_NUMBER); 
    --
    smonth date;
    vREC C%ROWTYPE;
    DBF_ID INTEGER;
    pANSWER SOAP_API_ANSWER_TYPE := SOAP_API_ANSWER_TYPE(NULL, NULL,null);  
    PRAGMA AUTONOMOUS_TRANSACTION;
    --
  PROCEDURE AUTO_UPDATE_SERVICES_API AS
  PRAGMA AUTONOMOUS_TRANSACTION; 
  begin    
    MERGE INTO SERVICES_API SA
      USING (SELECT DISTINCT UC.SERVICENAME AT_FT_DE, UC.CALLTYPE AT_FT_DESC
               FROM API_GET_UNBILLED_CALLS_LIST UC) API
        ON (SA.AT_FT_DE = API.AT_FT_DE AND SA.AT_FT_DESC = API.AT_FT_DESC)
      WHEN MATCHED THEN
        UPDATE SET SA.DATE_UPDATE = SYSDATE
      WHEN NOT MATCHED THEN 
        INSERT(SA.AT_FT_DE, SA.AT_FT_DESC, SA.DATE_INSERT, SA.DATE_UPDATE)
          VALUES(API.AT_FT_DE, API.AT_FT_DESC, SYSDATE, SYSDATE);
    --
    COMMIT;
  end;
  --
  BEGIN
    OPEN C;
    FETCH C INTO vREC;
    CLOSE C;
    
    DBF_ID := TO_NUMBER(MS_CONSTANTS.GET_CONSTANT_VALUE ('API_DBF_ID'));
    
    IF vREC.LOGIN IS NOT NULL THEN
      BEGIN
        pANSWER:=BEELINE_SOAP_API_PCKG.getUnbilledCallsList(BEELINE_SOAP_API_PCKG.auth(vREC.LOGIN, vREC.New_Pswd), pPHONE_NUMBER,vREC.account_number, '');
        --
        EXECUTE IMMEDIATE 'TRUNCATE TABLE API_GET_UNBILLED_CALLS_LIST';  
        --
        INSERT INTO API_GET_UNBILLED_CALLS_LIST(callDate, callNumber, callToNumber, serviceName, callType, dataVolume, callAmt, callDuration)
          SELECT  extractvalue (value(d) ,'/UnbilledCallsList/callDate') callDate
                 ,extractvalue (value(d) ,'/UnbilledCallsList/callNumber') callNumber
                 ,extractvalue (value(d) ,'/UnbilledCallsList/callToNumber') callToNumber
                 ,extractvalue (value(d) ,'/UnbilledCallsList/serviceName') serviceName
                 ,extractvalue (value(d) ,'/UnbilledCallsList/callType') callType
                 ,extractvalue (value(d) ,'/UnbilledCallsList/dataVolume') dataVolume
                 ,extractvalue (value(d) ,'/UnbilledCallsList/callAmt') callAmt
                 ,extractvalue (value(d) ,'/UnbilledCallsList/callDuration') callDuration
            FROM TABLE(XmlSequence(pANSWER.ANSWER.extract('S:Envelope/S:Body/ns0:getUnbilledCallsListResponse/UnbilledCallsList',
                                                          'xmlns:S="http://schemas.xmlsoap.org/soap/envelope/" xmlns:ns0="urn:uss-wsapi:Subscriber"'))) D;  
        --
        SELECT TRUNC(SYSDATE, 'MM')
          INTO smonth 
          FROM DUAL;
        --
        
        execute immediate 
          'merge into CALL_' || to_char(smonth, 'mm_yyyy') || ' ct
             using (select distinct tabs.SUBSCR_NO, tabs.START_TIME, tabs.AT_FT_CODE, tabs.DBF_ID, tabs.call_cost, 
                                    tabs.costnovat, tabs.dur, tabs.IMEI, tabs.ServiceType, tabs.ServiceDirection, 
                                    tabs.IsRoaming, tabs.RoamingZone, tabs.CALL_DATE, tabs.CALL_TIME, tabs.DURATION, 
                                    tabs.DIALED_DIG, tabs.AT_FT_DE, tabs.AT_FT_DESC, tabs.CALLING_NO, tabs.AT_CHG_AMT, 
                                    tabs.DATA_VOL, tabs.CELL_ID, tabs.MN_UNLIM, tabs.cost_chng  
                               from table (HOT_BILLING_GET_CALL_TAB(CURSOR(SELECT *
                                                                             FROM (SELECT :pPHONE1 SUBSCR_NO,
                                                                                          TO_CHAR(CONVERT_PCKG.TIMESTAMP_TZ_TO_DATE(UC.callDate), ''yyyymmddhh24miss'') CH_SEIZ_DT,
                                                                                          UC.serviceName AT_FT_CODE,
                                                                                          DECODE(REPLACE(UC.callAmt, ''.'', '',''), ''0,0'', ''0'', REPLACE(UC.callAmt, ''.'', '','')) AT_CHG_AMT,
                                                                                          UC.callNumber CALLING_NO,
                                                                                          REGEXP_REPLACE(UC.callDuration, '':'', '''') DURATION,
                                                                                          DECODE(REPLACE(UC.dataVolume, ''.'', '',''), ''0,0'', ''0'', REPLACE(UC.dataVolume, ''.'', '','')) DATA_VOL,
                                                                                          '''' IMEI,
                                                                                          '''' CELL_ID,
                                                                                          DECODE(UC.callToNumber, :pPHONE2, '''', UC.callToNumber) DIALED_DIG,
                                                                                          UC.callType AT_FT_DESC,
                                                                                          :pDBF_ID DBF_ID
                                                                                     FROM (SELECT DISTINCT CALLDATE, CALLNUMBER, CALLTONUMBER, 
                                                                                                         SERVICENAME, CALLTYPE, DATAVOLUME, CALLAMT, CALLDURATION
                                                                                                    FROM API_GET_UNBILLED_CALLS_LIST) UC) TT
                                                                             where TT.ch_seiz_dt is not null 
                                                                               and trunc(to_date(TT.ch_seiz_dt, ''yyyymmddhh24miss''), ''mm'')
                                                                                    =to_date(:smonth,''dd.mm.yyyy'')), 1)) tabs) t
               on (ct.subscr_no = t.subscr_no 
                    and ct.start_time = t.start_time 
                    and to_number(ct.AT_CHG_AMT,''99999999999D99'','' NLS_NUMERIC_CHARACTERS = '''',.'''''')
                        =to_number(t.AT_CHG_AMT,''99999999999D99'','' NLS_NUMERIC_CHARACTERS = '''',.'''''') 
                    and to_number(ct.DATA_VOL,''99999999999D99'','' NLS_NUMERIC_CHARACTERS = '''',.'''''')
                        =to_number(t.DATA_VOL,''99999999999D99'','' NLS_NUMERIC_CHARACTERS = '''',.'''''')
                    and ct.dur=t.dur)
               when not matched then
                 insert(ct.SUBSCR_NO, ct.START_TIME, ct.AT_FT_CODE, ct.DBF_ID, ct.call_cost, 
                        ct.costnovat, ct.dur, ct.IMEI, ct.ServiceType, ct.ServiceDirection, 
                        ct.IsRoaming, ct.RoamingZone, ct.CALL_DATE, ct.CALL_TIME, ct.DURATION, 
                        ct.DIALED_DIG, ct.AT_FT_DE, ct.AT_FT_DESC, ct.CALLING_NO, ct.AT_CHG_AMT, 
                        ct.DATA_VOL, ct.CELL_ID, ct.MN_UNLIM, ct.INSERT_DATE, ct.cost_chng) 
                   values(t.SUBSCR_NO, t.START_TIME, t.AT_FT_CODE, t.DBF_ID, t.call_cost, 
                          t.costnovat, t.dur, t.IMEI, t.ServiceType, t.ServiceDirection, 
                          t.IsRoaming, t.RoamingZone, t.CALL_DATE, t.CALL_TIME, t.DURATION, 
                          t.DIALED_DIG, t.AT_FT_DE, t.AT_FT_DESC, t.CALLING_NO, t.AT_CHG_AMT, 
                          t.DATA_VOL,t.CELL_ID,t.MN_UNLIM,sysdate,t.cost_chng)'
           USING pPHONE_NUMBER, pPHONE_NUMBER, DBF_ID, to_char(smonth, 'dd.mm.yyyy');
        --           
        DELETE_DOUBLE_DETAIL(pPHONE_NUMBER);
        commit;
        HOT_BILLING_PCKG.i_usm_PHONE(pPHONE_NUMBER, smonth);
        --
        AUTO_UPDATE_SERVICES_API;
        --
      END;
    end if;
  END; 
  
--обновление номера сим карты по конкретному телефону
function phone_SIM(  
    pPHONE_NUMBER number
    ) return varchar2 is
     --
    CURSOR C IS
      SELECT ACCOUNTS.LOGIN, ACCOUNTS.New_Pswd,
             (case ACCOUNTS.Is_Collector
                when 1 then nvl(bi.ban,0)
                else accounts.account_number
             end) account_number, 
             accounts.account_id,
             accounts.account_number account_number_main,
             ACCOUNTS.COMPANY_NAME
      FROM DB_LOADER_ACCOUNT_PHONES, 
               ACCOUNTS, 
               beeline_loader_inf bi
      WHERE DB_LOADER_ACCOUNT_PHONES.PHONE_NUMBER = pPHONE_NUMBER
          and bi.phone_number(+)=DB_LOADER_ACCOUNT_PHONES.Phone_Number
          AND ACCOUNTS.ACCOUNT_ID = DB_LOADER_ACCOUNT_PHONES.ACCOUNT_ID
          AND DB_LOADER_ACCOUNT_PHONES.YEAR_MONTH = (select max(YEAR_MONTH) 
                                                                                          from DB_LOADER_ACCOUNT_PHONES 
                                                                                          where PHONE_NUMBER = pPHONE_NUMBER);                                                           
    vREC C%ROWTYPE;
    Respond  varchar2(5000); -- ответ
    ResSerialNumber varchar2(18);
    ResImsi varchar2(15);
    vCountSim INTEGER;
    oldSim varchar2(18);
    pANSWER SOAP_API_ANSWER_TYPE := SOAP_API_ANSWER_TYPE(NULL, NULL,null);    
  begin
    --
    select count(*)
    into vCountSim
    from phones_dop pd
    where pd.phone_number = pPHONE_NUMBER; 
    oldSim := ''; 
    if vCountSim = 1 then
      --определяем старый номер сим карты
      select pd.SIM
      into oldSim
      from phones_dop pd
      where pd.phone_number = pPHONE_NUMBER;  
    end if;
    --
    OPEN C;
    FETCH C INTO vREC;
    CLOSE C;
          
    IF vREC.LOGIN IS NOT NULL THEN
      BEGIN
        --запрос
        pANSWER:=BEELINE_SOAP_API_PCKG.getSIMList(BEELINE_SOAP_API_PCKG.auth(vREC.LOGIN, vREC.New_Pswd),'',vREC.account_number, pPHONE_NUMBER);   
        --
        if pANSWER.Err_text='OK' then                
          select extractValue(pANSWER.ANSWER,'S:Envelope/S:Body/ns0:getSIMListResponse/SIMList/serialNumber','xmlns:S="http://schemas.xmlsoap.org/soap/envelope/" xmlns:ns1="urn:uss-wsapi:Types" xmlns:ns0="urn:uss-wsapi:Subscriber"') 
                  ,extractValue(pANSWER.ANSWER,'S:Envelope/S:Body/ns0:getSIMListResponse/SIMList/imsi', 'xmlns:S="http://schemas.xmlsoap.org/soap/envelope/" xmlns:ns1="urn:uss-wsapi:Types" xmlns:ns0="urn:uss-wsapi:Subscriber"')      
          into ResSerialNumber, ResImsi from dual; 
          
          --если по номеру имеется дополнительная информация, то обновляем ее, иначе вставляем
          if vCountSim = 1 then
            --обновление
            update phones_dop dp 
            set DP.SIM = ResSerialNumber, 
                 DP.BAN = vrec.account_number_main,
                 DP.NAME_BAN = vrec.COMPANY_NAME,
                 DP.datetime_sim = trunc(sysdate)                                             
            where dp.phone_number=pPHONE_NUMBER;          
            commit;      
          else
            --вставка
            INSERT INTO PHONES_DOP (PHONE_NUMBER, BAN, SIM, NAME_BAN, DATETIME_SIM) 
            VALUES (pPHONE_NUMBER, vrec.account_number_main, ResSerialNumber, vrec.COMPANY_NAME, trunc(sysdate));
            commit;
          end if;  
          --
          Respond:='ОК!';                     
          --Добавление в лог 
          insert into REPLACE_SIM_LOG(PHONE, OLD_SIM, NEW_SIM, REP_USER, REP_DATE, ERR, BSAL_ID, SIM_LOG_TYPE_ID)
          values(pPHONE_NUMBER, oldSim, ResSerialNumber, null, null, 0, pANSWER.BSAL_ID, 2);
          commit;
        else 
          Respond:= pANSWER.Err_text;
          insert into REPLACE_SIM_LOG(PHONE, OLD_SIM, NEW_SIM, REP_USER, REP_DATE, ERR, BSAL_ID, SIM_LOG_TYPE_ID)
          values
          (pPHONE_NUMBER, oldSim, null, null, null, 4, pANSWER.BSAL_ID, 2);
          commit;
        end if;
        -- 
      EXCEPTION
        WHEN OTHERS THEN
          Respond := pANSWER.Err_text||CHR(13)||SQLERRM;
          insert into REPLACE_SIM_LOG(PHONE, OLD_SIM, NEW_SIM, REP_USER, REP_DATE, ERR, BSAL_ID, SIM_LOG_TYPE_ID)
          values
          (pPHONE_NUMBER, oldSim, null, null, null, 2, pANSWER.BSAL_ID, 2);
          commit;
          return (Respond);
      END;
    ELSE
      Respond:='Не найден л\с';
      insert into REPLACE_SIM_LOG(PHONE, OLD_SIM, NEW_SIM, REP_USER, REP_DATE, ERR, BSAL_ID, SIM_LOG_TYPE_ID)
      values
      (pPHONE_NUMBER, oldSim, null, null, null,1,null, 2);
      commit;
    END IF;   
    return (Respond);    
  end;    

--получение номера симкарты телефона по бану
function account_phone_SIM(
  Paccount_id number
  ) return varchar2 is
  CURSOR C IS
    SELECT 
      ACCOUNTS.LOGIN, 
      ACCOUNTS.New_Pswd, 
      accounts.account_number,
      accounts.account_id,
      accounts.is_collector
    FROM  ACCOUNTS
    WHERE ACCOUNTS.account_id = Paccount_id;  
  vREC     C%ROWTYPE;
  Respond  varchar2(5000); -- ответ
  pANSWER SOAP_API_ANSWER_TYPE := SOAP_API_ANSWER_TYPE(NULL, NULL,null); 
  vLoad integer; --1 - успешная загрузка, иначе 0
  begin
    OPEN C;
    FETCH C INTO vREC;
    CLOSE C;
    IF vREC.LOGIN IS NOT NULL and vRec.Is_Collector=0 or vRec.Is_Collector is null THEN
      BEGIN
        pANSWER:=BEELINE_SOAP_API_PCKG.getSIMList(BEELINE_SOAP_API_PCKG.auth(vREC.LOGIN, vREC.New_Pswd),'',vREC.account_number);        
          
        if pANSWER.Err_text='OK' then    
          --             
          DELETE FROM API_GET_SIM_LIST;
          --
          INSERT INTO API_GET_SIM_LIST(ctn, serialNumber, IMSI)
            SELECT 
              extractvalue (value(d) ,'/SIMList/ctn') ctn,
              extractvalue (value(d) ,'/SIMList/serialNumber') serialNumber,
              extractvalue (value(d) ,'/SIMList/imsi') imsi
            FROM TABLE(XmlSequence(pANSWER.ANSWER.extract('S:Envelope/S:Body/ns0:getSIMListResponse/SIMList'
                                                            ,'xmlns:S="http://schemas.xmlsoap.org/soap/envelope/" xmlns:ns0="urn:uss-wsapi:Subscriber"'))) D;
          --           
          MERGE INTO db_loader_SIM ms
          -- Условие сравнения
            USING (select 
                         substr(d.ctn, -10) ctn
                         ,d.serialNumber serialNumber
                         ,d.imsi imsi       
                       from API_GET_SIM_LIST d               
                      ) api
            ON (ms.phone_number = api.ctn
                  and ms.account_id=Paccount_id)                
          WHEN MATCHED THEN
          -- Когда нашли
            UPDATE SET ms.sim_number = api.serialNumber, ms.imsi_number = api.imsi 
          WHEN NOT MATCHED THEN
          -- Когда не нашли
            INSERT (ms.account_id, ms.phone_number, ms.sim_number, ms.imsi_number)
            VALUES (Paccount_id, api.ctn, api.serialNumber, api.imsi);
          --- MERGE END   
          Respond:='Update '||sql%rowcount;
          -- Удалим номера, которые покинули л/с, т.е. есть в DB_LOADER_SIM, но нет в Загрузке по АПИ
          DELETE 
          FROM DB_LOADER_SIM ms
          WHERE ms.ACCOUNT_ID = pACCOUNT_ID
          AND ms.PHONE_NUMBER NOT IN (select substr(d.ctn, -10) ctn                         
                                                           from API_GET_SIM_LIST d);
          --признак успешной загрузки
          vLoad := 1;
          --логирование в лог загрузок 
          insert into account_load_logs(account_load_log_id, account_id, load_date_time, is_success, error_text, account_load_type_id)
            values(s_new_account_load_log_id.nextval, Paccount_id, sysdate, 1, 'Ok!'||Respond, 23);         
          if sql%rowcount>0 then 
            commit;
          end if;
        else 
          Respond:= pANSWER.Err_text;
          vLoad := 0; --ошибка загрузки
        end if;
      EXCEPTION
        WHEN OTHERS THEN
          Respond := SQLERRM;
          vLoad := 0; --ошибка загрузки
          --return Respond;
      END;--api_responce
    Else
      Respond:='Не найден л\с';
      vLoad := 0; --ошибка загрузки
    end if;--vrec.login
    
    --если была ошибка загрузки, то записываем ее в лог загрузки по л/с
    if vLoad = 0 then
      insert into account_load_logs(account_load_log_id, account_id, load_date_time, is_success, error_text, account_load_type_id)
        values(s_new_account_load_log_id.nextval, Paccount_id, sysdate, 0, 'Error!'||Respond, 23);      
      commit;
    end if;
    Return Respond;   
  end;--func
   
BEGIN
  --Initialization
  --Фиксы
  const_year_month:=to_number(to_char(sysdate,'YYYYMM')); 
end;