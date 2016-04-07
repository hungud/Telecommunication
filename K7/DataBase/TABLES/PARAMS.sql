--#if not TableExists("PARAMS") then
-- Create table
create table PARAMS
(
  param_id INTEGER not null,
  name     VARCHAR2(30) not null,
  value    VARCHAR2(256),
  type     CHAR(1) not null,
  descr    VARCHAR2(400)
);
-- S - строка 
-- P - пароль
-- N - число.
-- B - логическое (1/0)
--#end if

--#if not ConstraintExists("PK_PARAMS")
-- Create/Recreate primary, unique and foreign key constraints 
alter table PARAMS
  add constraint PK_PARAMS primary key (PARAM_ID)
  using index 
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
--#end if

--#if not ConstraintExists("UNQ_PARAM_NAME")
alter table PARAMS
  add constraint UNQ_PARAM_NAME unique (NAME)
  using index 
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
--#end if
  
--#if not ObjectExists("S_NEW_PARAM_ID")
CREATE SEQUENCE S_NEW_PARAM_ID
  START WITH 41
  MAXVALUE 999999999999999999999999999
  MINVALUE 1
  NOCYCLE
  CACHE 20
  NOORDER;
--#end if
  

--#if not ObjectExists("TI_PARAM_ID")
CREATE OR REPLACE TRIGGER TI_PARAM_ID
  BEFORE INSERT ON  PARAMS FOR EACH ROW 
DECLARE

BEGIN
      :NEW.PARAM_ID:= S_NEW_PARAM_ID.NEXTVAL;
END;  
--#end if


--#Execute MAIN_SCHEMA=IsClient("")

--#if not GrantExists("PARAMS", "ROLE", "SELECT") then
begin EXECUTE IMMEDIATE 'GRANT ALL ON PARAMS TO &MAIN_SCHEMA'||'_ROLE'; end;
--#end if

--#if not GrantExists("PARAMS", "ROLE_RO", "SELECT") then
begin EXECUTE IMMEDIATE 'GRANT SELECT ON PARAMS TO &MAIN_SCHEMA'||'_ROLE_RO'; end;
--#end if


--#if not RecordExists("SELECT * FROM PARAMS WHERE NAME='PHONE_NUMBER'")  and isclient("GSM_CORP") then
INSERT INTO PARAMS (NAME, DESCR, TYPE, VALUE)
  VALUES ('PHONE_NUMBER', 'Номер тел., на котор. отправляются уведомления по балансу', 'N', '89266433999');
--#end if

--#if not RecordExists("SELECT * FROM PARAMS WHERE NAME='DAY_LOAD_BILLS_ERR'") and (isclient("GSM_CORP") or isclient("CORP_MOBILE")) then
INSERT INTO PARAMS (NAME, DESCR, TYPE, VALUE)
  VALUES ('DAY_LOAD_BILLS_ERR', 'День месяца, после которого срабатывает предупреждение о не загруженных в этом месяце счетах', 'B', '6');
--#end if

--#if not RecordExists("SELECT * FROM PARAMS WHERE NAME='CRIT_SMS_COUNT'") and isclient("CORP_MOBILE") then
INSERT INTO PARAMS (NAME, DESCR, TYPE, VALUE)
  VALUES ('CRIT_SMS_COUNT', 'Критическое кол-во СМС, после которого срабатывает признак определения хакера', 'N', 50);
--#end if

--#if not RecordExists("SELECT * FROM PARAMS WHERE NAME='SHOW_MESSAGE_ON_SITE'") and isclient("GSM_CORP") then
INSERT INTO PARAMS (NAME, DESCR, TYPE, VALUE)
  VALUES ('SHOW_MESSAGE_ON_SITE', 'Показывать сообщение при входе в ЛК', 'S', '1');
--#end if

