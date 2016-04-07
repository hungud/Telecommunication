
  CREATE OR REPLACE PROCEDURE "CORP_MOBILE"."RECALC_TARIF" 
AS 
--#Version=1
-- 1.Пересчёт значения баланса разблокировки
 i int;
BEGIN
 update tariffs SET BALANCE_UNBLOCK=ROUND(MONTHLY_PAYMENT/(TO_NUMBER(TO_CHAR(LAST_DAY(sysdate),'DD'))),4)+1; 
 commit; 
END;