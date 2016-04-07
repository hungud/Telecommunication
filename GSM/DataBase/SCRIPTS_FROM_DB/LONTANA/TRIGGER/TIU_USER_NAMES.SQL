
  CREATE OR REPLACE TRIGGER "LONTANA"."TIU_USER_NAMES" 
BEFORE INSERT OR UPDATE
ON LONTANA.USER_NAMES 
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
DECLARE
    pCount integer;
BEGIN 
    --если вставка
    IF INSERTING THEN
        IF NVL(:NEW.USER_NAME_ID, 0) = 0 then
            :NEW.USER_NAME_ID := NEW_USER_NAME_ID;
        END IF;
        :NEW.USER_NAME_CREATED := USER;
        :NEW.DATE_CREATED := SYSDATE;
        --записываем историю если имеется активность в CRM и указано рабочее место
        IF ( :NEW.LAST_ACTIVE IS NOT NULL ) AND
            ( NVL(:NEW.LAST_CRM_PHONEUNREF_ID, 0) <> 0 )  THEN
            INSERT INTO LOG_WORK_USER_CRM (USER_NAME_ID, CRM_PHONEUNREF_ID, BEGIN_DATE, END_DATE) 
                VALUES (:NEW.USER_NAME_ID, :NEW.LAST_CRM_PHONEUNREF_ID, :NEW.LAST_ACTIVE, :NEW.LAST_ACTIVE);
        END IF;   
    END IF;
    :NEW.USER_NAME_LAST_UPDATED := USER;
    :NEW.DATE_LAST_UPDATED := SYSDATE;
    
    --если обновление
    IF UPDATING THEN
        --если оператора нет на рабочем месте или сменилось рабочее место
        IF ( ( :OLD.LAST_ACTIVE IS NULL ) AND ( :NEW.LAST_ACTIVE IS NOT NULL ) AND ( NVL(:NEW.LAST_CRM_PHONEUNREF_ID, 0) <> 0 ) ) OR
            ( ( :NEW.LAST_ACTIVE IS NOT NULL ) AND (NVL(:NEW.LAST_CRM_PHONEUNREF_ID, 0) <> 0) AND ( NVL(:OLD.LAST_CRM_PHONEUNREF_ID, 0) <> NVL(:NEW.LAST_CRM_PHONEUNREF_ID, 0) ) ) OR
            ( 
              ( :OLD.LAST_ACTIVE IS NOT NULL ) AND ( :NEW.LAST_ACTIVE IS NOT NULL ) AND ( NVL(:NEW.LAST_CRM_PHONEUNREF_ID, 0) <> 0 ) AND
              ( (to_date(to_char(:NEW.LAST_ACTIVE, 'DD.MM.YYYY HH24:MI:SS'), 'DD.MM.YYYY HH24:MI:SS') - to_date(to_char(:OLD.LAST_ACTIVE, 'DD.MM.YYYY HH24:MI:SS'), 'DD.MM.YYYY HH24:MI:SS')) >=  40/24/60/60)
            )  THEN
            INSERT INTO LOG_WORK_USER_CRM (USER_NAME_ID, CRM_PHONEUNREF_ID, BEGIN_DATE, END_DATE) 
                VALUES (:NEW.USER_NAME_ID, :NEW.LAST_CRM_PHONEUNREF_ID, :NEW.LAST_ACTIVE, :NEW.LAST_ACTIVE);
        ELSE
            IF ( :OLD.LAST_ACTIVE IS NOT NULL ) AND 
                ( :NEW.LAST_ACTIVE IS NOT NULL ) AND 
                ( NVL(:NEW.LAST_CRM_PHONEUNREF_ID, 0) <> 0 )  AND 
                (:OLD.LAST_ACTIVE <> :NEW.LAST_ACTIVE) THEN
                --проверяем наличие записи по данному пользователю в истории 
                --(для тех пользователей по которым уже имеется активность в CRM и указано рабочее место)
                SELECT count(*)
                INTO pCount
                FROM LOG_WORK_USER_CRM cr
                WHERE cr.USER_NAME_ID = :NEW.USER_NAME_ID;     
                    
                IF pCount > 0 THEN
                    --обновление
                    UPDATE LOG_WORK_USER_CRM cr
                    SET cr.END_DATE = :NEW.LAST_ACTIVE
                    WHERE cr.CRM_PHONEUNREF_ID = :NEW.LAST_CRM_PHONEUNREF_ID
                    AND cr.USER_NAME_ID = :NEW.USER_NAME_ID
                    AND cr.DATE_CREATED = (select max(wr.DATE_CREATED)
                                                           from LOG_WORK_USER_CRM wr
                                                           where WR.CRM_PHONEUNREF_ID = CR.CRM_PHONEUNREF_ID
                                                           and WR.USER_NAME_ID = CR.USER_NAME_ID);    
                ELSE
                    --вставка
                    INSERT INTO LOG_WORK_USER_CRM (USER_NAME_ID, CRM_PHONEUNREF_ID, BEGIN_DATE, END_DATE) 
                        VALUES (:NEW.USER_NAME_ID, :NEW.LAST_CRM_PHONEUNREF_ID, :NEW.LAST_ACTIVE, :NEW.LAST_ACTIVE);
                END IF;    
            END IF;
        END IF;
    END IF;
END;
ALTER TRIGGER "LONTANA"."TIU_USER_NAMES" ENABLE