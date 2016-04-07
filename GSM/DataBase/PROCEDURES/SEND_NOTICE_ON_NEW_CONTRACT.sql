CREATE OR REPLACE PROCEDURE SEND_NOTICE_ON_NEW_CONTRACT(
  pCONTRACT_ID IN INTEGER
  ) IS
--
--Version=11
--v11. 16.01.2016 - Алексеев Убрал СМС "НЕВЕРОЯТНО!Добавляем 10% к платежу при пополнении через сайт www.gsmcorporacia.ru/oplata_uslug и через приложение www.gsmcorp.ru/m"
--v10. 14.12.2015 - Афросин Убрал СМС "НЕВЕРОЯТНО!Добавляем 10% к платежу при пополнении через сайт www.gsmcorporacia.ru/oplata_uslug и через приложение www.gsmcorp.ru/m"
--v9.25.11.2015 - Соколов Добавил СМС "НЕВЕРОЯТНО!Добавляем 10% к платежу при пополнении через сайт www.gsmcorporacia.ru/oplata_uslug и через приложение www.gsmcorp.ru/m"
--v.8 29.09.2015 - Кочнев  убрал смс с текстом "Приложение GSM и  'Добавляем '||TO_CHAR(vPERCECNT_PAYKEEPER)||'% к Вашему платежу
-- по просьбе Александра Коломацкого
--v.7 20.08.2015 - Афросин - добавил еще одну смс с текстом "Приложение GSM Corporacia для iOS http://www.gsmcorporacia.ru/itunes моментальная оплата ,личный кабинет,акции и скидки ,выбор и заказ красивых номеров и многое другое"
--v.6 13.07.2015 - Матюнин И. - по просьюе Коломацкого,добавлено оповещение о бонусе при оплате банковской картой
                            -- вставку в  BLOCK_SEND_SMS в конце убрал - потому как она непонятно зачем тут и никто не знает!
--v.5 17.03.2015 Афросин Добавил в сообщение с информацией о USSD текст "проверка остатков трафика по тарифу *200*5550#"  
-- Овсянников Л.В. 12.11.2012 Добавление отправка ещё 2-х смс при подключении нового абонента.
-- Овсянников Л.В. 13.11.2012 Исправление текста 2-ой смс.
  CURSOR C IS
    SELECT CONTRACTS.PHONE_NUMBER_FEDERAL,
           OPERATORS.OPERATOR_NAME,
           ABONENTS.SURNAME||' '||ABONENTS.NAME||' '||ABONENTS.PATRONYMIC FIO         
      FROM CONTRACTS, 
           OPERATORS,
           ABONENTS      
      WHERE CONTRACTS.CONTRACT_ID=pCONTRACT_ID
        AND CONTRACTS.OPERATOR_ID=OPERATORS.OPERATOR_ID
        AND CONTRACTS.ABONENT_ID=ABONENTS.ABONENT_ID;      
  rec C%ROWTYPE;
  SMS_TEXT VARCHAR2(500 CHAR);
  SMS VARCHAR2(500 CHAR);
  vPERCECNT_PAYKEEPER NUMBER;
  vPAYKEEPER_COEFFICIENT NUMBER; 
BEGIN
  OPEN C;
  FETCH C INTO rec;
  CLOSE C;
  IF rec.OPERATOR_NAME='Билайн' THEN
    
    for rec_sms in (
                    select * from
                     (
                      select 1 sort_idx, 'Вас приветствует gsmcorp.ru, спасибо,что воспользовались услугами нашей компании!' SMS_TEXT from dual
                      union all
                      select 2  sort_idx, 'Ув. абонент, проверить баланс - *200*555# и 0588, проверка остатков трафика по тарифу *200*5550#, а так же в разделе кабинет абонента на нашем сайте gsmcorporacia.ru/lk/MAIN' SMS_TEXT from dual
                      union all
                      select 3  sort_idx, 'Служба поддержки - 84956487888 или с мобильного - 05455 (работает при блокировке).' SMS_TEXT from dual
                      /*union all
                      select 4  sort_idx, 'НЕВЕРОЯТНО! Добавляем 10% к платежу при пополнении через сайт www.gsmcorporacia.ru/oplata_uslug и через приложение www.gsmcorp.ru/m' SMS_TEXT from dual*/
                     )
                    order by sort_idx desc
                   )
    loop
      SMS:=LOADER3_PCKG.SEND_SMS(
           rec.PHONE_NUMBER_FEDERAL,
           'Смс-оповещение',
           rec_sms.SMS_TEXT);
      -- ждем секунду для соблюдеиня очередности отправки смс
      dbms_lock.sleep(1);  
    end loop;
    
    --v6 - при коэффициенте >1 действеут акция
    --vPAYKEEPER_COEFFICIENT := GET_PAYKEEPER_COEFFICIENT;
   -- IF NVL(vPAYKEEPER_COEFFICIENT, 0 ) > 1 THEN
   --   vPERCECNT_PAYKEEPER := (vPAYKEEPER_COEFFICIENT - 1)*100; -- ВЫЧИСЛЯЕМ ПРОЦЕНТ
     -- SMS_TEXT := 'Добавляем '||TO_CHAR(vPERCECNT_PAYKEEPER)||'% к Вашему платежу при оплате картой на нашем сайте! http://www.gsmcorporacia.ru/oplata_uslug/'; 
     -- SMS:=LOADER3_PCKG.SEND_SMS(
     --        rec.PHONE_NUMBER_FEDERAL,
      --       'Смс-оповещение',
      --       SMS_TEXT);  
    --END IF;

-- Закомментировал, так здесь не нужно
--    IF SMS IS NULL THEN  
--      INSERT INTO BLOCK_SEND_SMS(PHONE_NUMBER, SEND_DATE_TIME, ABONENT_FIO) 
--        VALUES (rec.PHONE_NUMBER_FEDERAL, sysdate, rec.FIO);
--    END IF;

    COMMIT;       
  END IF;
END;