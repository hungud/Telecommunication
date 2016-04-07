
  CREATE OR REPLACE TRIGGER "CORP_MOBILE"."TI_BSAL" 
--#Version=2
--
--v.2 Афросин 07.05.2015 добавил добавление в ADD_PHONE_FOR_CHECK_STATUS
--
--
  BEFORE INSERT ON BEELINE_SOAP_API_LOG FOR EACH ROW
BEGIN
    IF NVL(:NEW.BSAL_ID, 0) = 0 then
      :NEW.BSAL_ID :=  S_BSAL_ID.NEXTVAL;
    END IF;
    :NEW.insert_date := SYSDATE;
--  ЕСЛИ НОМЕР НЕ ПУСТОЙ И ЗАЯВКА НА БЛОКИРОВКУ ИЛИ РАЗБЛОКИРОВКУ НОМЕРА, ТО ДОБАВЛЯЕМ НОМЕР В ОЧЕРЕДЬ НА ОБНОВЛЕНИЕ СТАТУСА  
    IF NVL(:NEW.PHONE, '0') <> '0' AND :NEW.LOAD_TYPE IN (9, 10) THEN
      ADD_PHONE_FOR_CHECK_STATUS (:NEW.PHONE);
    END IF; 
END;
ALTER TRIGGER "CORP_MOBILE"."TI_BSAL" ENABLE