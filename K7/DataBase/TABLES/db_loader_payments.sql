CREATE TABLE DB_LOADER_PAYMENTS(
  ACCOUNT_ID               INTEGER,
  YEAR_MONTH               INTEGER,
  PHONE_NUMBER             VARCHAR2(10 CHAR),
  PAYMENT_DATE             DATE,
  PAYMENT_SUM              NUMBER(15,2),
  PAYMENT_STATUS_IS_VALID  NUMBER(1),
  PAYMENT_NUMBER           VARCHAR2(30 CHAR),
  PAYMENT_STATUS_TEXT      VARCHAR2(200 CHAR),
  CONTRACT_ID              INTEGER,
  DATE_CREATED             DATE
  );

COMMENT ON COLUMN DB_LOADER_PAYMENTS.CONTRACT_ID IS 'Ссылка на контракт, к которому относится платёж';

COMMENT ON COLUMN DB_LOADER_PAYMENTS.DATE_CREATED IS 'Дата загрузки платежа в БД';

CREATE INDEX I_DB_LOADER_PAYMENTS_CONTRACT ON DB_LOADER_PAYMENTS(CONTRACT_ID);

CREATE INDEX I_DB_LOADER_PAYMENTS_PHONE ON DB_LOADER_PAYMENTS
  (ACCOUNT_ID, TO_NUMBER("PHONE_NUMBER"), SIGN("PAYMENT_SUM"), PAYMENT_NUMBER);

CREATE UNIQUE INDEX U_LDR_PAYMENTS ON DB_LOADER_PAYMENTS
  (PHONE_NUMBER, PAYMENT_NUMBER, PAYMENT_SUM, PAYMENT_DATE, PAYMENT_STATUS_IS_VALID);

CREATE INDEX I_DB_LOADER_PAYMENTS_F2 ON DB_LOADER_PAYMENTS
  (ACCOUNT_ID, NVL(PAYMENT_NUMBER, 0), NVL(phone_number, '000')) 
  COMPRESS 1;

CREATE OR REPLACE TRIGGER TI_DB_LOADER_PAYMENTS
--
--#Version=6
--v.6 2015.11.06 Соколов. Исправил аннулирование обещвнного платежа
--v.5 2015.09.29 Крайнов. Логирование изменений по обещанному платежу
--v.4 22.09.2015 Кочнев при пополнении баланса, средства списываются на погашение действующего обещанного платежа. Оповещаем об этом абонентов по смс.
--v.3 13.08.2015 Афросин.Убрал обновление обещанного платежа по коллекторам и коммерсам
--v.2 13.08.2015 Соколов. Добавлено аннулирование или списание обещаного платежа при поступление на баланс
BEFORE INSERT ON DB_LOADER_PAYMENTS
  REFERENCING NEW AS NEW OLD AS OLD FOR EACH ROW
declare
  CURSOR C(YH IN DATE, PH IN VARCHAR2) IS
    SELECT *
      FROM PROMISED_PAYMENTS PP
      WHERE PP.PHONE_NUMBER = PH
        AND PP.PAYMENT_DATE <= YH
        AND PP.PROMISED_DATE >= YH;
  --проверяем номер на коллектора и коммерсов
  --если коммерсы или коллектор, то ничего не делаем с обещанным платежом
  vDUMMY C%ROWTYPE;
  SUM_PAYMENT NUMBER;
  vDATE_TIME_PAY DATE;
  SMS_TXT VARCHAR2(500 char);
  LOG_TXT VARCHAR2(500 char);
  function NEED_EDIT_PROMISED_PAYMENT(
    pPhone_number in varchar2
    ) return INTEGER as
    vRes Integer;
  begin  
    select count(*) into vRES from accounts
    where account_id  = CONVERT_PCKG.GET_ACCOUNT_ID_BY_PHONE(pPhone_number)
      and (nvl( IS_COLLECTOR, 0) = 1 or UPPER(COMPANY_NAME) like '%КОММЕРС%');      
    if nvl(vRES, 0) > 0 then
      vRes := 0;
    else
      vRES := 1;
    end if;
    Return vRes;
  end;
