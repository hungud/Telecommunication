
  CREATE OR REPLACE PACKAGE "LONTANA"."BALANCEENDM" AS
--
--#Version=3
--2 19.11.2014 Николаев М.А. Добавлено поле TYPE_ABON тип абонентской платы(месячная\посуточная)
--3 04.12.2014 Николаев М.А. Добавлено поле EXIT_PLUS признак погашения счета за месяц (Доработки Алексеев.)

procedure BalanceEndM_balphone(pyear_month number, sessionid number, pacc_id varchar2);

procedure BalanceEndM_balance_jobs(sessionid number);

procedure BalanceEndM_Rep(nnum number, sessionid number);


END;
CREATE OR REPLACE PACKAGE BODY "LONTANA"."BALANCEENDM" AS

procedure BalanceEndM_balphone(pyear_month number, sessionid number, pacc_id varchar2) is
 cpart number:=1; -- кол-во записей в партии
 ncount number:=0;
 ncount_part integer:=1;
 vacc_id varchar2(1000):='';
begin
 DELETE FROM BalanceEndM_report t
 WHERE t.session_id IN
      (SELECT session_id FROM BalanceEndM_balance_phone
       WHERE YEAR_MONTH=pyear_month AND accounts = pacc_id AND trunc(balance_date) <= trunc(sysdate));
 DELETE FROM BalanceEndM_balance_phone WHERE YEAR_MONTH=pyear_month AND accounts = pacc_id AND trunc(balance_date) <= trunc(sysdate);
 
 if pacc_id<>'-1' then
   vacc_id:=  ' AND get_account_id_by_phone(V.PHONE_NUMBER) in ('||pacc_id||')';
 end if;

 --кол-во джобов из настроек constants
 ncount_part:=nvl(ms_constants.GET_CONSTANT_VALUE('TEMP_JOBSBALANCE'),1);

 execute immediate
 'SELECT count(*)
    FROM V_BALANCES_ON_END_MONTHS_2 V,
         CONTRACTS c,
         CONTRACT_CANCELS cc
    WHERE V.PHONE_NUMBER=c.PHONE_NUMBER_FEDERAL(+)
      AND V.YEAR_MONTH>=TO_NUMBER(TO_CHAR(c.CONTRACT_DATE,''YYYYMM''))
                and not exists (select 1 from contracts c2
                                  where c2.PHONE_NUMBER_FEDERAL = c.PHONE_NUMBER_FEDERAL
                                    and V.YEAR_MONTH>=TO_NUMBER(TO_CHAR(c.CONTRACT_DATE,''YYYYMM''))
                                    and c2.CONTRACT_DATE > c.CONTRACT_DATE)
      AND c.CONTRACT_ID=cc.CONTRACT_ID(+)
      AND V.YEAR_MONTH<=NVL(TO_NUMBER(TO_CHAR(cc.CONTRACT_CANCEL_DATE,''YYYYMM'')),205012)'
      ||vacc_id||
      ' AND V. year_month ='||pyear_month into ncount;

 if ncount<1000 then cpart:=ncount ; end if;
 if ncount>=1000 then cpart:=round(ncount/ncount_part);end if;

 execute immediate
 'insert into BalanceEndM_balance_phone (phone_number, balance_date, num, session_id, accounts, year_month )
   select  tt.phone_number,SYSDATE, ceil(tt.rn / '||cpart||') vnum,
          '||sessionid||','''||pacc_id||''','||pyear_month||'
   from (select row_number() over(order by phone_number) rn, t.*
         from (SELECT V.PHONE_NUMBER
               FROM V_BALANCES_ON_END_MONTHS_2 V,
                    CONTRACTS c, CONTRACT_CANCELS cc
               WHERE V.PHONE_NUMBER=c.PHONE_NUMBER_FEDERAL(+)
                AND V.YEAR_MONTH>=TO_NUMBER(TO_CHAR(c.CONTRACT_DATE,''YYYYMM''))
                and not exists (select 1 from contracts c2
                                  where c2.PHONE_NUMBER_FEDERAL = c.PHONE_NUMBER_FEDERAL
                                    and V.YEAR_MONTH>=TO_NUMBER(TO_CHAR(c.CONTRACT_DATE,''YYYYMM''))
                                    and c2.CONTRACT_DATE > c.CONTRACT_DATE)
               AND c.CONTRACT_ID=cc.CONTRACT_ID(+)
               AND V.YEAR_MONTH<=NVL(TO_NUMBER(TO_CHAR(cc.CONTRACT_CANCEL_DATE,''YYYYMM'')),205012)'
               ||vacc_id||
               ' AND V.year_month ='||pyear_month||'
          ) t) tt ';
 commit;
end;


procedure BalanceEndM_balance_jobs(sessionid number) is
 vJobn binary_integer;
 vWhat varchar2(32767);
begin
 for i in (select distinct num, year_month  from BalanceEndM_balance_phone where session_id=sessionid) loop
   vWhat := ' BalanceEndM.BalanceEndM_Rep(' || i.num  || ',' ||sessionid ||');';
   dbms_job.submit(vJobn, vWhat, Sysdate, null, false, 0);
   commit;
 end loop;
end;


procedure BalanceEndM_Rep(nnum number, sessionid number)
is
 PRAGMA AUTONOMOUS_TRANSACTION;
 i integer:=0;
begin

