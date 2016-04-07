--#if not ObjectExists("S_NEW_PAYKEEPER_PAYMENT_ID")
CREATE SEQUENCE S_NEW_PAYKEEPER_PAYMENT_ID;
--#end if

--#if not TableExists("PAYKEEPER_PAYMENT_LOG") then
CREATE TABLE PAYKEEPER_PAYMENT_LOG
(
  PAYKEEPER_PAYMENT_ID  INTEGER CONSTRAINT PK_PAYKEEPER_PAYMENT_LOG PRIMARY KEY,   --  Первичный ключ ID
  PAYKEEPER_ID VARCHAR2 (50 CHAR), 
  PAY_SUM      VARCHAR2 (50 CHAR), --  Сумма платежа в рублях с точностью до сотых. Разделитель – точка   
  CLIENT_ID VARCHAR2(10 CHAR), -- Идентификатор клиента. Тот же, что при генерации формы оплаты   
  ORDER_ID  VARCHAR2(20 CHAR) DEFAULT NULL, -- Номер заказа. Не обязателен   
  KEY_HASH  VARCHAR2(50 CHAR),  -- Цифровая подпись запроса, строка из символов a-f и 0-9   
  USER_CREATED  VARCHAR2(30 CHAR),
  DATE_CREATED  DATE,
  USER_LAST_UPDATED  VARCHAR2(30 CHAR),
  DATE_LAST_UPDATED  DATE
);
--#end if

--#if GetTableComment("PAYKEEPER_PAYMENT")<>"Таблица" then
COMMENT ON TABLE PAYKEEPER_PAYMENT_LOG IS 'Лог всех запросов с платежами пришедших из платежной системы PayKeeper';
--#end if

--#if GetColumnComment("PAYKEEPER_PAYMENT_LOG.PAYKEEPER_PAYMENT_ID") <> "Первичный ключ ID" then
COMMENT ON COLUMN PAYKEEPER_PAYMENT_LOG.PAYKEEPER_PAYMENT_ID IS 'Первичный ключ ID';
--#end if

--#if GetColumnComment("PAYKEEPER_PAYMENT_LOG.PAYKEEPER_ID") <> "Первичный ключ ID Уникальный, никогда не повторяющийся номер платежа в PayKeeper" then
COMMENT ON COLUMN PAYKEEPER_PAYMENT_LOG.PAYKEEPER_ID IS 'Уникальный, никогда не повторяющийся номер платежа в PayKeeper';
--#end if

--#if GetColumnComment("PAYKEEPER_PAYMENT_LOG.PAY_SUM") <> "Сумма платежа в рублях с точностью до сотых. Разделитель – точка" then
COMMENT ON COLUMN PAYKEEPER_PAYMENT_LOG.PAY_SUM IS 'Сумма платежа в рублях с точностью до сотых. Разделитель – точка';
--#end if
                 
--#if GetColumnComment("PAYKEEPER_PAYMENT_LOG.CLIENT_ID") <> "Идентификатор клиента. Тот же, что при генерации формы оплаты" then
COMMENT ON COLUMN PAYKEEPER_PAYMENT_LOG.CLIENT_ID IS 'Идентификатор клиента. Тот же, что при генерации формы оплаты. В нашем случае - Номер телефона.';
--#end if
      
--#if GetColumnComment("PAYKEEPER_PAYMENT_LOG.ORDER_ID") <> "Номер заказа. Не обязателен" then
COMMENT ON COLUMN PAYKEEPER_PAYMENT_LOG.ORDER_ID IS 'Номер заказа. Не обязателен';
--#end if

--#if GetColumnComment("PAYKEEPER_PAYMENT_LOG.KEY_HASH") <> "Цифровая подпись запроса, строка из символов a-f и 0-9" then
COMMENT ON COLUMN PAYKEEPER_PAYMENT_LOG.KEY_HASH IS 'Цифровая подпись запроса, строка из символов a-f и 0-9';
--#end if

--#if not IndexExists("I_PAYKEEPER_PAYMENT_LOG_CLIENT_ID") THEN
CREATE INDEX I_PAYKEEPER_PAYMENT_LOG_NAME ON PAYKEEPER_PAYMENT_LOG(CLIENT_ID);
--#end if

--#IF GetVersion("TIU_PAYKEEPER_PAYMENT_LOG") < 1 THEN
CREATE OR REPLACE TRIGGER TIU_PAYKEEPER_PAYMENTs 
  BEFORE INSERT OR UPDATE ON PAYKEEPER_PAYMENT_LOG FOR EACH ROW 
--#Version=1
BEGIN 
  IF INSERTING THEN 
    IF NVL(:NEW.PAYKEEPER_PAYMENT_ID, 0) = 0 then 
      :NEW.PAYKEEPER_PAYMENT_ID := S_NEW_PAYKEEPER_PAYMENT_ID.NEXTVAL; 
    END IF; 
    :NEW.USER_CREATED := USER; 
    :NEW.DATE_CREATED := SYSDATE;
  END IF; 
  :NEW.USER_LAST_UPDATED := USER; 
  :NEW.DATE_LAST_UPDATED := SYSDATE; 
END;
--#end if

GRANT SELECT, INSERT, UPDATE, DELETE on PAYKEEPER_PAYMENT_LOG TO WWW_DEALER;

GRANT SELECT, INSERT, UPDATE, DELETE on PAYKEEPER_PAYMENT_LOG TO LONTANA_ROLE;

GRANT SELECT on PAYKEEPER_PAYMENT_LOG TO LONTANA_ROLE_RO;