BEGIN
  vDATE_TIME_PAY := SYSDATE;  
  :NEW.DATE_CREATED := vDATE_TIME_PAY;
  if :new.phone_number is not null then        
    if NEED_EDIT_PROMISED_PAYMENT(:NEW.PHONE_NUMBER) = 1 then   
      OPEN C(SYSDATE, :NEW.PHONE_NUMBER);
      FETCH C INTO vDUMMY;
      --- Соколов(Анулирование или списание)
      IF C%FOUND THEN
        SUM_PAYMENT := vDUMMY.PROMISED_SUM - :NEW.PAYMENT_SUM;
        IF SUM_PAYMENT > 0 THEN
          UPDATE PROMISED_PAYMENTS PP
            SET PP.PROMISED_SUM = SUM_PAYMENT
            WHERE PP.PHONE_NUMBER = :NEW.PHONE_NUMBER
             /* AND PP.PAYMENT_DATE <= :NEW.PAYMENT_DATE
              AND PP.PROMISED_DATE >= :NEW.PAYMENT_DATE;*/
              AND PP.PAYMENT_DATE <= SYSDATE
              AND PP.PROMISED_DATE >= SYSDATE;
          SMS_TXT := 'Средства зачисленные на баланс направлены '
              || 'на погашение текущего обещанного платежа. '
              || 'Остаток по обещенному платежу: '|| SUM_PAYMENT||' р.'; 
          LOG_TXT := 'Списание в счет непогашенного ОП. '
              || 'Остаток по обещенному платежу: '|| SUM_PAYMENT||' р.';
        ELSE
          UPDATE PROMISED_PAYMENTS PP
            SET PP.PROMISED_DATE = vDATE_TIME_PAY
            WHERE PP.PHONE_NUMBER = :NEW.PHONE_NUMBER
              AND PP.PAYMENT_DATE <= SYSDATE
              AND PP.PROMISED_DATE >= SYSDATE;
          SMS_TXT := 'Средства зачисленные на баланс направлены '
              || 'на погашение текущего обещанного платежа. '
              || 'Обещанный платеж погашен.'; 
          LOG_TXT := 'Списание ОП.';
        END IF;--IF SUM_PAYMENT > 0  
        insert into PROMISED_PAYMENTS_CHANGE_LOG(
                  account_id, year_month, phone_number, payment_date, 
                  payment_sum, payment_status_is_valid, payment_number, 
                  payment_status_text, contract_id, date_created, comm_txt) 
          values(:NEW.account_id, :NEW.year_month, :NEW.phone_number, :NEW.payment_date, 
                 :NEW.payment_sum, :NEW.payment_status_is_valid, :NEW.payment_number,
                 :NEW.payment_status_text, :NEW.contract_id, :NEW.date_created, LOG_TXT); 
        SEND_SMS_PROMISED_PAYMENT(:NEW.PHONE_NUMBER, SMS_TXT); 
      END IF;--IF C%FOUND THEN      
      CLOSE C;
    end if;--NEED_EDIT_PROMISED_PAYMENT(:NEW.PHONE_NUMBER)
    INSERT INTO QUEUE_CURRENT_BALANCES(PHONE_NUMBER, QUEUE_TYPE)
    VALUES(:NEW.PHONE_NUMBER, 42);
  end if;
END;
/

ALTER TABLE DB_LOADER_PAYMENTS ADD (
  CONSTRAINT U_LDR_PAYMENTS
  UNIQUE (PHONE_NUMBER, PAYMENT_NUMBER, PAYMENT_SUM, PAYMENT_DATE, PAYMENT_STATUS_IS_VALID)
  USING INDEX U_LDR_PAYMENTS
  ENABLE VALIDATE);

ALTER TABLE DB_LOADER_PAYMENTS ADD (
  CONSTRAINT FK_DB_LOADER_PAYMENTS_CONTRACT 
  FOREIGN KEY (CONTRACT_ID) 
  REFERENCES CONTRACTS (CONTRACT_ID)
  ON DELETE SET NULL
  ENABLE VALIDATE);

GRANT DELETE, INSERT, SELECT, UPDATE ON CORP_MOBILE.DB_LOADER_PAYMENTS TO CORP_MOBILE_ROLE;

GRANT SELECT ON CORP_MOBILE.DB_LOADER_PAYMENTS TO CORP_MOBILE_ROLE_RO;
