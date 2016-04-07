--#if not ObjectExists("S_NEW_ROAMING_RETARIF_PHONE_ID")
CREATE SEQUENCE S_NEW_ROAMING_RETARIF_PHONE_ID;
--#end if

--#if not TableExists("ROAMING_RETARIF_PHONES") then
CREATE TABLE ROAMING_RETARIF_PHONES
(
  ID                INTEGER    CONSTRAINT PK_ROAMING_RETARIF_PHONES PRIMARY KEY,
  PHONE_NUMBER      VARCHAR2(11 CHAR) NOT NULL,
  OPTION_CODE       VARCHAR2(100)     NOT NULL,
  BEGIN_DATE_TIME   DATE              NOT NULL,
  SERVICE_ON_TICKET_ID VARCHAR2(20),
  END_DATE_TIME     DATE,
  SERVICE_OFF_TICKET_ID VARCHAR2(20),
  SERVICE_OFF_CONFIRMED_DATETIME DATE,
  SERVICE_OFF_ERROR_MESSAGE VARCHAR2(1000),
  USER_CREATED      VARCHAR2(30 CHAR),
  DATE_CREATED      DATE,
  USER_LAST_UPDATED VARCHAR2(30 CHAR),
  DATE_LAST_UPDATED DATE
);
--#end if

--#if GetTableComment("ROAMING_RETARIF_PHONES")<>"Номера с ретарификацией в роуминге" then
COMMENT ON TABLE ROAMING_RETARIF_PHONES IS 'Номера с ретарификацией в роуминге';
--#end if

--#if GetColumnComment("ROAMING_RETARIF_PHONES.ID") <> "Первичный ключ" then
COMMENT ON COLUMN ROAMING_RETARIF_PHONES.ID IS 'Первичный ключ';
--#end if

--#if GetColumnComment("ROAMING_RETARIF_PHONES.PHONE_NUMBER") <> "Номер телефона" then
COMMENT ON COLUMN ROAMING_RETARIF_PHONES.PHONE_NUMBER IS 'Номер телефона';
--#end if

--#if GetColumnComment("ROAMING_RETARIF_PHONES.SERVICE_ON_TICKET_ID") <> "Код заявки на подключение услуги" then
COMMENT ON COLUMN ROAMING_RETARIF_PHONES.SERVICE_ON_TICKET_ID IS 'Код заявки на подключение услуги';
--#end if

--#if GetColumnComment("ROAMING_RETARIF_PHONES.OPTION_CODE") <> "Код опции" then
COMMENT ON COLUMN ROAMING_RETARIF_PHONES.OPTION_CODE IS 'Код опции';
--#end if

--#if GetColumnComment("ROAMING_RETARIF_PHONES.BEGIN_DATE_TIME") <> "Дата/время начала перетарификации" then
COMMENT ON COLUMN ROAMING_RETARIF_PHONES.BEGIN_DATE_TIME IS 'Дата/время начала перетарификации';
--#end if

--#if GetColumnComment("ROAMING_RETARIF_PHONES.END_DATE_TIME") <> "Дата/время окончания перетарификации" then
COMMENT ON COLUMN ROAMING_RETARIF_PHONES.END_DATE_TIME IS 'Дата/время окончания перетарификации';
--#end if

--#if GetColumnComment("ROAMING_RETARIF_PHONES.SERVICE_OFF_TICKET_ID") <> "Код заявки на отключение услуги" then
COMMENT ON COLUMN ROAMING_RETARIF_PHONES.SERVICE_OFF_TICKET_ID IS 'Код заявки на отключение услуги';
--#end if

--#if GetColumnComment("ROAMING_RETARIF_PHONES.SERVICE_OFF_ERROR_MESSAGE") <> "Текст ошибки отправки заявки на отключение услуги" then
COMMENT ON COLUMN ROAMING_RETARIF_PHONES.SERVICE_OFF_ERROR_MESSAGE IS 'Текст ошибки отправки заявки на отключение услуги';
--#end if

--#if GetColumnComment("ROAMING_RETARIF_PHONES.SERVICE_OFF_CONFIRMED_DATETIME") <> "Дата/время подтверждения отключения услуги-скидки (заполняется триггером)" then
COMMENT ON COLUMN ROAMING_RETARIF_PHONES.SERVICE_OFF_CONFIRMED_DATETIME IS 'Дата/время подтверждения отключения услуги-скидки (заполняется триггером)';
--#end if

--#if not ColumnExists("ROAMING_RETARIF_PHONES.ROAMING_RETARIF_METHOD") then
ALTER TABLE ROAMING_RETARIF_PHONES ADD ROAMING_RETARIF_METHOD NUMBER(1);
COMMENT ON COLUMN ROAMING_RETARIF_PHONES.ROAMING_RETARIF_METHOD IS 'Способ перетарификации: 1 - увеличить сумму для абонента, 2 - не менять стоимость услуг для абонента.';
--#end if

--#if not IndexExists("UQ_ROAMING_RETARIF_PHONES_PH_B") THEN
CREATE UNIQUE INDEX UQ_ROAMING_RETARIF_PHONES_PH_B ON ROAMING_RETARIF_PHONES (PHONE_NUMBER, BEGIN_DATE_TIME);
--#end if

--#IF GetVersion("TIU_ROAMING_RETARIF_PHONES") < 1 THEN
CREATE OR REPLACE TRIGGER TIU_ROAMING_RETARIF_PHONES 
  BEFORE INSERT OR UPDATE ON ROAMING_RETARIF_PHONES FOR EACH ROW 
--#Version=1
BEGIN 
  IF INSERTING THEN 
    IF NVL(:NEW.ID, 0) = 0 then 
      :NEW.ID := S_NEW_ROAMING_RETARIF_PHONE_ID.NEXTVAL; 
    END IF; 
    :NEW.USER_CREATED := USER; 
    :NEW.DATE_CREATED := SYSDATE;
  END IF; 
  :NEW.USER_LAST_UPDATED := USER; 
  :NEW.DATE_LAST_UPDATED := SYSDATE; 
END;
--#end if

