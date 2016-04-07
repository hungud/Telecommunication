CREATE TABLE LOG_SEND_MAIL_INFO_SMS
(
  YEAR_MONTH      INTEGER,
  DATE_CREATED    DATE,
  MESSAGE_TITLE   VARCHAR2(200 CHAR),
  MAIL_TEXT       CLOB,
  MAIL_RECIPIENT  VARCHAR2(100 CHAR),
  ERROR_TEXT      VARCHAR2(2000 CHAR)
)
LOB (MAIL_TEXT) STORE AS (
  TABLESPACE USERS
  ENABLE       STORAGE IN ROW
  CHUNK       8192
  RETENTION
  NOCACHE
  LOGGING
  INDEX       (
        TABLESPACE USERS
        STORAGE    (
                    INITIAL          64K
                    NEXT             1M
                    MINEXTENTS       1
                    MAXEXTENTS       UNLIMITED
                    PCTINCREASE      0
                    BUFFER_POOL      DEFAULT
                   ))
      STORAGE    (
                  INITIAL          64K
                  NEXT             1M
                  MINEXTENTS       1
                  MAXEXTENTS       UNLIMITED
                  PCTINCREASE      0
                  BUFFER_POOL      DEFAULT
                 ))
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

COMMENT ON TABLE LOG_SEND_MAIL_INFO_SMS IS 'Лог отправленных email с информацией о смс';

COMMENT ON COLUMN LOG_SEND_MAIL_INFO_SMS.YEAR_MONTH IS 'ДАТА И МЕСЯЦ';

COMMENT ON COLUMN LOG_SEND_MAIL_INFO_SMS.DATE_CREATED IS 'ДАТА СОЗДАНИЯ';

COMMENT ON COLUMN LOG_SEND_MAIL_INFO_SMS.MESSAGE_TITLE IS 'ТЕМА ПИСЬМА';

COMMENT ON COLUMN LOG_SEND_MAIL_INFO_SMS.MAIL_TEXT IS 'ТЕЛО ПИСЬМА';

COMMENT ON COLUMN LOG_SEND_MAIL_INFO_SMS.MAIL_RECIPIENT IS 'ПОЛУЧАТЕЛИ ПИСЬМА';

COMMENT ON COLUMN LOG_SEND_MAIL_INFO_SMS.ERROR_TEXT IS 'ТЕКСТ ОШИБКИ';