CREATE OR REPLACE VIEW V_BILL_FINANCE_FOR_CLIENTS AS
--Versions = 6  
  SELECT T1.ACCOUNT_ID,
         T1.YEAR_MONTH,
         T1.PHONE_NUMBER,
         T1.BILL_SUM_OLD,
         CASE 
           WHEN T1.BILL_SUM_OLD <> 0 THEN
             ROUND(T1.BILL_SUM_OLD 
                    + CASE
                        WHEN T1.ADD_SINGLE_PENALTI_TO_BILL = 1 THEN T1.SINGLE_PENALTI + T1.SINGLE_VIEW_BLACK_LIST
                        ELSE 0
                      END
                    + CASE
                        WHEN T1.ABON_MAIN > 0 THEN
                          T1.ABON_TP_REAL * (T1.ABON_TP_FULL_NEW  / T1.ABON_MAIN)    
                        ELSE T1.ABON_TP_FULL_NEW
                      END - T1.ABON_TP_REAL
                    + T1.ABON_SERVICE_ADD_COST
                    - T1.DISCOUNTS + T1.DISCOUNT_SMS_PLUS
                    + CASE
                        WHEN MS_CONSTANTS.GET_CONSTANT_VALUE('SERVER_NAME')='GSM_CORP' THEN 0
                        ELSE T1.DISCOUNT_CALL
                      END
                    + CASE -- ������ ��� �� "���������"
                        WHEN (MS_CONSTANTS.GET_CONSTANT_VALUE('SERVER_NAME')='CORP_MOBILE') 
                          AND (EXISTS(SELECT 1
                                        FROM V_BILL_ABON_PER_FOR_CLIENT VA
                                        WHERE VA.ACCOUNT_ID = T1.ACCOUNT_ID
                                          AND VA.YEAR_MONTH = T1.YEAR_MONTH
                                          AND VA.PHONE_NUMBER = T1.PHONE_NUMBER
                                          AND (VA.TARIFF_ID = 1060 
                                            or VA.TARIFF_ID = 1080))) 
                        THEN T1.DISCOUNT_SOVINTEL
                        ELSE 0
                      END, 4)
           ELSE 0           
         END AS BILL_SUM_NEW,
         T1.ABON_TP_REAL AS ABON_TP_OLD,
         ROUND(CASE
                 WHEN T1.ABON_MAIN > 0 THEN
                   T1.ABON_TP_REAL * (T1.ABON_TP_FULL_NEW  / T1.ABON_MAIN)    
                 ELSE T1.ABON_TP_FULL_NEW
               END, 4) AS ABON_TP_NEW,   --��������� ����� ������ �������
         T1.ABON_ADD AS ABON_ADD_OLD,
         T1.ABON_ADD + T1.ABON_SERVICE_ADD_COST AS ABON_ADD_NEW,
         T1.DISCOUNTS AS DISCOUNT_OLD,
         T1.DISCOUNT_SMS_PLUS 
         + CASE
             WHEN MS_CONSTANTS.GET_CONSTANT_VALUE('SERVER_NAME')='GSM_CORP' THEN 0
             ELSE T1.DISCOUNT_CALL
           END
         + CASE -- ������ ��� �� "���������"
             WHEN (MS_CONSTANTS.GET_CONSTANT_VALUE('SERVER_NAME')='CORP_MOBILE') 
               AND (EXISTS(SELECT 1
                             FROM V_BILL_ABON_PER_FOR_CLIENT VA
                             WHERE VA.ACCOUNT_ID = T1.ACCOUNT_ID
                               AND VA.YEAR_MONTH = T1.YEAR_MONTH
                               AND VA.PHONE_NUMBER = T1.PHONE_NUMBER
                               AND (VA.TARIFF_ID = 1060 
                                 or VA.TARIFF_ID = 1080))) 
             THEN T1.DISCOUNT_SOVINTEL
             ELSE 0
           END AS DISCOUNT_NEW,
         T1.SINGLE_PENALTI,
         T1.SINGLE_PAYMENTS - T1.SINGLE_MAIN AS SINGLE_PAYMENTS_OLD,
         T1.SINGLE_PAYMENTS - T1.SINGLE_MAIN
         + CASE 
             WHEN T1.ADD_SINGLE_PENALTI_TO_BILL = 1 THEN T1.SINGLE_PENALTI + T1.SINGLE_VIEW_BLACK_LIST
             ELSE 0
           END AS SINGLE_PAYMENTS_NEW,
         T1.CALLS_COUNTRY,
         T1.CALLS_SITY,
         T1.CALLS_LOCAL,
         T1.CALLS_SMS_MMS,
         T1.CALLS_GPRS,
         T1.CALLS_RUS_RPP,
         T1.COMPLETE_BILL
    FROM (SELECT FB.ACCOUNT_ID,
                 FB.YEAR_MONTH,
                 FB.PHONE_NUMBER,
                 FB.BILL_SUM AS BILL_SUM_OLD,
                 FB.ABON_MAIN + FB.SINGLE_MAIN AS ABON_TP_REAL,   --�������� ������ �� �������
                 FB.ABON_ADD + FB.SINGLE_ADD AS ABON_SERVICE_OLD,   --�������� ����� �� ������ �� �������
                 CASE
                   WHEN (FB.BILL_SUM <> 0) AND (FB.ABON_MAIN > 0) THEN
                     GET_NEW_FULL_FINANCE_ABON_TP(FB.ACCOUNT_ID, FB.YEAR_MONTH, FB.PHONE_NUMBER)
                   ELSE 0
                 END AS ABON_TP_FULL_NEW,   --������ ������ �� �����, �������������
                 CASE
                   WHEN (FB.BILL_SUM <> 0) AND (FB.CALLS = 0) 
                          AND (FB.ABON_MAIN + FB.SINGLE_MAIN = 0) AND ( MS_CONSTANTS.GET_CONSTANT_VALUE('SERVER_NAME')='CORP_MOBILE')
                          AND ((FB.ABON_ADD + FB.SINGLE_ADD = 418.9) OR (FB.ABON_ADD + FB.SINGLE_ADD = 403.56) OR (FB.ABON_ADD + FB.SINGLE_ADD = 304.794)) THEN
                     420 - (FB.ABON_ADD + FB.SINGLE_ADD)
                   WHEN (FB.BILL_SUM <> 0) AND (FB.ABON_ADD + FB.SINGLE_ADD <> 0) THEN
                     GET_TARIFF_OPTION_ADD_COST2(FB.ACCOUNT_ID, FB.YEAR_MONTH, FB.PHONE_NUMBER)
                   ELSE 0
                 END AS ABON_SERVICE_ADD_COST,   --���������� ��������� �����
                 FB.ABONKA, FB.CALLS, FB.SINGLE_PAYMENTS, FB.DISCOUNTS, FB.COMPLETE_BILL,
                 FB.ABON_MAIN, FB.ABON_ADD, FB.ABON_OTHER,
                 FB.SINGLE_MAIN, FB.SINGLE_ADD, FB.SINGLE_PENALTI, FB.SINGLE_CHANGE_TARIFF,
                 FB.SINGLE_VIEW_BLACK_LIST,
                 CASE 
                   WHEN FB.SINGLE_PAYMENTS = FB.SINGLE_MAIN + FB.SINGLE_ADD + FB.SINGLE_CHANGE_TARIFF + FB.SINGLE_TURN_ON_SERV
                                              + FB.SINGLE_CORRECTION_ROUMING + FB.SINGLE_INTRA_WEB + FB.SINGLE_OTHER THEN 1
                   ELSE 0
                 END AS ADD_SINGLE_PENALTI_TO_BILL,
                 FB.DISCOUNT_SMS_PLUS, FB.DISCOUNT_YEAR, FB.DISCOUNT_CALL, FB.DISCOUNT_SOVINTEL,
                 FB.CALLS_COUNTRY, FB.CALLS_SITY, FB.CALLS_LOCAL,
                 FB.CALLS_SMS_MMS, FB.CALLS_GPRS, FB.CALLS_RUS_RPP
            FROM DB_LOADER_FULL_FINANCE_BILL FB, BILL_FINANCE_FOR_CLIENTS_SAVED
            WHERE FB.COMPLETE_BILL=1
              AND FB.ACCOUNT_ID=BILL_FINANCE_FOR_CLIENTS_SAVED.ACCOUNT_ID(+)
              AND FB.YEAR_MONTH=BILL_FINANCE_FOR_CLIENTS_SAVED.YEAR_MONTH(+)
              AND FB.PHONE_NUMBER=BILL_FINANCE_FOR_CLIENTS_SAVED.PHONE_NUMBER(+)
              AND BILL_FINANCE_FOR_CLIENTS_SAVED.PHONE_NUMBER IS NULL) T1
  UNION ALL
  SELECT BS1.ACCOUNT_ID, 
         BS1.YEAR_MONTH, 
         BS1.PHONE_NUMBER,
         BS1.BILL_SUM_OLD,
         BS1.BILL_SUM_NEW, 
         BS1.ABON_TP_OLD,
         BS1.ABON_TP_NEW,
         BS1.ABON_ADD_OLD, 
         BS1.ABON_ADD_NEW,
         BS1.DISCOUNT_OLD, 
         BS1.DISCOUNT_NEW, 
         BS1.SINGLE_PENALTI,
         BS1.SINGLE_PAYMENTS_OLD, 
         BS1.SINGLE_PAYMENTS_NEW,
         BS1.CALLS_COUNTRY, 
         BS1.CALLS_SITY, 
         BS1.CALLS_LOCAL,
         BS1.CALLS_SMS_MMS, 
         BS1.CALLS_GPRS,
         BS1.CALLS_RUS_RPP,
         BS1.COMPLETE_BILL       
    FROM BILL_FINANCE_FOR_CLIENTS_SAVED BS1;            
    
--GRANT SELECT ON V_BILL_FINANCE_FOR_CLIENTS TO SIM_TRADE_ROLE;

--GRANT SELECT ON V_BILL_FINANCE_FOR_CLIENTS TO LONTANA_ROLE;

--GRANT SELECT ON V_BILL_FINANCE_FOR_CLIENTS TO CORP_MOBILE_ROLE;