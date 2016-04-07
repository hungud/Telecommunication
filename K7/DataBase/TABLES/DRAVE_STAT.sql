CREATE TABLE DRAVE_STAT
(
  DRAVE_STAT_ID       INTEGER,
  PHONE                      VARCHAR2(10 CHAR),
  TARIFF_CODE           VARCHAR2(30 CHAR),
  INITVALUE                NUMBER(18),
  CURRVALUE              NUMBER(18),
  CURR_CHECK_DATE  TIMESTAMP(6),
  NEXT_CHECK_DATE  TIMESTAMP(6),
  CTRL_PNT                NUMBER(12)                   DEFAULT 0,
  IS_CHECKED             NUMBER(12)                   DEFAULT 0,
  DRAVE_TURN_LOG_ID  NUMBER(28)                   DEFAULT 0
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

COMMENT ON TABLE DRAVE_STAT IS 'Статистики по номерам абонентов с тарифами драйв для отслеживания текущих объёмов остатка INTERNET';

COMMENT ON COLUMN DRAVE_STAT.DRAVE_STAT_ID IS 'Первичный ключ';

COMMENT ON COLUMN DRAVE_STAT.PHONE IS 'Номер телефона';

COMMENT ON COLUMN DRAVE_STAT.TARIFF_CODE IS 'Код тарифа';

COMMENT ON COLUMN DRAVE_STAT.INITVALUE IS 'Объём трафика при инициализации';

COMMENT ON COLUMN DRAVE_STAT.CURRVALUE IS 'Текущий доступный трафик';

COMMENT ON COLUMN DRAVE_STAT.CURR_CHECK_DATE IS 'Дата-время текущей проверки';

COMMENT ON COLUMN DRAVE_STAT.NEXT_CHECK_DATE IS 'Дата-время следующей проверки';

COMMENT ON COLUMN DRAVE_STAT.CTRL_PNT IS 'Метка опорной точки, по опорным точкам строится прогноз времени следующей проверки';

COMMENT ON COLUMN DRAVE_STAT.IS_CHECKED IS 'Метка обработки записи';

COMMENT ON COLUMN DRAVE_STAT.DRAVE_TURN_LOG_ID IS 'Ид. записи в логе DRAVE_TURN_LOG';


CREATE UNIQUE INDEX PK_DRAVE_STAT ON DRAVE_STAT
(DRAVE_STAT_ID)
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

ALTER TABLE DRAVE_STAT ADD (
  CONSTRAINT PK_DRAVE_STAT
  PRIMARY KEY
  (DRAVE_STAT_ID)
  USING INDEX PK_DRAVE_STAT);

GRANT SELECT ON DRAVE_STAT TO CORP_MOBILE_ROLE;

GRANT SELECT ON DRAVE_STAT TO CORP_MOBILE_ROLE_RO;

create index i_drave_stat_phone on drave_stat(phone)
compress 1;