CREATE TABLE SERVICE_TYPES(
  SERVICE_TYPE_CHAR Varchar2(1 char) NOT NULL PRIMARY KEY,
  NAME Varchar2(30 ) NOT NULL
)
/
  
COMMENT ON TABLE SERVICE_TYPES IS 'Тип вызовов'
/
COMMENT ON COLUMN SERVICE_TYPES.SERVICE_TYPE_CHAR IS 'Тип вызова'
/
COMMENT ON COLUMN SERVICE_TYPES.NAME IS 'Название типа вызова'
/
SET DEFINE OFF;
Insert into SERVICE_TYPES (SERVICE_TYPE_CHAR, NAME) Values ('C', 'Звонок');
Insert into SERVICE_TYPES (SERVICE_TYPE_CHAR, NAME) Values ('M', 'Межгород');
Insert into SERVICE_TYPES (SERVICE_TYPE_CHAR, NAME) Values ('S', 'СМС');
Insert into SERVICE_TYPES (SERVICE_TYPE_CHAR, NAME) Values ('U', 'ММС');
Insert into SERVICE_TYPES (SERVICE_TYPE_CHAR, NAME) Values ('G', 'GPRS');
Insert into SERVICE_TYPES (SERVICE_TYPE_CHAR, NAME) Values ('W', 'WAP');
Insert into SERVICE_TYPES (SERVICE_TYPE_CHAR, NAME) Values ('D', 'Плата за доп.услуги');
Insert into SERVICE_TYPES (SERVICE_TYPE_CHAR, NAME) Values ('N', 'Плата за прямой номер');
Insert into SERVICE_TYPES (SERVICE_TYPE_CHAR, NAME) Values ('P', 'Абонненсткая плата');
Insert into SERVICE_TYPES (SERVICE_TYPE_CHAR, NAME) Values ('O', 'Прочее');
Insert into SERVICE_TYPES (SERVICE_TYPE_CHAR, NAME) Values ('A', 'Пополнение счета');
Insert into SERVICE_TYPES (SERVICE_TYPE_CHAR, NAME) Values ('J', 'Корректировка');
COMMIT;
