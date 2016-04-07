--#if not ObjectExists("S_NEW_ROAMING_RETARIF_SERV_ID")
CREATE SEQUENCE S_NEW_ROAMING_RETARIF_SERV_ID;
--#end if

--#if not TableExists("ROAMING_RETARIF_SERVS") then
CREATE TABLE ROAMING_RETARIF_SERVS
(
  ID           INTEGER  CONSTRAINT PK_ROAMING_RETARIF_SERVS PRIMARY KEY,
  NAME          VARCHAR2(250 CHAR),
  USER_CREATED  VARCHAR2(30 CHAR),
  DATE_CREATED  DATE,
  USER_LAST_UPDATED  VARCHAR2(30 CHAR),
  DATE_LAST_UPDATED  DATE
);
--#end if

--#if GetTableComment("ROAMING_RETARIF_SERV")<>"Справочник услуг в роуминге" then
COMMENT ON TABLE ROAMING_RETARIF_SERVS IS 'Справочник услуг в роуминге';
--#end if

--#if GetColumnComment("ROAMING_RETARIF_SERVS.ID") <> "Первичный ключ" then
COMMENT ON COLUMN ROAMING_RETARIF_SERVS.ID IS 'Первичный ключ';
--#end if

--#if GetColumnComment("ROAMING_RETARIF_SERVS.NAME") <> "Название услуги" then
COMMENT ON COLUMN ROAMING_RETARIF_SERVS.NAME IS 'Название услуги';
--#end if

--#if not IndexExists("UQ_ROAMING_RETARIF_SERVS_NAME") THEN
CREATE UNIQUE INDEX UQ_ROAMING_RETARIF_SERVS_NAME ON ROAMING_RETARIF_SERVS(NAME);
--#end if

--#IF GetVersion("TIU_ROAMING_RETARIF_SERVS") < 1 THEN
CREATE OR REPLACE TRIGGER TIU_ROAMING_RETARIF_SERVS 
  BEFORE INSERT OR UPDATE ON ROAMING_RETARIF_SERVS FOR EACH ROW 
--#Version=1
BEGIN 
  IF INSERTING THEN 
    IF NVL(:NEW.ID, 0) = 0 then 
      :NEW.ID := S_NEW_ROAMING_RETARIF_SERV_ID.NEXTVAL; 
    END IF; 
    :NEW.USER_CREATED := USER; 
    :NEW.DATE_CREATED := SYSDATE;
  END IF; 
  :NEW.USER_LAST_UPDATED := USER; 
  :NEW.DATE_LAST_UPDATED := SYSDATE; 
END;
--#end if


