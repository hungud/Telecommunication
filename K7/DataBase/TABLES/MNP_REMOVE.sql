--#if not TableExists("MNP_REMOVE")
CREATE TABLE MNP_REMOVE
(
  PHONE_NUMBER       NVARCHAR2(10),
  TEMP_PHONE_NUMBER  NVARCHAR2(10),
  DATE_ACTIVATE      DATE,
  USER_CREATED       VARCHAR2(50 BYTE),
  DATE_CREATED       DATE,
  IS_ACTIVE          NUMBER(1)
)
TABLESPACE USERS
RESULT_CACHE (MODE DEFAULT)
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
            FLASH_CACHE      DEFAULT
            CELL_FLASH_CACHE DEFAULT
           )
LOGGING 
NOCOMPRESS 
NOCACHE
NOPARALLEL
MONITORING;

COMMENT ON TABLE MNP_REMOVE IS 'NMP_ПЕРЕХОДЫ';

COMMENT ON COLUMN MNP_REMOVE.PHONE_NUMBER IS 'Основной номер';

COMMENT ON COLUMN MNP_REMOVE.TEMP_PHONE_NUMBER IS 'Временный MNP номер';

COMMENT ON COLUMN MNP_REMOVE.DATE_ACTIVATE IS 'Дата перехода (сразу не заполнять)';

COMMENT ON COLUMN MNP_REMOVE.USER_CREATED IS 'Пользователь';

COMMENT ON COLUMN MNP_REMOVE.DATE_CREATED IS 'запись';

COMMENT ON COLUMN MNP_REMOVE.IS_ACTIVE IS 'Переход произошёл';



CREATE UNIQUE INDEX UK_MNP_PHONE_NUMBER ON MNP_REMOVE
(PHONE_NUMBER)
LOGGING
TABLESPACE USERS
PCTFREE    10
INITRANS   2
MAXTRANS   255
STORAGE    (
            INITIAL          64K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
            FLASH_CACHE      DEFAULT
            CELL_FLASH_CACHE DEFAULT
           )
NOPARALLEL;


CREATE OR REPLACE TRIGGER TBIU_MNP_REMOVE
  before insert or update ON MNP_REMOVE for each row
begin
  if INSERTING then 
    :new.is_active:=0;
    :new.user_created:=user;
    :new.date_created:=sysdate;
    :new.date_activate:=null;   
  end if;
 if nvl(:old.is_active,0)>0 and UPDATING then 
   :new.phone_number:=:old.phone_number;
   :new.temp_phone_number:=:old.temp_phone_number;
 end if;
end TBIU_MNP_REMOVE;
/


ALTER TABLE MNP_REMOVE ADD (
  CONSTRAINT UK_MNP_PHONE_NUMBER
  UNIQUE (PHONE_NUMBER)
  USING INDEX UK_MNP_PHONE_NUMBER
  ENABLE VALIDATE)
/
--#end if

 
GRANT SELECT, INSERT, DELETE, UPDATE ON MNP_REMOVE TO CORP_MOBILE_ROLE;     
      
GRANT SELECT ON MNP_REMOVE TO CORP_MOBILE_ROLE_RO;