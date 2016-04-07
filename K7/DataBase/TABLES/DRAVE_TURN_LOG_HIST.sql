CREATE TABLE DRAVE_TURN_LOG_HIST
(
  DRAVE_LOG_ID             NUMBER(38),
  PHONE                    VARCHAR2(10 CHAR),
  TARIFF_CODE              VARCHAR2(30 CHAR),
  DATE_ON                  TIMESTAMP(6),
  DATE_OFF                 TIMESTAMP(6),
  LIMIT_SPEED              INTEGER              DEFAULT 0,
  IS_SEND_SMS_ZERO_FIRST   NUMBER(38)           DEFAULT 0,
  IS_SEND_SMS_ZERO_SECOND  NUMBER(38)           DEFAULT 0,
  IS_SEND_SMS_PREV_FIRST   NUMBER(38)           DEFAULT 0,
  IS_SEND_SMS_PREV_SECOND  NUMBER(38)           DEFAULT 0,
  PREDVALUE                NUMBER(18)
)
TABLESPACE USERS
PCTUSED    0
PCTFREE    10
INITRANS   1
MAXTRANS   255
STORAGE    (
            INITIAL          64K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           )
LOGGING 
NOCOMPRESS 
NOCACHE
NOPARALLEL
MONITORING;

COMMENT ON TABLE DRAVE_TURN_LOG_HIST IS 'Архив истории тарифов драйв на номер абонента';

COMMENT ON COLUMN DRAVE_TURN_LOG_HIST.IS_SEND_SMS_ZERO_SECOND IS 'Признак отправки смс о расходовании трафика в 0 и вкл. ограничении скорости после 23 числа (1 - отправлялось, 0 - не отправлялось)';

COMMENT ON COLUMN DRAVE_TURN_LOG_HIST.IS_SEND_SMS_PREV_FIRST IS 'Признак отправки смс об израсходовании 80 % трафика до 23 числа (1 - отправлялось, 0 - не отправлялось)';

COMMENT ON COLUMN DRAVE_TURN_LOG_HIST.IS_SEND_SMS_PREV_SECOND IS 'Признак отправки смс об израсходовании 80 % трафика после 23 числа (1 - отправлялось, 0 - не отправлялось)';

COMMENT ON COLUMN DRAVE_TURN_LOG_HIST.PREDVALUE IS 'Объем прогнозируемого трафика';

COMMENT ON COLUMN DRAVE_TURN_LOG_HIST.DRAVE_LOG_ID IS 'Первичный ключ';

COMMENT ON COLUMN DRAVE_TURN_LOG_HIST.PHONE IS 'Номер телефона';

COMMENT ON COLUMN DRAVE_TURN_LOG_HIST.TARIFF_CODE IS 'Код тарифа';

COMMENT ON COLUMN DRAVE_TURN_LOG_HIST.DATE_ON IS 'Дата подключения';

COMMENT ON COLUMN DRAVE_TURN_LOG_HIST.DATE_OFF IS 'Дата отключения';

COMMENT ON COLUMN DRAVE_TURN_LOG_HIST.LIMIT_SPEED IS 'Признак включения ограничения скорости (1 - включено, 0 - выключенно)';

COMMENT ON COLUMN DRAVE_TURN_LOG_HIST.IS_SEND_SMS_ZERO_FIRST IS 'Признак отправки смс о расходовании трафика в 0 и вкл. ограничении скорости до 23 числа (1 - отправлялось, 0 - не отправлялось)';