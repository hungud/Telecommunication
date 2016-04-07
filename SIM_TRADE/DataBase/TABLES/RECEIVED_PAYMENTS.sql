--DROP TABLE RECEIVED_PAYMENTS;

--#if not ObjectExists("S_NEW_RECEIVED_PAYMENT_ID") then
CREATE SEQUENCE S_NEW_RECEIVED_PAYMENT_ID;
--#end if


--#if not TableExists("RECEIVED_PAYMENTS") then
CREATE TABLE RECEIVED_PAYMENTS (
  RECEIVED_PAYMENT_ID   INTEGER 
    CONSTRAINT PK_RECEIVED_PAYMENT_ID PRIMARY KEY,
  PHONE_NUMBER          VARCHAR2(10 CHAR) 
    CONSTRAINT CHK_RECEIVED_PAYMENT_PHONE CHECK (LENGTH(PHONE_NUMBER) = 10)
    CONSTRAINT NN_RECEIVED_PAYMENT_PHONE NOT NULL,
  PAYMENT_SUM           NUMBER(15, 2) NOT NULL,
  PAYMENT_DATE_TIME     DATE CONSTRAINT NN_RECEIVED_PAYMENT_DATE_TIME NOT NULL,
  CONTRACT_ID           INTEGER 
    CONSTRAINT FK_RECEIVED_PAYMENT_CONTRACT REFERENCES CONTRACTS
    CONSTRAINT NN_RECEIVED_PAYMENT_CONTRACT NOT NULL,
  IS_CONTRACT_PAYMENT   NUMBER(1, 0) DEFAULT 0
    CONSTRAINT CHK_RECEIVED_PAYMENT_CONTR_PAY CHECK (IS_CONTRACT_PAYMENT IN (0, 1))
    CONSTRAINT NN_RECEIVED_PAYMENT_CONTR_PAYM NOT NULL,
  FILIAL_ID             INTEGER
    CONSTRAINT FK_RECEIVED_PAYMENTS_FILIAL REFERENCES FILIALS
    CONSTRAINT NN_RECEIVED_PAYMENTS_FILIAL NOT NULL,
  PAYMENT_ANNUL_FLAG    NUMBER(1, 0) DEFAULT 0 
    CONSTRAINT CHK_RECEIVED_PAYMENT_ANNUL_FLG CHECK (PAYMENT_ANNUL_FLAG IN (0, 1)),
  PAYMENT_ANNUL_DATE_TIME DATE,
  PAYMENT_ANNUL_REASON  VARCHAR2(200 CHAR),
  USER_WHO_ANNULATE     VARCHAR2(30 CHAR),
  USER_CREATED          VARCHAR2(30 CHAR),
  DATE_CREATED          DATE,
  USER_LAST_UPDATED     VARCHAR2(30 CHAR),
  DATE_LAST_UPDATED     DATE,
  CONSTRAINT CHK_RECEIVED_PAYMENT_ANN_DATET CHECK (
    (PAYMENT_ANNUL_FLAG = 0 AND PAYMENT_ANNUL_DATE_TIME IS NULL)
    OR (PAYMENT_ANNUL_FLAG = 1 AND PAYMENT_ANNUL_DATE_TIME IS NOT NULL)
    )
);
--#end if

--#if not ConstraintExists("FK_REC_PAYMENT_CONTRACT_TYPE")
ALTER TABLE CORP_MOBILE.RECEIVED_PAYMENTS ADD 
CONSTRAINT FK_REC_PAYMENT_CONTRACT_TYPE
 FOREIGN KEY (RECEIVED_PAYMENT_TYPE_ID)
 REFERENCES CORP_MOBILE.RECEIVED_PAYMENT_TYPES (RECEIVED_PAYMENT_TYPE_ID)
 ENABLE
 VALIDATE;
--#end if


