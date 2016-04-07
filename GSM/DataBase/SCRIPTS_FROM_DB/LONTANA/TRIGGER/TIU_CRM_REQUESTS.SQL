
  CREATE OR REPLACE TRIGGER "LONTANA"."TIU_CRM_REQUESTS" 
BEFORE INSERT OR UPDATE
ON LONTANA.CRM_REQUESTS 
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
DECLARE 
  PRAGMA AUTONOMOUS_TRANSACTION;
  sms varchar2(512);
  v_DOP_CONTACT integer;
  function convertDOP_CONTACT_to_num(pDOP_CONTACT varchar2) return integer
  as
    res integer;
  begin
    begin
      res := to_number(pDOP_CONTACT);
    exception
      when others then
      res := 0;
    end;
    Return res;
  end;
BEGIN
  IF INSERTING THEN
    IF NVL(:NEW.REQUEST_ID, 0) = 0 then
      :NEW.REQUEST_ID := S_NEW_REQUEST_ID.NEXTVAL;
    END IF;
  END IF;
  IF UPDATING THEN 
    IF (:OLD.ID_STATUS_REQUEST<>:NEW.ID_STATUS_REQUEST) AND (:NEW.ID_STATUS_REQUEST=3) AND (:NEW.TYPE_REQUEST_ID <> 121) THEN 
        v_DOP_CONTACT := convertDOP_CONTACT_to_num(:NEW.DOP_CONTACT);
        IF :NEW.TYPE_REQUEST_ID <> 8 THEN
            --отправляем на номер абонента
            IF nvl(:NEW.PHONE_NUMBER, 0) <> 0 THEN 
                sms:=loader3_pckg.SEND_SMS(:NEW.PHONE_NUMBER, null,'Выполнение заявки №'||:NEW.REQUEST_ID||', временно преостановлено, подробности по телефону 8-495-788-79-08');
            END IF; 
            --если доп. номер <> номеру абонента, то отправляем на него тоже   
            IF nvl(v_DOP_CONTACT, 0) <> 0 THEN --если доп. номер не пустой
                IF nvl(v_DOP_CONTACT, 0) <> nvl(:NEW.PHONE_NUMBER, 0) THEN --если доп. номер <> номеру абонента, а иначе получается что шлем 2 смс на один номер, а это неправильно
                    sms:=loader3_pckg.SEND_SMS(v_DOP_CONTACT, null,'Выполнение заявки №'||:NEW.REQUEST_ID||', временно преостановлено, подробности по телефону 8-495-788-79-08');
                END IF;
            END IF;  
        ELSE
            --отправляем на номер, по которому звонили, а это доп. номер
            IF nvl(v_DOP_CONTACT, 0) <> 0 THEN --если доп. номер не пустой
                sms:=loader3_pckg.SEND_SMS(v_DOP_CONTACT, null,'Выполнение заявки №'||:NEW.REQUEST_ID||', временно преостановлено, подробности по телефону 8-495-788-79-08');
            ELSE --если доп. номер пустой, то отправляем на номер, который ууказан как номер абонента (получается что с него звонили)
                IF nvl(:NEW.PHONE_NUMBER, 0) <> 0 THEN 
                    sms:=loader3_pckg.SEND_SMS(:NEW.PHONE_NUMBER, null,'Выполнение заявки №'||:NEW.REQUEST_ID||', временно преостановлено, подробности по телефону 8-495-788-79-08');
                END IF; 
            END IF;     
        END IF;
    END IF;
  END IF;
  :NEW.DATE_LAST_UPDATED:=SYSDATE;
END;
ALTER TRIGGER "LONTANA"."TIU_CRM_REQUESTS" ENABLE