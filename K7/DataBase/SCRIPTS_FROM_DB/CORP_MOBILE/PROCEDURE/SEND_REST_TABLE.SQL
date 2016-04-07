
  CREATE OR REPLACE PROCEDURE "CORP_MOBILE"."SEND_REST_TABLE" 
AS
   --
   --Version=3
   --
   --v.3 Афросин 12.03.2015 - При отстутствии пакетов позвращаем результат'Подключенных пакетов нет'
   --                        Для коллектора убираем все отображение INTERNET,если действующий тариф имеет признак is_auto_internet = 1
   --v.2 Афросин 25.02.2015 - Переделки касательно текста сообщения и тарифов MSK1000_F
   --v.1 Афросин 20.02.2015 - Добавил процедуру
   --
   CURSOR phones
   IS
      SELECT PHONE_NUMBER FROM USSD_TARIFF_REST_QUEUE;

   C_CELL_PLAN_CODE   CONSTANT VARCHAR2 (9) := 'MSK1000_F';

   res                         VARCHAR2 (1000);
   --======Только коллекторы===================
   --призанк удаления строки международной связи - Международная связь
   del_str                     BOOLEAN;

   --признак удаления интернета тарифов с признаком IS_AUTO_INTERNET
   del_auto_internet           BOOLEAN;

   --======Конец Только коллекторы===================
   tar_count                   INTEGER;
BEGIN
   FOR ph IN phones
   LOOP
      del_str := FALSE;
      del_auto_internet := FALSE;
      tar_count := 0;

      --проверка на коллекторский счет и тариф  C_CELL_PLAN_CODE
      IF GET_IS_COLLECTOR_BY_PHONE (ph.phone_number) = 1
      THEN
         --призанк удаления строки международной связи - Международная связь
         SELECT COUNT (CELL_PLAN_CODE)
           INTO tar_count
           FROM db_loader_account_phones
          WHERE     year_month = TO_NUMBER (TO_CHAR (SYSDATE, 'yyyymm'))
                AND phone_number = ph.phone_number
                AND CELL_PLAN_CODE = C_CELL_PLAN_CODE;

         IF NVL (tar_count, 0) > 0
         THEN
            del_str := TRUE;
         END IF;

         --признак удаления интернета тарифов с признаком IS_AUTO_INTERNET
         SELECT COUNT (*)
           INTO tar_count
           FROM tariffs
          WHERE     is_auto_internet = 1
                AND tariff_id = GET_CURR_PHONE_TARIFF_ID (ph.phone_number);

         IF NVL (tar_count, 0) > 0
         THEN
            del_auto_internet := TRUE;
         END IF;
      END IF;



      res := NULL;

      FOR c
         IN (SELECT --SOC_NAME,  -- Услуга
                    REST_NAME,
              CASE WHEN CURR_VALUE < 0 THEN 0 ELSE CURR_VALUE END
                    || CASE UPPER (UNIT_TYPE)
                          WHEN 'INTERNET' THEN 'Мб;'
                          WHEN 'SMS_MMS' THEN 'шт.;'
                          WHEN 'VOICE' THEN 'мин.;'
                          ELSE ''
                       END
                       CURR_VALUE,                                  --Остаток,
                       
                    UPPER (UNIT_TYPE) UNIT_TYPE
               FROM TABLE (TARIFF_RESTS_TABLE (ph.phone_number)))
      LOOP
         IF    (    del_str
                AND UPPER (C.REST_NAME) =
                       'МЕЖДУНАРОДНАЯ СВЯЗЬ ЗОЛОТО')
            OR (del_auto_internet AND C.UNIT_TYPE = 'INTERNET')
         THEN
            NULL;
         ELSE
            res := res || c.REST_NAME || ' - ' || c.CURR_VALUE || CHR (13);
         END IF;
      END LOOP;

      IF NVL (res, '-1') = '-1'
      THEN
         res := 'Подключенных пакетов нет';
      ELSE
         res := 'Остаток:' || CHR (13) || res;
      END IF;

      res :=
         LOADER3_PCKG.SEND_SMS (ph.phone_number,
                                'Остаток по пакетам',
                                res);

      DELETE FROM USSD_TARIFF_REST_QUEUE
            WHERE PHONE_NUMBER = ph.phone_number;

      COMMIT;
   END LOOP;
END;