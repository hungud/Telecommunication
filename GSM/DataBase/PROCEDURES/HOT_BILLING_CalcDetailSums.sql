--#IF GETVERSION("HOT_BILLING_CALCDETAILSUMS") < 2 THEN
CREATE OR REPLACE PROCEDURE HOT_BILLING_CALCDETAILSUMS 
(
 ModNumber IN integer,
 DivNumber IN integer
) IS
--#Version=1 
--1 Создание процедуры с целью замены HOT_BILLING_CALCDETAILSUMS1(2,3,4,5,6)
  cursor curf is
  select rowid,hbu.phone_number,hbu.u_month from hot_billing_usm_PHONE hbu
  where mod(hbu.phone_number,DivNumber)=ModNumber
  order by hbu.date_insert;
  phone_n varchar2(11);
  rowi  rowid;
  smonth date;
  --cnt int;
BEGIN
  --cnt:=0;
  open curf;
  loop
    FETCH curf
      into rowi, phone_n,smonth;
    EXIT WHEN curf%NOTFOUND;
    /* IF cnt=0 then
     delete TEMP_CALCDETAILSUM;
     INSERT INTO TEMP_CALCDETAILSUM
     SELECT PHONE_NUMBER, max(balance_date) from (
        SELECT PHONE_NUMBER, PHONE_BALANCES.BALANCE_DATE balance_date
        FROM PHONE_BALANCES
        where mod(PHONE_BALANCES.phone_number,DivNumber)=ModNumber
        UNION
        SELECT CONTRACTS.PHONE_NUMBER_FEDERAL phone_number, CONTRACTS.CONTRACT_DATE
         FROM CONTRACTS
         where mod(CONTRACTS.PHONE_NUMBER_FEDERAL,DivNumber)=ModNumber
     ) group by phone_number;
    END IF; */
    --cnt:=cnt+1;
    delete hot_billing_usm_PHONE hbu
    where hbu.rowid=rowi;
    commit;
    HOT_BILLING_PCKG.CalcDetailSumOpt(phone_n,smonth);
  end loop;
  close curf;
end;
/

--#end if