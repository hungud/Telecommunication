CREATE TABLE CONSTANTS(
  CONSTANT_ID Integer PRIMARY KEY NOT NULL,
  NAME Varchar2(30 ) NOT NULL UNIQUE,
  VALUE Varchar2(150 ),
  TYPE  varchar2(1 char) NOT NULL,
  DESCRIPTION Varchar2(150 ) NOT NULL,
  ACCESS_VERSTION         NUMBER(13,6)          DEFAULT 0,
  ACCESS_VERSTION_STRING  VARCHAR2(30 CHAR)     DEFAULT '0.0.0.0'
);
/
-- Table and Columns comments section
  
COMMENT ON TABLE CONSTANTS IS 'Таблица с константами'
/
COMMENT ON COLUMN CONSTANTS.CONSTANT_ID IS 'Идентификатор записи'
/
COMMENT ON COLUMN CONSTANTS.NAME IS 'Название константы'
/
COMMENT ON COLUMN CONSTANTS.VALUE IS 'Значение константы'
/
COMMENT ON COLUMN CONSTANTS.DESCRIPTION IS 'Комментарий к константе'
/
COMMENT ON COLUMN CONSTANTS.TYPE IS 'Тип константы (S- строка, N - числово тип и т.д.)'
/
COMMENT ON COLUMN CONSTANTS.ACCESS_VERSTION IS 'Доступно с версии';
COMMENT ON COLUMN CONSTANTS.ACCESS_VERSTION_STRING IS 'Доступно с версии(строка)';

CREATE SEQUENCE S_NEW_CONSTANT_ID
  START WITH 1
  MAXVALUE 999999999999999999999999999
  MINVALUE 1
  NOCYCLE
  CACHE 20
  NOORDER;


CREATE OR REPLACE TRIGGER TI_CONSTANTS
  BEFORE INSERT ON CONSTANTS FOR EACH ROW

DECLARE
  vRES VARCHAR2(30 CHAR);
  vTEMP VARCHAR2(30 CHAR);
  vRESn NUMBER;
--#Version=1
BEGIN
  IF INSERTING THEN
    IF NVL(:NEW.CONSTANT_ID, 0) = 0 then
      :NEW.CONSTANT_ID :=  S_NEW_CONSTANT_ID.NEXTVAL;
    END IF;
  END IF;
  
  
  vRES:=:NEW.ACCESS_VERSTION_STRING;
  vRESn:=0;
  BEGIN
    --Читаем 1ую
    vTEMP := SUBSTR(vRES, 1, INSTR(vRES, '.')-1);
    vRES := SUBSTR(vRES, INSTR(vRES, '.') + 1);
    vRESn := vRESn + TO_NUMBER(vTEMP) * 1000;
    --Читаем 2ую
    vTEMP := SUBSTR(vRES, 1, INSTR(vRES, '.')-1);
    vRES := SUBSTR(vRES, INSTR(vRES, '.') + 1);
    vRESn := vRESn + TO_NUMBER(vTEMP);
    --Читаем 3ую
    vTEMP := SUBSTR(vRES, 1, INSTR(vRES, '.')-1);
    vRES := SUBSTR(vRES, INSTR(vRES, '.') + 1);
    vRESn := vRESn + TO_NUMBER(vTEMP)/1000;
    --Читаем последнюю
    vRESn := vRESn + TO_NUMBER(vRES)/1000/1000;    
  EXCEPTION
    WHEN OTHERS THEN
      vRESn:=0;
  END;
  :NEW.ACCESS_VERSTION := vRESn;
  
END;

SET DEFINE OFF;
Insert into CONSTANTS
   (CONSTANT_ID, NAME, VALUE, TYPE, DESCRIPTION, 
    ACCESS_VERSTION, ACCESS_VERSTION_STRING)
 Values
   (1, 'PARSER_URL', 'http://api.tarifer.ru/api/v1/parsers/create?app_id=173cda709dab103efb6c9a66e48f9aa9', 'S', 'Ссылка на парсер счетов и детализаций', 
    0, '0.0.0.0');
COMMIT;

GRANT SELECT ON CONTRACTS TO BUSINESS_COMM_ROLE_RO;

Insert into CONSTANTS   (NAME, DESCRIPTION, TYPE)  Values   ('START_TIME_JOB_AFTER_STOP', 'Время запуска job после их остановки', 'D');
Insert into CONSTANTS   (NAME, VALUE, TYPE, DESCRIPTION,   ACCESS_VERSTION, ACCESS_VERSTION_STRING)
  Values  ('DIR_PAYMENT_FILES_NEW', 'DIR_PAYMENT_FILES_NEW', 'S', 'Директория с неразобранными файлами платежей', 0, '0.0.0.0');
  
Insert into CONSTANTS
   (NAME, VALUE, TYPE, DESCRIPTION, 
    ACCESS_VERSTION, ACCESS_VERSTION_STRING)
 Values
   ('UNKNOWN_INN_ID', '0', 'I', ' ИД виртуального счета для тех платежей, ИНН которых не опредедяется в базе', 
    0, '0.0.0.0');
COMMIT;	

Insert into CONSTANTS
   (NAME, VALUE, TYPE, DESCRIPTION)
 Values
   ('URL_DET_OPERATOR_BY_PHONE', 'http://api.tarifer.ru/api/v1/phone_numbers/7%phone%/operator?app_id=173cda709dab103efb6c9a66e48f9aa9', 'S', 'Ссылка определения информации по номеру телефона');
COMMIT;
