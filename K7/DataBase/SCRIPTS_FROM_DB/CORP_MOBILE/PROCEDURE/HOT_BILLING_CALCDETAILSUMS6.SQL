
  CREATE OR REPLACE PROCEDURE "CORP_MOBILE"."HOT_BILLING_CALCDETAILSUMS6" IS
  cursor curf is
  select rowid,hbu.phone_number,hbu.u_month from hot_billing_usm_PHONE hbu
  where mod(hbu.phone_number,6)=5
  order by hbu.date_insert;
  phone_n varchar2(11);
  rowi  rowid;
  smonth date;
BEGIN
  open curf;
  loop
    FETCH curf
      into rowi, phone_n,smonth;
    EXIT WHEN curf%NOTFOUND;
    delete hot_billing_usm_PHONE hbu
    where hbu.rowid=rowi;
    commit;
    HOT_BILLING_PCKG.CalcDetailSum(phone_n,smonth);
  end loop;
  close curf;
end;
