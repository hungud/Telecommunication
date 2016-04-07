--#if not ObjectExists("S_NEW_CONSTANT_ID")
CREATE SEQUENCE S_NEW_CONSTANT_ID;
--#end if


--#if not TableExists("CONSTANTS") then
CREATE TABLE CONSTANTS ( 
  NAME         VARCHAR2 (30)  NOT NULL, 
  DESCR        VARCHAR2 (400), 
  TYPE         CHAR (1)      NOT NULL, 
  VALUE        VARCHAR2 (256), 
  CONSTANT_ID  INTEGER       NOT NULL,
  CONSTRAINT UNQ_CONST_NAME UNIQUE (NAME), 
  CONSTRAINT PK_CONSTANTS
  PRIMARY KEY ( CONSTANT_ID ) ); 
--#end if

--#if GetTableComment("CONSTANTS")<>"Константы системы (настройки, текущие значения и т.д.)" then
COMMENT ON TABLE CONSTANTS IS 'Константы системы (настройки, текущие значения и т.д.)';
--#end if

--#if GetColumnSize("CONSTANTS.DESCR") < 400 then
ALTER TABLE CONSTANTS
MODIFY  DESCR        VARCHAR2 (400);
--#end if

--#if not ColumnExists("CONSTANTS.PAGE_NAME") then
ALTER TABLE CONSTANTS
ADD  PAGE_NAME VARCHAR2 (256);
--#end if

--#if not ColumnExists("CONSTANTS.ORDER_NUMBER") then
ALTER TABLE CONSTANTS
ADD  ORDER_NUMBER INTEGER;
--#end if

--#if not ColumnExists("CONSTANTS.CAPTION") then
ALTER TABLE CONSTANTS
ADD  CAPTION VARCHAR2(256);
--#end if

--#if not ColumnExists("CONSTANTS.ITEMS") then
ALTER TABLE CONSTANTS
ADD  ITEMS VARCHAR2 (2000);
--#end if

--#if not ColumnExists("CONSTANTS.ACCESS_VERSTION") then
ALTER TABLE CONSTANTS ADD ACCESS_VERSTION NUMBER(13, 6) DEFAULT 0;
--#end if

--#if not ColumnExists("CONSTANTS.ACCESS_VERSTION") then
ALTER TABLE CONSTANTS ADD ACCESS_VERSTION_STRING VARCHAR2(30 CHAR) DEFAULT '0.0.0.0';
--#end if

--#if GetColumnComment("CONSTANTS.CONSTANT_ID") <> "Код записи (первичный ключ)" then
COMMENT ON COLUMN CONSTANTS.CONSTANT_ID IS 'Код записи (первичный ключ)';
--#end if

--#if GetColumnComment("CONSTANTS.DESCR") <> "Описание константы" then
COMMENT ON COLUMN CONSTANTS.DESCR IS 'Описание константы';
--#end if
--#if GetColumnComment("CONSTANTS.NAME") <> "Имя константы" then
COMMENT ON COLUMN CONSTANTS.NAME IS 'Имя константы';
--#end if
--#if GetColumnComment("CONSTANTS.TYPE") <> "Тип значения константы" then
COMMENT ON COLUMN CONSTANTS.TYPE IS 'Тип значения константы';
--#end if
--#if GetColumnComment("CONSTANTS.VALUE") <> "Значение константы в виде строки" then
COMMENT ON COLUMN CONSTANTS.VALUE IS 'Значение константы в виде строки';
--#end if
--#if GetColumnComment("CONSTANTS.PAGE_NAME") <> "Наименование страницы настройки" then
COMMENT ON COLUMN CONSTANTS.PAGE_NAME IS 'Наименование страницы настройки';
--#end if
--#if GetColumnComment("CONSTANTS.ORDER_NUMBER") <> "Порядковый номер на странице настройки" then
COMMENT ON COLUMN CONSTANTS.ORDER_NUMBER IS 'Порядковый номер на странице настройки';
--#end if
--#if GetColumnComment("CONSTANTS.ITEMS") <> "Список допустимых значений" then
COMMENT ON COLUMN CONSTANTS.ITEMS IS 'Список допустимых значений';
--#end if
--#if GetColumnComment("CONSTANTS.CAPTION") <> "Заголовок параметра" then
COMMENT ON COLUMN CONSTANTS.CAPTION IS 'Заголовок параметра';
--#end if
--#if GetColumnComment("CONSTANTS.ACCESS_VERSTION") <> "Доступно с версии" then
COMMENT ON COLUMN CONSTANTS.ACCESS_VERSTION IS 'Доступно с версии';
--#end if
--#if GetColumnComment("CONSTANTS.ACCESS_VERSTION") <> "Доступно с версии(строка)" then
COMMENT ON COLUMN CONSTANTS.ACCESS_VERSTION_STRING IS 'Доступно с версии(строка)';
--#end if

--#if not IndexExists("I_CONSTANTS_NAME_VALUE") then
CREATE UNIQUE INDEX I_CONSTANTS_NAME_VALUE ON CONSTANTS(NAME, VALUE);
--#end if

--#if GetVersion("NEW_CONSTANT_ID") < 1 then
CREATE OR REPLACE FUNCTION NEW_CONSTANT_ID RETURN NUMBER IS
--#Version=1
  RES INTEGER;
begin
  select S_NEW_CONSTANT_ID.NEXTVAL
  INTO RES
  FROM DUAL;
  RETURN RES;
END;
/
--#end if

--#if GetVersion("TBI_CONSTANTS_BEFORE_INSERT") < 1 then
CREATE OR REPLACE TRIGGER tbi_constants_before_insert
  BEFORE INSERT OR UPDATE ON CONSTANTS
  FOR EACH ROW
DECLARE 
  vRES VARCHAR2(30 CHAR);
  vTEMP VARCHAR2(30 CHAR);
  vRESn NUMBER;
--#Version=1
BEGIN
  IF INSERTING THEN
    IF NVL(:NEW.CONSTANT_ID, 0) <= 0 THEN
      :NEW.CONSTANT_ID := new_constant_id;
    END IF;
  END IF;
  vRES:=:NEW.ACCESS_VERSTION_STRING;
  vRESn:=0;
  BEGIN
    --Читаем 1ую
    vTEMP:=SUBSTR(vRES, 1, INSTR(vRES, '.')-1);
    vRES:=SUBSTR(vRES, INSTR(vRES, '.') + 1);
    vRESn:=vRESn + TO_NUMBER(vTEMP) * 1000;
    --Читаем 2ую
    vTEMP:=SUBSTR(vRES, 1, INSTR(vRES, '.')-1);
    vRES:=SUBSTR(vRES, INSTR(vRES, '.') + 1);
    vRESn:=vRESn + TO_NUMBER(vTEMP);
    --Читаем 3ую
    vTEMP:=SUBSTR(vRES, 1, INSTR(vRES, '.')-1);
    vRES:=SUBSTR(vRES, INSTR(vRES, '.') + 1);
    vRESn:=vRESn + TO_NUMBER(vTEMP)/1000;
    --Читаем последнюю
    vRESn:=vRESn + TO_NUMBER(vRES)/1000/1000;    
  EXCEPTION
    WHEN OTHERS THEN
      vRESn:=0;
  END;
  :NEW.ACCESS_VERSTION:=vRESn;