--#if not ColumnExists("RECEIVED_PAYMENTS.REMARK") then
ALTER TABLE RECEIVED_PAYMENTS ADD REMARK VARCHAR2(500 CHAR);
--#end if

--#if GetTableComment("RECEIVED_PAYMENTS") <> "Принятые платежи" then
COMMENT ON TABLE RECEIVED_PAYMENTS IS 'Принятые платежи';
--#end if

--#if GetColumnComment("RECEIVED_PAYMENTS.RECEIVED_PAYMENT_ID") <> "Первичный ключ" then
COMMENT ON COLUMN RECEIVED_PAYMENTS.RECEIVED_PAYMENT_ID IS 'Первичный ключ';
--#end if

--#if GetColumnComment("RECEIVED_PAYMENTS.PHONE_NUMBER") <> "Номер телефона" then
COMMENT ON COLUMN RECEIVED_PAYMENTS.PHONE_NUMBER IS 'Номер телефона';
--#end if

--#if GetColumnComment("RECEIVED_PAYMENTS.PAYMENT_SUM") <> "Оплаченная сумма" then
COMMENT ON COLUMN RECEIVED_PAYMENTS.PAYMENT_SUM  IS 'Оплаченная сумма';
--#end if

--#if GetColumnComment("RECEIVED_PAYMENTS.PAYMENT_DATE_TIME") <> "Дата и время платежа" then
COMMENT ON COLUMN RECEIVED_PAYMENTS.PAYMENT_DATE_TIME IS 'Дата и время платежа';
--#end if

--#if GetColumnComment("RECEIVED_PAYMENTS.CONTRACT_ID") <> "Код договора" then
COMMENT ON COLUMN RECEIVED_PAYMENTS.CONTRACT_ID  IS 'Код договора';
--#end if

--#if GetColumnComment("RECEIVED_PAYMENTS.IS_CONTRACT_PAYMENT") <> "Признак, что платёж сделан при заключении контракта" then
COMMENT ON COLUMN RECEIVED_PAYMENTS.IS_CONTRACT_PAYMENT IS 'Признак, что платёж сделан при заключении контракта';
--#end if

--#if GetColumnComment("RECEIVED_PAYMENTS.FILIAL_ID") <> "Код филиала (офиса), принявшего платёж" then
COMMENT ON COLUMN RECEIVED_PAYMENTS.FILIAL_ID IS 'Код филиала (офиса), принявшего платёж';
--#end if

--#if GetColumnComment("RECEIVED_PAYMENTS.PAYMENT_ANNUL_FLAG") <> "Признак аннулирования" then
COMMENT ON COLUMN RECEIVED_PAYMENTS.PAYMENT_ANNUL_FLAG   IS 'Признак аннулирования';
--#end if

--#if GetColumnComment("RECEIVED_PAYMENTS.PAYMENT_ANNUL_DATE_TIME") <> "Дата и время аннулирования платежа" then
COMMENT ON COLUMN RECEIVED_PAYMENTS.PAYMENT_ANNUL_DATE_TIME IS 'Дата и время аннулирования платежа';
--#end if

--#if GetColumnComment("RECEIVED_PAYMENTS.PAYMENT_ANNUL_REASON") <> "Причина аннулирования" then
COMMENT ON COLUMN RECEIVED_PAYMENTS.PAYMENT_ANNUL_REASON IS 'Причина аннулирования';
--#end if

--#if GetColumnComment("RECEIVED_PAYMENTS.USER_WHO_ANNULATE") <> "Пользователь, который аннулировал платёж" then
COMMENT ON COLUMN RECEIVED_PAYMENTS.USER_WHO_ANNULATE IS 'Пользователь, который аннулировал платёж';
--#end if

--#if GetColumnComment("RECEIVED_PAYMENTS.REMARK") <> "Примечание к платежу" then
COMMENT ON COLUMN RECEIVED_PAYMENTS.REMARK IS 'Примечание к платежу';
--#end if

