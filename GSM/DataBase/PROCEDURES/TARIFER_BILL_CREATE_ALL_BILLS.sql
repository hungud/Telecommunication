CREATE OR REPLACE PROCEDURE TARIFER_BILL_CREATE_ALL_BILLS (
   pYEAR_MONTH   IN INTEGER)
IS
--
--#Version=1
--
--v.1 27.05.2015 ������� ������ ������� ���  �������� ������
--
BEGIN
   FOR REC IN (  SELECT DISTINCT D.PHONE_NUMBER
                   FROM DB_LOADER_PHONE_PERIODS D
                  WHERE D.YEAR_MONTH = pYEAR_MONTH
               ORDER BY D.PHONE_NUMBER ASC)
   LOOP
      TARIFER_BILL_CREATE (pYEAR_MONTH, REC.PHONE_NUMBER);
   END LOOP;
END;
/