END;
/
--#end if

--#if not RecordExists("SELECT * FROM constants WHERE NAME='CALC_ABON_PAYMENT_BLOCK_5_DAYS'") AND (isclient("CORP_MOBILE") OR IsClient("SIM_TRADE")) then
INSERT INTO CONSTANTS (NAME, DESCR, TYPE, VALUE)
  VALUES ('CALC_ABON_PAYMENT_BLOCK_5_DAYS', 'АбонПлата считается еще 5 дней после блокировки', 'B', 1);
--#end if
  
--#if not RecordExists("SELECT * FROM constants WHERE NAME='SHOW_TARIFF_MISMATCHES'") then
INSERT INTO CONSTANTS (NAME, DESCR, TYPE, VALUE)
  VALUES ('SHOW_TARIFF_MISMATCHES', 'Показывать отчет - Нарушения в тарифах', 'B', 1);  
--#end if
  
--#if not RecordExists("SELECT * FROM constants WHERE NAME='SHOW_PHONE_NUMBER_MISMATCHES'") AND (isclient("CORP_MOBILE") OR IsClient("SIM_TRADE")) then
INSERT INTO CONSTANTS (NAME, DESCR, TYPE, VALUE)
  VALUES ('SHOW_PHONE_NUMBER_MISMATCHES', 'Показывать отчет - Нарушения - несакционированные телефоны', 'B', 1);    
--#end if
  
--#if not RecordExists("SELECT * FROM constants WHERE NAME='SHOW_SEND_MAIL_PARAMETRES'") then
INSERT INTO CONSTANTS (NAME, DESCR, TYPE, VALUE)
  VALUES ('SHOW_SEND_MAIL_PARAMETRES', 'Показывать справочник - Настройки отправки e-Mail', 'B', 1);      
--#end if
  
--#if not RecordExists("SELECT * FROM constants WHERE NAME='SHOW_SEND_ON_MAIL'") and IsClient("SIM_TRADE") then
INSERT INTO CONSTANTS (NAME, DESCR, TYPE, VALUE)
  VALUES ('SHOW_SEND_ON_MAIL', 'Показывать отчет - Отправить отчет на e-Mail', 'B', 1);        
--#end if
  
--#if not RecordExists("SELECT * FROM constants WHERE NAME='SHOW_REF_MAIL_RECIPIENT'") then
INSERT INTO CONSTANTS (NAME, DESCR, TYPE, VALUE)
  VALUES ('SHOW_REF_MAIL_RECIPIENT', 'Показывать справочник - получателей отчетов по e-Mail', 'B', 1);
--#end if
  
--#if not RecordExists("SELECT * FROM constants WHERE NAME='SHOW_CONTRACT_ID_AND_DISCOUNT'") AND isclient("GSM_CORP") then
INSERT INTO CONSTANTS (NAME, DESCR, TYPE, VALUE)
  VALUES ('SHOW_CONTRACT_ID_AND_DISCOUNT', 'Показывать договор и скидку оператора в Отчете балансов', 'B', 1);      
--#end if
  
--#if not RecordExists("SELECT * FROM constants WHERE NAME='SHOW_TARIFFS_ADD_COST'") AND isclient("CORP_MOBILE") then
INSERT INTO CONSTANTS (NAME, DESCR, TYPE, VALUE)
  VALUES ('SHOW_TARIFFS_ADD_COST', 'Показывать Доб. Абон. Плата в Справочник тарифов', 'B', 1);      
--#end if
  
--#if not RecordExists("SELECT * FROM constants WHERE NAME='SHOW_OPERATOR_DISCOUNT'") AND isclient("GSM_CORP") then
INSERT INTO CONSTANTS (NAME, DESCR, TYPE, VALUE)
  VALUES ('SHOW_OPERATOR_DISCOUNT', 'Показывать Скидку оператора в информации номера', 'B', 1);   
--#end if
    
--#if not RecordExists("SELECT * FROM constants WHERE NAME='HAND_BLOCK_IS_ROBOT_BLOCK'") AND isclient("CORP_MOBILE") then
INSERT INTO CONSTANTS (NAME, DESCR, TYPE, VALUE)
  VALUES ('HAND_BLOCK_IS_ROBOT_BLOCK', 'Ручная блокировка блокирует робота вообще', 'B', 1);    
--#end if
      
--#if not RecordExists("SELECT * FROM constants WHERE NAME='BLOCK_PHONE_DELAY'") AND isclient("CORP_MOBILE") then
INSERT INTO CONSTANTS (NAME, DESCR, TYPE, VALUE)
  VALUES ('BLOCK_PHONE_DELAY', 'Задержка между отправкой СМС и блокировкой в секундах', 'N', 600);  
--#end if
    
--#if not RecordExists("SELECT * FROM constants WHERE NAME='REPORTS_USE_ACCOUNT_THREADS'") AND isclient("CORP_MOBILE") then
INSERT INTO CONSTANTS (NAME, DESCR, TYPE, VALUE)
  VALUES ('REPORTS_USE_ACCOUNT_THREADS', 'В отчетах используется деление по лиц. счетам', 'B', 1);     
--#end if
    
--#if not RecordExists("SELECT * FROM constants WHERE NAME='SEND_INFO_SMS'") AND isclient("GSM_CORP") then
INSERT INTO CONSTANTS (NAME, DESCR, TYPE, VALUE)
  VALUES ('SEND_INFO_SMS', 'Слать СМС с инфо при заключ нового договора', 'B', 1);  
--#end if
    
--#if not RecordExists("SELECT * FROM constants WHERE NAME='SHOW_BILLS_OPERATOR_AND_CLIENT'") AND (isclient("CORP_MOBILE") OR IsClient("GSM_CORP")) then
INSERT INTO CONSTANTS (NAME, DESCR, TYPE, VALUE)
  VALUES ('SHOW_BILLS_OPERATOR_AND_CLIENT', 'Показывать счета и их сравнение(от оператора и для клиента)', 'B', 1);   
--#end if
  
--#if not RecordExists("SELECT * FROM constants WHERE NAME='SERVER_NAME'") then
INSERT INTO CONSTANTS (NAME, DESCR, TYPE, VALUE)
  VALUES ('SERVER_NAME', 'Имя сервера, где идет работа', 'N', 'CORP_MOBILE');   
--#end if

--#if not RecordExists("SELECT * FROM constants WHERE NAME='SHOW_LOAD_BEE_REP'") AND (isclient("CORP_MOBILE") OR IsClient("GSM_CORP")) then
INSERT INTO CONSTANTS (NAME, DESCR, TYPE, VALUE)
  VALUES ('SHOW_LOAD_BEE_REP', 'Доступна ручная загрузка файлов Билайн', 'B', '0');
--#end if

--#if not RecordExists("SELECT * FROM constants WHERE NAME='SHOW_AUTO_REPORTS'") AND (isclient("CORP_MOBILE") OR IsClient("SIM_TRADE")) then
INSERT INTO CONSTANTS (NAME, DESCR, TYPE, VALUE)
  VALUES ('SHOW_AUTO_REPORTS', 'Доступны автоотчеты', 'B', '1');
