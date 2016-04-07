
  CREATE OR REPLACE PROCEDURE "CORP_MOBILE"."TARIFER_BILL_CREATE2" (
  pYEAR_MONTH IN INTEGER,
  pPHONE_NUMBER IN VARCHAR2
  ) IS
  vCOUNT INTEGER;
BEGIN
  SELECT COUNT(*)
    INTO vCOUNT
    FROM TARIFER_BILL_FOR_CLIENTS
    WHERE YEAR_MONTH = pYEAR_MONTH
      AND PHONE_NUMBER = pPHONE_NUMBER;
  IF vCOUNT = 0 THEN
    calc_balance_rows(pPHONE_NUMBER);
    INSERT INTO TARIFER_BILL_FOR_CLIENTS( YEAR_MONTH, PHONE_NUMBER, BILL_SUMM, 
                                          ABON_TP, ABON_ADD, DISCOUNT, SINGLE_PAYMENTS, SINGLE_CHANGE_TARIFF,
                                          CALLS, CALLS_COUNTRY, CALLS_SITY, CALLS_LOCAL, CALLS_SMS_MMS, CALLS_GPRS, 
                                          CALLS_RUS_RPP, CALLS_ALL, ROUMING_NATIONAL, ROUMING_INTERNATIONAL)
      VALUES(pYEAR_MONTH, pPHONE_NUMBER, 0,
             0, 0, 0, 0, 0, 
             0, 0, 0, 0, 0, 0, 
             0, 0, 0, 0);
    -- Абонки
    UPDATE TARIFER_BILL_FOR_CLIENTS B
      SET B.ABON_TP = NVL((SELECT SUM(-x.ROW_COST)
                             FROM ABONENT_BALANCE_ROWS X
                             WHERE TO_NUMBER(TO_CHAR(x.ROW_DATE, 'YYYYMM')) = pYEAR_MONTH
--                               AND X.PHONE_NUMBER = pPHONE_NUMBER
                               AND X.ROW_COMMENT LIKE '1 Абонплата%'
                               --AND X.ROW_TYPE = 1
                           ), 0),
          B.ABON_ADD = NVL((SELECT SUM(-x.ROW_COST)
                              FROM ABONENT_BALANCE_ROWS X
                              WHERE TO_NUMBER(TO_CHAR(x.ROW_DATE, 'YYYYMM')) = pYEAR_MONTH
--                                AND X.PHONE_NUMBER = pPHONE_NUMBER
                                AND X.ROW_COMMENT LIKE '2 Абонплата за услугу%'
                                --AND X.ROW_TYPE = 2
                           ), 0),
          B.CALLS = NVL((SELECT SUM(-x.ROW_COST)
                           FROM ABONENT_BALANCE_ROWS X
                           WHERE TO_NUMBER(TO_CHAR(x.ROW_DATE, 'YYYYMM')) = pYEAR_MONTH
--                             AND X.PHONE_NUMBER = pPHONE_NUMBER
                             AND (X.ROW_COMMENT LIKE 'Дет. зв. из тек. нач.%' OR X.ROW_COMMENT LIKE 'Детализация звонков%')
                             --AND (X.ROW_TYPE = 3 OR X.ROW_TYPE= 4)
                         ), 0),
          B.SINGLE_PAYMENTS = NVL((SELECT SUM(-x.ROW_COST)
                                     FROM ABONENT_BALANCE_ROWS X
                                     WHERE TO_NUMBER(TO_CHAR(x.ROW_DATE, 'YYYYMM')) = pYEAR_MONTH
--                                       AND X.PHONE_NUMBER = pPHONE_NUMBER
                                       AND X.ROW_COMMENT LIKE 'Подключена услуга%'
                                       --AND X.ROW_TYPE = 5
                                   ), 0),
          B.SINGLE_CHANGE_TARIFF = NVL((SELECT SUM(-x.PAYMENT_SUM)
                                          FROM RECEIVED_PAYMENTS X
                                          WHERE X.PHONE_NUMBER = pPHONE_NUMBER
                                            AND TO_NUMBER(TO_CHAR(x.PAYMENT_DATE_TIME , 'YYYYMM')) = pYEAR_MONTH
                                            AND X.RECEIVED_PAYMENT_TYPE_ID = 21
                                            AND X.IS_CONTRACT_PAYMENT = 0
                                            AND X.REVERSESCHET = 1), 0)   
      WHERE B.YEAR_MONTH = pYEAR_MONTH
        AND B.PHONE_NUMBER = pPHONE_NUMBER;
    -- Сбор Итого.       
    UPDATE TARIFER_BILL_FOR_CLIENTS B
      SET B.BILL_SUMM = B.BILL_SUMM + B.ABON_TP + B.ABON_ADD + B.CALLS + B.SINGLE_PAYMENTS + B.SINGLE_CHANGE_TARIFF,
          B.SINGLE_PAYMENTS = B.SINGLE_PAYMENTS + B.SINGLE_CHANGE_TARIFF
      WHERE B.YEAR_MONTH = pYEAR_MONTH
        AND B.PHONE_NUMBER = pPHONE_NUMBER;
    COMMIT;
  END IF;
END; 