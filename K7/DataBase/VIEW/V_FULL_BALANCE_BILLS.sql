CREATE OR REPLACE FORCE VIEW V_FULL_BALANCE_BILLS AS
-- Version = 11
-- 11. 2015.10.01. �������. ������ ������� callback(�� �������������� ����� 1.5����)
-- 10. 06.08.2015. �������. �������� ������� �� ������.
-- 9. 15.07.2015. �������. �������� ��� ���������� ������� �� ������ �/�. 
-- 10.04.2014. �������. ���� ������� �� ���������� CallBack
-- �������. �������� ���������� �������, �.�. ������ ���� �������� ������� �������� �� ������� ������� ��������. 
-- �������. ���������� �������� � ����� �������, ��� �����.
  SELECT TBFC.PHONE_NUMBER,
         LAST_DAY(TO_DATE(TBFC.YEAR_MONTH, 'yyyymm')) AS BILL_DATE,
         CASE
           WHEN TRUNC(SYSDATE) <= ACCOUNT_LOADED_BILLS.DATE_CREDIT_END
                AND (CHECK_PHONE_CREDIT(TBFC.PHONE_NUMBER, 
                                        ACCOUNT_LOADED_BILLS.DATE_END) = 1)
                AND TBFC.YEAR_MONTH >= ACCOUNT_LOADED_BILLS.YEAR_MONTH
             THEN TBFC.BILL_SUMM
                - TBFC.ABON_TP
                - TBFC.ABON_ADD
                - TBFC.DISCOUNT
           ELSE TBFC.BILL_SUMM
         END AS bill_sum,
         CASE
           WHEN TRUNC(SYSDATE) <= ACCOUNT_LOADED_BILLS.DATE_CREDIT_END
                AND (CHECK_PHONE_CREDIT(TBFC.PHONE_NUMBER, 
                                        LAST_DAY(TO_DATE(TBFC.YEAR_MONTH, 'yyyymm'))) = 1)
                AND TBFC.YEAR_MONTH >= ACCOUNT_LOADED_BILLS.YEAR_MONTH
             THEN '���� ��������� ��� ��. ��. � ' || TO_CHAR(TO_DATE(TBFC.YEAR_MONTH, 'yyyymm'), 'DD.MM.YYYY')
                   || ' �� ' || TO_CHAR(LAST_DAY(TO_DATE(TBFC.YEAR_MONTH, 'yyyymm')), 'DD.MM.YYYY')
           ELSE '���� ��������� � ' || TO_CHAR(TO_DATE(TBFC.YEAR_MONTH, 'yyyymm'), 'DD.MM.YYYY')
                || ' �� ' || TO_CHAR(LAST_DAY(TO_DATE(TBFC.YEAR_MONTH, 'yyyymm')), 'DD.MM.YYYY')
         END AS REMARK,
         1 AS BILL_CHECKED, 
         TBFC.ABON_TP AS ABON_TP_NEW
    FROM TARIFER_BILL_FOR_CLIENTS TBFC,
         (SELECT ABL.ACCOUNT_ID, MAX(ABL.YEAR_MONTH) YEAR_MONTH, MAX(ABL.DATE_END) DATE_END,
                 MAX(ABL.DATE_BEGIN) DATE_BEGIN, MAX(ABL.DATE_CREDIT_END) DATE_CREDIT_END                 
            FROM ACCOUNT_LOADED_BILLS ABL
            WHERE ABL.LOAD_BILL_IN_BALANCE = 1
            GROUP BY ACCOUNT_ID) ACCOUNT_LOADED_BILLS
    WHERE NVL(CONVERT_PCKG.GET_ACCOUNT_ID_BY_PHONE(TBFC.PHONE_NUMBER), 1) = ACCOUNT_LOADED_BILLS.ACCOUNT_ID 
      AND ACCOUNT_LOADED_BILLS.YEAR_MONTH >= TBFC.YEAR_MONTH
  UNION ALL
  SELECT DB_LOADER_PHONE_STAT.PHONE_NUMBER,
         CASE
           WHEN LAST_DAY(TO_DATE(TO_CHAR(DB_LOADER_PHONE_STAT.YEAR_MONTH || '01'), 'YYYYMMDD')) > DB_LOADER_PHONE_STAT.LAST_CHECK_DATE_TIME THEN 
             CASE
               WHEN TO_DATE(TO_CHAR(DB_LOADER_PHONE_STAT.YEAR_MONTH || '01'), 'YYYYMMDD') > DB_LOADER_PHONE_STAT.LAST_CHECK_DATE_TIME THEN
                 TO_DATE(TO_CHAR(DB_LOADER_PHONE_STAT.YEAR_MONTH || '01'), 'YYYYMMDD')
               ELSE TRUNC(DB_LOADER_PHONE_STAT.LAST_CHECK_DATE_TIME)
             END 
           ELSE LAST_DAY(TO_DATE(TO_CHAR(DB_LOADER_PHONE_STAT.YEAR_MONTH || '01'), 'YYYYMMDD'))
         END AS BILL_DATE,
         DB_LOADER_PHONE_STAT.ESTIMATE_SUM AS BILL_SUM,
         '����������� ������� �� ' || LOWER(TO_CHAR(TO_DATE(DB_LOADER_PHONE_STAT.YEAR_MONTH, 'YYYYMM'), 'MM.YYYY'))
           || ' (�� ' || TO_CHAR(DB_LOADER_PHONE_STAT.LAST_CHECK_DATE_TIME, 'DD.MM.YYYY HH24:MI') || ')',
         1 AS BILL_CHECKED,
         0 AS ABON_TP_NEW
    FROM DB_LOADER_PHONE_STAT
    WHERE NOT EXISTS (SELECT 1
                        FROM ACCOUNT_LOADED_BILLS
                          WHERE DB_LOADER_PHONE_STAT.ACCOUNT_ID = ACCOUNT_LOADED_BILLS.ACCOUNT_ID
                            AND DB_LOADER_PHONE_STAT.YEAR_MONTH = ACCOUNT_LOADED_BILLS.YEAR_MONTH
                            AND ACCOUNT_LOADED_BILLS.LOAD_BILL_IN_BALANCE = 1);

--GRANT SELECT ON V_FULL_BALANCE_BILLS TO CORP_MOBILE_ROLE;

--GRANT SELECT ON V_FULL_BALANCE_BILLS TO CORP_MOBILE_ROLE_RO;