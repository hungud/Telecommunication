CREATE TABLE ROAMING_TYPES(
  ROAMING_TYPE_ID Integer NOT NULL PRIMARY KEY,
  NAME Varchar2(150 char ) NOT NULL
)
/
  
COMMENT ON TABLE ROAMING_TYPES IS 'Типы роуминга'
/
COMMENT ON COLUMN ROAMING_TYPES.ROAMING_TYPE_ID IS 'Идентификатор записи'
/
COMMENT ON COLUMN ROAMING_TYPES.NAME IS 'Назваине типа роуминга'
/

SET DEFINE OFF;
Insert into ROAMING_TYPES (ROAMING_TYPE_ID, NAME) Values (0, 'нет роуминга');
Insert into ROAMING_TYPES (ROAMING_TYPE_ID, NAME) Values (1, 'роуминг(для старых детализаций');
Insert into ROAMING_TYPES (ROAMING_TYPE_ID, NAME) Values (2, 'международный роуминг');
Insert into ROAMING_TYPES (ROAMING_TYPE_ID, NAME) Values  (3, 'внутрисетевой, национальный роуминг');
COMMIT;
