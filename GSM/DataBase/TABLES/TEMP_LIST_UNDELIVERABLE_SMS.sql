CREATE GLOBAL TEMPORARY TABLE TEMP_LIST_UNDELIVERABLE_SMS
(
  LIST_PHONE_SMS_ID  INTEGER,
  PHONE_NUMBER       VARCHAR2(10 CHAR),
  STATUS_SMS         VARCHAR2(200 BYTE),
  SLERROR            VARCHAR2(500 BYTE),
  DATE_INSERT        DATE
)
ON COMMIT PRESERVE ROWS
NOCACHE;

COMMENT ON TABLE TEMP_LIST_UNDELIVERABLE_SMS IS 'Временная таьлица со списком номеров, по которым имеются недоставленные смс';

COMMENT ON COLUMN TEMP_LIST_UNDELIVERABLE_SMS.LIST_PHONE_SMS_ID IS 'Уникальный код';

COMMENT ON COLUMN TEMP_LIST_UNDELIVERABLE_SMS.PHONE_NUMBER IS 'Номер';

COMMENT ON COLUMN TEMP_LIST_UNDELIVERABLE_SMS.STATUS_SMS IS 'Статус смс';

COMMENT ON COLUMN TEMP_LIST_UNDELIVERABLE_SMS.SLERROR IS 'Ошибка';

COMMENT ON COLUMN TEMP_LIST_UNDELIVERABLE_SMS.DATE_INSERT IS 'Дата вставки';