--#if not IndexExists("UQ_RECEIVED_PAYMENT_CONTRACT_P") THEN
-- Уникальность позволяет сделать только одну запись для договора с признаком IS_CONTRACT_PAYMENT=1
CREATE UNIQUE INDEX UQ_RECEIVED_PAYMENT_CONTRACT_P ON RECEIVED_PAYMENTS (
  CONTRACT_ID, 
  DECODE(PAYMENT_ANNUL_FLAG, 1, RECEIVED_PAYMENT_ID, DECODE(IS_CONTRACT_PAYMENT, 1, 1, RECEIVED_PAYMENT_ID))
  );
--#end if

--#if not IndexExists("I_RECEIVED_PAYMENTS_PHONE") THEN
CREATE INDEX I_RECEIVED_PAYMENTS_PHONE
ON RECEIVED_PAYMENTS
(PHONE_NUMBER) COMPRESS 1
/
--#end if

--#if GetVersion("NEW_RECEIVED_PAYMENT_ID") < 1 then
CREATE OR REPLACE FUNCTION NEW_RECEIVED_PAYMENT_ID RETURN NUMBER IS
--#Version=1
  vRES NUMBER;
BEGIN
  SELECT S_NEW_RECEIVED_PAYMENT_ID.NEXTVAL
  INTO vRES
  FROM DUAL;
  RETURN vRES;
END;
/

SHOW ERRORS;
--#end if


--#if GetVersion("TIU_RECEIVED_PAYMENTS") < 1 then
CREATE OR REPLACE TRIGGER CORP_MOBILE.TIU_RECEIVED_PAYMENTS
BEFORE INSERT OR UPDATE
ON CORP_MOBILE.RECEIVED_PAYMENTS
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
BEGIN
  IF :NEW.PAYMENT_DATE_TIME IS NULL THEN
    RAISE_APPLICATION_ERROR(-20074, 'Дата платежа не может быть пустой');
  END IF;
  --IF TRUNC(:NEW.PAYMENT_DATE_TIME) > TRUNC(SYSDATE) THEN
  --  RAISE_APPLICATION_ERROR(-20075, 'Дата платежа не может быть позже текущей даты');
  --END IF;
  IF (:NEW.PAYMENT_ANNUL_FLAG = 1) 
    AND (TRUNC(:NEW.PAYMENT_ANNUL_DATE_TIME) > TRUNC(SYSDATE)) THEN
    RAISE_APPLICATION_ERROR(-20076, 'Дата аннулирования платежа не может быть позже текущей');
  END IF;
  IF INSERTING THEN
    IF NVL(:NEW.RECEIVED_PAYMENT_ID, 0) = 0 then
      :NEW.RECEIVED_PAYMENT_ID := NEW_RECEIVED_PAYMENT_ID;
    END IF;
    IF :NEW.REVERSESCHET IS NULL then
      :NEW.REVERSESCHET := 0;
    END IF;
    :NEW.USER_CREATED := USER;
    :NEW.DATE_CREATED := SYSDATE;
  END IF;
  :NEW.USER_LAST_UPDATED := USER;
  :NEW.DATE_LAST_UPDATED := SYSDATE;
  IF :NEW.PAYMENT_SUM <> 0 THEN
    INSERT INTO QUEUE_CURRENT_BALANCES(PHONE_NUMBER, QUEUE_TYPE)
        VALUES(:NEW.PHONE_NUMBER, 47);
  END IF;  
END;
/
/
SHOW ERRORS;

--#end if

--#if not ColumnExists("RECEIVED_PAYMENTS.RECEIVED_PAYMENT_TYPE_ID") then
ALTER TABLE RECEIVED_PAYMENTS ADD (RECEIVED_PAYMENT_TYPE_ID INTEGER);
--#end if

