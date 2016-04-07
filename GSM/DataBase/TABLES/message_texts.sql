create table MESSAGE_TEXTS
(
  TEXT_BLOCK_SMS   VARCHAR2(140 CHAR),
  TEXT_NOTIFY_SMS  VARCHAR2(160 CHAR),
  TEXT_NOTIFY_SMS2 VARCHAR2(200 CHAR)
)

comment on table MESSAGE_TEXTS is 'Таблица текстов сообщений';
comment on column MESSAGE_TEXTS.TEXT_BLOCK_SMS   is 'Текст блокирующей смс';
comment on column MESSAGE_TEXTS.TEXT_NOTIFY_SMS  is 'Текст предупреждающей смс';
comment on column MESSAGE_TEXTS.TEXT_NOTIFY_SMS2 is 'Текст предупреждающей смс 2';

UPDATE message_texts SET text_block_sms='Ваш баланс %balance% руб. Ваш номер заблокирован. т.788-79-08.';
UPDATE message_texts SET text_notify_sms='Ваш баланс близок к отключению услуг. т.788-79-08.';
UPDATE message_texts SET text_notify_sms2='Баланс Вашего счета %balance% Во избежание блокировки пополните счет. Проверка баланса *132*11# вызов. Абонентский отдел +74957378081';


--#if not ColumnExists("MESSAGE_TEXTS.TEXT_NOTIFY_SMS_HAND_BLOCK")
ALTER TABLE MESSAGE_TEXTS ADD TEXT_NOTIFY_SMS_HAND_BLOCK VARCHAR2(200 CHAR);
COMMENT ON COLUMN MESSAGE_TEXTS.TEXT_NOTIFY_SMS_HAND_BLOCK IS 'Текст предупреждающей смс при наличии у номера ручной блокировки л/с номера - Коммерс и Телетай коллекторов';
--#end if

--#if not ColumnExists("MESSAGE_TEXTS.TEXT_NOTIFY_SMS_HAND_BLOCK_4_PITER")
ALTER TABLE MESSAGE_TEXTS ADD TEXT_NOTIFY_SMS_HAND_BLOCK_4_PITER VARCHAR2(200 CHAR);
COMMENT ON COLUMN MESSAGE_TEXTS.TEXT_NOTIFY_SMS_HAND_BLOCK_4_PITER IS 'Текст предупреждающей смс при наличии у номера ручной блокировки л/с Коллекторов Питер';
--#end if