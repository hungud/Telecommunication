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

--#if not RecordExists("SELECT * FROM PARAMS WHERE NAME='('MONTH_OFFSET_MONITOR_OUTGOING_CALLS', '") and isclient("GSM_CORP") 
Insert into PARAMS
   ( NAME, VALUE, TYPE, DESCR)
 Values
   ( 'MONTH_OFFSET_MONITOR_OUTGOING_CALLS', '1', 'N', 'Смещение периода рассчета статистики исходящей связи для джоба J_CALC_CALL_SUMMARY_STAT');
--#end if
Insert into PARAMS
   (NAME, VALUE, TYPE, DESCR)
 Values
   ('MONITOR_OUT_GOING_CALLS', ';PASHKOVA;kulikova;sabrina;NARGIZA;', 'S', 'Имя пользователя должно быть заключено в ";".Список логинов(кроме администратора) для которых дотсупен Мониторинг->Монитор исхлдяжей связи.');

Insert into PARAMS
   (NAME, VALUE, TYPE, DESCR)
 Values
   ('TARIFF_NAME_NO_SHOW_VOICE', ';ULTRA VIP 1400(НОВ.);ПОЛНЫЙ БЕЗЛИМИТ (1300);', 'S', 'Список тарифов у которых не показываем интернет');

Insert into PARAMS
(NAME, VALUE, TYPE, DESCR)
Values
('EMAIL_ALARM_LOAD_LOGS', 'gsm-corp@bk.ru,aleksandrk@gsmcorporacia.ru', 'S', 'Список e-mail адресов для рассылки уведомлений о невозвожности входа в личный кабинета билайна');

Insert into PARAMS
(NAME, VALUE, TYPE, DESCR)
Values
('EMAIL_ALARM_TEMPLATE_SUBJECT', 'Ошибка при аворизации в личный кабинет', 'S', 'Шаблон темы письма при отправке уведомлений об ошибке');

Insert into PARAMS
(NAME, VALUE, TYPE, DESCR)
Values
('EMAIL_ALARM_TEMPLATE_BODY', 'Ошибка при входе в личный кабинет для счетов: %%% ', 'S', 'Шаблон письма при отправке уведомлений об ошибке');

Insert into PARAMS   ( NAME, VALUE, TYPE, DESCR)
 Values
  ('TARIFER_SUPPORT_MAIL', 'a.afrosin@tarifer.ru,i.matyunin@tarifer.ru,k.kraynov@tarifer.ru,a.alexeev@tarifer.ru,a.larin@tarifer.ru', 'S', 'E-mail адреса сотрудников тех поддержки "тарифера"');
  
Insert into PARAMS
   (NAME, VALUE, TYPE, DESCR)
 Values
   ('PAYKEEPER_COEFFICIENT', '1.05', 'S', 'Коэффициент пересчета платежа при зачислении в тарифер, пришедшего из PayKeeper (используется в акции)');  
   
Insert into PARAMS
   (NAME, VALUE, TYPE, DESCR)
 Values
   ('URL_DET_OPERATOR_BY_PHONE', 'http://api.tarifer.ru/api/v1/phone_numbers/%phone%/operator?app_id=931ac0dcb74920020214f8f4c23b023c', 'S', 'Ссылка определения оператора связи по номеру телефона'); 

Insert into PARAMS
   (NAME, VALUE, TYPE, DESCR)
 Values
   ('EMAIL_SEND_INFO_UNDELIVERABLE_SMS', 'gsm-corp@bk.ru', 'S', 'Список e-mail адресов для рассылки уведомлений о недоставленных смс');    

Insert into PARAMS(NAME, VALUE, TYPE, DESCR)
  Values('EMAIL_SEND_STAT_SMS_PREV_DAY', 'aleksandrk@gsmcorporacia.ru', 'S', 'Список e-mail адресов для рассылки уведомлений о статистике отправки смс');  

Insert into PARAMS(NAME, VALUE, TYPE, DESCR)
  Values('DAYS_FOR_UNLOCK_SAVE', '7', 'N', 'Кол-во дней, в течении которыз доступна разблокировка их сохранения.');  

Insert into PARAMS
   (NAME, TYPE, DESCR)
 Values
   ('USER_LAST_CRM_CHAT', 'N', 'Оператор, с которым диалог открывался последним!');

Insert into PARAMS
   (NAME, VALUE, TYPE, DESCR)
 Values
   ('URL_OPERATORS_MESS_NOTIFICATION', 'http://cc.gsmcorp.tarifer.ru/instant_messages/notify_operator?message_id=%mess_id%', 'S', 'Ссылка уведомления оператора о сообщении');

Insert into PARAMS
   (NAME, VALUE, TYPE, DESCR)
 Values
   ('EMAIL_SEND_INFO_NOT_OPER_CHAT', 'info@gsmcorporacia.ru', 'S', 'Список e-mail адресов для рассылки уведомлений об отсутствии операторов, которые могут работать с чатом, в сети'); 
   
Insert into PARAMS
   (NAME, VALUE, TYPE, DESCR)
 Values
   ('SHOW_SIGN_IS_NOT_BREAK_CHAT', '0', 'N', 'Признак показа функционала по удержанию чата у операторов'); 
   
Insert into PARAMS
   (NAME, VALUE, TYPE, DESCR)
 Values
   ('URL_CLOSE_OPERATORS_CHAT', 'http://cc.gsmcorp.tarifer.ru/instant_messages/close_dialog?operator_id=%oper_id%', 'S', 'Ссылка закрытия диалога у оператора');
   
Insert into PARAMS
   (NAME, TYPE, DESCR)
 Values
   ('USER_LAST_CRM_REQUEST_ACT_TARIFFS', 'S', 'Оператор, которым последним обрабатывал заявку на активацию номера с IVR!');
   
commit;