--#if GetColumnComment("RECEIVED_PAYMENTS.RECEIVED_PAYMENT_TYPE_ID") <> "Тип платежа(ссылка на RECEIVED_PAYMENT_TYPES)" then
COMMENT ON COLUMN RECEIVED_PAYMENTS.RECEIVED_PAYMENT_TYPE_ID   IS 'Тип платежа(ссылка на RECEIVED_PAYMENT_TYPES)';
--#end if

--#if not ColumnExists("RECEIVED_PAYMENTS.REVERSESCHET") then
ALTER TABLE RECEIVED_PAYMENTS ADD (REVERSESCHET INTEGER);
/
ALTER TABLE CORP_MOBILE.RECEIVED_PAYMENTS
MODIFY(REVERSESCHET  DEFAULT 0)
/
--#end if

--#if GetColumnComment("RECEIVED_PAYMENTS.REVERSESCHET") <> "если 1, то в расшифровке баланса - сумма дублируется с противоположным знаком для счетов включенных в баланс" then
COMMENT ON COLUMN RECEIVED_PAYMENTS.REVERSESCHET   IS 'если 1, то в расшифровке баланса - сумма дублируется с противоположным знаком для счетов включенных в баланс';
--#end if

--#Execute MAIN_SCHEMA=IsClient("")

--#if not GrantExists("RECEIVED_PAYMENTS", "ROLE", "SELECT") then
begin EXECUTE IMMEDIATE 'GRANT ALL ON RECEIVED_PAYMENTS TO &MAIN_SCHEMA'||'_ROLE'; end;
--#end if

--#if not GrantExists("RECEIVED_PAYMENTS", "ROLE_RO", "SELECT") then
begin EXECUTE IMMEDIATE 'GRANT SELECT ON RECEIVED_PAYMENTS TO &MAIN_SCHEMA'||'_ROLE_RO'; end;
--#end if

--#if not GrantExists("RECEIVED_PAYMENTS", "ROLE_RO", "INSERT") then
begin EXECUTE IMMEDIATE 'GRANT INSERT ON RECEIVED_PAYMENTS TO &MAIN_SCHEMA'||'_ROLE_RO'; end;
--#end if

  
--#if not ColumnExistst("RECEIVED_PAYMENTS.PARENT_PAYMENT_ID") then
ALTER TABLE RECEIVED_PAYMENTS ADD PARENT_PAYMENT_ID INTEGER;
--#end if  

--#if GetColumnComment("RECEIVED_PAYMENTS.PARENT_PAYMENT_ID") <> "Ссылка на родительский платеж (для группы номеров с распределением платежа)" then
COMMENT ON COLUMN RECEIVED_PAYMENTS.PARENT_PAYMENT_ID IS 'Ссылка на родительский платеж (для группы номеров с распределением платежа)';
--#end if  

--#if ColumnExistst("RECEIVED_PAYMENTS.PARENT_PAYMENT_ID") <> "Ссылка на родительский платеж (для группы номеров с распределением платежей)" then
ALTER TABLE RECEIVED_PAYMENTS 
  ADD CONSTRAINT FK_RECEIVED_PAYMENT_PARENT_ID 
  FOREIGN KEY (PARENT_PAYMENT_ID)
  REFERENCES RECEIVED_PAYMENTS (RECEIVED_PAYMENT_ID);
--#end if    

ALTER TABLE RECEIVED_PAYMENTS ADD IS_DISTRIBUTED NUMBER(1);--DEFAULT 0;

CREATE INDEX I_RECEIVED_PAYM_IS_DISTRIBUTED ON RECEIVED_PAYMENTS(IS_DISTRIBUTED);
 
--#if not ColumnExistst("RECEIVED_PAYMENTS.PAYMENT_PERIOD") then
ALTER TABLE RECEIVED_PAYMENTS ADD PAYMENT_PERIOD INTEGER;
--#end if  

