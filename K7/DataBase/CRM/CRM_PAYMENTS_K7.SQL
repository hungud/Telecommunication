CREATE OR REPLACE FORCE VIEW CRM_V_PAYMENTS (
   PHONE_NUMBER,
   PAYMENT_SUM,
   PAYMENT_DATE,
   CONTRACT_ID,
   PAYMENT_REMARK,
   PAYMENT_NUMBER,
   PAYMENT_TYPE,
   CREATED_DATE,
   RECEIVED_PAYMENT_ID
)
AS
   SELECT                                                        --#Version=10
            --Nikolaev 20/03/2012 ������� ���� �������� ������� � ����� � ����

                                                        -- ������� �� ��������
                                                                            --
                                                           -- ��������� ������
                                                                            --
 --26 .10 .12 �������� �������� ����������� ���� ��� ������������� RECEIVED_PAYMENTS.RECEIVED_PAYMENT_ID
         CONTRACTS.PHONE_NUMBER_FEDERAL AS PHONE_NUMBER,
         CONTRACTS.START_BALANCE AS PAYMENT_SUM,
         CONTRACTS.CONTRACT_DATE AS PAYMENT_DATE,
         CONTRACTS.CONTRACT_ID AS CONTRACT_ID,
         '��������� ������' AS PAYMENT_REMARK,
         TO_CHAR (NULL) AS PAYMENT_NUMBER,
         0 AS PAYMENT_TYPE,
         CONTRACTS.CONTRACT_DATE AS CREATED_DATE,
         NULL AS RECEIVED_PAYMENT_ID
    FROM CONTRACTS
   WHERE CONTRACTS.START_BALANCE <> 0
   -- �������� �������
   UNION ALL
   SELECT RECEIVED_PAYMENTS.PHONE_NUMBER,
          RECEIVED_PAYMENTS.PAYMENT_SUM,
          TRUNC (RECEIVED_PAYMENTS.PAYMENT_DATE_TIME),
          RECEIVED_PAYMENTS.CONTRACT_ID,
             '��������������� � �����'
          || CASE
                WHEN RECEIVED_PAYMENTS.REMARK IS NULL THEN NULL
                ELSE ': ' || RECEIVED_PAYMENTS.REMARK
             END
             AS PAYMENT_REMARK,
          TO_CHAR (NULL) AS PAYMENT_NUMBER,
          1 AS PAYMENT_TYPE,
          RECEIVED_PAYMENTS.DATE_CREATED AS CREATED_DATE,
          RECEIVED_PAYMENTS.RECEIVED_PAYMENT_ID AS RECEIVED_PAYMENT_ID
     FROM RECEIVED_PAYMENTS
    WHERE IS_CONTRACT_PAYMENT = 0 -- ����� �������� � ������ ���������� ��������
   -- ����������� ������� � �����
   UNION ALL
   SELECT DB_LOADER_PAYMENTS.PHONE_NUMBER,
          DB_LOADER_PAYMENTS.PAYMENT_SUM,
          DB_LOADER_PAYMENTS.PAYMENT_DATE,
          DB_LOADER_PAYMENTS.CONTRACT_ID,
             '����� ���������'
          || CASE
                WHEN PAYMENT_STATUS_TEXT IS NULL THEN NULL
                ELSE ' (' || PAYMENT_STATUS_TEXT || ')'
             END
             AS PAYMENT_REMARK,
          DB_LOADER_PAYMENTS.PAYMENT_NUMBER,
          2 AS PAYMENT_TYPE,
          DATE_CREATED AS CREATED_DATE,
          NULL AS RECEIVED_PAYMENT_ID
     FROM DB_LOADER_PAYMENTS
    WHERE (   DB_LOADER_PAYMENTS.YEAR_MONTH =
                 TO_CHAR (DB_LOADER_PAYMENTS.PAYMENT_DATE, 'YYYYMM')
           OR db_loader_payments.year_month =
                 TO_CHAR (db_loader_payments.payment_date + 5, 'yyyymm'))
   --AND DB_LOADER_PAYMENTS.PAYMENT_STATUS_IS_VALID = 1 ������ ������� ���� �����
   UNION ALL
   -- ��������� �������
   SELECT PROMISED_PAYMENTS.PHONE_NUMBER AS PHONE_NUMBER,
          PROMISED_PAYMENTS.PROMISED_SUM AS PAYMENT_SUM,
          TRUNC (PROMISED_PAYMENTS.PAYMENT_DATE) AS PAYMENT_DATE,
          NULL AS CONTRACT_ID,
             '��������� ������ �� '
          || TO_CHAR (PROMISED_PAYMENTS.PROMISED_DATE,
                      'DD.MM.YYYY HH24:MI:SS')
             AS PAYMENT_REMARK,
          TO_CHAR (NULL) PAYMENT_NUMBER,
          3 AS PAYMENT_TYPE,
          PROMISED_PAYMENTS.DATE_CREATED AS DATE_CREATED,
          NULL AS RECEIVED_PAYMENT_ID
     FROM PROMISED_PAYMENTS
    WHERE PROMISED_PAYMENTS.PROMISED_DATE >= SYSDATE;

GRANT SELECT ON CRM_V_PAYMENTS TO CRM_USER;
CREATE SYNONYM CRM_USER.PAYMENTS FOR CRM_V_PAYMENTS;