insert into ROAMING_RETARIF_SERVS (name) values ('(РЕГ) в др.сеть в др.регионе');
insert into ROAMING_RETARIF_SERVS (name) values ('(РЕГ) вх.городской в др.регионе');
insert into ROAMING_RETARIF_SERVS (name) values ('(РЕГ) вх.из др.сети в др.регионе');
insert into ROAMING_RETARIF_SERVS (name) values ('(РЕГ) вх.мобильный в др.регионе');
insert into ROAMING_RETARIF_SERVS (name) values ('(РЕГ) вх/Мегафон в др.регионе');
insert into ROAMING_RETARIF_SERVS (name) values ('(РЕГ) вх/МСС в др.регионе');
insert into ROAMING_RETARIF_SERVS (name) values ('(РЕГ) вх/МТС в др.регионе');
insert into ROAMING_RETARIF_SERVS (name) values ('(РЕГ) вх/Скайлинк в др.регионе');
insert into ROAMING_RETARIF_SERVS (name) values ('(РЕГ) городской в др.регионе');
insert into ROAMING_RETARIF_SERVS (name) values ('(РЕГ) исх Билайн региона нахождения');
insert into ROAMING_RETARIF_SERVS (name) values ('(РЕГ) исх.мобильный в др.регионе');
insert into ROAMING_RETARIF_SERVS (name) values ('(РЕГ) исх/Мегафон в др.регионе');
insert into ROAMING_RETARIF_SERVS (name) values ('(РЕГ) исх/МТС в др.регионе');
insert into ROAMING_RETARIF_SERVS (name) values ('(РЕГ) Прослуш. п/я (абонент находится на территории другого региона)');
insert into ROAMING_RETARIF_SERVS (name) values ('(РЕГ) Рег. моб. БЛ (другой регион)(с территории другого региона)');
insert into ROAMING_RETARIF_SERVS (name) values ('(РЕГ) Рег. моб. БЛ (удаленный регион)(с территории другого региона)');
insert into ROAMING_RETARIF_SERVS (name) values ('(РЕГ) Региональный звонок в др.регионе');
insert into ROAMING_RETARIF_SERVS (name) values ('(РЕГ) Россия в др.регионе');
insert into ROAMING_RETARIF_SERVS (name) values ('(РЕГ) Черноземье из др.региона');
insert into ROAMING_RETARIF_SERVS (name) values ('(РЕГ)Москва и МO из ЦР');
-- Новые
insert into ROAMING_RETARIF_SERVS (name) values ('(РЕГ) Исходящий м/г');
insert into ROAMING_RETARIF_SERVS (name) values ('(РЕГ) Исходящий м/г на "Билайн"');
insert into ROAMING_RETARIF_SERVS (name) values ('(РЕГ) Исходящий на номер др.сети');
insert into ROAMING_RETARIF_SERVS (name) values ('(РЕГ) Исходящий рег. на "Билайн"');
insert into ROAMING_RETARIF_SERVS (name) values ('(РЕГ) Входящий с гор.номера');
insert into ROAMING_RETARIF_SERVS (name) values ('(РЕГ) Входящий с "Мегафон"');
insert into ROAMING_RETARIF_SERVS (name) values ('(РЕГ) Входящий с "МТС"');
insert into ROAMING_RETARIF_SERVS (name) values ('(РЕГ) Входящий с моб.номера');
insert into ROAMING_RETARIF_SERVS (name) values ('(РЕГ) Входящий с номера др.сети');
insert into ROAMING_RETARIF_SERVS (name) values ('(РЕГ) Исходящий  (Москва/МО)');
insert into ROAMING_RETARIF_SERVS (name) values ('(РЕГ) Вход.из др.региона (Чернозем.)');
insert into ROAMING_RETARIF_SERVS (name) values ('(РЕГ) Входящий с "Скай Линк"');
insert into ROAMING_RETARIF_SERVS (name) values ('(РЕГ) И?ходящий в Россию');
insert into ROAMING_RETARIF_SERVS (name) values ('(РЕГ) И?ходящий на местный "Билайн"');
insert into ROAMING_RETARIF_SERVS (name) values ('(РЕГ) Исход?щий (Москва/МО)');
insert into ROAMING_RETARIF_SERVS (name) values ('(РЕГ) Исход?щий в Россию');
insert into ROAMING_RETARIF_SERVS (name) values ('(РЕГ) Исходящий (?осква/МО)');
insert into ROAMING_RETARIF_SERVS (name) values ('(РЕГ) Исходящий (Москва/МО)');
insert into ROAMING_RETARIF_SERVS (name) values ('(РЕГ) Исходящий ?а местный "Билайн"');
insert into ROAMING_RETARIF_SERVS (name) values ('(РЕГ) Исходящий в Россию');
insert into ROAMING_RETARIF_SERVS (name) values ('(РЕГ) Исходящий на "Мегафон"');
insert into ROAMING_RETARIF_SERVS (name) values ('(РЕГ) Исходящий на "МТС"');
insert into ROAMING_RETARIF_SERVS (name) values ('(РЕГ) Исходящий на местный "Билайн"');
insert into ROAMING_RETARIF_SERVS (name) values ('(РЕГ) мжгр.звонок в др.регионе');
--
commit;