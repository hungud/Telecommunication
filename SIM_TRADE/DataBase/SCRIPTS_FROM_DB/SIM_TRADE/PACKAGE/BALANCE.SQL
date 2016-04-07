
  CREATE OR REPLACE PACKAGE "SIM_TRADE"."BALANCE" AS



procedure finance_balphone(pyear_month number, sessionid number, pacc_id varchar2);

procedure finance_balance_jobs(sessionid number);

procedure finance_rep(nnum number, sessionid number, pyear_month number);


END;
CREATE OR REPLACE PACKAGE BODY "SIM_TRADE"."BALANCE" AS


procedure finance_balphone(pyear_month number, sessionid number, pacc_id varchar2) is
--declare
i integer;
cpart number:=1; -- кол-во записей в партии
ncount number:=0;
date_bal date:=sysdate;
ncount_part integer:=1;
vsession_id integer;
vacc_id varchar2(1000):='';
vIsCredit varchar2(100):='';
begin

delete from finance_balance_phone where (session_id=sessionid or YEAR_MONTH=pyear_month);
delete from finance_report where (session_id=sessionid or YEAR_MONTH=pyear_month);
commit;

if pacc_id<>'-1' then
vacc_id:=  '  fb.ACCOUNT_ID in ('||pacc_id||') and ';
  end if;

--кол-во джобов из настроек constants
ncount_part:=nvl(ms_constants.GET_CONSTANT_VALUE('TEMP_JOBSBALANCE'),1);

execute immediate
'SELECT count(*)
          FROM db_loader_bills fb
          WHERE '||vacc_id||'
          year_month ='||pyear_month||' 
          ' into ncount;

if ncount<1000 then cpart:=ncount ; end if;
if ncount>=1000 then cpart:=round(ncount/ncount_part);end if;

execute immediate

'insert into finance_balance_phone (phone_number,balance_date,num,flag,session_id, comments, year_month, account_id )
 select  tt.phone_number,last_day(to_date('||pyear_month||',''YYYYMM'')), ceil(tt.rn / '||cpart||') vnum, 0,
 '||sessionid||','''||pacc_id||''','||pyear_month||', tt.account_id  from (select row_number() over(order by phone_number) rn, t.*
          from (
                  SELECT distinct fb.PHONE_NUMBER, fb.account_id
          FROM db_loader_bills fb
          WHERE '||vacc_id||'
             year_month ='||pyear_month||' 
                       
              ) t) tt ';

 commit;

  end;


 procedure finance_balance_jobs(sessionid number) is
 vJobn binary_integer;
 vWhat varchar2(32767);
begin
for i in (select distinct num, year_month  from finance_balance_phone where session_id=sessionid) loop
vWhat := ' balance.finance_rep(' || i.num  || ',' ||sessionid ||',' ||i.year_month || ');';
     dbms_job.submit(vJobn, vWhat, Sysdate, null, false, 0);
     commit;
   end loop;
   end;


 procedure finance_rep(nnum number, sessionid number, pyear_month number)
is
 PRAGMA AUTONOMOUS_TRANSACTION;
i integer:=0;
balance_work number;
balance_test number;
phone_number number;
balance_date date:=sysdate;

  pBALANCE NUMBER;
  pCHARGES  NUMBER;
  pABON  NUMBER;
  pABON_BE  NUMBER;
  pABON_BL_BE  NUMBER;
  pUSL  NUMBER;
  pBILLS  NUMBER;
  pBILL_AB  NUMBER;
  pBILL_AB_BE  NUMBER;
  pBILL_USL  NUMBER;

begin

for rec in (select *  from finance_balance_phone vbp where num=nnum and session_id=sessionid)
  loop
insert into  finance_report
(year_month,phone_number, date_begin, date_end, beeline_bill, client_bill, abon_tp_old, abon_tp_new, abon_add_old, abon_add_new, 
calls_gprs, calls_country, calls_sms_mms, calls_local, calls_rus_rpp, calls_sity, discount_old, discount_new, rouming_national, 
rouming_international, payments, payments_full,balance_on_begin, contract_date, contract_num, SESSION_ID,DATE_REPORT)
select b.YEAR_MONTH,
         b.PHONE_NUMBER,
         B.DATE_BEGIN,
         B.DATE_END,
         b.BILL_SUM BEELINE_BILL,
         V.BILL_SUM_NEW CLIENT_BILL,
         V.ABON_TP_OLD,
         V.ABON_TP_NEW,
         V.ABON_ADD_OLD,
         V.ABON_ADD_NEW,
         V.CALLS_GPRS,
         V.CALLS_COUNTRY,
         V.CALLS_SMS_MMS,
         V.CALLS_LOCAL,
         V.CALLS_RUS_RPP,
         V.CALLS_SITY,
         V.DISCOUNT_OLD,
         V.DISCOUNT_NEW,
         V.ROUMING_NATIONAL,
         V.ROUMING_INTERNATIONAL,
         (SELECT SUM(P.PAYMENT_SUM)
            FROM DB_LOADER_PAYMENTS P
            WHERE P.PHONE_NUMBER=B.PHONE_NUMBER
              AND P.PAYMENT_DATE>=B.DATE_BEGIN
              AND P.PAYMENT_DATE<=B.DATE_END) PAYMENTS,              
         (SELECT SUM(P.PAYMENT_SUM)
            FROM V_FULL_BALANCE_PAYMENTS P
            WHERE P.PHONE_NUMBER=B.PHONE_NUMBER
              AND P.PAYMENT_DATE>=B.DATE_BEGIN
              AND P.PAYMENT_DATE<=B.DATE_END) PAYMENTS_FULL,
         GET_ABONENT_BALANCE(B.PHONE_NUMBER, B.DATE_BEGIN) BALANCE_ON_BEGIN,
         (select C.CONTRACT_DATE 
            from V_CONTRACTS c 
            WHERE c.PHONE_NUMBER_FEDERAL=b.PHONE_NUMBER
              and C.CONTRACT_CANCEL_DATE is null           
              and rownum=1) CONTRACT_DATE, 
         (SELECT ACCOUNT_NUMBER FROM ACCOUNTS WHERE ACCOUNT_ID=B.ACCOUNT_ID) CONTRACT_NUM ,
         sessionid,sysdate 
    from db_loader_bills b,
         V_BILL_FINANCE_FOR_CLIENTS_06 v
    where v.PHONE_NUMBER=rec.phone_number
    and b.YEAR_MONTH=rec.year_month
    and b.account_id=rec.account_id
    and b.YEAR_MONTH=v.YEAR_MONTH(+)
      and b.PHONE_NUMBER=v.PHONE_NUMBER(+)
      and b.ACCOUNT_ID=v.ACCOUNT_ID(+);

i:=i+1;
           if mod(i,20)=0 then
           commit;
           end if;

end loop;

  commit;
  
  
end;



end;