--#end if

--#if not RecordExists("SELECT * FROM constants WHERE NAME='SHOW_BLOCK_SAVE'") AND isclient("CORP_MOBILE") then
INSERT INTO CONSTANTS (NAME, DESCR, TYPE, VALUE)
  VALUES ('SHOW_BLOCK_SAVE', 'Номера в блоке дня блока сохранения', 'B', '1');
--#end if

--#if not RecordExists("SELECT * FROM constants WHERE NAME='SHOW_UNBLOCK_SAVE'") AND isclient("CORP_MOBILE") then
INSERT INTO CONSTANTS (NAME, DESCR, TYPE, VALUE)
  VALUES ('SHOW_UNBLOCK_SAVE', 'Номера в блоке сохранения дня разблока', 'B', '1');
--#end if
  
--#if not RecordExists("SELECT * FROM constants WHERE NAME='CREDIT_SYSTEM_ENABLE'") AND isclient("CORP_MOBILE") then
INSERT INTO CONSTANTS (NAME, DESCR, TYPE, VALUE)
  VALUES ('CREDIT_SYSTEM_ENABLE', 'Кредит система включена, 1-да, прочее-нет', 'B', '1');
--#end if

--#if not RecordExists("SELECT * FROM constants WHERE NAME='FORWARDING_SYSTEM_ENABLE'") AND isclient("CORP_MOBILE") then
INSERT INTO CONSTANTS (NAME, DESCR, TYPE, VALUE)
  VALUES ('FORWARDING_SYSTEM_ENABLE', 'Переадресация СМС по номерам, 1-да, прочее-нет', 'B', '1');
--#end if

--#if not RecordExists("SELECT * FROM constants WHERE NAME='SHOW_CONTRACT_INFO'") AND isclient("CORP_MOBILE") then
INSERT INTO CONSTANTS (NAME, DESCR, TYPE, VALUE)
  VALUES ('SHOW_CONTRACT_INFO', 'Показ вкладки "Договор" в инфо', 'B', '1');
--#end if
  
--#if not RecordExists("SELECT * FROM constants WHERE NAME='SHOW_CONTRACT_SEND_ACTIV'") AND isclient("GSM_CORP") then
INSERT INTO CONSTANTS (NAME, DESCR, TYPE, VALUE)
  VALUES ('SHOW_CONTRACT_SEND_ACTIV', 'Показ столбца в договорах', 'B', '1');
--#end if

--#if not RecordExists("SELECT * FROM constants WHERE NAME='SEND_SMS_NOTICE_DELAY'") AND isclient("CORP_MOBILE") then
INSERT INTO CONSTANTS (NAME, DESCR, TYPE, VALUE)
  VALUES ('SEND_SMS_NOTICE_DELAY', 'Задержка между оповещениями о балансе в секундах', 'N', '86400');  
--#end if
  
--#if not RecordExists("SELECT * FROM constants WHERE NAME='USE_LOYAL_SYSTEM'") AND isclient("GSM_CORP") then
INSERT INTO CONSTANTS (NAME, DESCR, TYPE, VALUE)
  VALUES ('USE_LOYAL_SYSTEM', 'Использовать систему лояльного блока', 'B', '1');
--#end if

--#if not RecordExists("SELECT * FROM constants WHERE NAME='SHOW_COMPANY_NAME'") AND isclient("CORP_MOBILE") then
INSERT INTO CONSTANTS (NAME, DESCR, TYPE, VALUE)
  VALUES ('SHOW_COMPANY_NAME', 'Показывать название компании в отчетах', 'B', '1');
--#end if

--#if not RecordExists("SELECT * FROM constants WHERE NAME='USE_BILL_CHECK'") AND isclient("GSM_CORP") then
INSERT INTO CONSTANTS (NAME, DESCR, TYPE, VALUE)
  VALUES ('USE_BILL_CHECK', 'Включена поверка счетов', 'B', '1');
--#end if

--#if not RecordExists("SELECT * FROM constants WHERE NAME='SHOW_PAYMENT_WITHOUT_CONTRACTS'") AND isclient("GSM_CORP") then
INSERT INTO CONSTANTS (NAME, DESCR, TYPE, VALUE)
  VALUES ('SHOW_PAYMENT_WITHOUT_CONTRACTS', 'Показывать отчет Платежи без договоров', 'B', '1');
--#end if

--#if not RecordExists("SELECT * FROM constants WHERE NAME='SHOW_REPORT_ACCOUNT_STAT_NOW'") AND isclient("CORP_MOBILE") then
INSERT INTO CONSTANTS (NAME, DESCR, TYPE, VALUE)
  VALUES ('SHOW_REPORT_ACCOUNT_STAT_NOW', 'Показывать отчёт - Количество номеров на лицевом счёте', 'B', '1');
--#end if

--#if not RecordExists("SELECT * FROM constants WHERE NAME='REPORT_CONTRACTS_HAND_BLOCK'") AND isclient("CORP_MOBILE") then
INSERT INTO CONSTANTS (NAME, DESCR, TYPE, VALUE)
  VALUES ('REPORT_CONTRACTS_HAND_BLOCK', 'Показывать отчёт - Договора с ручной блокировкой', 'B', '1');
--#end if
  
--#if not RecordExists("SELECT * FROM constants WHERE NAME='USE_PROMISED_PAYMENTS'") AND isclient("CORP_MOBILE") then
INSERT INTO CONSTANTS (NAME, DESCR, TYPE, VALUE)
  VALUES ('USE_PROMISED_PAYMENTS', 'Используется система обещанных платежей', 'B', '1');
--#end if
  
--#if not RecordExists("SELECT * FROM constants WHERE NAME='SHOW_REPORT_VIRTUAL_PAYMENTS'") AND isclient("CORP_MOBILE") then
INSERT INTO CONSTANTS (NAME, DESCR, TYPE, VALUE)
  VALUES ('SHOW_REPORT_VIRTUAL_PAYMENTS', 'Показывать отчёт - Виртуальные платежи', 'B', '1');  
--#end if

--#if not RecordExists("SELECT * FROM constants WHERE NAME='INTERVAL_CHECK_BALANCE_CHANGE'") AND (isclient("CORP_MOBILE") OR IsClient("GSM_CORP")) then
INSERT INTO CONSTANTS (NAME, DESCR, TYPE, VALUE)
  VALUES ('INTERVAL_CHECK_BALANCE_CHANGE', 'Интервал проверки уменьшения баланса в секундах', 'N', '1800');
--#end if

--#if not RecordExists("SELECT * FROM constants WHERE NAME='ENCRYPT_PASSWORD'") AND (isclient("CORP_MOBILE") OR IsClient("GSM_CORP")) then
INSERT INTO CONSTANTS (NAME, DESCR, TYPE, VALUE)
  VALUES ('ENCRYPT_PASSWORD', 'Шифровать пароль при входе', 'B', '1');
--#end if
  
--#if not RecordExists("SELECT * FROM constants WHERE NAME='AUTO_BLOCK_PHONE_NO_CONTRACTS'") AND (isclient("CORP_MOBILE") OR IsClient("SIM_TRADE")) then
INSERT INTO CONSTANTS (NAME, DESCR, TYPE, VALUE)
  VALUES ('AUTO_BLOCK_PHONE_NO_CONTRACTS', 'Система автоблока номеров без договора', 'B', '1');
