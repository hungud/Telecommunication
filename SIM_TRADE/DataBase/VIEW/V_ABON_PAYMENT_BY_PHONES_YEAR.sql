CREATE OR REPLACE VIEW V_ABON_PAYMENT_BY_PHONES_YEAR AS
SELECT
--#Version=2
--
-- ������������ ��������� ��� �������� � ������� ������� ��������� � �������� �� �������.
-- � ����� PAYMENT_01 - PAYMENT_12 �������� ���������� �� ������, ������� � �.�.
-- � ���� BALANCE ������� ������� ������ ��������.
--
    ACCOUNT_ID,
    PHONE_NUMBER,
    BILL_YEAR,
    TARIFF_NAME,
    CASE WHEN PAYMENT_01 = 0 THEN NULL ELSE PAYMENT_01 END AS PAYMENT_01,
    CASE WHEN PAYMENT_02 = 0 THEN NULL ELSE PAYMENT_02 END AS PAYMENT_02,
    CASE WHEN PAYMENT_03 = 0 THEN NULL ELSE PAYMENT_03 END AS PAYMENT_03,
    CASE WHEN PAYMENT_04 = 0 THEN NULL ELSE PAYMENT_04 END AS PAYMENT_04,
    CASE WHEN PAYMENT_05 = 0 THEN NULL ELSE PAYMENT_05 END AS PAYMENT_05,
    CASE WHEN PAYMENT_06 = 0 THEN NULL ELSE PAYMENT_06 END AS PAYMENT_06,
    CASE WHEN PAYMENT_07 = 0 THEN NULL ELSE PAYMENT_07 END AS PAYMENT_07,
    CASE WHEN PAYMENT_08 = 0 THEN NULL ELSE PAYMENT_08 END AS PAYMENT_08,
    CASE WHEN PAYMENT_09 = 0 THEN NULL ELSE PAYMENT_09 END AS PAYMENT_09,
    CASE WHEN PAYMENT_10 = 0 THEN NULL ELSE PAYMENT_10 END AS PAYMENT_10,
    CASE WHEN PAYMENT_11 = 0 THEN NULL ELSE PAYMENT_11 END AS PAYMENT_11,
    CASE WHEN PAYMENT_12 = 0 THEN NULL ELSE PAYMENT_12 END AS PAYMENT_12,
    CASE WHEN PAYMENT_FOR_YEAR = 0 THEN NULL ELSE PAYMENT_FOR_YEAR END AS PAYMENT_FOR_YEAR,
    BALANCE
--    PROFIT_FOR_YEAR + BALANCE PROFIT_WITH_BALANCE
  FROM (
    SELECT
      ACCOUNT_ID,
      PHONE_NUMBER,
      TRUNC(V_ABON_PAYMENT_BY_PHONES.YEAR_MONTH / 100) BILL_YEAR,
      TARIFF_NAME,
      SUM(CASE WHEN TO_CHAR(V_ABON_PAYMENT_BY_PHONES.YEAR_MONTH) LIKE '%01' THEN V_ABON_PAYMENT_BY_PHONES.SUBSCRIBER_PAYMENT_NEW ELSE 0 END) AS PAYMENT_01,
      SUM(CASE WHEN TO_CHAR(V_ABON_PAYMENT_BY_PHONES.YEAR_MONTH) LIKE '%02' THEN V_ABON_PAYMENT_BY_PHONES.SUBSCRIBER_PAYMENT_NEW ELSE 0 END) AS PAYMENT_02,
      SUM(CASE WHEN TO_CHAR(V_ABON_PAYMENT_BY_PHONES.YEAR_MONTH) LIKE '%03' THEN V_ABON_PAYMENT_BY_PHONES.SUBSCRIBER_PAYMENT_NEW ELSE 0 END) AS PAYMENT_03,
      SUM(CASE WHEN TO_CHAR(V_ABON_PAYMENT_BY_PHONES.YEAR_MONTH) LIKE '%04' THEN V_ABON_PAYMENT_BY_PHONES.SUBSCRIBER_PAYMENT_NEW ELSE 0 END) AS PAYMENT_04,
      SUM(CASE WHEN TO_CHAR(V_ABON_PAYMENT_BY_PHONES.YEAR_MONTH) LIKE '%05' THEN V_ABON_PAYMENT_BY_PHONES.SUBSCRIBER_PAYMENT_NEW ELSE 0 END) AS PAYMENT_05,
      SUM(CASE WHEN TO_CHAR(V_ABON_PAYMENT_BY_PHONES.YEAR_MONTH) LIKE '%06' THEN V_ABON_PAYMENT_BY_PHONES.SUBSCRIBER_PAYMENT_NEW ELSE 0 END) AS PAYMENT_06,
      SUM(CASE WHEN TO_CHAR(V_ABON_PAYMENT_BY_PHONES.YEAR_MONTH) LIKE '%07' THEN V_ABON_PAYMENT_BY_PHONES.SUBSCRIBER_PAYMENT_NEW ELSE 0 END) AS PAYMENT_07,
      SUM(CASE WHEN TO_CHAR(V_ABON_PAYMENT_BY_PHONES.YEAR_MONTH) LIKE '%08' THEN V_ABON_PAYMENT_BY_PHONES.SUBSCRIBER_PAYMENT_NEW ELSE 0 END) AS PAYMENT_08,
      SUM(CASE WHEN TO_CHAR(V_ABON_PAYMENT_BY_PHONES.YEAR_MONTH) LIKE '%09' THEN V_ABON_PAYMENT_BY_PHONES.SUBSCRIBER_PAYMENT_NEW ELSE 0 END) AS PAYMENT_09,
      SUM(CASE WHEN TO_CHAR(V_ABON_PAYMENT_BY_PHONES.YEAR_MONTH) LIKE '%10' THEN V_ABON_PAYMENT_BY_PHONES.SUBSCRIBER_PAYMENT_NEW ELSE 0 END) AS PAYMENT_10,
      SUM(CASE WHEN TO_CHAR(V_ABON_PAYMENT_BY_PHONES.YEAR_MONTH) LIKE '%11' THEN V_ABON_PAYMENT_BY_PHONES.SUBSCRIBER_PAYMENT_NEW ELSE 0 END) AS PAYMENT_11,
      SUM(CASE WHEN TO_CHAR(V_ABON_PAYMENT_BY_PHONES.YEAR_MONTH) LIKE '%12' THEN V_ABON_PAYMENT_BY_PHONES.SUBSCRIBER_PAYMENT_NEW ELSE 0 END) AS PAYMENT_12,
      SUM(V_ABON_PAYMENT_BY_PHONES.SUBSCRIBER_PAYMENT_NEW) AS PAYMENT_FOR_YEAR,
      GET_ABONENT_BALANCE(V_ABON_PAYMENT_BY_PHONES.PHONE_NUMBER) BALANCE 
    FROM
      V_ABON_PAYMENT_BY_PHONES
    GROUP BY
      TRUNC(V_ABON_PAYMENT_BY_PHONES.YEAR_MONTH / 100),
      PHONE_NUMBER,
      TARIFF_NAME,
      ACCOUNT_ID
  ) T
ORDER BY PHONE_NUMBER
/
