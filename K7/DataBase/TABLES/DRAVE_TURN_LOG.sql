CREATE TABLE DRAVE_TURN_LOG
(
  DRAVE_LOG_ID             NUMBER(38),
  PHONE                    VARCHAR2(10 CHAR),
  TARIFF_CODE              VARCHAR2(30 CHAR),
  DATE_ON                  TIMESTAMP(6),
  DATE_OFF                 TIMESTAMP(6),
  LIMIT_SPEED              NUMBER(38)           DEFAULT 0,
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

COMMENT ON TABLE DRAVE_TURN_LOG IS 'История тарифов драйв на номер абонента';

COMMENT ON COLUMN DRAVE_TURN_LOG.IS_SEND_SMS_ZERO_SECOND IS 'Признак отправки смс о расходовании трафика в 0 и вкл. ограничении скорости после 23 числа (1 - отправлялось, 0 - не отправлялось)';

COMMENT ON COLUMN DRAVE_TURN_LOG.IS_SEND_SMS_PREV_FIRST IS 'Признак отправки смс об израсходовании 80 % трафика до 23 числа (1 - отправлялось, 0 - не отправлялось)';

COMMENT ON COLUMN DRAVE_TURN_LOG.IS_SEND_SMS_PREV_SECOND IS 'Признак отправки смс об израсходовании 80 % трафика после 23 числа (1 - отправлялось, 0 - не отправлялось)';

COMMENT ON COLUMN DRAVE_TURN_LOG.PREDVALUE IS 'Объем прогнозируемого трафика';

COMMENT ON COLUMN DRAVE_TURN_LOG.DRAVE_LOG_ID IS 'Первичный ключ';

COMMENT ON COLUMN DRAVE_TURN_LOG.PHONE IS 'Номер телефона';

COMMENT ON COLUMN DRAVE_TURN_LOG.TARIFF_CODE IS 'Код тарифа';

COMMENT ON COLUMN DRAVE_TURN_LOG.DATE_ON IS 'Дата подключения';

COMMENT ON COLUMN DRAVE_TURN_LOG.DATE_OFF IS 'Дата отключения';

COMMENT ON COLUMN DRAVE_TURN_LOG.LIMIT_SPEED IS 'Признак включения ограничения скорости (1 - включено, 0 - выключенно)';

COMMENT ON COLUMN DRAVE_TURN_LOG.IS_SEND_SMS_ZERO_FIRST IS 'Признак отправки смс о расходовании трафика в 0 и вкл. ограничении скорости до 23 числа (1 - отправлялось, 0 - не отправлялось)';


CREATE UNIQUE INDEX PK_DRAVE_TURN_LOG ON DRAVE_TURN_LOG
(DRAVE_LOG_ID)
LOGGING
TABLESPACE USERS
PCTFREE    10
INITRANS   2
MAXTRANS   255
STORAGE    (
            INITIAL          64K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           )
NOPARALLEL;

ALTER TABLE DRAVE_TURN_LOG ADD (
  CONSTRAINT PK_DRAVE_TURN_LOG
  PRIMARY KEY
  (DRAVE_LOG_ID)
  USING INDEX PK_DRAVE_TURN_LOG);

GRANT SELECT ON DRAVE_TURN_LOG TO CORP_MOBILE_ROLE;

GRANT SELECT ON DRAVE_TURN_LOG TO CORP_MOBILE_ROLE_RO;

create index i_drave_turn_log_phone on drave_turn_log(phone);