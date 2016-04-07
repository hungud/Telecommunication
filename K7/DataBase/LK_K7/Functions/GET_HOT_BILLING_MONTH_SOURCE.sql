CREATE OR REPLACE FUNCTION K7_LK.GET_HOT_BILLING_MONTH_SOURCE (
   pYEAR_MONTH   IN INTEGER)
   RETURN VARCHAR2
IS
   --
   --#Version=1
   --
   -- Возвращает источник детализации
   --
   -- Входные параметры:
   --   pYEAR_MONTH - Год и месяц в формате 201407 (YYYYMM)
   --
   -- Результат функции:
   --   Код источника:
   --     'TABLE' - в таблице CALL_MM_YYYY,
   --     'DISK'  - на диске.
   --
   CURSOR C
   IS
      SELECT DECODE (DB,  1, 'TABLE',  0, 'DISK',  'UNKNOWN')
        FROM CORP_MOBILE.HOT_BILLING_MONTH
       WHERE HOT_BILLING_MONTH.YEAR_MONTH = pYEAR_MONTH;

   vRESULT   VARCHAR2 (20 CHAR);
BEGIN
   OPEN C;

   FETCH C INTO vRESULT;

   CLOSE C;

   RETURN vRESULT;
END;
/
