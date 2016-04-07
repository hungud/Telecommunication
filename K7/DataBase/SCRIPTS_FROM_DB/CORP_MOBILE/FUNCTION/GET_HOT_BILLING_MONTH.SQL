
  CREATE OR REPLACE FUNCTION "CORP_MOBILE"."GET_HOT_BILLING_MONTH" (pYEAR IN INTEGER,
    pMONTH IN INTEGER
  ) RETURN INTEGER IS
--Vesion=1
res integer;
BEGIN
  select hbm.db into res from HOT_BILLING_MONTH hbm
  where hbm.year_month=pYEAR*100+pMONTH;
  RETURN RES;
exception when others then
  return 0;
END;