--#if GetColumnComment("RECEIVED_PAYMENTS.PAYMENT_PERIOD") <> "Период распределения затрат (для распределенных платежей по группе номеров)" then
COMMENT ON COLUMN RECEIVED_PAYMENTS.PAYMENT_PERIOD IS 'Период распределения затрат (для распределенных платежей по группе номеров) в формате YYYYMM';
--#end if  

CREATE INDEX I_RECEIVED_PAYMENTS_DATE_PAY ON RECEIVED_PAYMENTS
(to_number(to_char(PAYMENT_DATE_TIME, 'yyyymm')))
LOGGING
TABLESPACE USERS
PCTFREE    10
INITRANS   2
MAXTRANS   255
STORAGE    (
            INITIAL          512K
            NEXT             1M
            MAXSIZE          UNLIMITED
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
            FLASH_CACHE      DEFAULT
            CELL_FLASH_CACHE DEFAULT
           )
NOPARALLEL
COMPRESS 1;

DROP TRIGGER TIU_RECEIVED_PAYMENTS;

CREATE OR REPLACE TRIGGER TIUD_RECEIVED_PAYMENTS
BEFORE INSERT OR UPDATE OR DELETE
ON RECEIVED_PAYMENTS
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
declare
  vCURRENT_SCHEMA varchar2(100 char);
  vCURRENT_USER varchar2(100 char);
  vHOST varchar2(100 char);
  vIP_ADDRESS varchar2(100 char);
  vOS_USER varchar2(100 char);  