--#if not RecordExists("SELECT * FROM PARAMS WHERE NAME='MESSAGE_ON_SITE'") and isclient("GSM_CORP") then
INSERT INTO PARAMS (NAME, DESCR, TYPE, VALUE)
  VALUES ('MESSAGE_ON_SITE', 'Сообщение при входе в ЛК', 'N', 'Коллектив компании ООО ''ДжиЭсЭм Корпорация''<br>сердечно поздравляет Вас C Новым годом и Рождеством! <br>Уверены, что в новом году Вас ждут интересные встречи,<br>исполнятся давние желания и появятся новые надежды!<br>     Крепкого Вам здоровья, удачи и мира, счастья и процветания!!!');
--#end if

--#if not RecordExists("SELECT * FROM PARAMS WHERE NAME='ROBOT_SITE_ADRESS'") then
INSERT INTO PARAMS (NAME, DESCR, TYPE, VALUE)
  VALUES ('ROBOT_SITE_ADRESS', 'Адрес робота по новому кабинету Билайн', 'N',  'http://194.190.8.163:443');
--#end if

--#if not RecordExists("SELECT * FROM PARAMS WHERE NAME='LOADER_LOG_DIR'") and (isclient("GSM_CORP") or isclient("CORP_MOBILE")) then
insert into params (name, value, type, descr)
values ('LOADER_LOG_DIR', '\\10.176.1.100\share\Tarifer', 'N','Директория для создания логов');
--#end if

--#if not RecordExists("SELECT * FROM PARAMS WHERE NAME='SMS_SYSTEM_ERROR_NOTICE_PHONES'") then
INSERT INTO PARAMS (NAME, DESCR, TYPE, VALUE)
  VALUES ('SMS_SYSTEM_ERROR_NOTICE_PHONE', 'Номера для смс-уведомлений об ошибках системы', 'N',  '9272087270;9277401866;');                      
--#end if

--#if not RecordExists("SELECT * FROM PARAMS WHERE NAME='SMS_SYSTEM_ERROR_NOTICE_TYPES'") then
INSERT INTO PARAMS (NAME, DESCR, TYPE, VALUE)
  VALUES ('SMS_SYSTEM_ERROR_NOTICE_TYPES', 'Типы уведомлений.HotBilling;ReportData;Payments;abonSTate', 'N',  'HB;RD;P;ST'); 
--#end if
                    
--#if not RecordExists("SELECT * FROM PARAMS WHERE NAME='CALC_ABON_BLOCK_COUNT_DAYS'") and isclient("CORP_MOBILE") then
INSERT INTO PARAMS (NAME, DESCR, TYPE, VALUE)
  VALUES ('CALC_ABON_BLOCK_COUNT_DAYS', 'Число дней учета аб.пл. после блока', 'N',  '1'); =======
--#end if

--#if not RecordExists("SELECT * FROM PARAMS WHERE NAME='SMTP_HOST'") and isclient("CORP_MOBILE") then
INSERT INTO PARAMS (NAME, DESCR, TYPE, VALUE)
  VALUES ('SMTP_HOST', 'Сервер SMTP', 'S',  'smtp.qip.ru'); 
--#end if

--#if not RecordExists("SELECT * FROM PARAMS WHERE NAME='SMTP_USERNAME'") and isclient("CORP_MOBILE") then
INSERT INTO PARAMS (NAME, DESCR, TYPE, VALUE)
  VALUES ('SMTP_USERNAME', 'Отправка почты - Пользователь', 'S',  'k7@fromru.com'); 
--#end if

--#if not RecordExists("SELECT * FROM PARAMS WHERE NAME='SMTP_PASSWORD'") and isclient("CORP_MOBILE") then
INSERT INTO PARAMS (NAME, DESCR, TYPE, VALUE)
  VALUES ('SMTP_PASSWORD', 'Отправка почты - Пароль', 'P',  'ct2OZW2l75kS'); 
--#end if

--#if not RecordExists("SELECT * FROM PARAMS WHERE NAME='SMTP_FROMTEXT'") and isclient("CORP_MOBILE") then
INSERT INTO PARAMS (NAME, DESCR, TYPE, VALUE)
  VALUES ('SMTP_FROMTEXT', 'Отправка почты - от кого', 'S',  'Агенство связи'); 
