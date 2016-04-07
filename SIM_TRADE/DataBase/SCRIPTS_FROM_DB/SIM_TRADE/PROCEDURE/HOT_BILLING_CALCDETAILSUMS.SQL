
  CREATE OR REPLACE PROCEDURE "SIM_TRADE"."HOT_BILLING_CALCDETAILSUMS" (
   ModNumber   IN INTEGER,
   DivNumber   IN INTEGER)
IS
   --#Version=1
   --1 Создание процедуры с целью замены HOT_BILLING_CALCDETAILSUMS1(2,3,4,5,6)
   CURSOR curf
   IS
        SELECT ROWID, hbu.phone_number, hbu.u_month
          FROM hot_billing_usm_PHONE hbu
         WHERE MOD (hbu.phone_number, DivNumber) = ModNumber
      ORDER BY hbu.date_insert;

   phone_n   VARCHAR2 (11);
   rowi      ROWID;
   smonth    DATE;
--cnt int;
BEGIN
   --cnt:=0;
   --DELETE_DOUBLE_DETAIL; -- Удаление дублей детализация, commit внутри
   OPEN curf;

   LOOP
      FETCH curf INTO rowi, phone_n, smonth;

      EXIT WHEN curf%NOTFOUND;
      DELETE hot_billing_usm_PHONE hbu
       WHERE hbu.ROWID = rowi;

      COMMIT;
      HOT_BILLING_PCKG.CalcDetailSumOpt (phone_n, smonth);
   END LOOP;

   CLOSE curf;
END;