
  CREATE OR REPLACE FUNCTION "CORP_MOBILE"."MOB_PAY_ADDF" (pPHONE   IN VARCHAR2,
                                         pSUM     IN NUMBER,
                                         pCHECK   IN NUMBER DEFAULT NULL)
   RETURN VARCHAR2
AS
   f   NUMBER;
--#Version=3
--
--v.3 23.04.2015 Афросин Добавил список полей в  INSERT INTO mob_pay
--v.2 13.01.2015 Котенков. (Задача 2555) Убрана проверка на не проведенный платеж, добавлено возвращение текста результата.

BEGIN
   SELECT CASE
             WHEN cnt = 0
             THEN
                -1
             ELSE
                (SELECT mp.sum_pay
                   FROM mob_pay mp
                  WHERE mp.phone = pPHONE AND mp.date_pay IS NULL)
          END
             mobi
     INTO f
     FROM (SELECT COUNT (*) cnt
             FROM (SELECT mp.sum_pay
                     FROM mob_pay mp
                    WHERE mp.phone = pPHONE AND mp.date_pay IS NULL));

   IF f > 0
   THEN
      UPDATE mob_pay mp
         SET mp.sum_pay = pSUM
       WHERE mp.phone = pPHONE AND mp.date_pay IS NULL;

      INSERT INTO many_logs (log_source_id,
                             year_month,
                             phone_number,
                             date_on,
                             text_messages,
                             note,
                             login_session)
              VALUES (
                        GET_LOG_SOURCE_ID ('MOBIEPAY'),
                        TO_NUMBER (TO_CHAR (SYSDATE, 'yyyymm')),
                        pPHONE,
                        SYSDATE,
                           'Не проведенный платеж '
                        || TO_CHAR (f)
                        || 'р. заменен на '
                        || TO_CHAR (pSUM)
                        || 'р.',
                        'Добавление новых платежей из файла',
                        SYS_CONTEXT ('USERENV', 'CURRENT_USER'));

      --      return f;
      RETURN 'Отобран оператором до активации.';
   ELSE
      INSERT INTO mob_pay (PHONE,
                           SUM_PAY,
                           DATE_INSERT,
                           DATE_PAY)
           VALUES (pPHONE,
                   pSUM,
                   NULL,
                   NULL);

      INSERT INTO many_logs (log_source_id,
                             year_month,
                             phone_number,
                             date_on,
                             text_messages,
                             note,
                             login_session)
              VALUES (
                        GET_LOG_SOURCE_ID ('MOBIEPAY'),
                        TO_NUMBER (TO_CHAR (SYSDATE, 'yyyymm')),
                        pPHONE,
                        SYSDATE,
                           'Добавлен новый платеж на '
                        || TO_CHAR (pSUM)
                        || 'р.',
                        'Добавление новых платежей из файла',
                        SYS_CONTEXT ('USERENV', 'CURRENT_USER'));

      --    return 0;
      RETURN 'Был активирован, повторное поступление.';
   END IF;

   COMMIT;
EXCEPTION
   WHEN OTHERS
   THEN
      --    return 0;
      RETURN 'Ошибка при добавлении платежа!';
END;