--#end if
  
--#if not RecordExists("SELECT * FROM constants WHERE NAME='USE_FILIAL_BLOCK_ACCESS'") AND isclient("GSM_CORP") then
INSERT INTO CONSTANTS (NAME, DESCR, TYPE, VALUE)
  VALUES ('USE_FILIAL_BLOCK_ACCESS', 'Блокировка филиалам доступа к прочим л/с', 'B', '1');
--#end if
  
--#if not RecordExists("SELECT * FROM constants WHERE NAME='HEAD_OFFICE'") AND isclient("GSM_CORP") then
INSERT INTO CONSTANTS (NAME, DESCR, TYPE, VALUE)
  VALUES ('HEAD_OFFICE', 'Главный офис(номер филиала)', 'B', '16');
--#end if

--#if not RecordExists("SELECT * FROM constants WHERE NAME='DO_TIMER_ON'") then
INSERT INTO CONSTANTS (NAME, DESCR, TYPE, VALUE)
  VALUES ('DO_TIMER_ON', 'Включить таймер на главной странице', 'B', '1');
--#end if

--#if not RecordExists("SELECT * FROM constants WHERE NAME='DO_CHECK_BALANCE_CHANGE'") then
INSERT INTO CONSTANTS (NAME, DESCR, TYPE, VALUE)
  VALUES ('DO_CHECK_BALANCE_CHANGE', 'Делать проверку изменения баланса', 'B', '1');
--#end if

--#if not RecordExists("SELECT * FROM constants WHERE NAME='DO_CHECK_HOT_BIL_LOAD'") then
INSERT INTO CONSTANTS (NAME, DESCR, TYPE, VALUE)
  VALUES ('DO_CHECK_HOT_BIL_LOAD', 'Делать проверку загрузки гор. билинга в БД', 'B', '1');
--#end if

--#if not RecordExists("SELECT * FROM constants WHERE NAME='DO_CHECK_HOT_BIL_LOAD_LOG'") then
INSERT INTO CONSTANTS (NAME, DESCR, TYPE, VALUE)
  VALUES ('DO_CHECK_HOT_BIL_LOAD_LOG', 'Делать проверку загрузки гор. билинга в логах на наличие ошибок', 'B', '1');
--#end if

--#if not RecordExists("SELECT * FROM constants WHERE NAME='DO_CHECK_LOAD_LOG'") then
INSERT INTO CONSTANTS (NAME, DESCR, TYPE, VALUE)
  VALUES ('DO_CHECK_LOAD_LOG', 'Делать проверку логов робота', 'B', '1');
--#end if

--#if not RecordExists("SELECT * FROM constants WHERE NAME='DO_CHECK_HACKERS'") then
INSERT INTO CONSTANTS (NAME, DESCR, TYPE, VALUE)
  VALUES ('DO_CHECK_HACKERS', 'Делать проверку на хакеров', 'B', '1');
--#end if

--#if not RecordExists("SELECT * FROM constants WHERE NAME='SHOW_CONTRACT_DOP_STATUS'") AND isclient("CORP_MOBILE") then
INSERT INTO CONSTANTS (NAME, DESCR, TYPE, VALUE)
  VALUES ('SHOW_CONTRACT_DOP_STATUS', 'Показывать доп.статус контракта', 'B', '1');
--#end if

--#if not RecordExists("SELECT * FROM constants WHERE NAME='SHOW_CITY_NUMBERS'")  AND isclient("CORP_MOBILE") then
INSERT INTO CONSTANTS (NAME, DESCR, TYPE, VALUE)
  VALUES ('SHOW_CITY_NUMBERS', 'Показывать отчёт - Городские номера', 'B', '1');  
--#end if

--#if not RecordExists("SELECT * FROM constants WHERE NAME='PAS_FINANCE_REPORT'") AND isclient("GSM_CORP") then
INSERT INTO CONSTANTS (NAME, DESCR, TYPE, VALUE)
  VALUES ('PAS_FINANCE_REPORT', 'Пароль на финансовый отчёт', 'N', 'FinanceGsm');  
--#end if

--#if not RecordExists("SELECT * FROM constants WHERE NAME='SHOW_REPORT_DEBITORKA'") AND isclient("CORP_MOBILE") then
INSERT INTO CONSTANTS (NAME, DESCR, TYPE, VALUE)
  VALUES ('SHOW_REPORT_DEBITORKA', 'Отчет "Дебиторская задолженность"', 'B', '1');  
--#end if

--#if not RecordExists("SELECT * FROM constants WHERE NAME='USE_ABON_DISCOUNTS'") AND isclient("CORP_MOBILE") then
INSERT INTO CONSTANTS (NAME, DESCR, TYPE, VALUE)
  VALUES ('USE_ABON_DISCOUNTS', 'Использовать "Скидка абонентской платы"', 'B', '1');  
--#end if

--#if not RecordExists("SELECT * FROM constants WHERE NAME='USE_INSTALLMENT_PAYMENT'") AND isclient("CORP_MOBILE") then
INSERT INTO CONSTANTS (NAME, DESCR, TYPE, VALUE)
  VALUES ('USE_INSTALLMENT_PAYMENT', 'Использовать "Рассрочку в договорах"', 'B', '1');  
--#end if
  
--#if not RecordExists("SELECT * FROM constants WHERE NAME='USE_FULL_ACCESS_DENIED_BLOCK'") AND isclient("CORP_MOBILE") then
INSERT INTO CONSTANTS (NAME, DESCR, TYPE, VALUE)
  VALUES ('USE_FULL_ACCESS_DENIED_BLOCK', 'Использовать полный запрет блока номера(потоки блока берут список из PHONE_NUMBER_BLOCK_DENIED)', 'B', '1'); 
--#end if

--#if not RecordExists("SELECT * FROM constants WHERE NAME='SHOW_DEALERS'") AND isclient("CORP_MOBILE") then
INSERT INTO CONSTANTS (NAME, DESCR, TYPE, VALUE)
  VALUES ('SHOW_DEALERS', 'Показывать справочник дилеров', 'B', '1');
--#end if

--#if not RecordExists("SELECT * FROM constants WHERE NAME='SHOW_ACCOUNT_INFO'") AND isclient("CORP_MOBILE") then
INSERT INTO CONSTANTS (NAME, DESCR, TYPE, VALUE)
  VALUES ('SHOW_ACCOUNT_INFO', 'Показывать информацию о счетах', 'B', '1');
--#end if
  
--#if not RecordExists("SELECT * FROM constants WHERE NAME='SHOW_REPORT_TARIFF_OPT_PHONES'") AND isclient("CORP_MOBILE") then
INSERT INTO CONSTANTS (NAME, DESCR, TYPE, VALUE)
  VALUES ('SHOW_REPORT_TARIFF_OPT_PHONES', 'Показывать отчет Тарифная опция/услуга - список номеров', 'B', '1');
--#end if

