
  CREATE OR REPLACE PROCEDURE "CORP_MOBILE"."HOT_BILLING_SAVE_CALLS" 
(
 ModNumber IN integer,
 DivNumber IN integer
) IS
--#Version=1
BEGIN
   hot_billing_PCKG.SAVE_CALL(DivNumber,ModNumber,0);
end;
