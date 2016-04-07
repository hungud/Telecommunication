CREATE TABLE GPRS_STAT
(
  STAT_ID          NUMBER(38),
  PHONE            VARCHAR2(10 CHAR),
  TARIFF_CODE      VARCHAR2(30 CHAR),
  INITVALUE        NUMBER(18),
  CURRVALUE        NUMBER(18),
  CURR_CHECK_DATE  TIMESTAMP(6),
  NEXT_CHECK_DATE  TIMESTAMP(6),
  CTRL_PNT         NUMBER(12)                   DEFAULT 0,
  IS_CHECKED       NUMBER(12)                   DEFAULT 0
)
TABLESPACE USERS
RESULT_CACHE (MODE DEFAULT)
PCTUSED    0
PCTFREE    10
INITRANS   1
MAXTRANS   255
STORAGE    (
            INITIAL          64K
            NEXT             1M
            MAXSIZE          UNLIMITED
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
            FLASH_CACHE      DEFAULT
            CELL_FLASH_CACHE DEFAULT
           )
LOGGING 
NOCOMPRESS 
NOCACHE
NOPARALLEL
MONITORING;
/
ALTER TABLE GPRS_STAT ADD (
  CONSTRAINT PK_GPRS_STAT
 PRIMARY KEY
 (STAT_ID));
/
CREATE SEQUENCE GPRS_STAT_ID
  START WITH 201
  MAXVALUE 9999999999999999999999999999
  MINVALUE 1
  NOCYCLE
  CACHE 20
  NOORDER;
/
CREATE OR REPLACE FUNCTION NEW_GPRS_STAT_ID RETURN NUMBER IS
--#Version=1
  vRES NUMBER;
BEGIN
  SELECT GPRS_STAT_ID.NEXTVAL
  INTO vRES
  FROM DUAL;
  RETURN vRES;
END;
/
COMMENT ON TABLE GPRS_STAT 										IS 'Статистики по номерам абонентов для отслеживания текущих объёмов остатка INTERNET, выбора подходящего пакета доп.трафика и переключения на него';

COMMENT ON COLUMN GPRS_STAT.STAT_ID 					IS 'Первичный ключ';

COMMENT ON COLUMN GPRS_STAT.PHONE 						IS 'Номер телефона';

COMMENT ON COLUMN GPRS_STAT.TARIFF_CODE 			IS 'Код тарифа';

COMMENT ON COLUMN GPRS_STAT.INITVALUE 				IS 'Объём трафика при инициализации пакета';

COMMENT ON COLUMN GPRS_STAT.CURRVALUE 				IS 'Текущий доступный трафик';

COMMENT ON COLUMN GPRS_STAT.CURR_CHECK_DATE 	IS 'Дата-время текущей проверки';

COMMENT ON COLUMN GPRS_STAT.NEXT_CHECK_DATE 	IS 'Дата-время следующей проверки';

COMMENT ON COLUMN GPRS_STAT.CTRL_PNT					IS 'Метка опорной точки, по опорным точкам строится прогноз времени следующей проверки и вычисляется подходящий пакет для подключения';

COMMENT ON COLUMN GPRS_STAT.IS_CHECKED 				IS 'Метка обработки записи';
/


alter table GPRS_STAT add (TURN_LOG_ID number(28) default 0);

COMMENT ON COLUMN GPRS_STAT.TURN_LOG_ID IS 'Ид. записи в логе переключений GPRS_TURN_LOG';

GRANT SELECT ON GPRS_STAT TO CORP_MOBILE_ROLE;

GRANT SELECT ON GPRS_STAT TO CORP_MOBILE_ROLE_RO;

CREATE INDEX I_GPRS_STAT_PHONE ON GPRS_STAT(PHONE)
COMPRESS 1;