for rec in (select *  from BalanceEndM_balance_phone where num=nnum and session_id=sessionid)
loop
  insert into  BalanceEndM_Report
  (login, year_month,phone_number, date_balance, balance, phone_is_active, begin_date,
   SUBSCRIBER_PAYMENT_NEW, activ, all_calls, diler_calls, bill_sum_new, diler_sum, tariff_name,
   SESSION_ID,DATE_REPORT,TYPE_ABON, EXIT_PLUS, DILER_SUM_OLD)
  select 
    tab.LOGIN, tab.YEAR_MONTH, tab.PHONE_NUMBER, tab.DATE_BALANCE,
    tab.BALANCE, tab.PHONE_IS_ACTIVE, tab.BEGIN_DATE, tab.SUBSCRIBER_PAYMENT_NEW,
    tab.ACTIV, tab.ALL_CALLS, tab.DILER_CALLS, tab.BILL_SUM_NEW, tab.DILER_SUM,
    tab.tariff_name, tab.sessionid, SYSDATE, tab.TYPE_ABON, 
    CASE 
    WHEN 0 = (select count(*)
                     from IOT_BALANCE_HISTORY IO 
                     where IO.PHONE_NUMBER = tab.phone_number 
                     AND IO.BALANCE>0 
                     AND IO.START_TIME between tab.BIL_BEGIN_DATE AND tab.BIL_BEGIN_DATE+45)  
          AND 
              tab.BILL_SUM_NEW<>0 then 'Счёт не погашен' 
    WHEN tab.BILL_SUM_NEW=0 then 'Нулевой счёт' 
    ELSE 'Счёт погашен'
    END EXIT_PLUS,
    TAB.DILER_SUM_OLD
  from
    (SELECT GET_ACCOUNT_LOGIN_BY_PHONE(V.PHONE_NUMBER) LOGIN,
         V.YEAR_MONTH,
         V.PHONE_NUMBER,
         V.DATE_CHECK AS DATE_BALANCE,
         GET_ABONENT_BALANCE(V.PHONE_NUMBER, V.DATE_CHECK) AS BALANCE,
         HI.PHONE_IS_ACTIVE,
         HI.BEGIN_DATE,
         V.ABON_TP_NEW SUBSCRIBER_PAYMENT_NEW,
         CASE
           WHEN (V.ALL_CALLS > 0) OR (V.STAT_NAL_CALL > 0)
             THEN 1
           ELSE
             CHECK_DETAIL_EXISTS(V.year_month, V.phone_number)
         END ACTIV,
         V.ALL_CALLS,
         DC.DILER_CALLS,
         V.BILL_SUM_NEW,
         V.BILL_SUM_NEW - V.ALL_CALLS + DC.DILER_CALLS DILER_SUM,
         tr.tariff_name,
--         (SELECT TARIFF_NAME
--            FROM TARIFFS
--            WHERE TARIFF_ID = GET_PHONE_TARIFF_ID(V.PHONE_NUMBER, HI.CELL_PLAN_CODE, V.DATE_CHECK)) TARIFF_NAME,
          sessionid, --SYSDATE,
          case
            when nvl(tr.tariff_abon_daily_pay,0)= 0 and not exists (select 1 from phone_number_with_daily_abon wda
                   where wda.phone_number = V.PHONE_NUMBER
                   )
            then  'Ежемесячная'
            else 'Посуточная'
          end as TYPE_ABON,
          (select BIL.BEGIN_DATE
           from BILLS_PERIODS BIL 
           where BIL.YEAR_MONTH = rec.year_month) BIL_BEGIN_DATE,
         V.BILL_SUM_OLD - V.ALL_CALLS -V.DISCOUNT_CALL + DC.DILER_CALLS DILER_SUM_OLD  
    FROM V_BALANCES_ON_END_MONTHS_2 V,
         DB_LOADER_ACCOUNT_PHONE_HISTS HI,
         CONTRACTS c,
         CONTRACT_CANCELS cc,
         DILER_CALL_FOR_PHONE DC,
         TARIFFS tr
    WHERE V.PHONE_NUMBER=c.PHONE_NUMBER_FEDERAL(+)
      AND V.YEAR_MONTH>=TO_NUMBER(TO_CHAR(c.CONTRACT_DATE,'YYYYMM'))
      AND c.CONTRACT_ID=cc.CONTRACT_ID(+)
                and not exists (select 1 from contracts c2
                                  where c2.PHONE_NUMBER_FEDERAL = c.PHONE_NUMBER_FEDERAL
                                    and V.YEAR_MONTH>=TO_NUMBER(TO_CHAR(c.CONTRACT_DATE,'YYYYMM'))
                                    and c2.CONTRACT_DATE > c.CONTRACT_DATE)
      AND V.YEAR_MONTH<=NVL(TO_NUMBER(TO_CHAR(cc.CONTRACT_CANCEL_DATE,'YYYYMM')),205012)
      AND V.PHONE_NUMBER=HI.PHONE_NUMBER(+)
      AND HI.END_DATE>=V.DATE_CHECK
      AND HI.begin_DATE<=V.DATE_CHECK
      AND V.year_month = DC.YEAR_MONTH (+)
      AND V.phone_number = DC.PHONE_NUMBER(+)
      AND V.PHONE_NUMBER = rec.phone_number
      AND V.YEAR_MONTH = rec.year_month
      and tr.tariff_id(+)=GET_PHONE_TARIFF_ID(hi.PHONE_NUMBER, HI.CELL_PLAN_CODE, HI.begin_DATE + (HI.END_DATE - HI.begin_DATE)/2)) tab;
  i:=i+1;
  if mod(i,20)=0 then
   commit;
  end if;

end loop;

commit;


end;

END; 