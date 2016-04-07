CREATE TABLE DRAVE_STAT_HIST
(
  DRAVE_STAT_ID          INTEGER,
  PHONE            VARCHAR2(10 CHAR),
  TARIFF_CODE      VARCHAR2(30 CHAR),
  INITVALUE        NUMBER(18),
  CURRVALUE        NUMBER(18),
  CURR_CHECK_DATE  TIMESTAMP(6),
  NEXT_CHECK_DATE  TIMESTAMP(6),
  CTRL_PNT         NUMBER(12)                   DEFAULT 0,
  IS_CHECKED       NUMBER(12)                   DEFAULT 0,
  DRAVE_TURN_LOG_ID      NUMBER(28)      DEFAULT 0
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

COMMENT ON TABLE DRAVE_STAT_HIST IS 'Архив статистик по номерам абонентов с тарифами драйв для отслеживания текущих объёмов остатка INTERNET';

COMMENT ON COLUMN DRAVE_STAT_HIST.DRAVE_STAT_ID IS 'Первичный ключ';

COMMENT ON COLUMN DRAVE_STAT_HIST.PHONE IS 'Номер телефона';

COMMENT ON COLUMN DRAVE_STAT_HIST.TARIFF_CODE IS 'Код тарифа';

COMMENT ON COLUMN DRAVE_STAT_HIST.INITVALUE IS 'Объём трафика при инициализации';

COMMENT ON COLUMN DRAVE_STAT_HIST.CURRVALUE IS 'Текущий доступный трафик';

COMMENT ON COLUMN DRAVE_STAT_HIST.CURR_CHECK_DATE IS 'Дата-время текущей проверки';

COMMENT ON COLUMN DRAVE_STAT_HIST.NEXT_CHECK_DATE IS 'Дата-время следующей проверки';

COMMENT ON COLUMN DRAVE_STAT_HIST.CTRL_PNT IS 'Метка опорной точки, по опорным точкам строится прогноз времени следующей проверки';

COMMENT ON COLUMN DRAVE_STAT_HIST.IS_CHECKED IS 'Метка обработки записи';

COMMENT ON COLUMN DRAVE_STAT_HIST.DRAVE_TURN_LOG_ID IS 'Ид. записи в логе DRAVE_TURN_LOG';