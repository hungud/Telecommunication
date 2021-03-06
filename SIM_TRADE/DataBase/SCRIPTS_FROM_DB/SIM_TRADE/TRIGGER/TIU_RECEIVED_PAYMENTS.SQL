
  CREATE OR REPLACE TRIGGER "SIM_TRADE"."TIU_RECEIVED_PAYMENTS" 
  BEFORE INSERT OR UPDATE ON RECEIVED_PAYMENTS FOR EACH ROW
--#Version=1
BEGIN
  IF :NEW.PAYMENT_DATE_TIME IS NULL THEN
    RAISE_APPLICATION_ERROR(-20074, 'Дата платежа не может быть пустой');
  END IF;
  IF TRUNC(:NEW.PAYMENT_DATE_TIME) > TRUNC(SYSDATE) THEN
    RAISE_APPLICATION_ERROR(-20075, 'Дата платежа не может быть позже текущей даты');
  END IF;
  IF (:NEW.PAYMENT_ANNUL_FLAG = 1) 
    AND (TRUNC(:NEW.PAYMENT_ANNUL_DATE_TIME) > TRUNC(SYSDATE)) THEN
    RAISE_APPLICATION_ERROR(-20076, 'Дата аннулирования платежа не может быть позже текущей');
  END IF;
  IF INSERTING THEN
    IF NVL(:NEW.RECEIVED_PAYMENT_ID, 0) = 0 then
      :NEW.RECEIVED_PAYMENT_ID := NEW_RECEIVED_PAYMENT_ID;
    END IF;
    :NEW.USER_CREATED := USER;
    :NEW.DATE_CREATED := SYSDATE;
  END IF;
  :NEW.USER_LAST_UPDATED := USER;
  :NEW.DATE_LAST_UPDATED := SYSDATE;
END; 

ALTER TRIGGER "SIM_TRADE"."TIU_RECEIVED_PAYMENTS" ENABLE