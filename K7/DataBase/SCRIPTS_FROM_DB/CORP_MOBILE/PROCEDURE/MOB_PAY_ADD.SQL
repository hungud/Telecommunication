
  CREATE OR REPLACE PROCEDURE "CORP_MOBILE"."MOB_PAY_ADD" (pPHONE IN VARCHAR2, pSUM IN NUMBER)
IS
   f   NUMBER;
--#Version=2
--
--v.2 Афросин 23.04.2015 Добавил список полей в  INSERT INTO mob_pay 
--
BEGIN
   SELECT COUNT (*)
     INTO f
     FROM mob_pay mp
    WHERE mp.phone = pPHONE AND mp.date_pay IS NULL;

   IF f > 0 THEN
      UPDATE mob_pay mp
         SET mp.sum_pay = pSUM
       WHERE mp.phone = pPHONE AND mp.date_pay IS NULL;
   ELSE
      INSERT INTO mob_pay (PHONE, SUM_PAY, DATE_INSERT, DATE_PAY, USER_CREATED)
           VALUES (pPHONE, pSUM, NULL, NULL, USER);
   END IF;

   COMMIT;
EXCEPTION
   WHEN OTHERS THEN
      NULL;
END;