--#if not RecordExists("SELECT * FROM constants WHERE NAME='LOAD_FIO_WHEN_LOAD_CONTRACTS'") AND isclient("CORP_MOBILE") then
INSERT INTO CONSTANTS (NAME, DESCR, TYPE, VALUE)
  VALUES ('LOAD_FIO_WHEN_LOAD_CONTRACTS', 'Загружать ФИО при загрузке контрактов', 'B', '1');
--#end if

--#if not RecordExists("SELECT * FROM constants WHERE NAME='SHOW_SEND_MAIL_INFO_ABON'") AND isclient("CORP_MOBILE") then
INSERT INTO CONSTANTS (NAME, DESCR, TYPE, VALUE)
  VALUES ('SHOW_SEND_MAIL_INFO_ABON', 'Показывать в карточке абонента - отправку почты', 'B', '1');
--#end if

--#if not RecordExists("SELECT * FROM constants WHERE NAME='SHOW_REPORT_MISSING_PHONE'") AND isclient("CORP_MOBILE") then
INSERT INTO CONSTANTS (NAME, DESCR, TYPE, VALUE)
  VALUES ('SHOW_REPORT_MISSING_PHONE', 'Показывать отчет Номера исчезнувшие с договоров', 'B', '1');
--#end if

--#if not RecordExists("SELECT * FROM constants WHERE NAME='SHOW_REPORT_BILL_NEGATIVE'") AND isclient("CORP_MOBILE") then
INSERT INTO CONSTANTS (NAME, DESCR, TYPE, VALUE)
  VALUES ('SHOW_REPORT_BILL_NEGATIVE', 'Показывать отчет Счета выставленные в минус', 'B', '1');
--#end if

--#if not RecordExists("SELECT * FROM constants WHERE NAME='BLOCK_TYPES_ENABLE'") AND (isclient("CORP_MOBILE") OR IsClient("GSM_CORP")) then
INSERT INTO constants (NAME, DESCR, TYPE, VALUE)
  VALUES ('BLOCK_TYPES_ENABLE', 'Отображение блок-функций', 'B',  '1');
--#end if

--#if not RecordExists("SELECT * FROM constants WHERE NAME='REPLACE_SIM_ENABLE'") AND (isclient("CORP_MOBILE") OR IsClient("GSM_CORP")) then
INSERT INTO constants (NAME, DESCR, TYPE, VALUE)
  VALUES ('REPLACE_SIM_ENABLE', 'Разрешена замена SIM', 'B',  '1');
--#end if

--#if not RecordExists("SELECT * FROM constants WHERE NAME='SHOW_STATUS_JOB'") AND (isclient("CORP_MOBILE") OR IsClient("GSM_CORP")) then
INSERT INTO CONSTANTS (NAME, DESCR, TYPE, VALUE)
  VALUES ('SHOW_STATUS_JOB', 'Показывать статусы JOB-ов', 'N', '1');
--#end if

--#if not RecordExists("SELECT * FROM constants WHERE NAME='SHOW_REPORT_BALANCE_ON_DATE'") and IsClient("SIM_TRADE") then
INSERT INTO CONSTANTS (NAME, DESCR, TYPE, VALUE)
  VALUES ('SHOW_REPORT_BALANCE_ON_DATE', 'Показывать отчет "Балансы по дате"', 'B', '1');
--#end if

--#if not RecordExists("SELECT * FROM constants WHERE NAME='SHOW_DOP_PHONE_INFO'") AND (isclient("CORP_MOBILE") OR IsClient("GSM_CORP")) then
INSERT INTO CONSTANTS (NAME, DESCR, TYPE, VALUE)
  VALUES ('SHOW_DOP_PHONE_INFO', 'Показывать закладку доп. инфо.', 'N', '0');
--#end if

--#if not RecordExists("SELECT * FROM constants WHERE NAME='SHOW_LOAD_BEE_REP_PAYMENTS'") and IsClient("CORP_MOBILE") then
INSERT INTO CONSTANTS (NAME, DESCR, TYPE, VALUE)
  VALUES ('SHOW_LOAD_BEE_REP_PAYMENTS', 'Доступна ручная загрузка файлов Билайн платежи', 'B', '0');
--#end if

--#if not RecordExists("SELECT * FROM constants WHERE NAME='SHOW_LOAD_BEE_REP_STATUS'") and IsClient("CORP_MOBILE") then
INSERT INTO CONSTANTS (NAME, DESCR, TYPE, VALUE)
  VALUES ('SHOW_LOAD_BEE_REP_STATUS', 'Доступна ручная загрузка файлов Билайн статусы', 'B', '0');
--#end if

--#if not RecordExists("SELECT * FROM constants WHERE NAME='SHOW_LOAD_BEE_REP_NACHISL'") and IsClient("CORP_MOBILE") then
INSERT INTO CONSTANTS (NAME, DESCR, TYPE, VALUE)
  VALUES ('SHOW_LOAD_BEE_REP_NACHISL', 'Доступна ручная загрузка файлов Билайн начисления', 'B', '0');
--#end if

--#if not RecordExists("SELECT * FROM constants WHERE NAME='SHOW_LOAD_BEE_REP_KODBASESTAT'") and IsClient("CORP_MOBILE") then
INSERT INTO CONSTANTS (NAME, DESCR, TYPE, VALUE)
  VALUES ('SHOW_LOAD_BEE_REP_KODBASESTAT', 'Доступна ручная загрузка файлов Билайн коды базовых станций', 'B', '0');
--#end if

--#if not RecordExists("SELECT * FROM constants WHERE NAME='SHOW_LOAD_BEE_REP_KODBASESTAMO'") and IsClient("CORP_MOBILE") then
INSERT INTO CONSTANTS (NAME, DESCR, TYPE, VALUE)
  VALUES ('SHOW_LOAD_BEE_REP_KODBASESTAMO', 'Доступна ручная загрузка файлов Билайн коды базовых станций МО', 'B', '0');
--#end if

--#if not RecordExists("SELECT * FROM constants WHERE NAME='SHOW_LOAD_BEE_REP_BILLS'") and IsClient("CORP_MOBILE") then
INSERT INTO CONSTANTS (NAME, DESCR, TYPE, VALUE)
  VALUES ('SHOW_LOAD_BEE_REP_BILLS', 'Доступна ручная загрузка файлов Билайн счета', 'B', '0');
--#end if

--#if not RecordExists("SELECT * FROM constants WHERE NAME='SHOW_LOAD_BEE_REP_CONTRACT'") and IsClient("CORP_MOBILE") then
INSERT INTO CONSTANTS (NAME, DESCR, TYPE, VALUE)
  VALUES ('SHOW_LOAD_BEE_REP_CONTRACT', 'Доступна ручная загрузка файлов Билайн контракты', 'B', '0');
--#end if

--#if not RecordExists("SELECT * FROM constants WHERE NAME='SHOW_LOAD_BEE_REP_RASTORZH'") and IsClient("CORP_MOBILE") then
INSERT INTO CONSTANTS (NAME, DESCR, TYPE, VALUE)
  VALUES ('SHOW_LOAD_BEE_REP_RASTORZH', 'Доступна ручная загрузка файлов Билайн расторжение', 'B', '0');
--#end if

