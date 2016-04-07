CREATE TABLE TARIFFS(
  TARIFF_ID               Integer        NOT NULL,
  TARIFF_CODE             Varchar2(30 )  NOT NULL,
  TARIFF_NAME             Varchar2(100 ) NOT NULL,
  MOBILE_OPERATOR_NAME_ID Integer        NOT NULL,
  IS_ACTIVE               Integer        NOT NULL,
  START_BALANCE           Number(10,2),
  CONNECT_PRICE           Number(10,2),
  MONTHLY_PAYMENT         Number(10,2),
  CALC_KOEFF              Number(15,4),
  TARIFF_ADD_COST         Number(15,2),
  CALC_KOEFF_DETAL        Number(15,4),
  USER_CREATED            VARCHAR2(30 CHAR) NOT NULL,
  DATE_CREATED            DATE              NOT NULL,
  USER_LAST_UPDATED       VARCHAR2(30 CHAR) NOT NULL,
  DATE_LAST_UPDATED       DATE              NOT NULL  
);

COMMENT ON TABLE  TARIFFS                         IS 'Справочник тарифных планов';
COMMENT ON COLUMN TARIFFS.TARIFF_ID               IS 'Идентификтор записи';
COMMENT ON COLUMN TARIFFS.TARIFF_CODE             IS 'Код тарифного плана';
COMMENT ON COLUMN TARIFFS.TARIFF_NAME             IS 'Наименование тарифного плана';
COMMENT ON COLUMN TARIFFS.MOBILE_OPERATOR_NAME_ID IS 'Код оператора сотовой связи';
COMMENT ON COLUMN TARIFFS.IS_ACTIVE               IS 'Активный (можно подключать абонентов на него)';
COMMENT ON COLUMN TARIFFS.START_BALANCE           IS 'Стартовый баланс';
COMMENT ON COLUMN TARIFFS.CONNECT_PRICE           IS 'Стоимость подключения';
COMMENT ON COLUMN TARIFFS.MONTHLY_PAYMENT         IS 'Абонентская плата по тарифу в мес.';
COMMENT ON COLUMN TARIFFS.CALC_KOEFF              IS 'Коэффициент пересчёта абонплаты';
COMMENT ON COLUMN TARIFFS.TARIFF_ADD_COST         IS 'Добавочная стоимость для тарифа';
COMMENT ON COLUMN TARIFFS.CALC_KOEFF_DETAL        IS 'Коэффициент пересчёта детализаций';
COMMENT ON COLUMN TARIFFS.USER_CREATED            IS 'Пользователь, создавший запись';
COMMENT ON COLUMN TARIFFS.DATE_CREATED            IS 'Дата/время создания записи';
COMMENT ON COLUMN TARIFFS.USER_LAST_UPDATED       IS 'Пользователь, редактировавший запись последним';
COMMENT ON COLUMN TARIFFS.DATE_LAST_UPDATED       IS 'Дата/время последней редакции записи';

CREATE UNIQUE INDEX PK_TARIFFS ON TARIFFS (TARIFF_ID);


CREATE SEQUENCE S_NEW_TARIFFS
  START WITH 1
  MAXVALUE 999999999999999999999999999
  MINVALUE 1
  NOCYCLE
  CACHE 20
  NOORDER;

CREATE OR REPLACE TRIGGER TIU_TARIFFS
  BEFORE INSERT OR UPDATE ON TARIFFS FOR EACH ROW
BEGIN
 IF INSERTING THEN
    IF NVL(:NEW.TARIFF_ID, 0) = 0 then
      :NEW.TARIFF_ID := S_NEW_TARIFFS.NEXTVAL;
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

ALTER TABLE TARIFFS ADD (
  CONSTRAINT TARIFF_ID_PK
  PRIMARY KEY (TARIFF_ID)
  USING INDEX PK_TARIFFS
  ENABLE VALIDATE);

ALTER TABLE TARIFFS ADD (
  CONSTRAINT FK_OPERATOR_ID 
  FOREIGN KEY (MOBILE_OPERATOR_NAME_ID) 
  REFERENCES MOBILE_OPERATOR_NAMES (MOBILE_OPERATOR_NAME_ID)
  ENABLE VALIDATE);

GRANT DELETE, INSERT, SELECT, UPDATE ON TARIFFS TO BUSINESS_COMM_ROLE;
GRANT SELECT ON S_NEW_TARIFFS TO BUSINESS_COMM_ROLE;
GRANT SELECT, UPDATE ON TARIFFS TO BUSINESS_COMM_ROLE_RO;

CREATE UNIQUE INDEX I_TARIFF_ID_TARIFF_NAME ON TARIFFS
(TARIFF_ID, TARIFF_NAME);

CREATE INDEX I_tariffs_tariff_name_add_cost ON  tariffs
  (tariff_id, tariff_name, tariff_add_cost);

-- добавляем foreign key - связку на filials.filial_id, удаляем колонку mobile_operator_name_id
alter table TARIFFS add filial_id number;
comment on column TARIFFS.filial_id is 'Филиал оператора FILIALS.FILIAL_ID';
update TARIFFS a set a.filial_id = decode(a.mobile_operator_name_id,31,81,a.mobile_operator_name_id);
alter table TARIFFS modify filial_id not null;
alter table TARIFFS
  add constraint FK_FILIAL_ID1 foreign key (FILIAL_ID)
  references filials (FILIAL_ID);
alter table TARIFFS drop constraint FK_OPERATOR_ID;    
alter table TARIFFS drop column mobile_operator_name_id;