BEGIN
  
  
  IF NOT DELETING THEN
    IF :NEW.PAYMENT_DATE_TIME IS NULL THEN
      RAISE_APPLICATION_ERROR(-20074, 'Дата платежа не может быть пустой');
    END IF;
    --IF TRUNC(:NEW.PAYMENT_DATE_TIME) > TRUNC(SYSDATE) THEN
    --  RAISE_APPLICATION_ERROR(-20075, 'Дата платежа не может быть позже текущей даты');
    --END IF;
    IF (:NEW.PAYMENT_ANNUL_FLAG = 1) 
      AND (TRUNC(:NEW.PAYMENT_ANNUL_DATE_TIME) > TRUNC(SYSDATE)) THEN
      RAISE_APPLICATION_ERROR(-20076, 'Дата аннулирования платежа не может быть позже текущей');
    END IF;
    IF INSERTING THEN
      IF NVL(:NEW.RECEIVED_PAYMENT_ID, 0) = 0 then
        :NEW.RECEIVED_PAYMENT_ID := NEW_RECEIVED_PAYMENT_ID;
      END IF;
      IF :NEW.REVERSESCHET IS NULL then
        :NEW.REVERSESCHET := 0;
      END IF;
      :NEW.USER_CREATED := USER;
      :NEW.DATE_CREATED := SYSDATE;
    END IF;
    :NEW.USER_LAST_UPDATED := USER;
    :NEW.DATE_LAST_UPDATED := SYSDATE;
    IF :NEW.PAYMENT_SUM <> 0 THEN
      INSERT INTO QUEUE_CURRENT_BALANCES(PHONE_NUMBER, QUEUE_TYPE)
          VALUES(:NEW.PHONE_NUMBER, 47);
    END IF;
  END IF;
  
  vCURRENT_SCHEMA := SYS_CONTEXT('USERENV', 'CURRENT_SCHEMA');
  vCURRENT_USER := SYS_CONTEXT('USERENV', 'CURRENT_USER');
  vHOST := SYS_CONTEXT('USERENV', 'HOST');
  vIP_ADDRESS := SYS_CONTEXT('USERENV', 'IP_ADDRESS');
  vOS_USER := SYS_CONTEXT ( 'USERENV', 'OS_USER');
  
  
    IF INSERTING THEN
    insert into RECEIVED_PAYMENTS_log
    ( fdate_rec       ,
      CURR_SCHEMA      ,
      CURR_USER        ,
      HOST             ,
      IP_ADDRESS       ,
      OS_USER          ,
      faction         ,

      received_payment_id      ,

      phone_number             ,
      payment_sum              ,
      payment_date_time        ,
      contract_id              ,
      is_contract_payment      ,
      filial_id                ,
      payment_annul_flag       ,
      payment_annul_date_time  ,
      payment_annul_reason     ,
      user_who_annulate        ,

      remark                   ,
      received_payment_type_id ,
      reverseschet             ,
      parent_payment_id        ,
      is_distributed           ,
      payment_period           ,

      phone_number_NEW             ,
      payment_sum_NEW              ,
      payment_date_time_NEW        ,
      contract_id_NEW              ,
      is_contract_payment_NEW      ,
      filial_id_NEW                ,
      payment_annul_flag_NEW       ,
      payment_annul_date_time_NEW  ,
      payment_annul_reason_NEW     ,
      user_who_annulate_NEW        ,

      remark_NEW                   ,
      received_payment_type_id_NEW ,
      reverseschet_NEW             ,
      parent_payment_id_NEW        ,
      is_distributed_NEW          ,
      payment_period_NEW)
    values
    ( sysdate       ,
      vCURRENT_SCHEMA,
      vCURRENT_USER,
      vHOST,
      vIP_ADDRESS,
      vOS_USER,
      'INSERT'         ,

      :NEW.received_payment_id      ,

      NULL             ,
      NULL              ,
      NULL        ,
      NULL              ,
      NULL      ,
      NULL                ,
      NULL       ,
      NULL  ,
      NULL     ,
      NULL        ,

      NULL                   ,
      NULL ,
      NULL             ,
      NULL        ,
      NULL           ,
      NULL           ,

      :NEW.phone_number             ,
      :NEW.payment_sum              ,
      :NEW.payment_date_time        ,
      :NEW.contract_id              ,
      :NEW.is_contract_payment      ,
      :NEW.filial_id                ,
      :NEW.payment_annul_flag       ,
      :NEW.payment_annul_date_time  ,
      :NEW.payment_annul_reason     ,
      :NEW.user_who_annulate        ,

      :NEW.remark                   ,
      :NEW.received_payment_type_id ,
      :NEW.reverseschet             ,
      :NEW.parent_payment_id        ,
      :NEW.is_distributed          ,
      :NEW.payment_period);
  elsif UPDATING then
    insert into RECEIVED_PAYMENTS_log
    ( fdate_rec       ,
      CURR_SCHEMA      ,
      CURR_USER        ,
      HOST             ,
      IP_ADDRESS       ,
      OS_USER          ,
      faction         ,

      received_payment_id      ,

      phone_number             ,
      payment_sum              ,
      payment_date_time        ,
      contract_id              ,
      is_contract_payment      ,
      filial_id                ,
      payment_annul_flag       ,
      payment_annul_date_time  ,
      payment_annul_reason     ,
      user_who_annulate        ,

      remark                   ,
      received_payment_type_id ,
      reverseschet             ,
      parent_payment_id        ,
      is_distributed           ,
      payment_period           ,

      phone_number_NEW             ,
      payment_sum_NEW              ,
      payment_date_time_NEW        ,
      contract_id_NEW              ,
      is_contract_payment_NEW      ,
      filial_id_NEW                ,
      payment_annul_flag_NEW       ,
      payment_annul_date_time_NEW  ,
      payment_annul_reason_NEW     ,
      user_who_annulate_NEW        ,

      remark_NEW                   ,
      received_payment_type_id_NEW ,
      reverseschet_NEW             ,
      parent_payment_id_NEW        ,
      is_distributed_NEW          ,
      payment_period_NEW)
    values
    ( sysdate       ,
      vCURRENT_SCHEMA,
      vCURRENT_USER,
      vHOST,
      vIP_ADDRESS,
      vOS_USER,
      'UPDATE'         ,

      :OLD.received_payment_id      ,

      :OLD.phone_number             ,
      :OLD.payment_sum              ,
      :OLD.payment_date_time        ,
      :OLD.contract_id              ,
      :OLD.is_contract_payment      ,
      :OLD.filial_id                ,
      :OLD.payment_annul_flag       ,
      :OLD.payment_annul_date_time  ,
      :OLD.payment_annul_reason     ,
      :OLD.user_who_annulate        ,

      :OLD.remark                   ,
      :OLD.received_payment_type_id ,
      :OLD.reverseschet             ,
      :OLD.parent_payment_id        ,
      :OLD.is_distributed           ,
      :OLD.payment_period           ,

       :NEW.phone_number             ,
      :NEW.payment_sum              ,
      :NEW.payment_date_time        ,
      :NEW.contract_id              ,
      :NEW.is_contract_payment      ,
      :NEW.filial_id                ,
      :NEW.payment_annul_flag       ,
      :NEW.payment_annul_date_time  ,
      :NEW.payment_annul_reason     ,
      :NEW.user_who_annulate        ,

      :NEW.remark                   ,
      :NEW.received_payment_type_id ,
      :NEW.reverseschet             ,
      :NEW.parent_payment_id        ,
      :NEW.is_distributed          ,
      :NEW.payment_period);
  elsif DELETING then
    insert into RECEIVED_PAYMENTS_log
    ( fdate_rec       ,
      CURR_SCHEMA      ,
      CURR_USER        ,
      HOST             ,
      IP_ADDRESS       ,
      OS_USER          ,
      faction         ,

      received_payment_id      ,

      phone_number             ,
      payment_sum              ,
      payment_date_time        ,
      contract_id              ,
      is_contract_payment      ,
      filial_id                ,
      payment_annul_flag       ,
      payment_annul_date_time  ,
      payment_annul_reason     ,
      user_who_annulate        ,

      remark                   ,
      received_payment_type_id ,
      reverseschet             ,
      parent_payment_id        ,
      is_distributed           ,
      payment_period           ,

      phone_number_NEW             ,
      payment_sum_NEW              ,
      payment_date_time_NEW        ,
      contract_id_NEW              ,
      is_contract_payment_NEW      ,
      filial_id_NEW                ,
      payment_annul_flag_NEW       ,
      payment_annul_date_time_NEW  ,
      payment_annul_reason_NEW     ,
      user_who_annulate_NEW        ,

      remark_NEW                   ,
      received_payment_type_id_NEW ,
      reverseschet_NEW             ,
      parent_payment_id_NEW        ,
      is_distributed_NEW          ,
      payment_period_NEW)
    values
    ( sysdate       ,
      vCURRENT_SCHEMA,
      vCURRENT_USER,
      vHOST,
      vIP_ADDRESS,
      vOS_USER,
      'DELETE'         ,

      :OLD.received_payment_id      ,

      :OLD.phone_number             ,
      :OLD.payment_sum              ,
      :OLD.payment_date_time        ,
      :OLD.contract_id              ,
      :OLD.is_contract_payment      ,
      :OLD.filial_id                ,
      :OLD.payment_annul_flag       ,
      :OLD.payment_annul_date_time  ,
      :OLD.payment_annul_reason     ,
      :OLD.user_who_annulate        ,

      :OLD.remark                   ,
      :OLD.received_payment_type_id ,
      :OLD.reverseschet             ,
      :OLD.parent_payment_id        ,
      :OLD.is_distributed           ,
      :OLD.payment_period           ,

      NULL             ,
      NULL              ,
      NULL        ,
      NULL              ,
      NULL      ,
      NULL                ,
      NULL       ,
      NULL  ,
      NULL     ,
      NULL        ,

      NULL                   ,
      NULL ,
      NULL             ,
      NULL        ,
      NULL          ,
      NULL);
  end if;  
    
END;
/