--#end if
  
--#if not RecordExists("SELECT * FROM PARAMS WHERE NAME='DAY_LOAD_BILLS_ERR'") and isclient("CORP_MOBILE") then
INSERT INTO PARAMS (NAME, DESCR, TYPE, VALUE)
  VALUES ('TELETIE_PAY_PASSWORD', 'Пароль для хеширования платежей', 'N',  '9osGetQSt2Q7'); 
--#end if

--#if not RecordExists("SELECT * FROM PARAMS WHERE NAME='MAIL_COST'") and isclient("CORP_MOBILE") then
INSERT INTO PARAMS (NAME, DESCR, TYPE, VALUE)
  VALUES ('MAIL_COST', 'Стоимость отправки почты за 1 день', 'N',  '3'); 
--#end if

--#if not RecordExists("SELECT * FROM PARAMS WHERE NAME='DB_DIR'") and isclient("CORP_MOBILE") then
INSERT INTO PARAMS (NAME, DESCR, TYPE, VALUE)
  VALUES ('DB_DIR', 'Папка с файлами звонков, платежей ит.п. ', B',  '\\10.176.1.100\share\Tarifer\DB\'); 
--#end if

--#if not RecordExists("SELECT * FROM PARAMS WHERE NAME='TEMPDB_DIR'") and isclient("CORP_MOBILE") then
INSERT INTO PARAMS (NAME, DESCR, TYPE, VALUE)
  VALUES ('TEMPDB_DIR', 'Директория для временного хранения файлов деталки из счёта', B',  'E:\temp\LOADCSV\TEMPDB'); 
--#end if

--#if not RecordExists("SELECT * FROM PARAMS WHERE NAME='PHONE_NOTICE_HOT_BILL_ERROR'") and isclient("CORP_MOBILE") then
INSERT INTO PARAMS (NAME, DESCR, TYPE, VALUE)
  VALUES ('PHONE_NOTICE_HOT_BILL_ERROR', 'Телефон отправки о неработоспособности гор. билинга', 'N',  '9623630138'); 
--#end if

--#if not RecordExists("SELECT * FROM PARAMS WHERE NAME='PHONE_NOTICE_TELETIE_ERROR'") and isclient("CORP_MOBILE") then
INSERT INTO PARAMS (NAME, DESCR, TYPE, VALUE)
  VALUES ('PHONE_NOTICE_TELETIE_ERROR', 'Телефон отправки о неработоспособности TELETIE', 'N',  '9623630138'); 
--#end if

--#if not RecordExists("SELECT * FROM PARAMS WHERE NAME='CALC_BALANCE_STREAM_COUNT'") and isclient("CORP_MOBILE") then
INSERT INTO PARAMS (NAME, DESCR, TYPE, VALUE)
  VALUES ('CALC_BALANCE_STREAM_COUNT', 'Число потоков пересчета текущего баланса', 'N',  '3'); 
--#end if

--#if not RecordExists("SELECT * FROM PARAMS WHERE NAME='TP_NOTIFY_GPRS'") and isclient("CORP_MOBILE") then
INSERT INTO PARAMS (NAME, DESCR, TYPE, VALUE)
  VALUES ('TP_NOTIFY_GPRS', 'ТП с оповещениями о платном GPRS', 'S',  '1040,799,819,1201,980,1200,1240,1241,383,404,405,406,407,408,409,410,436,437,538,539,880'); 
--#end if

--#if not RecordExists("SELECT * FROM PARAMS WHERE NAME='MES_NOTIFY_GPRS'") and isclient("CORP_MOBILE") then
INSERT INTO PARAMS (NAME, DESCR, TYPE, VALUE)
  VALUES ('MES_NOTIFY_GPRS', 'Сообщение о платном GPRS', 'S',  'ВНИМАНИЕ, платный интернет-трафик! Тарификация 0.5руб. - 9,95 руб./ 1мБайт. Во избежание расходов, отключите GPRS в настройках мобильного телефона, или подключите безлимитный интернет. Конт. телефон 84957378081'); 
--#end if

--#if not RecordExists("SELECT * FROM PARAMS WHERE NAME='TP_NOTIFY_GPRS_ISKL'") and isclient("CORP_MOBILE") then
INSERT INTO PARAMS (NAME, DESCR, TYPE, VALUE)
  VALUES ('TP_NOTIFY_GPRS_ISKL', 'Исключения для ТП с оповещениями о платном GPRS', 'S',  '383,404,405,406,407,408,409,410,436,437,538,539,880'); 
--#end if

--#if not RecordExists("SELECT * FROM PARAMS WHERE NAME='MES_NOTIFY_GPRS_ISKL'") and isclient("CORP_MOBILE") then
INSERT INTO PARAMS (NAME, DESCR, TYPE, VALUE)
  VALUES ('MES_NOTIFY_GPRS_ISKL', 'Сообщение о платном GPRS', 'S',  'ВНИМАНИЕ, платный интернет-трафик! Тарификация 0.5руб. - 9,95 руб./ 1мБайт. Во избежание расходов, отключите GPRS в настройках мобильного телефона, или подключите безлимитный интернет. Конт. телефон 84957378081'); 
--#end if

--#if not RecordExists("SELECT * FROM PARAMS WHERE NAME='SEND_SMS_CREATE_REQUEST'") and (isclient("CORP_MOBILE") or isclient("GSM_CORP")) then
INSERT INTO PARAMS (NAME, DESCR, TYPE, VALUE)
  VALUES ('SEND_SMS_CREATE_REQUEST', 'Отправлять ли смс при создании заявок.', 'N',  '1'); 
--#end if

--#if not RecordExists("SELECT * FROM PARAMS WHERE NAME='USERS_ADD_PAYMENT'") and isclient("GSM_CORP") then
INSERT INTO PARAMS (NAME, DESCR, TYPE, VALUE)
  VALUES ('USERS_ADD_PAYMENT', 'Пользователи, которым разрешено добавлять платежи', 'S',  'MATVEEVNS;ADMIN;TANYA'); 
--#end if

--ALTER TABLE CORP_MOBILE.PARAMS
--MODIFY(VALUE VARCHAR2(600 BYTE))

ALTER TABLE PARAMS MODIFY(NAME VARCHAR2(60)); 

--#if not RecordExists("SELECT * FROM PARAMS WHERE NAME='('BEELINE_BLOCK_CODE_FOR_BLOCK', '") and isclient("GSM_CORP") then
Insert into PARAMS (NAME, VALUE, TYPE, DESCR) Values ('BEELINE_BLOCK_CODE_FOR_BLOCK', 'WIB', 'S', 'Код блокировки по желанию (полная)');
--#end if

--#if not RecordExists("SELECT * FROM PARAMS WHERE NAME='('BEELINE_BLOCK_CODE_FOR_BLOCK_SAVE', '") and isclient("GSM_CORP") then
Insert into PARAMS (NAME, VALUE, TYPE, DESCR) Values ('BEELINE_BLOCK_CODE_FOR_BLOCK_SAVE', 'S1B', 'S', 'Код блокировки по сохранению(полная)');
--#end if

--#if not RecordExists("SELECT * FROM PARAMS WHERE NAME='('AVG_HOT_BIL_NFILES_PERCENT', '") and isclient("GSM_CORP") then
insert into PARAMS (NAME, VALUE, TYPE, DESCR) values  ('AVG_HOT_BIL_NFILES_PERCENT', 10, 'N',  'Отклонениме (в процентах) количества загруженных вфайлов от среднего за период');
--#end if

--#if not RecordExists("SELECT * FROM PARAMS WHERE NAME='('AVG_HOT_BIL_FILES_PER_HOUR', '") and isclient("GSM_CORP") then
insert into PARAMS (NAME, VALUE, TYPE, DESCR) values  ('AVG_HOT_BIL_FILES_PER_HOUR', 2, 'N',  'Среднее количество загружаемых файлов в час (для горячего биллинга)');
--#end if

--#if not RecordExists("SELECT * FROM PARAMS WHERE NAME='('AVG_HOT_BIL_FILES_PER_DAY', '") and isclient("GSM_CORP") then
insert into PARAMS (NAME, VALUE, TYPE, DESCR) values  ('AVG_HOT_BIL_FILES_PER_DAY', 50, 'N', 'Среднее количество загружаемых файлов в день (для горячего биллинга)');
--#end if

--#if not RecordExists("SELECT * FROM PARAMS WHERE NAME='('AVG_HOT_BIL_FILES_PER_WEEK', '") and isclient("GSM_CORP") then
insert into PARAMS (NAME, VALUE, TYPE, DESCR) values ('AVG_HOT_BIL_FILES_PER_WEEK', 300, 'N', 'Среднее количество загружаемых файлов в неделю (для горячего биллинга)');
--#end if

--#if not IndexExists("I_PARAMS_NAME_VALUE") then
CREATE UNIQUE INDEX I_PARAMS_NAME_VALUE ON PARAMS(NAME, VALUE);
--#end if

Insert into PARAMS   (NAME, VALUE, TYPE, DESCR)
 Values   ('GET_NEW_CONTRACTS_URL', 'http://tariffer.ditrade.ru/TariferActivation/?PASS_KEY=8c72f20eadcd960af2277612ef2e88be23f1e3122f49a6fa8987d25fcd1de77&DATE=CONTRACT_DATE', 'S', 'Ссылка для получения контрактов, активированных в определенную дату');

Insert into PARAMS
   (NAME, VALUE, TYPE, DESCR)
 Values
   ( 'MAIL_NEW_CONTRACTS_K7', 'denis@k7.ru', 'S', 'Почтовый ящик K7 для рассылки инфы о заведенных в автомате договорах');
Insert into PARAMS
   ( NAME, VALUE, TYPE, DESCR)
 Values
   ( 'MAIL_NEW_CONTRACTS_TELETIE', 'info@teletie.ru,start@teletie.ru,elvira_d@simtravel.ru,anastasya_k@simtravel.ru', 'S', 'Почтовый ящик TELETIE для рассылки инфы о заведенных в автомате договорах');

Insert into PARAMS   ( NAME, VALUE, TYPE, DESCR)
 Values
   ( 'MAIL_NEW_CONTRACTS_FIRST_LINE', 'Результат загрузки:<br>', 'S', 'Первая строка в  теле письма при заведении договоров в автомате');

Insert into PARAMS   ( NAME, VALUE, TYPE, DESCR)
 Values
  ('TARIFER_SUPPORT_MAIL', 'a.afrosin@tarifer.ru,i.matyunin@tarifer.ru,k.kraynov@tarifer.ru,a.alexeev@tarifer.ru', 'S', 'E-mail адреса сотрудников тех поддержки "тарифера"');


Insert into PARAMS
   (NAME, VALUE, TYPE, DESCR)
 Values
   ('MONTH_COUNT_AVG_SUM', '2', 'N', 'Количество месяцев за которое рассчитывается средний платеж для формы Инф.Абонента -> Платежи');
   
INSERT INTO PARAMS (NAME, VALUE, TYPE, DESCR) 
VALUES
('TEXT_ABON_FOR_INET_TARIFF', 
 'Следующее списание абонентской платы за %month_name% по вашему тарифу произойдет %new_date% в размере %abon_sum% руб. Пополните баланс заранее.', 
 'S', 
 'Предупреждение о необходимости пополнения счета, когда баланс меньше абонки'); 

Insert into PARAMS
   (NAME, VALUE, TYPE, DESCR)
 Values
   ('SIGNATURE_MAIL_ABOUT_DETAIL_K7', '*Предварительные начисления могут отличаться от детализации за закрытый биллинговый период.
*Это письмо было сформировано автоматически, отвечать на него не нужно.
*По всем вопросам обращаться e-mail: oao@k7.ru tel: +7 (495) 247-88-88', 'S', 'Строка подписи для письма с детализацией. Форма инф.по абонентую Владка "Детализация". Кнопка отправить по почте');

Insert into PARAMS
   (NAME, VALUE, TYPE, DESCR)
 Values
   ('SIGNATURE_MAIL_ABOUT_DETAIL_TELETIE', '*Предварительные начисления могут отличаться от детализации за закрытый биллинговый период.',
    'S', 'Строка подписи для письма с детализацией у TeleTie. Форма инф.по абонентую Владка "Детализация". Кнопка отправить по почте');

Insert into PARAMS
   (NAME, VALUE, TYPE, DESCR)
 Values
   ('MAIL_ERROR_TURN_TARIFF_OPTIONS', 'dzhunusova_e@teletie.moscow,koshuba_a@teletie.moscow,dzhenkova_a@teletie.moscow,pozdeeva_t@teletie.moscow,ms@sim-travel.ru,start@teletie.ru', 'S', 'Список Email адресов для рассылки ошибков о подключении отложенных опций');

INSERT INTO PARAMS (NAME, VALUE, TYPE, DESCR) 
VALUES ('TXT_SMS_4_PHONE_WITH_REPRIEVE_ABON', 'Баланс: %bal% руб., списана абон.плата по тарифу %tar% на сумму %abon_sum% руб. Во избежание блокировки необходимо пополнить баланс!', 'S', 'Текст смс для номеров с отсрочкой абонки (для номеров с тп с автоподкл. пакетов)');

INSERT INTO PARAMS (NAME, VALUE, TYPE, DESCR) 
VALUES ('CHECK_NEED_WORK_PROC_SEND_UNL_INTERNET', '1', 'B', 'Признак необходимости работы процедуры отправки смс о списание абон платы для номеров с безлимитным интернетом, у которых баланс меньше абонки');

INSERT INTO PARAMS (NAME, VALUE, TYPE, DESCR) 
VALUES ('CHECK_WORK_PROC_SEND_SMS_PHN_PEPR_ABON', '1', 'B', 'Признак необходимости работы процедуры отправки смс о списание абон платы для номеров с отсрочкой абонки');

INSERT INTO PARAMS (NAME, VALUE, TYPE, DESCR) 
VALUES ('DO_NOT_SEND_SMS_BLOCK_PHN_PEPR_ABON', '1', 'B', 'Не отправлять смс о блоке на номера с отсрочкой абонки');

COMMIT;

Insert into PARAMS    (NAME, VALUE, TYPE, DESCR)
 Values    ('CHANGE_PP_EMAIL', 'agsv@k7.ru', 'S', 'Еmail, на который отправляется письмо для смены тарифа вручную');

Insert into PARAMS  (NAME, VALUE, TYPE, DESCR)
 Values  ('CALL_CENTER_CONTACTS_STR', '+74952478888 ( 0577 с номеров Билайн бесплатно)', 'S', 'Номера телефонов для обращения к операторам CALL-центра');
 
Insert into PARAMS  (NAME, VALUE, TYPE, DESCR)
 Values  ('TEXT_SMS_ZERO_TRAFFIC_DRAVE_FIRST', 'Уважаемый Абонент! Вы израсходовали интернет-трафик, доступный на тарифе %tariff%. Скорость ограничена. Рекомендуем перейти на тариф с большим количеством интернета! Узнать остаток *132*12# и в личном кабинете lte.teletie.ru. Тел.: +74997090202. Телетай.', 'S', 'Текст 1 смс для номеров с тп "Драйв", которые израсходовали трафик в 0 (не для контактных номеров)');
 
Insert into PARAMS  (NAME, VALUE, TYPE, DESCR)
 Values  ('TEXT_SMS_ZERO_TRAFFIC_DRAVE_SECOND', 'Уважаемый Абонент! Вы израсходовали интернет-трафик, доступный на тарифе %tariff%. Скорость ограничена. Рекомендуем перейти на тариф с большим количеством интернета! Узнать остаток *132*12# и в личном кабинете lte.teletie.ru. Тел.: +74997090202. Телетай.', 'S', 'Текст 2 смс для номеров с тп "Драйв", которые израсходовали трафик в 0 (не для контактных номеров)');
 
Insert into PARAMS  (NAME, VALUE, TYPE, DESCR)
 Values  ('TEXT_SMS_PREV_FLOW_TRAFFIC_DRAVE_FIRST', 'Уважаемый Абонент! Сообщаем, что Вы израсходовали более 80% доступного интернет-трафика на тарифе %tariff%. У Вас осталось меньше %traf_volue% Гб. После окончания интернет-трафика скорость будет ограничена. Рекомендуем перейти на тариф с большим количеством интернета. Узнать остаток *132*12# и в личном кабинете lte.teletie.ru. Тел: +74997090202. Телетай.', 'S', 'Текст 1 смс для номеров с тп "Драйв", которые израсходовали трафик более чем на 80% (не для контактных номеров)');
 
Insert into PARAMS  (NAME, VALUE, TYPE, DESCR)
 Values  ('TEXT_SMS_PREV_FLOW_TRAFFIC_DRAVE_SECOND', 'Уважаемый Абонент! Сообщаем, что Вы израсходовали более 80% доступного интернет-трафика на тарифе %tariff%. У Вас осталось меньше %traf_volue% Гб. После окончания интернет-трафика скорость будет ограничена. Рекомендуем перейти на тариф с большим количеством интернета. Узнать остаток *132*12# и в личном кабинете lte.teletie.ru. Тел: +74997090202. Телетай.', 'S', 'Текст 2 смс для номеров с тп "Драйв", которые израсходовали трафик более чем на 80% (не для контактных номеров)');

Insert into PARAMS   (NAME, VALUE, TYPE, DESCR)
 Values   ('MAIL_BLOCK_ON_SAVE', 'agsv@k7.ru', 'S', 'Почтовые ящики, на которые отправляются оповещения при блокировке номеров');
 
INSERT INTO PARAMS (NAME, VALUE, TYPE, DESCR) 
VALUES ('CALC_ABON_TP_UNLIM_ON_4_OLD_PHN', '1', 'B', 'Признак работы алгоритма по отсрочке абонки для номеров со старыми контратками (т.е. контрактами, у которых идет 2 и более месяц существования контракта)');

INSERT INTO PARAMS (NAME, VALUE, TYPE, DESCR) 
VALUES ('DAY_BLOCK_PHN_CALC_ABON_TP_UNLIM_NEW_PHN', '3', 'N', 'День блокировки номеров с отсрочкой абонки (для новых номеров)');

INSERT INTO PARAMS (NAME, VALUE, TYPE, DESCR) 
VALUES ('DAY_BLOCK_PHN_CALC_ABON_TP_UNLIM_OLD_PHN', '3', 'N', 'День блокировки номеров с отсрочкой абонки (для старых номеров)');
  
Insert into PARAMS  (NAME, VALUE, TYPE, DESCR)
 Values  ('TEXT_SMS_ZERO_TRAFFIC_ALL_PHONE', 'Уважаемый Абонент! Вы израсходовали интернет-трафик, доступный на пакете %tariff%. Узнать остаток *132*12# и в личном кабинете lte.teletie.ru. Тел.: +74997090202. Телетай.', 'S', 'Текст смс при расходе трафика на пакетах в 0');

Insert into PARAMS  (NAME, VALUE, TYPE, DESCR)
 Values  ('TEXT_SMS_PREV_FLOW_TRAFFIC_ALL_PHONE', 'Уважаемый Абонент! Сообщаем, что Вы израсходовали более 80% доступного трафика на пакете %tariff%. У Вас осталось меньше %traf_volue% Гб. Узнать остаток *132*12# и в личном кабинете lte.teletie.ru. Тел: +74997090202. Телетай.', 'S', 'Текст смс при расходе трафика на пакете более чем на 80%');

COMMIT;