--#if not RecordExists("SELECT * FROM constants WHERE NAME='SHOW_LOAD_BEE_REP_DETAILS'") and IsClient("CORP_MOBILE") then
INSERT INTO CONSTANTS (NAME, DESCR, TYPE, VALUE)
  VALUES ('SHOW_LOAD_BEE_REP_DETAILS', 'Доступна ручная загрузка файлов Билайн детализации', 'B', '0');
--#end if

--#if not RecordExists("SELECT * FROM constants WHERE NAME='SHOW_LOAD_BEE_REP_MOBIPAY'") and IsClient("CORP_MOBILE") then
INSERT INTO CONSTANTS (NAME, DESCR, TYPE, VALUE)
  VALUES ('SHOW_LOAD_BEE_REP_MOBIPAY', 'Доступна ручная загрузка файлов Билайн мобильные платежи', 'B', '0');
--#end if

--#if not RecordExists("SELECT * FROM constants WHERE NAME='SHOW_LOAD_BEE_REP_CHANGETP'") and IsClient("CORP_MOBILE") then
INSERT INTO CONSTANTS (NAME, DESCR, TYPE, VALUE)
  VALUES ('SHOW_LOAD_BEE_REP_CHANGETP', 'Доступна ручная загрузка файлов Билайн смена ТП', 'B', '0');
--#end if

--#if not RecordExists("SELECT * FROM constants WHERE NAME='SHOW_LOAD_BEE_REP_DOPPHONEINFO'") AND (isclient("CORP_MOBILE") OR IsClient("GSM_CORP")) then
INSERT INTO CONSTANTS (NAME, DESCR, TYPE, VALUE)
  VALUES ('SHOW_LOAD_BEE_REP_DOPPHONEINFO', 'Доступна ручная загрузка файлов Билайн доп. инфо', 'B', '0');
--#end if

--#if not RecordExists("SELECT * FROM constants WHERE NAME='REPLACE_SIM_ADM_ENABLE'") AND IsClient("GSM_CORP") then
INSERT INTO CONSTANTS (NAME, DESCR, TYPE, VALUE)
  VALUES ('REPLACE_SIM_ADM_ENABLE', 'Разрешена замена SIM только админам', 'B', '0');
--#end if

--#if not RecordExists("SELECT * FROM constants WHERE NAME='REPLACE_SIM_ADM_ENABLE'") AND IsClient("GSM_CORP") then
INSERT INTO CONSTANTS (NAME, DESCR, TYPE, VALUE)
  VALUES ('SHOW_CONTRACT_GROUPS', 'Показывать Групповые договора', 'B', '1');
--#end if

--#if not RecordExists("SELECT * FROM constants WHERE NAME='IS_MONITORING'") AND IsClient("CORP_MOBILE") then
INSERT INTO CONSTANTS (NAME, DESCR, TYPE, VALUE)
  VALUES ('IS_MONITORING', 'Показывать пункт меню Мониторинг', 'B', '1');
--#end if

--#if not RecordExists("SELECT * FROM constants WHERE NAME='USE_DETAIL_HIDE_PHONES'") AND IsClient("CORP_MOBILE") then
INSERT INTO CONSTANTS (NAME, DESCR, TYPE, VALUE)
  VALUES ('USE_DETAIL_HIDE_PHONES', 'Использовать скрытие детализации', 'B', '1');
--#end if

--#if not RecordExists("SELECT * FROM constants WHERE NAME='SHOW_BILLVIOLS'") then
INSERT INTO CONSTANTS (NAME, DESCR, TYPE, VALUE)
  VALUES ('SHOW_BILLVIOLS', 'Показывать отчет - Нарушения в тарифах', 'B', 1);  
--#end if

--#if not RecordExists("SELECT * FROM constants WHERE NAME='SHOW_BILL_VIOLATION_IN_ACCOUNT'") then
INSERT INTO CONSTANTS (NAME, DESCR, TYPE, VALUE)
  VALUES ('SHOW_BILL_VIOLATION_IN_ACCOUNT', 'Показывать отчет - Нарушения в счетах', 'B', 1);  
--#end if

--#if not RecordExists("SELECT * FROM constants WHERE NAME='SHOW_SUSPICION_OF_FRAUD'") AND IsClient("CORP_MOBILE") then
INSERT INTO CONSTANTS (NAME, DESCR, TYPE, VALUE)
  VALUES ('SHOW_SUSPICION_OF_FRAUD', 'Показывать отчет Подозрение в мошенничестве', 'B', '1');
--#end if

--#if not RecordExists("SELECT * FROM constants WHERE NAME='SHOW_MOBPAY'") AND IsClient("CORP_MOBILE") then
INSERT INTO CONSTANTS (NAME, DESCR, TYPE, VALUE)
  VALUES ('SHOW_MOBPAY', 'Показывать отчет MobPay в Платежах', 'B', '1');
--#end if

--#if not RecordExists("SELECT * FROM constants WHERE NAME='SHOW_JOURNAL_OF_SENDING'") AND IsClient("CORP_MOBILE") then
INSERT INTO CONSTANTS (NAME, DESCR, TYPE, VALUE)
  VALUES ('SHOW_JOURNAL_OF_SENDING', 'Показывать отчет Журнал отправок', 'B', '1');
--#end if

--#if not RecordExists("SELECT * FROM constants WHERE NAME='SHOW_REP_OF_DOPSTATUS'") AND IsClient("CORP_MOBILE") then
INSERT INTO CONSTANTS (NAME, DESCR, TYPE, VALUE)
  VALUES ('SHOW_REP_OF_DOPSTATUS', 'Показывать отчет по Доп.статусам', 'B', '1');
--#end if

--#if not RecordExists("SELECT * FROM constants WHERE NAME='SHOW_JOURNAL_OF_LOGPHONE'") AND IsClient("CORP_MOBILE") then
INSERT INTO CONSTANTS (NAME, DESCR, TYPE, VALUE)
  VALUES ('SHOW_JOURNAL_OF_LOGPHONE', 'Показывать отчет Журнал логов по номеру телефона', 'B', '1');
--#end if

--#if not RecordExists("SELECT * FROM constants WHERE NAME='USE_TARIFF_OPTION_GROUP'") AND IsClient("CORP_MOBILE") then
INSERT INTO CONSTANTS (NAME, DESCR, TYPE, VALUE, ACCESS_VERSTION_STRING)
  VALUES ('USE_TARIFF_OPTION_GROUP', 'Использовать справочник "Группы тарифных опций"', 'B', '1', '1.8.19.0');
--#end if

--#if not RecordExists("SELECT * FROM constants WHERE NAME='SHOW_FINANCE_REPORT'") AND IsClient("CORP_MOBILE") then
INSERT INTO CONSTANTS (NAME, DESCR, TYPE, VALUE, ACCESS_VERSTION_STRING)
  VALUES ('SHOW_FINANCE_REPORTS', 'Показывать Финансовые отчеты', 'B', '1', '1.8.20.1');
--#end if

--#if not RecordExists("SELECT * FROM constants WHERE NAME='SHOW_FIN_REP_HISTORY_ACTIV_PHONE'") AND IsClient("CORP_MOBILE") then
INSERT INTO CONSTANTS (NAME, DESCR, TYPE, VALUE, ACCESS_VERSTION_STRING)
  VALUES ('SHOW_FIN_REP_HISTORY_ACT_PHONE', 'Показывать Фин отчет "Списки активных номеров"', 'B', '1', '1.8.20.1');
