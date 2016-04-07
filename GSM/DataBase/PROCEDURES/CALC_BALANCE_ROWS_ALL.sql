CREATE OR REPLACE PROCEDURE CALC_BALANCE_ROWS_ALL
IS
--
--#Version=1
--
--v.1 27.05.2015 Афросин  Получение всех расшифровок баланса
--
   L   BINARY_INTEGER;
BEGIN
   EXECUTE IMMEDIATE 'TRUNCATE TABLE ABONENT_BALANCE_ROWS_ALL';

--   COMMIT;

   FOR rec
      IN (SELECT d.PHONE_NUMBER
            FROM db_loader_phone_periods d
           WHERE     d.YEAR_MONTH =
                        TO_NUMBER (
                           TO_CHAR (ADD_MONTHS (SYSDATE, -1), 'YYYYMM'))
                 AND NOT EXISTS
                            (SELECT 1
                               FROM tarifer_bill_for_clients v
                              WHERE     v.YEAR_MONTH = d.YEAR_MONTH
                                    AND v.PHONE_NUMBER = d.PHONE_NUMBER))
   LOOP
     --CALC_BALANCE_ROWS_NO_CREDIT (rec.PHONE_NUMBER);
     CALC_BALANCE_ROWS (rec.PHONE_NUMBER);
      
     INSERT INTO ABONENT_BALANCE_ROWS_ALL (phone_number,
                                            ROW_DATE,
                                            ROW_COST,
                                            ROW_COMMENT,
                                            ROW_TYPE
                                            )
         SELECT rec.PHONE_NUMBER,
                ROW_DATE,
                ROW_COST,
                ROW_COMMENT,
                CASE
                  WHEN ROW_COMMENT LIKE '1 Абонплата%' THEN
                     1
                  WHEN ROW_COMMENT LIKE '2 Абонплата за услугу%'THEN
                     2
                  WHEN ROW_COMMENT LIKE 'Дет. зв. из тек. нач.%' THEN
                     3
                  WHEN ROW_COMMENT LIKE 'Детализация звонков%' THEN
                     4
                  WHEN ROW_COMMENT LIKE 'Подключена услуга%' THEN
                     5
                  WHEN ROW_COMMENT LIKE 'Рассрочка:%' THEN
                     6
                  WHEN ROW_COMMENT LIKE 'Депозит клиента%' THEN
                     7
                  WHEN ROW_COMMENT LIKE 'Счёт%' THEN
                     10
                  WHEN ROW_COMMENT LIKE 'Оплата: Стартовый баланс%' THEN
                     11
                  WHEN ROW_COMMENT LIKE 'Оплата: Зарегистрирован в офисе:%' THEN
                     12
                  WHEN ROW_COMMENT LIKE 'Оплата Компенсирующая:%' THEN
                     13
                  WHEN ROW_COMMENT LIKE 'Оплата:%' THEN
                     20
                ELSE
                   -1
             END 
           FROM ABONENT_BALANCE_ROWS;
      COMMIT;
   END LOOP;
END;
/
