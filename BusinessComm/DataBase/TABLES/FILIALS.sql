CREATE TABLE FILIALS
(
  FILIAL_ID          INTEGER           NOT NULL,
  FILIAL_NAME        VARCHAR2(50 CHAR) NOT NULL,
  USER_CREATED       VARCHAR2(30 CHAR) NOT NULL,
  DATE_CREATED       DATE              NOT NULL,
  USER_LAST_UPDATED  VARCHAR2(30 CHAR) NOT NULL,
  DATE_LAST_UPDATED  DATE              NOT NULL  
);

COMMENT ON TABLE FILIALS IS 'Филиалы и офисы организации';
COMMENT ON COLUMN FILIALS.FILIAL_ID IS 'Первичный ключ';
COMMENT ON COLUMN FILIALS.FILIAL_NAME IS 'Наименование ';
COMMENT ON COLUMN FILIALS.USER_CREATED IS 'Пользователь, создавший запись';
COMMENT ON COLUMN FILIALS.DATE_CREATED IS 'Дата/время создания записи';
COMMENT ON COLUMN FILIALS.USER_LAST_UPDATED IS 'Пользователь, редактировавший запись последним';
COMMENT ON COLUMN FILIALS.DATE_LAST_UPDATED IS 'Дата/время последней редакции записи';

CREATE UNIQUE INDEX PK_FILIALS ON FILIALS (FILIAL_ID);


CREATE SEQUENCE S_NEW_FILIALS
  START WITH 1
  MAXVALUE 999999999999999999999999999
  MINVALUE 1
  NOCYCLE
  CACHE 20
  NOORDER;

CREATE OR REPLACE TRIGGER TIU_FILIALS
  BEFORE INSERT OR UPDATE ON FILIALS FOR EACH ROW
BEGIN
 IF INSERTING THEN
    IF NVL(:NEW.FILIAL_ID, 0) = 0 then
      :NEW.FILIAL_ID := S_NEW_FILIALS.NEXTVAL;
    END IF;
    :NEW.USER_CREATED := USER;
    :NEW.DATE_CREATED := SYSDATE;
    :NEW.USER_LAST_UPDATED := USER;
    :NEW.DATE_LAST_UPDATED := SYSDATE;
  END IF;
  if UPDATING THEN
    :NEW.USER_LAST_UPDATED := USER;
    :NEW.DATE_LAST_UPDATED := SYSDATE;
  end if;
END;

ALTER TABLE FILIALS ADD (
  CONSTRAINT FILIALS_ID_PK
  PRIMARY KEY (FILIAL_ID)
  USING INDEX PK_FILIALS
  ENABLE VALIDATE);

GRANT DELETE, INSERT, SELECT, UPDATE ON FILIALS TO BUSINESS_COMM_ROLE;
GRANT SELECT ON S_NEW_FILIALS TO BUSINESS_COMM_ROLE;
GRANT SELECT, UPDATE ON FILIALS TO BUSINESS_COMM_ROLE_RO;

CREATE INDEX I_filials_names ON    filials
   (FILIAL_ID, FILIAL_NAME);

-- добавляем колонку BRANCH (параметр в шаблоне для ссылки) 
ALTER TABLE FILIALS ADD(BRANCH VARCHAR2(15 CHAR));  
COMMENT ON COLUMN FILIALS.BRANCH IS 'Префикс для ссылки';
-- добавляем данные о филиалах, используя идентификаторы и наименования из MOBILE_OPERATOR_NAMES.
insert into FILIALS (filial_id, filial_name, user_created, date_created, user_last_updated, date_last_updated,branch) 
select mobile_operator_name_id, mobile_operator_name, user_created, date_created, user_last_updated, date_last_updated, 
decode(mobile_operator_name_id,17,'Center',32,'Ural',15,'Szf')
from mobile_operator_names where mobile_operator_name_id <> 31;
commit;

-- устраняем избыточность (дубликаты филиалов Мегафона) 
delete from FILIALS f where f.filial_id in (21,41);
commit;

-- связываем FILIALS с MOBILE_OPERATOR_NAMES
-- Добавляем колонку для Foreign Key 
alter table FILIALS add mobile_operator_name_id number;
comment on column FILIALS.mobile_operator_name_id
  is 'Id оператора сотовой связи MOBILE_OPERATOR_NAMES.MOBILE_OPERATOR_NAME_ID';
-- заполняем значениями   
update FILIALS set mobile_operator_name_id = decode(filial_id,81,31,41);
commit;
alter table FILIALS modify mobile_operator_name_id not null;  
-- Create foreign key constraints 
alter table FILIALS
  add constraint FK_MOBILE_OPERATOR_NAME foreign key (MOBILE_OPERATOR_NAME_ID)
  references mobile_operator_names (MOBILE_OPERATOR_NAME_ID);