CREATE OR REPLACE FUNCTION GET_MOB_PAY_TXT (pPHONEA IN VARCHAR2, pUSER in VARCHAR2 := 'USSD_USER' )
   RETURN VARCHAR2
IS
  --#Version=2
  --v2. 03.09.2015 Соколов Добавил таблицу MOB_PAY_IN_PROCESSED.
   PRAGMA AUTONOMOUS_TRANSACTION;
   MOB_PAY_TXT   VARCHAR2 (300 CHAR);
   flag          INTEGER;
   s_pay         NUMBER;
BEGIN
   --делаем проверку навозможность добавления обещанного платежа
   SELECT COUNT (*)
     INTO flag
     FROM (
            SELECT cbr.phone FROM MOB_PAY_REQUEST cbr
            UNION ALL
            SELECT pn.phone FROM MOB_PAY_IN_PROCESSED pn
          ) t
   WHERE t.phone = pPHONEA;

   IF flag = 0
   THEN
      BEGIN
         SELECT mp.sum_pay
           INTO s_pay
           FROM mob_pay mp
          WHERE mp.phone = pPHONEA AND mp.date_pay IS NULL;

         INSERT INTO MOB_PAY_REQUEST (PHONE, SUM_PAY, USER_CREATED)
              VALUES (pPHONEA, s_pay, pUSER);

         COMMIT;
         MOB_PAY_TXT :=
            'Ваша заявка добавлена в очередь.';
      EXCEPTION
         WHEN OTHERS
         THEN
            MOB_PAY_TXT := 'Неверный запрос.';
      END;
   ELSE
      MOB_PAY_TXT :=
         'Запрос не выполнен. Ваша предыдущая заявка еще не обработана.';
   END IF;

   RETURN MOB_PAY_TXT;
END;