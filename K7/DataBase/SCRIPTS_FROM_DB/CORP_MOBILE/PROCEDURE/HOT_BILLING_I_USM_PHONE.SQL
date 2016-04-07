
  CREATE OR REPLACE PROCEDURE "CORP_MOBILE"."HOT_BILLING_I_USM_PHONE" (subscr in varchar2,smonth in date) IS
  flag integer;
begin
  select count(*)
    into flag
    from hot_billing_usm_PHONE hbu
   where hbu.phone_number = subscr
   and hbu.u_month=smonth;
  if flag = 0 then
    insert into hot_billing_usm_PHONE values (subscr, null,smonth);
    commit;
  end if;
end;
