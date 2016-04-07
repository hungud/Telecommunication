CREATE OR REPLACE PROCEDURE TARIFER_BILL_CREATE (pYEAR_MONTH     IN INTEGER,
                                                 pPHONE_NUMBER   IN VARCHAR2)
IS
--
--#Version=1
--
--v.1 27.05.2015 Афросин создал функцию для  создания счетов
--
   
   vCOUNT   INTEGER;
BEGIN
   SELECT COUNT (*)
     INTO vCOUNT
     FROM TARIFER_BILL_FOR_CLIENTS
    WHERE YEAR_MONTH = pYEAR_MONTH AND PHONE_NUMBER = pPHONE_NUMBER;

   IF vCOUNT = 0
   THEN
      INSERT INTO TARIFER_BILL_FOR_CLIENTS (YEAR_MONTH,
                                            PHONE_NUMBER,
                                            BILL_SUMM,
                                            ABON_TP,
                                            ABON_ADD,
                                            DISCOUNT,
                                            SINGLE_PAYMENTS,
                                            SINGLE_CHANGE_TARIFF,
                                            SINGLE_CORRECTION,
                                            CALLS,
                                            CALLS_COUNTRY,
                                            CALLS_SITY,
                                            CALLS_LOCAL,
                                            CALLS_SMS_MMS,
                                            CALLS_GPRS,
                                            CALLS_RUS_RPP,
                                            CALLS_ALL,
                                            ROUMING_NATIONAL,
                                            ROUMING_INTERNATIONAL)
           VALUES (pYEAR_MONTH,
                   pPHONE_NUMBER,
                   0,
                   0,
                   0,
                   0,
                   0,
                   0,
                   0,
                   0,
                   0,
                   0,
                   0,
                   0,
                   0,
                   0,
                   0,
                   0,
                   0);

      -- Абонки
      UPDATE TARIFER_BILL_FOR_CLIENTS B
         SET B.ABON_TP =
                NVL (
                   (SELECT SUM (-x.ROW_COST)
                      FROM ABONENT_BALANCE_ROWS_ALL X
                     WHERE     X.PHONE_NUMBER = B.PHONE_NUMBER
                           AND TO_NUMBER (TO_CHAR (x.ROW_DATE, 'YYYYMM')) =
                                  B.YEAR_MONTH
                           --AND X.ROW_COMMENT LIKE '1 Абонплата%'
                           AND X.ROW_TYPE = 1),
                   0),
             B.ABON_ADD =
                NVL (
                   (SELECT SUM (-x.ROW_COST)
                      FROM ABONENT_BALANCE_ROWS_ALL X
                     WHERE     X.PHONE_NUMBER = B.PHONE_NUMBER
                           AND TO_NUMBER (TO_CHAR (x.ROW_DATE, 'YYYYMM')) =
                                  B.YEAR_MONTH
                           -- AND X.ROW_COMMENT LIKE '2 Абонплата за услугу%'
                           AND X.ROW_TYPE = 2),
                   0),
             B.CALLS =
                NVL (
                   (SELECT SUM (-x.ROW_COST)
                      FROM ABONENT_BALANCE_ROWS_ALL X
                     WHERE     X.PHONE_NUMBER = B.PHONE_NUMBER
                           AND TO_NUMBER (TO_CHAR (x.ROW_DATE, 'YYYYMM')) =
                                  B.YEAR_MONTH
                           --AND (X.ROW_COMMENT LIKE 'Дет. зв. из тек. нач.%' OR X.ROW_COMMENT LIKE 'Детализация звонков%')
                           AND (X.ROW_TYPE = 3 OR X.ROW_TYPE = 4)),
                   0),
             B.SINGLE_PAYMENTS =
                NVL (
                   (SELECT SUM (-x.ROW_COST)
                      FROM ABONENT_BALANCE_ROWS_ALL X
                     WHERE     X.PHONE_NUMBER = B.PHONE_NUMBER
                           AND TO_NUMBER (TO_CHAR (x.ROW_DATE, 'YYYYMM')) =
                                  B.YEAR_MONTH
                           --AND X.ROW_COMMENT LIKE 'Подключена услуга%'
                           AND X.ROW_TYPE = 5),
                   0),
             B.SINGLE_CHANGE_TARIFF =
                NVL (
                   (SELECT SUM (-x.PAYMENT_SUM)
                      FROM RECEIVED_PAYMENTS X
                     WHERE     X.PHONE_NUMBER = B.PHONE_NUMBER
                           AND TO_NUMBER (
                                  TO_CHAR (x.PAYMENT_DATE_TIME, 'YYYYMM')) =
                                  B.YEAR_MONTH
                           AND X.RECEIVED_PAYMENT_TYPE_ID IN (21, 41)
                           AND X.IS_CONTRACT_PAYMENT = 0
                           AND X.REVERSESCHET = 1),
                   0),
             B.SINGLE_CORRECTION =
                NVL (
                   (SELECT SUM (-x.PAYMENT_SUM)
                      FROM RECEIVED_PAYMENTS X
                     WHERE     X.PHONE_NUMBER = B.PHONE_NUMBER
                           AND TO_NUMBER (
                                  TO_CHAR (x.PAYMENT_DATE_TIME, 'YYYYMM')) =
                                  B.YEAR_MONTH
                           AND X.RECEIVED_PAYMENT_TYPE_ID NOT IN (21, 41)
                           AND X.IS_CONTRACT_PAYMENT = 0
                           AND X.REVERSESCHET = 1),
                   0)
       WHERE B.YEAR_MONTH = pYEAR_MONTH AND B.PHONE_NUMBER = pPHONE_NUMBER;

      -- Сбор Итого.
      UPDATE TARIFER_BILL_FOR_CLIENTS B
         SET B.BILL_SUMM =
                  B.BILL_SUMM
                + B.ABON_TP
                + B.ABON_ADD
                + B.CALLS
                + B.SINGLE_PAYMENTS
                + B.SINGLE_CHANGE_TARIFF
                + B.SINGLE_CORRECTION,
             B.SINGLE_PAYMENTS =
                  B.SINGLE_PAYMENTS
                + B.SINGLE_CHANGE_TARIFF
                + B.SINGLE_CORRECTION
       WHERE B.YEAR_MONTH = pYEAR_MONTH AND B.PHONE_NUMBER = pPHONE_NUMBER;

      -- Присоединение звонков по детализации
      UPDATE TARIFER_BILL_FOR_CLIENTS B
         SET B.CALLS_SMS_MMS =
                NVL (
                   (SELECT SUM (d.MMS_COST + d.SMS_COST)
                      FROM db_loader_phone_stat d
                     WHERE     d.YEAR_MONTH = b.YEAR_MONTH
                           AND d.PHONE_NUMBER = b.PHONE_NUMBER),
                   0),
             B.CALLS_GPRS =
                NVL (
                   (SELECT SUM (d.INTERNET_COST)
                      FROM db_loader_phone_stat d
                     WHERE     d.YEAR_MONTH = b.YEAR_MONTH
                           AND d.PHONE_NUMBER = b.PHONE_NUMBER),
                   0),
             B.CALLS_LOCAL =
                NVL (
                   (SELECT SUM (d.CALLS_COST)
                      FROM db_loader_phone_stat d
                     WHERE     d.YEAR_MONTH = b.YEAR_MONTH
                           AND d.PHONE_NUMBER = b.PHONE_NUMBER),
                   0),
             B.CALLS_RUS_RPP =
                  b.CALLS
                - NVL (
                     (SELECT SUM (
                                  d.CALLS_COST
                                + d.INTERNET_COST
                                + d.MMS_COST
                                + d.SMS_COST)
                        FROM db_loader_phone_stat d
                       WHERE     d.YEAR_MONTH = b.YEAR_MONTH
                             AND d.PHONE_NUMBER = b.PHONE_NUMBER),
                     0)
       WHERE B.YEAR_MONTH = pYEAR_MONTH AND B.PHONE_NUMBER = pPHONE_NUMBER;

      COMMIT;
   END IF;
END;
/