--#end if

--#if not RecordExists("SELECT * FROM constants WHERE NAME='SHOW_FIN_REP_INFLOW_OUTFLOW'") AND IsClient("CORP_MOBILE") then
INSERT INTO CONSTANTS (NAME, DESCR, TYPE, VALUE, ACCESS_VERSTION_STRING)
  VALUES ('SHOW_FIN_REP_INFLOW_OUTFLOW', 'Показывать Фин отчет "Приток и отток номеров"', 'B', '1', '1.8.21.1');
--#end if
    
--#if not RecordExists("SELECT * FROM constants WHERE NAME='SHOW_HOT_BIL_DELAY'") then
INSERT INTO CONSTANTS (NAME, DESCR, TYPE, VALUE, ACCESS_VERSTION_STRING)
  VALUES ('SHOW_HOT_BIL_DELAY', 'Показывать отчёт по задержкам гор билинга', 'B', '1', '1.8.21.2');
--#end if

--#if not RecordExists("SELECT * FROM constants WHERE NAME='SHOW_DETAIL_API'") then
INSERT INTO CONSTANTS (NAME, DESCR, TYPE, VALUE, ACCESS_VERSTION_STRING)
  VALUES ('SHOW_DETAIL_API', 'Показывать кнопку показать детализацию из API', 'B', '1', '1.8.21.3');
--#end if

--#if not RecordExists("SELECT * FROM constants WHERE NAME='SHOW_FINANCE_SUM_BILLS'") AND IsClient("CORP_MOBILE") then
INSERT INTO CONSTANTS (NAME, DESCR, TYPE, VALUE, ACCESS_VERSTION_STRING)
  VALUES ('SHOW_FINANCE_SUM_BILLS', 'Показывать Фин. отчет "Сумма счетов и платежей', 'B', '1', '1.8.21.7');
--#end if

--#if not RecordExists("SELECT * FROM constants WHERE NAME='SHOW_SUM_POSITIVE_BALANCE'") AND IsClient("CORP_MOBILE") then
INSERT INTO CONSTANTS (NAME, DESCR, TYPE, VALUE, ACCESS_VERSTION_STRING)
  VALUES ('SHOW_SUM_POSITIVE_BALANCE', 'Показывать отчет "Суммы положительных балансов"', 'B', '1', '1.8.21.7');
--#end if

--#if not RecordExists("SELECT * FROM constants WHERE NAME='USE_TYPE_PAYMENTS'") AND IsClient("CORP_MOBILE") then
INSERT INTO CONSTANTS (NAME, DESCR, TYPE, VALUE, ACCESS_VERSTION_STRING)
  VALUES ('USE_TYPE_PAYMENTS', 'Использовать типы платежей', 'B', '1', '1.8.21.19');
--#end if

--#if not RecordExists("SELECT * FROM constants WHERE NAME='SHOW_LOAD_BEE_REP_CHANGE_DST'") and IsClient("CORP_MOBILE") then
INSERT INTO CONSTANTS (NAME, DESCR, TYPE, VALUE, ACCESS_VERSTION_STRING)
  VALUES ('SHOW_LOAD_BEE_REP_CHANGE_DST', 'Доступна ручная загрузка файлов Билайн смена доп.статусов', 'B', '1','1.8.21.19');
--#end if

--#if not RecordExists("SELECT * FROM constants WHERE NAME='SHOW_PHONE_INACTIVITY'") AND IsClient("CORP_MOBILE") then
INSERT INTO CONSTANTS (NAME, DESCR, TYPE, VALUE, ACCESS_VERSTION_STRING)
  VALUES ('SHOW_PHONE_INACTIVITY', 'Показывать отчет "Номера с отсутствующей активностью"', 'B', '1', '1.8.21.7');
--#end if

--#if not RecordExists("SELECT * FROM constants WHERE NAME='SHOW_LOAD_BEE_REP_RECEIVED_PAY'") and IsClient("CORP_MOBILE") then
INSERT INTO CONSTANTS (NAME, DESCR, TYPE, VALUE, ACCESS_VERSTION_STRING)
  VALUES ('SHOW_LOAD_BEE_REP_RECEIVED_PAY', 'Доступна ручная загрузка файлов Билайн ручные платежи', 'B', '1','1.8.21.19');
--#end if

--#if not RecordExists("SELECT * FROM constants WHERE NAME='LOAD_NEW_WHEN_LOAD_CONTRACTS'") and IsClient("CORP_MOBILE") then
INSERT INTO CONSTANTS (NAME, DESCR, TYPE, VALUE, ACCESS_VERSTION_STRING)
  VALUES ('LOAD_NEW_WHEN_LOAD_CONTRACTS', 'Загружать новые поля при загрузке контрактов', 'B', '1','1.8.22.12');
--#end if

--#if not RecordExists("SELECT * FROM constants WHERE NAME='SHOW_REPORT_PASSENGER'") and IsClient("CORP_MOBILE") then
INSERT INTO CONSTANTS (NAME, DESCR, TYPE, VALUE, ACCESS_VERSTION_STRING)
  VALUES ('SHOW_REPORT_PASSENGER', 'Показывать отчет Пассажирский', 'B', '1','1.8.22.7');
--#end if

--#if not RecordExists("SELECT * FROM constants WHERE NAME='BEELINE_SMS_GATEWAY'") and IsClient("CORP_MOBILE") then
INSERT INTO CONSTANTS (NAME, DESCR, TYPE, VALUE, ACCESS_VERSTION_STRING)
  VALUES ('BEELINE_SMS_GATEWAY', 'Показывает наличие билайновского смс-шлюза( -1 - шлюза нет, 0 - шлюз есть и отключен, 1 - шлюз есть и включен)', 'N', '-1','1.8.24.6');
--#end if

--#if not RecordExists("SELECT * FROM constants WHERE NAME='BEELINE_SMS_GATEWAY'") and IsClient("CORP_MOBILE") then
INSERT INTO CONSTANTS (NAME, DESCR, TYPE, VALUE, ACCESS_VERSTION_STRING)
  VALUES ('SHOW_PHONE_ON_BAN_REPORT', 'Отображает форму с отчетом по номерам на определенном счете (Бане)', 'B', '0','1.8.24.6');
--#end if

--#if not RecordExists("SELECT * FROM constants WHERE NAME='SHOW_REPORT_ACCOUNT4PERIOD'") and IsClient("CORP_MOBILE") then
INSERT INTO CONSTANTS (NAME, DESCR, TYPE, VALUE, ACCESS_VERSTION_STRING)
  VALUES ('SHOW_REPORT_ACCOUNT4PERIOD', 'Показать отчет по счетам за период', 'B', '0','1.8.24.7');
--#end if

--#if not RecordExists("SELECT * FROM constants WHERE NAME='SHOW_REPORT_APIREJECTBLOCKS'") and IsClient("CORP_MOBILE") then
Insert into CONSTANTS   (NAME, DESCR, TYPE, VALUE, ACCESS_VERSTION_STRING)
 Values ('SHOW_REPORT_APIREJECTBLOCKS', 'Показать отчет по отклоненным блокировкам/разблокировкам через API', 'B', '1', '1.8.24.13');
