/* Formatted on 23/04/2015 17:29:00 (QP5 v5.252.13127.32867) */
CREATE OR REPLACE FUNCTION GET_MOB_PAY_TXT (pPHONEA IN VARCHAR2, pUSER in VARCHAR2 := 'USSD_USER' )
   RETURN VARCHAR2
IS
   --#Version=1
   PRAGMA AUTONOMOUS_TRANSACTION;
   MOB_PAY_TXT   VARCHAR2 (300 CHAR);
   flag          INTEGER;
   s_pay         NUMBER;
BEGIN
   SELECT COUNT (*)
     INTO flag
     FROM MOB_PAY_REQUEST cbr
    WHERE cbr.phone = pPHONEA;

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
/
