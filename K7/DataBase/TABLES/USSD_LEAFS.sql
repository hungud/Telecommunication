CREATE SEQUENCE S_NEW_LEAF_ID
  START WITH 1
  MAXVALUE 999999999999999999999999999
  MINVALUE 1
  NOCYCLE
  NOCACHE
  NOORDER;

CREATE TABLE USSD_LEAFS (
       LEAF_ID INTEGER PRIMARY KEY,
       USSD    VARCHAR2(50),
       USSD_LVL integer,
       SERVICE integer,
       RESPONSE VARCHAR2(50),
       TEXT_RU varchar2(200),
       TEXT_TR varchar2(200),
       TEXT_EN varchar2(200),
       USSD_END number(1),
       SQL_T varchar2(200)
);

CREATE OR REPLACE FUNCTION NEW_LEAF_ID RETURN NUMBER IS
--#Version=1
  vRES NUMBER;
BEGIN
  SELECT S_NEW_LEAF_ID.NEXTVAL
    INTO vRES
    FROM DUAL;
  RETURN vRES;
END;

CREATE OR REPLACE TRIGGER TI_USSD_LEAFS
  BEFORE INSERT ON USSD_LEAFS FOR EACH ROW
--#Version=1
BEGIN
    :NEW.LEAF_ID := NEW_LEAF_ID;
END;

--GRANT DELETE, INSERT, SELECT, UPDATE ON USSD_LEAFS TO CORP_MOBILE_ROLE;

--GRANT SELECT ON USSD_LEAFS TO CORP_MOBILE_ROLE_RO;  

ALter table USSD_LEAFS Add (DESCRPTION varchar2(200));
COMMENT ON TABLE USSD_LEAFS IS 'Таблица реакции на USSD- запросы';
COMMENT ON COLUMN USSD_LEAFS.LEAF_ID IS 'ID запроса';
COMMENT ON COLUMN USSD_LEAFS.USSD IS 'USSD команда';
COMMENT ON COLUMN USSD_LEAFS.USSD_LVL IS 'Признак того, что обрабатываем команду';
COMMENT ON COLUMN USSD_LEAFS.SERVICE IS '';
COMMENT ON COLUMN USSD_LEAFS.RESPONSE IS '';
COMMENT ON COLUMN USSD_LEAFS.TEXT_RU IS 'Текст ответа на русском языке';
COMMENT ON COLUMN USSD_LEAFS.TEXT_TR IS 'Текст ответа в транслите';
COMMENT ON COLUMN USSD_LEAFS.TEXT_EN IS 'Текст ответа на английском языке';
COMMENT ON COLUMN USSD_LEAFS.SQL_T IS 'Запрос, выполняемый при запросе';
COMMENT ON COLUMN USSD_LEAFS.CHECK_NUMBER IS '';


Insert into USSD_LEAFS
   (USSD, USSD_LVL, SERVICE, RESPONSE, 
    TEXT_RU, TEXT_TR, TEXT_EN, USSD_END, SQL_T, 
    CHECK_NUMBER, DESCRPTION)
 Values
   ('*132*100%#', 1, NULL, NULL, 
    '%USSD_TEXT%', '%USSD_TEXT%', NULL, 1, 'Select F_USSD_CHANGE_PP(%MSISDN%, %USSD_CODE%) from dual', 
    0, 'Добавление заявки на смену тарифного плана');

DROP TRIGGER TIU_USSD_LEAFS;

CREATE OR REPLACE TRIGGER TIU_USSD_LEAFS
--#Version=1
  BEFORE INSERT OR UPDATE ON USSD_LEAFS FOR EACH ROW
declare
 ct integer;
BEGIN
  ct := 0;
  if INSERTING then
    if nvl(:NEW.LEAF_ID, 0 ) = 0 then  
      :NEW.LEAF_ID := NEW_LEAF_ID;
    end if;
    
    select count(*) into ct from USSD_LEAFS ul
    where 
      :NEW.USSD like ul.ussd 
      or
      ul.ussd like  :NEW.USSD;
  end if;
  
  if updating then
    IF :NEW.USSD <> :OLD.USSD then
      select count(*) into ct from USSD_LEAFS ul
    where 
      :NEW.USSD like ul.ussd 
      or
      ul.ussd like  :NEW.USSD;
     end if;
  end if;
  
  if ct > 0 then
    RAISE_APPLICATION_ERROR (-20000, 'Невозможно создание пересекающихся USSD команд!!!');  
  end if; 
  
END;
/
ALTER TABLE USSD_LEAFS ADD(USE_FOR_COLUMN VARCHAR2(60 CHAR));
COMMENT ON COLUMN USSD_LEAFS.USE_FOR_COLUMN IS 'Для какого поля таблицы используется команда (например, TARIFFS.TARIFF_ID)';

Insert into USSD_LEAFS
   (LEAF_ID, USSD, USSD_LVL, SERVICE, RESPONSE, 
    TEXT_RU, TEXT_TR, TEXT_EN, USSD_END, SQL_T, 
    CHECK_NUMBER, DESCRPTION, USE_FOR_COLUMN)
 Values
   (26, '*132*101#', 1, NULL, NULL, 
    '%USSD_TEXT%', '%USSD_TEXT%', NULL, 1, 'select USSD_K7_LK_RESET_PASSWORD(%MSISDN%) from dual', 
    0, 'Запрос пароля для доступа в личный кабинет К7 (ag-sv.ru)', NULL);