
  CREATE OR REPLACE PROCEDURE "CORP_MOBILE"."TEMP_BALPHONE_TEST" (sessionid number, pacc_id varchar2, is_credit number default 0) is
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

delete from TESTBALANCE_PHONE1_test where (session_id=sessionid or balance_date<sysdate-1);
delete from TESTDELTA_BALANCE_test where (session_id=sessionid or balance_date<sysdate-1);

commit;

if IS_CREDIT=1 then vIsCredit:=' and nvl(c.IS_CREDIT_CONTRACT,0)=1 ';end if;
if IS_CREDIT<>1 then vIsCredit:=' ';end if;

if pacc_id<>'-1' then
vacc_id:=  '  AC.ACCOUNT_ID in ('||pacc_id||') and ';
  end if;

--кол-во джобов из настроек constants
ncount_part:=nvl(ms_constants.GET_CONSTANT_VALUE('TEMP_JOBSBALANCE'),1);

execute immediate
'SELECT count(*)
          FROM v_contracts c, abonents a, operators, PHONE_NUMBER_ATTRIBUTES, ACCOUNTS AC
          WHERE '||vacc_id||'
          c.abonent_id = a.abonent_id
          '||vIsCredit||'
            AND c.contract_cancel_date IS NULL
            AND operators.operator_id(+) = c.operator_id
            and ac.ACCOUNT_ID(+) = GET_ACCOUNT_ID_BY_PHONE(c.PHONE_NUMBER_FEDERAL)
            AND PHONE_NUMBER_ATTRIBUTES.PHONE_NUMBER(+) = C.PHONE_NUMBER_FEDERAL
            AND c.phone_number_federal IN (SELECT p1.phone_number
                                       FROM db_loader_account_phones p1
                                       WHERE p1.year_month =to_char(sysdate,''YYYYMM'')) ' into ncount;

if ncount<1000 then cpart:=ncount ; end if;
if ncount>=1000 then cpart:=round(ncount/ncount_part);end if;

execute immediate

'insert into TESTBALANCE_PHONE1_test (phone_number,balance_date,num,flag,tarif_id,tarif_name,session_id, comments,ITOGBAL)
 select  tt.phone_number,sysdate, ceil(tt.rn / '||cpart||') vnum, 0, 0,0,
 '||sessionid||','''||pacc_id||''', GET_CREDIT_INFO(tt.CONTRACT_ID) as ITOGBAL
  from (select row_number() over(order by phone_number) rn, t.*
          from (
                  SELECT distinct c.PHONE_NUMBER_FEDERAL as phone_number, C.CONTRACT_ID
          FROM v_contracts c, abonents a, operators, PHONE_NUMBER_ATTRIBUTES, ACCOUNTS AC
          WHERE '||vacc_id||'
          c.abonent_id = a.abonent_id
          '||vIsCredit||'
            AND c.contract_cancel_date IS NULL
            AND operators.operator_id(+) = c.operator_id
            and ac.ACCOUNT_ID(+) = GET_ACCOUNT_ID_BY_PHONE(c.PHONE_NUMBER_FEDERAL)
            AND PHONE_NUMBER_ATTRIBUTES.PHONE_NUMBER(+) = C.PHONE_NUMBER_FEDERAL
            AND c.phone_number_federal IN (SELECT p1.phone_number
                                       FROM db_loader_account_phones p1
                                       WHERE p1.year_month =to_char(sysdate,''YYYYMM''))
          ) t) tt ';


 commit;

 end;