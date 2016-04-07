
  CREATE OR REPLACE FUNCTION "CORP_MOBILE"."CALC3" (
  accid in integer,
  phone in varchar2,
  ym_beg in integer
  ) return number is
cursor c1 is
  select p.PHONE_NUMBER,
         p.PAYMENT_SUM
    from db_loader_payments p
    where p.ACCOUNT_ID=accid
      and p.PHONE_NUMBER=phone
      and p.YEAR_MONTH>=ym_beg+1; 
cursor c2 is
  select b.PHONE_NUMBER,
         b.BILL_SUM
    from db_loader_bills b
    where b.ACCOUNT_ID=accid
      and b.PHONE_NUMBER=phone
      and b.YEAR_MONTH=ym_beg; 
r1 c1%rowtype;       
r2 c2%rowtype;   
su number(15,2);    
begin
  su:=0;
  for r1 in c1
  loop
    su:=su+r1.PAYMENT_SUM;
  end loop;
  for r2 in c2
  loop
    su:=su-r2.BILL_SUM;
  end loop;
  return su;
end; 