--#end if

--#if not RecordExists("SELECT * FROM constants WHERE NAME='SHOW_REPORT_HOTBILLINGFILES'") then
Insert into CONSTANTS   (NAME, DESCR, TYPE, VALUE, ACCESS_VERSTION_STRING)
 Values ('SHOW_REPORT_HOTBILLINGFILES', 'Показать отчет о загрузках горячего биллинга', 'B', '1', '1.8.24.13');
--#end if

--#if not RecordExists("SELECT * FROM constants WHERE NAME='SHOW_REP_RECOV_CLOSE_CONTRACTS'") then
Insert into CONSTANTS
   (NAME, DESCR, TYPE, VALUE, ACCESS_VERSTION_STRING)
 Values
   ('SHOW_REP_RECOV_CLOSE_CONTRACTS', 'Показать отчет для своевременного восстановления/расторжения договора', 'B', '0', '1.8.24.20');
--#end if

--#if not RecordExists("SELECT * FROM constants WHERE NAME='SHOW_REP_CHNG_STAT_PRESALE_BLOCK'") then
Insert into CONSTANTS
   (NAME, DESCR, TYPE, VALUE, ACCESS_VERSTION_STRING)
 Values
   ('SHOW_REP_CHNG_STAT_PRESAL_BLC', 'Показать отчет по статусу "Предпродажная блокировка"', 'B', '0', '1.8.25.10');
--#end if

--#if not RecordExists("SELECT * FROM constants WHERE NAME='DO_TIMER_LOG_ERROR_ON'") then
INSERT INTO CONSTANTS (NAME, DESCR, TYPE, VALUE, ACCESS_VERSTION_STRING)
  VALUES ('DO_TIMER_LOG_ERROR_ON', 'Включить таймер на главной странице (ошибки загрузки)', 'B', '1', '1.8.25.10');
--#end if

--#if not RecordExists("SELECT * FROM constants WHERE NAME='INTERVAL_CHECK_LOG_ERROR'") then
INSERT INTO CONSTANTS (NAME, DESCR, TYPE, VALUE, ACCESS_VERSTION_STRING)
  VALUES ('INTERVAL_CHECK_LOG_ERROR', 'Интервал проверки критических ошибок загрузки (секунды)', 'N', '300', '1.8.25.10');
--#end if

--#if not RecordExists("SELECT * FROM constants WHERE NAME='MAIL_LOG_ERROR'") then
INSERT INTO CONSTANTS (NAME, DESCR, TYPE, VALUE, ACCESS_VERSTION_STRING)
  VALUES ('MAIL_LOG_ERROR', 'e-mail для отправки критических ошибок загрузки', 'S', 'skotenkov@gmail.com', '1.8.25.10');
--#end if

--#if not RecordExists("SELECT * FROM constants WHERE NAME='INACTIVE_SUBSCR_COLUMN_NAME'") then
INSERT INTO CONSTANTS (NAME, DESCR, TYPE, VALUE, ACCESS_VERSTION_STRING)
  VALUES ('INACTIVE_SUBSCR_COLUMN_NAME', 'список полей для отчета "Номера с отсутствующей активностью" для TeleTie' , 'S', 'login,phone_number_federal,contract_date,balance,phone_is_active,dop_status_name,last_check_date_time', '1.8.26.29');
--#end if

--#if not RecordExists("SELECT * FROM constants WHERE NAME='INACTIVE_SUBSCR_COLUMN_NAME'") then
INSERT INTO CONSTANTS (NAME, DESCR, TYPE, VALUE, ACCESS_VERSTION_STRING)
  VALUES ('ENABLE_BLOCK_BY_SAVE', 'Отображать кнопку "Блокировка по сохранению"' , 'B', '1', '1.8.26.32');
--#end if

--#if not RecordExists("SELECT * FROM constants WHERE NAME='SHOW_FEATURE_PHONE_ISCOLLECTOR'") then
Insert into CONSTANTS
   (NAME, DESCR, TYPE, VALUE, ACCESS_VERSTION_STRING)
 Values
   ('SHOW_FEATURE_PHONE_ISCOLLECTOR', 'Показывать в карте абонента надпись "Коллектор", если номер принадлежит коллектору', 'B', '1', '1.8.26.37');
--#end if


Insert into CONSTANTS  (NAME, DESCR, TYPE, VALUE,  ACCESS_VERSTION_STRING) Values
   ('HOT_BILLING_FILE_EXT', 'Расширение для загружаемого файла горячего биллинга', 'S', 'dbf',     '0.0.0.0');
   
--#if not RecordExists("SELECT * FROM constants WHERE NAME='SHOW_JOB_AND_SEND_ACCOUNTS'") then
Insert into CONSTANTS
   (NAME, DESCR, TYPE, VALUE, ACCESS_VERSTION_STRING)
 Values
   ('SHOW_JOB_AND_SEND_ACCOUNTS', 'Показывать состояние загрузок и оповещений в лицевых счетах', 'B', '1', '1.8.26.53');
--#end if
-#if not RecordExists("SELECT * FROM constants WHERE NAME='SHOW_ROAMING_RETARIF_PROFIT'") then
INSERT INTO CONSTANTS (NAME, DESCR, TYPE, VALUE, ACCESS_VERSTION_STRING)
  VALUES ('SHOW_ROAMING_RETARIF_PROFIT', 'Отображать отчет "Выгодность ретарификации роуминга"' , 'B', '1', '1.8.26.55');
--#end if

--#if not RecordExists("SELECT * FROM constants WHERE NAME='SHOW_BLOCKPHONE_ONEPAYMENT'") then
INSERT INTO CONSTANTS (NAME, DESCR, TYPE, VALUE, ACCESS_VERSTION_STRING)
  VALUES ('SHOW_BLOCKPHONE_ONEPAYMENT', 'Показывать отчет по выговорившим первый платеж' , 'B', '1', '1.8.26.55');
--#end if

--#if not RecordExists("SELECT * FROM constants WHERE NAME='HOUR_START_SEND_PROMIZED_MESS'") then
INSERT INTO CONSTANTS (NAME, DESCR, TYPE, VALUE, ACCESS_VERSTION_STRING)
 Values    ('HOUR_START_SEND_PROMIZED_MESS', 'Время (час) начала рассылки смс об окончании обещанного платежа', 'N', '10', '1.8.26.71');
--#end if

Insert into CONSTANTS
   (NAME, DESCR, TYPE, VALUE, ACCESS_VERSTION_STRING)
 Values
   ('EXPORT_OBJECTS_TO_SVN_PATH', 'Путь для выгрузки файлов скриптов Базы данных', 'S', '/u03/backup/DATA_BASE_SCRIPTS',  '1.8.26.74');
COMMIT;

INSERT INTO CONSTANTS (NAME, DESCR, TYPE, ACCESS_VERSTION_STRING) 
VALUES ('START_TIME_JOB_AFTER_STOP', 'Время запуска job после их остановки', 'S', '0.0.0.0');
COMMIT;
