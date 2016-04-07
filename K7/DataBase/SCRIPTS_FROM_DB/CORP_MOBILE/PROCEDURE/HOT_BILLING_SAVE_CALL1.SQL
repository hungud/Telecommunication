
  CREATE OR REPLACE PROCEDURE "CORP_MOBILE"."HOT_BILLING_SAVE_CALL1" is
begin
  -- Call the procedure
  hot_billing_PCKG.SAVE_CALL(1,0,0);
end;
