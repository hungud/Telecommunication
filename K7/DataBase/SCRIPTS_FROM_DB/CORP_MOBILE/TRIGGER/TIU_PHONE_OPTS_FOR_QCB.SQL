
  CREATE OR REPLACE TRIGGER "CORP_MOBILE"."TIU_PHONE_OPTS_FOR_QCB" 
BEFORE INSERT OR UPDATE
ON CORP_MOBILE.DB_LOADER_ACCOUNT_PHONE_OPTS 
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
DECLARE
    sms varchar2(512);
    pTarCount integer;
    pCnt integer;
    pRes integer;
    provv_id integer;
BEGIN
  IF INSERTING THEN
    INSERT INTO QUEUE_CURRENT_BALANCES(PHONE_NUMBER, QUEUE_TYPE) VALUES(:NEW.PHONE_NUMBER, 46);
    :NEW.ADDED_FOR_RETARIF := GET_OPT_ADDED_FOR_RETARIF(:NEW.ACCOUNT_ID, :NEW.PHONE_NUMBER, :NEW.OPTION_CODE);
    --
    --для тестирования указываем номер (потом уберем и распространим на всех)
    IF (:NEW.TURN_OFF_DATE IS NULL) AND (to_number(to_char(sysdate, 'DD')) <> 1) THEN
        BEGIN
            --проверяем была ли по данному номеру в прошлом месяце услуга с таким же кодом с открытой датой отключения
            SELECT count(*)
            INTO pCnt
            FROM DB_LOADER_ACCOUNT_PHONE_OPTS db
            WHERE DB.PHONE_NUMBER = :NEW.PHONE_NUMBER
            AND DB.YEAR_MONTH = to_number(to_char(add_months(to_date(:NEW.YEAR_MONTH, 'YYYYMM'), -1), 'YYYYMM'))
            AND DB.OPTION_CODE = :NEW.OPTION_CODE
            AND DB.TURN_OFF_DATE IS NULL;
            
            pRes := 0;
            --если есть, то необходимо проверить наличие закрытой услуги в текущем месяце
            IF pCnt > 0 THEN
                SELECT count(*)
                INTO pCnt
                FROM DB_LOADER_ACCOUNT_PHONE_OPTS db
                WHERE DB.PHONE_NUMBER = :NEW.PHONE_NUMBER
                AND DB.YEAR_MONTH = :NEW.YEAR_MONTH
                AND DB.OPTION_CODE = :NEW.OPTION_CODE
                AND DB.TURN_OFF_DATE IS NOT NULL;
                
                --если нет такой услуги, то смс не отсылаем
                IF pCnt = 0 THEN
                    pRes := 1;
                END IF;
            END IF;
            
            IF pRes = 0 THEN
                --проверяем на возможность отправки смс
                SELECT COUNT(*)
                   INTO pTarCount
                  FROM TARIFF_OPTIONS op
                WHERE OP.OPTION_CODE = :NEW.OPTION_CODE 
                     AND OP.OPTION_NAME_FOR_AB IS NOT NULL --берем только те услуги, у которых имеется текст сообщения для отправки
                     AND OP.OPTION_NAME_FOR_AB <> '-' --исключаем сообщения с текстом "-"
                     AND NVL(OP.IS_AUTO_INTERNET, 0) <> 1 --убераем услуги с автоподключением
                     AND NOT EXISTS --смс о подкл. услуги отправляем если услуга не включена в тариф (стоимость не нулевая)
                                        (
                                            SELECT 1
                                              FROM TARIFF_OPTION_NEW_COST cs
                                            WHERE CS.TARIFF_ID = GET_CURR_PHONE_TARIFF_ID(:NEW.PHONE_NUMBER)
                                                 AND CS.TARIFF_OPTION_COST_ID = 
                                                                                                       (
                                                                                                         SELECT OC.TARIFF_OPTION_COST_ID
                                                                                                           FROM TARIFF_OPTION_COSTS oc
                                                                                                         WHERE OC.TARIFF_OPTION_ID = OP.TARIFF_OPTION_ID
                                                                                                       )
                                                 AND NVL(CS.TURN_ON_COST, 0) = 0
                                                 AND NVL(CS.MONTHLY_COST, 0) = 0
                                        )
                     AND 2 < TRUNC(SYSDATE) - ( --не отправляем смс в первые 2 дня после заведения контракта
                                                                   select trunc(V.CONTRACT_DATE)
                                                                     from v_contracts v
                                                                   where V.PHONE_NUMBER_FEDERAL = :NEW.PHONE_NUMBER
                                                                       and V.CONTRACT_CANCEL_DATE is null
                                                              )
                     AND 0 = (
                                     select count(*)
                                      from DB_LOADER_ACCOUNT_PHONE_OPTS db
                                    where DB.PHONE_NUMBER = :NEW.PHONE_NUMBER
                                        and DB.YEAR_MONTH = :NEW.YEAR_MONTH
                                        and DB.OPTION_CODE = OP.OPTION_CODE
                                        and trunc(DB.TURN_OFF_DATE) = :NEW.TURN_ON_DATE
                                  ); --билайн иногда косячит и переподключает услуги, это надо учесть
                                     --если в тек месяце есть услуга, у которой дата откл. = дате подкл. новой услуги, то отсекаем
                --
                IF pTarCount > 0 THEN
                    --отправляем смс
                    --проверяем на то, чтобы дата подключения не была пустой
                    IF :NEW.TURN_ON_DATE IS NOT NULL THEN 
                        --если дата подключения > дате загрузки в тарифер, то отправляем смс в дату подключения (ставим в очередь)
                        IF TRUNC(:NEW.TURN_ON_DATE) > TRUNC(SYSDATE)  THEN
                            --определяем провайдера
                            begin
                                select ssa.provider_id 
                                   into provv_id 
                                  from SMS_SEND_PARAM_BY_ACCOUNT ssa
                                where ssa.account_id=GET_ACCOUNT_ID_BY_PHONE(:NEW.PHONE_NUMBER);
                            exception
                               when others then
                                   provv_id :=0;
                            end;
                             --
                            IF provv_id <> 0 THEN
                                sms_add_request(provv_id, :NEW.PHONE_NUMBER, 'Опция "'||:NEW.OPTION_NAME||'" подключена.', TRUNC(:NEW.TURN_ON_DATE)+9/24);
                            END IF;
                        ELSE  --иначе, отправляем сегодняшним днем
                            --если дата подключения = дате загрузки, то отправляем. Старые не отправляем
                            IF TRUNC(:NEW.TURN_ON_DATE) = TRUNC(SYSDATE) THEN
                                sms:=loader3_pckg.SEND_SMS(:NEW.PHONE_NUMBER, null, 'Опция "'||:NEW.OPTION_NAME||'" подключена.'); 
                            END IF;
                        END IF; 
                    END IF;                        
                END IF;
            END IF;
        EXCEPTION
            WHEN OTHERS THEN
                NULL;
        END;
    END IF;
    --
  END IF;
  IF UPDATING AND :NEW.TURN_OFF_DATE is not NULL AND :OLD.TURN_OFF_DATE is NULL THEN
    INSERT INTO QUEUE_CURRENT_BALANCES(PHONE_NUMBER, QUEUE_TYPE) VALUES(:OLD.PHONE_NUMBER, 46);
    IF :OLD.ADDED_FOR_RETARIF = 1 THEN
      UPDATE ROAMING_RETARIF_PHONES RRP
        SET RRP.SERVICE_OFF_CONFIRMED_DATETIME = SYSDATE
        WHERE RRP.PHONE_NUMBER = :NEW.PHONE_NUMBER
          AND RRP.OPTION_CODE = :NEW.OPTION_CODE
          AND RRP.END_DATE_TIME IS NOT NULL
          AND RRP.SERVICE_OFF_CONFIRMED_DATETIME IS NULL;
    END IF;  
  END IF;
END;
ALTER TRIGGER "CORP_MOBILE"."TIU_PHONE_OPTS_FOR_QCB" ENABLE