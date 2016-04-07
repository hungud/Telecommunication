CREATE OR REPLACE PACKAGE "BALANCE" AS

type rowGetCurtarif is record(
 --привязка к типу поля
tariff_id  tariffs.tariff_id%TYPE,
PHONE_NUMBER  contracts.phone_number_federal%TYPE,
contract_date contracts.contract_date%TYPE,
CALC_KOEFF_DETAL tariffs.tariff_id%TYPE
);

type tblrowGetCurtarif is table of rowGetCurtarif;
----------------------------------------------------------
type rowGETABONENTBALANCE is record(
 --привязка к типу поля
PHONE_NUMBER contracts.phone_number_federal%TYPE,
DATE_ROWS  contracts.contract_date%TYPE,
COST_ROWS  db_loader_full_finance_bill.bill_sum%TYPE,
DESCRIPTION_ROWS contracts.comments%TYPE
);

type tblGETABONENTBALANCE is table of rowGETABONENTBALANCE;

function GET_CUR_TARIF_by_PHONE
(pPHONE_NUM VARCHAR2 default null)
return tblrowGetCurtarif
pipelined;

function CALCBALANCEROWS2
  (pPHONE_NUMBER VARCHAR2,
  pBALANCE_DATE DATE DEFAULT NULL,
    pFILL_DESCRIPTION BOOLEAN DEFAULT TRUE,
  /*pPHONE_NUMBER VARCHAR2,
  pFILL_DESCRIPTION BOOLEAN DEFAULT TRUE,
  pBALANCE_DATE DATE DEFAULT NULL,*/
  pPERIOD_ACTIV BOOLEAN DEFAULT TRUE
  ) return tblGETABONENTBALANCE
pipelined;

function get_contract_now_year (
  pPHONE_NUMber IN VARCHAR2 default null,
  pYEAR_MONTH IN INTEGER) return integer ;

function get_tarifid ( pPHONE_NUM IN VARCHAR2 default null) return integer ;

FUNCTION get_cur_coeff(
  pACCOUNT_ID IN INTEGER,
  pYEAR_MONTH IN INTEGER,
  pPHONE_NUMBER IN VARCHAR2
  ) RETURN NUMBER;
---------------------------------------------------------------
type rowVBILLFINANCEFORCLIENTS is record(
account_id db_loader_full_finance_bill.account_id%TYPE,
year_month db_loader_full_finance_bill.year_month%TYPE,
phone_number db_loader_full_finance_bill.phone_number%TYPE,
bill_sum_old db_loader_full_finance_bill.bill_sum%TYPE,
bill_sum_new db_loader_full_finance_bill.bill_sum%TYPE,
abon_tp_old db_loader_full_finance_bill.abon_main%TYPE,
abon_tp_new db_loader_full_finance_bill.abon_main%TYPE,
abon_add_old db_loader_full_finance_bill.abon_add%TYPE,
abon_add_new db_loader_full_finance_bill.abon_add%TYPE,
discount_old db_loader_full_finance_bill.discount_call%TYPE,
discount_new db_loader_full_finance_bill.discount_call%TYPE,
single_penalti db_loader_full_finance_bill.single_penalti%TYPE,
single_payments_old db_loader_full_finance_bill.single_payments%TYPE,
single_payments_new db_loader_full_finance_bill.single_payments%TYPE,
calls_country db_loader_full_finance_bill.calls_country%TYPE,
calls_sity db_loader_full_finance_bill.calls_sity%TYPE,
calls_local db_loader_full_finance_bill.calls_sms_mms%TYPE,
calls_sms_mms db_loader_full_finance_bill.calls_sms_mms%TYPE,
calls_gprs db_loader_full_finance_bill.calls_gprs%TYPE,
calls_rus_rpp db_loader_full_finance_bill.calls_rus_rpp%TYPE,
complete_bill db_loader_full_finance_bill.complete_bill%TYPE,
rouming_national  db_loader_full_finance_bill.rouming_national%TYPE,
rouming_international  db_loader_full_finance_bill.rouming_international%TYPE,
single_other  db_loader_full_finance_bill.single_other%TYPE,
single_turn_on_serv  db_loader_full_finance_bill.single_turn_on_serv%TYPE
);

type tblVBILLFINANCEFORCLIENTS is table of rowVBILLFINANCEFORCLIENTS;

function  BILLFINANCEFORCLIENTS (pPHONE_NUM VARCHAR2 default null)
return tblVBILLFINANCEFORCLIENTS
pipelined;

function get_abonent_balance ( pPHONE_NUM IN VARCHAR2 default null, pdate_balance IN date default null) return number ;
--------------------------------------------------------------------
type rowABONBALANS is record(
phone_number_federal contracts.phone_number_federal%TYPE,
operator_name operators.operator_name%TYPE,
surname abonents.surname%TYPE,
name abonents.name%TYPE,
patronymic abonents.patronymic%TYPE,
bdate abonents.bdate%TYPE,
contact_info abonents.contact_info%TYPE,
balance db_loader_full_finance_bill.abonka%TYPE,
disconnect_limit db_loader_full_finance_bill.abonka%TYPE,
connect_limit db_loader_full_finance_bill.abonka%TYPE,
is_vip varchar2(10),
phone_is_active_code  number,
account_id number,
status_date date,
tariff_name tariffs.tariff_name%TYPE,
tariff_id tariffs.tariff_id%TYPE,
loader_script_name operators.loader_script_name%TYPE,
hand_block contracts.hand_block%TYPE,
is_credit_contract contracts.is_credit_contract%TYPE,
phone_is_active varchar2(10),
limit_exceed_sum db_loader_full_finance_bill.abonka%TYPE,
account_number accounts.account_number%TYPE,
company_name varchar2(30),
is_discount varchar2(30),
color number
);

type tblABONBALANS is table of rowABONBALANS;

type rc_t is ref cursor return rowABONBALANS;

function ABON_BALANS_WITHOUTSORT (paccount_id in integer)
  return tblABONBALANS
pipelined;


      --type rec_t is record(g number, id number);
      type tab_t is table of rowABONBALANS;
      type rc_t1 is ref cursor return rowABONBALANS;

      function pip(in_p rc_t1)
        return tab_t pipelined
        parallel_enable (partition in_p by range(account_id))
        order in_p by (phone_number_federal);

        type rowCALCBALANCESTATBYYM  is record(
  pPHONE_NUMBER  db_loader_full_finance_bill.phone_number%TYPE,
  pBALANCE_DATE  contracts.contract_date%TYPE,
  pYEAR_MONTH    db_loader_full_finance_bill.year_month%TYPE,
  pBALANCE       db_loader_full_finance_bill.bill_sum%TYPE,
  pCHARGES       db_loader_full_finance_bill.bill_sum%TYPE,
  pABON          db_loader_full_finance_bill.bill_sum%TYPE,
  pABON_BE       db_loader_full_finance_bill.bill_sum%TYPE,
  pABON_BL_BE    db_loader_full_finance_bill.bill_sum%TYPE,
  pUSL           db_loader_full_finance_bill.bill_sum%TYPE,
  pBILLS         db_loader_full_finance_bill.bill_sum%TYPE,
  pBILL_AB       db_loader_full_finance_bill.bill_sum%TYPE,
  pBILL_AB_BE    db_loader_full_finance_bill.bill_sum%TYPE,
  pBILL_USL      db_loader_full_finance_bill.bill_sum%TYPE
);

type tblCALCBALANCESTATBYYM is table of rowCALCBALANCESTATBYYM;

function  CALC_BALANCE_STAT_BY_YM(
  pPHONE_NUMBER  VARCHAR2,
  pBALANCE_DATE  DATE DEFAULT NULL,

  pYEAR_MONTH  INTEGER
  ) return tblCALCBALANCESTATBYYM
pipelined ;

PROCEDURE CALC_VIRT_BALANCE(
  pPHONE_NUMBER IN VARCHAR2,
  pBALANCE_DATE IN DATE DEFAULT NULL,
  pYEAR_MONTH IN INTEGER,
  pBALANCE IN OUT NUMBER,
  pCHARGES IN OUT NUMBER,
  pABON IN OUT NUMBER,
  pABON_BE IN OUT NUMBER,
  pABON_BL_BE IN OUT NUMBER,
  pUSL IN OUT NUMBER,
  pBILLS IN OUT NUMBER,
  pBILL_AB IN OUT NUMBER,
  pBILL_AB_BE IN OUT NUMBER,
  pBILL_USL IN OUT NUMBER
  );

procedure virtual_balphone(pyear_month number, sessionid number, pacc_id varchar2, pis_credit number default 0);

procedure virtual_balance_jobs(sessionid number);

procedure virtual_rep_bal(nnum number, sessionid number);

procedure finance_balphone(pyear_month number, sessionid number, pacc_id varchar2);

procedure finance_balance_jobs(sessionid number);

procedure finance_rep(nnum number, sessionid number, pyear_month number);


END;
/
CREATE OR REPLACE PACKAGE BODY "BALANCE" AS

function GET_CUR_TARIF_by_PHONE
(pPHONE_NUM VARCHAR2 default null)
return tblrowGetCurtarif
pipelined is

BEGIN

  FOR curr IN (select distinct nvl(t.tariff_id,-1),c.phone_number_federal,c.contract_date,1 as calc_koeff_detal
    from contracts c, tariffs t
where c.phone_number_federal=pPHONE_NUM
and c.tariff_id=t.tariff_id(+)
and c.contract_date=(
Select max(c.contract_date)
from contracts c,contract_cancels b
where c.phone_number_federal=pPHONE_NUM and c.contract_id=b.contract_id(+)
group by c.phone_number_federal)
) LOOP

pipe row (curr);

  END LOOP;

  RETURN;

EXCEPTION
  WHEN OTHERS THEN
   null;

    RAISE;
END;


function  BILLFINANCEFORCLIENTS (pPHONE_NUM VARCHAR2 default null)
return tblVBILLFINANCEFORCLIENTS
pipelined is

coeff number:=1;
begin
coeff:=1;-- GET_CALC_COEFF_DETAL(GET_CURR_PHONE_TARIFF_ID(pPHONE_NUM));
--coeff:=1;
  -- определить коэф-нт по тарифу
   -- умножать поля уже в зависимости от выбранного коэф-та
  for curr in (SELECT T1.ACCOUNT_ID,
         T1.YEAR_MONTH,
         T1.PHONE_NUMBER,
         round(T1.BILL_SUM_OLD,4) BILL_SUM_OLD,
         CASE
           WHEN T1.BILL_SUM_OLD <> 0 THEN
             ROUND(round(T1.BILL_SUM_OLD,4)
                    + CASE
                        WHEN T1.ADD_SINGLE_PENALTI_TO_BILL = 1 THEN T1.SINGLE_PENALTI + T1.SINGLE_VIEW_BLACK_LIST
                        ELSE 0
                      END
                    + CASE
                        WHEN T1.ABON_MAIN > 0 THEN
                          T1.ABON_TP_REAL * (T1.ABON_TP_FULL_NEW  / T1.ABON_MAIN)
                        ELSE T1.ABON_TP_FULL_NEW
                      END - T1.ABON_TP_REAL
                    + T1.ABON_SERVICE_ADD_COST
                    - T1.DISCOUNTS + T1.DISCOUNT_SMS_PLUS
                    + CASE
                        WHEN MS_CONSTANTS.GET_CONSTANT_VALUE('SERVER_NAME')='GSM_CORP' THEN 0
                        ELSE T1.DISCOUNT_CALL
                      END
                    , 4)
           ELSE 0
         END AS BILL_SUM_NEW,
         T1.ABON_TP_REAL AS ABON_TP_OLD,
         ROUND(CASE
                 WHEN T1.ABON_MAIN > 0 THEN
                   T1.ABON_TP_REAL * (T1.ABON_TP_FULL_NEW  / T1.ABON_MAIN)
                 ELSE T1.ABON_TP_FULL_NEW
               END, 4) AS ABON_TP_NEW,   --Определим новую абонку клиенту
         T1.ABON_ADD AS ABON_ADD_OLD,
         T1.ABON_ADD + T1.ABON_SERVICE_ADD_COST AS ABON_ADD_NEW,
         T1.DISCOUNTS AS DISCOUNT_OLD,
         T1.DISCOUNT_SMS_PLUS
         + CASE
             WHEN MS_CONSTANTS.GET_CONSTANT_VALUE('SERVER_NAME')='GSM_CORP' THEN 0
             ELSE T1.DISCOUNT_CALL
           END AS DISCOUNT_NEW,
         T1.SINGLE_PENALTI,
         T1.SINGLE_PAYMENTS - T1.SINGLE_MAIN AS SINGLE_PAYMENTS_OLD,
         T1.SINGLE_PAYMENTS - T1.SINGLE_MAIN
         + CASE
             WHEN T1.ADD_SINGLE_PENALTI_TO_BILL = 1 THEN T1.SINGLE_PENALTI + T1.SINGLE_VIEW_BLACK_LIST
             ELSE 0
           END AS SINGLE_PAYMENTS_NEW,
         T1.CALLS_COUNTRY,
         T1.CALLS_SITY,
         T1.CALLS_LOCAL,
         T1.CALLS_SMS_MMS,
         T1.CALLS_GPRS,
         T1.CALLS_RUS_RPP,
         T1.COMPLETE_BILL,
         T1.ROUMING_NATIONAL,
         T1.ROUMING_INTERNATIONAL,
         T1.SINGLE_OTHER,
         T1.SINGLE_TURN_ON_SERV

    FROM (SELECT FB.ACCOUNT_ID,
                 FB.YEAR_MONTH,
                 FB.PHONE_NUMBER,
                 FB.BILL_SUM AS BILL_SUM_OLDold,
                 FB.ABON_MAIN + FB.SINGLE_MAIN AS ABON_TP_REAL,   --Реальная абонка по билайну
                 FB.ABON_ADD + FB.SINGLE_ADD AS ABON_SERVICE_OLD,   --Реальная плата за услуги по билайну
                 CASE
                   WHEN (FB.BILL_SUM <> 0) AND (FB.ABON_MAIN > 0) THEN
                     CASE
                       WHEN GET_NEW_FULL_FINANCE_ABON_TP(FB.ACCOUNT_ID, FB.YEAR_MONTH, FB.PHONE_NUMBER) > 0 THEN
                         GET_NEW_FULL_FINANCE_ABON_TP(FB.ACCOUNT_ID, FB.YEAR_MONTH, FB.PHONE_NUMBER)
                       ELSE FB.ABON_MAIN
                     END
                   ELSE 0
                 END AS ABON_TP_FULL_NEW,   --Полная абонка за месяц, пересчитанная
                 CASE
                   WHEN (FB.BILL_SUM <> 0) AND (FB.ABON_ADD + FB.SINGLE_ADD <> 0) THEN
                     GET_TARIFF_OPTION_ADD_COST2(FB.ACCOUNT_ID, FB.YEAR_MONTH, FB.PHONE_NUMBER)
                   ELSE 0
                 END AS ABON_SERVICE_ADD_COST,   --Добавочная стоимость услуг
                 FB.ABONKA, FB.CALLS, FB.SINGLE_PAYMENTS, FB.DISCOUNTS, FB.COMPLETE_BILL,
                 FB.ABON_MAIN, FB.ABON_ADD, FB.ABON_OTHER,
                 FB.SINGLE_MAIN, FB.SINGLE_ADD, FB.SINGLE_PENALTI, FB.SINGLE_CHANGE_TARIFF,
                 FB.SINGLE_VIEW_BLACK_LIST,
                 CASE
                   WHEN FB.SINGLE_PAYMENTS = FB.SINGLE_MAIN + FB.SINGLE_ADD + FB.SINGLE_CHANGE_TARIFF + FB.SINGLE_TURN_ON_SERV
                                              + FB.SINGLE_CORRECTION_ROUMING + FB.SINGLE_INTRA_WEB +
                                              FB.SINGLE_OTHER*decode(sign(FB.single_other),-1,1,FB.single_other*coeff)  THEN 1
                   ELSE 0
                 END AS ADD_SINGLE_PENALTI_TO_BILL,
                 FB.DISCOUNT_SMS_PLUS, FB.DISCOUNT_YEAR,
                 FB.DISCOUNT_CALL*coeff DISCOUNT_CALL,
                 --FB.DISCOUNT_SOVINTEL,
                 FB.CALLS_COUNTRY*coeff CALLS_COUNTRY,
                 FB.CALLS_SITY*coeff CALLS_SITY,
                 FB.CALLS_LOCAL*coeff CALLS_LOCAL,
                 FB.CALLS_SMS_MMS*coeff CALLS_SMS_MMS,
                 FB.CALLS_GPRS*coeff CALLS_GPRS,
                 FB.CALLS_RUS_RPP*coeff CALLS_RUS_RPP,
                 FB.rouming_national*coeff rouming_national,
                 FB.rouming_international*coeff rouming_international,
                 FB.SINGLE_OTHER*decode(sign(FB.single_other),-1,1,FB.single_other*coeff) SINGLE_OTHER,
                 FB.single_turn_on_serv*coeff single_turn_on_serv,
                 (FB.abon_main+FB.abon_add+FB.abon_other+
FB.single_main+FB.single_add+FB.single_penalti+FB.single_change_tariff+
FB.single_turn_on_serv*coeff+
FB.single_correction_rouming+FB.single_intra_web+FB.single_view_black_list+
FB.single_other*decode(sign(FB.single_other),-1,1,FB.single_other*coeff) +
FB.discount_year+FB.discount_sms_plus+--FB.DISCOUNT_SOVINTEL+
FB.discount_call*coeff+
FB.discount_count_on_phones+discount_others+
FB.calls_country*coeff+
FB.calls_sity*coeff+
FB.calls_local*coeff+
FB.calls_sms_mms*coeff+
FB.calls_gprs*coeff+
FB.calls_rus_rpp*coeff+
FB.rouming_national*coeff+
FB.rouming_international*coeff
/*+FB.DISCOUNTS*/) AS BILL_SUM_OLD

            FROM DB_LOADER_FULL_FINANCE_BILL FB, BILL_FINANCE_FOR_CLIENTS_SAVED
            WHERE  fb.phone_number=pPHONE_NUM
            and            FB.COMPLETE_BILL=1
              AND FB.ACCOUNT_ID=BILL_FINANCE_FOR_CLIENTS_SAVED.ACCOUNT_ID(+)
              AND FB.YEAR_MONTH=BILL_FINANCE_FOR_CLIENTS_SAVED.YEAR_MONTH(+)
              AND FB.PHONE_NUMBER=BILL_FINANCE_FOR_CLIENTS_SAVED.PHONE_NUMBER(+)
              AND BILL_FINANCE_FOR_CLIENTS_SAVED.PHONE_NUMBER IS NULL) T1
               UNION ALL
  SELECT BS1.ACCOUNT_ID,
         BS1.YEAR_MONTH,
         BS1.PHONE_NUMBER,
         BS1.BILL_SUM_OLD,
         BS1.BILL_SUM_NEW,
         BS1.ABON_TP_OLD,
         BS1.ABON_TP_NEW,
         BS1.ABON_ADD_OLD,
         BS1.ABON_ADD_NEW,
         BS1.DISCOUNT_OLD,
         BS1.DISCOUNT_NEW,
         BS1.SINGLE_PENALTI,
         BS1.SINGLE_PAYMENTS_OLD,
         BS1.SINGLE_PAYMENTS_NEW,
         BS1.CALLS_COUNTRY,
         BS1.CALLS_SITY,
         BS1.CALLS_LOCAL,
         BS1.CALLS_SMS_MMS,
         BS1.CALLS_GPRS,
         BS1.CALLS_RUS_RPP,
         BS1.COMPLETE_BILL,
         null,
         null, null, null
    FROM BILL_FINANCE_FOR_CLIENTS_SAVED BS1
    where phone_number=pPHONE_NUM) loop

  pipe row (curr);

  END LOOP;

  RETURN;

  end;

function get_contract_now_year (
  pPHONE_NUMber IN VARCHAR2 default null,
  pYEAR_MONTH IN INTEGER) return integer is
  res integer:=0;
  begin

  for i in(
   select distinct to_char(min(v.CONTRACT_DATE),'YYYYMM') contract_mon from contracts v where v.PHONE_NUMBER_FEDERAL=pPHONE_NUMBER) loop

  if i.contract_mon=pYEAR_MONTH then
    res:=1;
    else res:=0;
    end if;

   end loop;


   RETURN res;

    end;

function get_tarifid ( pPHONE_NUM IN VARCHAR2 default null) return integer is
  res integer;
  begin
   select t.TARIFF_ID into res  from TABLE(GET_CUR_TARIF_by_PHONE(pPHONE_NUM)) t;

   RETURN res;

    end;

    FUNCTION get_cur_coeff(
  pACCOUNT_ID IN INTEGER,
  pYEAR_MONTH IN INTEGER,
  pPHONE_NUMBER IN VARCHAR2
  ) RETURN NUMBER IS
--Version=2
  CURSOR C IS
    SELECT
         nvl(tariffs.calc_koeff,1) calc_koeff
    FROM (SELECT AP.*,
                 GET_PHONE_TARIFF_ID(AP.PHONE_NUMBER, AP.TARIFF_CODE, AP.DATE_END) AS TARIFF_ID,
                 (AP.DATE_END - AP.DATE_BEGIN + 1)/(LAST_DAY(AP.DATE_BEGIN) - TO_DATE(TO_CHAR(AP.DATE_BEGIN, 'YYYYMM')||'01', 'YYYYMMDD') + 1) COEFF_MONTH
            FROM DB_LOADER_FULL_BILL_ABON_PER AP
            where  AP.PHONE_NUMBER = pPHONE_NUMBER
             AND AP.YEAR_MONTH = pYEAR_MONTH
            AND AP.ACCOUNT_ID = pACCOUNT_ID) T1,
         TARIFFS
    WHERE  T1.TARIFF_ID=TARIFFS.TARIFF_ID(+)
    and tariffs.calc_koeff is not null;

  ITOG NUMBER(15, 4);

  ABON_MAIN number(15,4);
BEGIN
  ITOG:=0;
  FOR rec IN C LOOP
    ITOG:= rec.calc_koeff;

  END LOOP;


  RETURN ITOG;

END;

function CALCBALANCEROWS2 (
  pPHONE_NUMBER VARCHAR2,
  pBALANCE_DATE DATE DEFAULT NULL,
  pFILL_DESCRIPTION BOOLEAN DEFAULT TRUE,
  pPERIOD_ACTIV BOOLEAN DEFAULT TRUE
  ) return tblGETABONENTBALANCE

pipelined is
vPERIOD_ACTIV INTEGER;
  DAY_PAY_IN_BLOK CONSTANT NUMBER:=5;
  DAYS_NESTABIL CONSTANT INTEGER:=5;
  cDAYS_PAYMENT_BEFORE_CONTRACT INTEGER := 4; -- Дня до начала контракта, для которых нужно засчитывать платежи
  CURSOR C_CONTRACT IS
    SELECT
      CONTRACTS.CONTRACT_DATE,
      CONTRACTS.CONTRACT_ID,
      CONTRACTS.IS_CREDIT_CONTRACT
    FROM
      CONTRACTS
    WHERE
      CONTRACTS.PHONE_NUMBER_FEDERAL = pPHONE_NUMBER
      AND (pBALANCE_DATE IS NULL OR CONTRACTS.CONTRACT_DATE <= pBALANCE_DATE)
--      AND CONTRACTS.CONTRACT_ID NOT IN (
--          SELECT CONTRACT_CANCELS.CONTRACT_ID
--            FROM CONTRACT_CANCELS)
    ORDER BY
      CONTRACTS.CONTRACT_DATE DESC
      ;
  CURSOR C_BALANCE(aPHONE_NUMBER VARCHAR2, aCONTRACT_DATE date) IS
    SELECT
      PHONE_BALANCES.BALANCE_DATE,
      PHONE_BALANCES.BALANCE_VALUE,
      PHONE_BALANCES.FIX_YEAR_MONTH_ID
    FROM
      PHONE_BALANCES
    WHERE
      PHONE_BALANCES.PHONE_NUMBER = aPHONE_NUMBER
      AND (pBALANCE_DATE IS NULL OR PHONE_BALANCES.BALANCE_DATE <= pBALANCE_DATE)
      and (aCONTRACT_DATE IS NULL OR PHONE_BALANCES.BALANCE_DATE >= aCONTRACT_DATE)
    ORDER BY
      PHONE_BALANCES.BALANCE_DATE DESC
      ;
  CURSOR cPHONE_STATUS_HISTORY(aPHONE_NUMBER VARCHAR2, pBEGIN_DATE DATE, pEND_DATE DATE, pCALC_ABON_PAYMENT_TO_MONTHEND INTEGER) IS
    SELECT
      CASE
        WHEN DB_LOADER_ACCOUNT_PHONE_HISTS.PHONE_IS_ACTIVE=0 THEN
          TRUNC(DB_LOADER_ACCOUNT_PHONE_HISTS.BEGIN_DATE)+1
        ELSE
          TRUNC(DB_LOADER_ACCOUNT_PHONE_HISTS.BEGIN_DATE)
      END as BEGIN_DATE,
      CASE
        WHEN TRUNC(DB_LOADER_ACCOUNT_PHONE_HISTS.END_DATE) > pEND_DATE THEN
          TRUNC(pEND_DATE)
        ELSE
          CASE
            WHEN DB_LOADER_ACCOUNT_PHONE_HISTS.PHONE_IS_ACTIVE=0 THEN
              TRUNC(DB_LOADER_ACCOUNT_PHONE_HISTS.END_DATE)-1
            ELSE
              TRUNC(DB_LOADER_ACCOUNT_PHONE_HISTS.END_DATE)
          END
      END as END_DATE,
      DB_LOADER_ACCOUNT_PHONE_HISTS.PHONE_IS_ACTIVE,
      DB_LOADER_ACCOUNT_PHONE_HISTS.CELL_PLAN_CODE,
      DB_LOADER_ACCOUNT_PHONE_HISTS.HISTORY_ID,
      TARIFFS.TARIFF_ID,
      -- В зависимости от активности номера либо простая либо блокированная цена
      CASE WHEN (DB_LOADER_ACCOUNT_PHONE_HISTS.PHONE_IS_ACTIVE=1)
        -- Если абонент блокирован в настоящий момент, то считаем абонплату как для действующего
        OR ((DB_LOADER_ACCOUNT_PHONE_HISTS.END_DATE > SYSDATE)
              AND (TO_CHAR(DB_LOADER_ACCOUNT_PHONE_HISTS.BEGIN_DATE, 'YYYYMM') = TO_CHAR(SYSDATE, 'YYYYMM'))
              AND (pCALC_ABON_PAYMENT_TO_MONTHEND=1))
        THEN NVL(TARIFFS.MONTHLY_PAYMENT, 0)
        ELSE NVL(TARIFFS.MONTHLY_PAYMENT_LOCKED, 0)
      END as MONTHLY_PRICE,
      -- В зависимости от активности номера либо простая либо блокированная стоимость
      CASE WHEN (DB_LOADER_ACCOUNT_PHONE_HISTS.PHONE_IS_ACTIVE=1)
        -- Если абонент блокирован в настоящий момент, то считаем абонплату как для действующего
        OR ((DB_LOADER_ACCOUNT_PHONE_HISTS.END_DATE > SYSDATE)
              AND (TO_CHAR(DB_LOADER_ACCOUNT_PHONE_HISTS.BEGIN_DATE, 'YYYYMM') = TO_CHAR(SYSDATE, 'YYYYMM'))
              AND (pCALC_ABON_PAYMENT_TO_MONTHEND=1))
        THEN NVL(TARIFFS.DAYLY_PAYMENT, 0)
        ELSE NVL(TARIFFS.DAYLY_PAYMENT_LOCKED, 0)
      END as DAYLY_PRICE
    FROM
      DB_LOADER_ACCOUNT_PHONE_HISTS,
      TARIFFS
    WHERE
      DB_LOADER_ACCOUNT_PHONE_HISTS.PHONE_NUMBER = aPHONE_NUMBER
      AND TRUNC(DB_LOADER_ACCOUNT_PHONE_HISTS.BEGIN_DATE) <= pEND_DATE
      AND TRUNC(DB_LOADER_ACCOUNT_PHONE_HISTS.END_DATE) >= pBEGIN_DATE
      --AND TARIFFS.TARIFF_CODE=DB_LOADER_ACCOUNT_PHONE_HISTS.CELL_PLAN_CODE
      -- Коду может соответствовать несколько тарифов, выбираем подходящий
      AND TARIFFS.TARIFF_ID = GET_PHONE_TARIFF_ID(
        aPHONE_NUMBER,
        DB_LOADER_ACCOUNT_PHONE_HISTS.CELL_PLAN_CODE,
        NVL(CASE
              WHEN DB_LOADER_ACCOUNT_PHONE_HISTS.END_DATE-1>DB_LOADER_ACCOUNT_PHONE_HISTS.BEGIN_DATE THEN
                DB_LOADER_ACCOUNT_PHONE_HISTS.END_DATE-1
              ELSE DB_LOADER_ACCOUNT_PHONE_HISTS.END_DATE
            END, SYSDATE)
        )
      AND (pBALANCE_DATE IS NULL OR DB_LOADER_ACCOUNT_PHONE_HISTS.BEGIN_DATE <= pBALANCE_DATE)
    ORDER BY
      DB_LOADER_ACCOUNT_PHONE_HISTS.END_DATE DESC
      ;
  CURSOR DEP(pCONTRACT_ID IN INTEGER) IS
    SELECT CURRENT_DEPOSITE_VALUE, DATE_DEPOSITE_CHANGE
      FROM CONTRACT_DEPOSITES
      WHERE CONTRACT_ID=pCONTRACT_ID;
  CURSOR OPER(pCONTRACT_ID IN INTEGER,pDATE DATE) IS
    SELECT NOTE
      FROM CONTRACT_DEPOSITE_OPER
      WHERE CONTRACT_ID=pCONTRACT_ID
        AND OPERATION_DATE_TIME=pDATE;
  CURSOR CODE(pDATE IN DATE) IS
    SELECT CELL_PLAN_CODE
      FROM DB_LOADER_ACCOUNT_PHONE_HISTS
      WHERE DB_LOADER_ACCOUNT_PHONE_HISTS.PHONE_NUMBER=pPHONE_NUMBER
        AND DB_LOADER_ACCOUNT_PHONE_HISTS.BEGIN_DATE<=pDATE
        AND DB_LOADER_ACCOUNT_PHONE_HISTS.END_DATE>=pDATE;
  CURSOR DB_REPORT(pYEAR_MONTH IN INTEGER) IS
    SELECT DATE_LAST_UPDATE,
           --Процент владельца добавляется к стоимости
           TRUNC(RECALC_CHARGE_COST(pPHONE_NUMBER, -DETAIL_SUM), 2) AS BILL_SUM,
           'Детализация звонков за ' || TO_CHAR(DATE_LAST_UPDATE,'MM.YYYY') || ' (на '
           || TO_CHAR(DATE_LAST_UPDATE,'DD.MM.YYYY HH24:MI') || ')' AS REMARKS
      FROM DB_LOADER_REPORT_DATA
      WHERE DB_LOADER_REPORT_DATA.PHONE_NUMBER=pPHONE_NUMBER
        AND DB_LOADER_REPORT_DATA.YEAR_MONTH=pYEAR_MONTH;
  CURSOR NEW_DATE_ABON(pSTART_BALANCE_DATE IN DATE,
                       pCORRECT_ACTIVATION_DATE_DAYS IN INTEGER) IS
    SELECT FIRST_VALUE(DB_LOADER_ACCOUNT_PHONE_HISTS.BEGIN_DATE) OVER (ORDER BY DB_LOADER_ACCOUNT_PHONE_HISTS.END_DATE ASC)
        FROM DB_LOADER_ACCOUNT_PHONE_HISTS
        WHERE DB_LOADER_ACCOUNT_PHONE_HISTS.PHONE_NUMBER=pPHONE_NUMBER
          AND DB_LOADER_ACCOUNT_PHONE_HISTS.PHONE_IS_ACTIVE=1
          AND DB_LOADER_ACCOUNT_PHONE_HISTS.END_DATE>=pSTART_BALANCE_DATE-pCORRECT_ACTIVATION_DATE_DAYS
          AND DB_LOADER_ACCOUNT_PHONE_HISTS.BEGIN_DATE<=pSTART_BALANCE_DATE+pCORRECT_ACTIVATION_DATE_DAYS;
  CURSOR ACC_ID IS
    SELECT P1.ACCOUNT_ID
      FROM DB_LOADER_ACCOUNT_PHONES P1
      WHERE P1.PHONE_NUMBER=pPHONE_NUMBER
        AND P1.YEAR_MONTH=(SELECT MAX(P2.YEAR_MONTH)
                             FROM DB_LOADER_ACCOUNT_PHONES P2);
  CURSOR OPT_ACT(pBEGIN_DATE IN DATE, pEND_DATE IN DATE) IS
    SELECT TRUNC(H.BEGIN_DATE) BEGIN_DATE,
           TRUNC(H.END_DATE) END_DATE
      FROM DB_LOADER_ACCOUNT_PHONE_HISTS H
      WHERE H.PHONE_NUMBER=pPHONE_NUMBER
        AND TRUNC(H.BEGIN_DATE)<=TRUNC(pEND_DATE)
        AND TRUNC(H.END_DATE)>=TRUNC(pBEGIN_DATE)
        AND H.PHONE_IS_ACTIVE=1
      ORDER BY H.BEGIN_DATE ASC;
  CURSOR PH_W_D_A IS
    SELECT *
      FROM PHONE_NUMBER_WITH_DAILY_ABON PHA
      WHERE PHA.PHONE_NUMBER=pPHONE_NUMBER;
  CURSOR TARIFF_PAY_TYPE IS
    SELECT NVL(tariffs.TARIFF_ABON_DAILY_PAY, 1) CALC_ABON_PAYMENT_TO_NOW
           from tariffs
           where TARIFFS.TARIFF_ID =
                   GET_PHONE_TARIFF_ID(pPHONE_NUMBER,
                                       (select DB_LOADER_ACCOUNT_PHONES.CELL_PLAN_CODE
                                          from DB_LOADER_ACCOUNT_PHONES
                                          WHERE DB_LOADER_ACCOUNT_PHONES.PHONE_NUMBER=pPHONE_NUMBER
                                            AND DB_LOADER_ACCOUNT_PHONES.LAST_CHECK_DATE_TIME=
                                                 (select MAX(P2.LAST_CHECK_DATE_TIME)
                                                    from DB_LOADER_ACCOUNT_PHONES P2
                                                    WHERE P2.PHONE_NUMBER=pPHONE_NUMBER
                                                    )),
                                       SYSDATE);
  vACCOUNT_ID INTEGER;
  recCODE DB_LOADER_ACCOUNT_PHONE_HISTS.CELL_PLAN_CODE%TYPE;
  recDEP DEP%ROWTYPE;
  recOPER OPER%ROWTYPE;
  recPHONE_STATUS_HISTORY cPHONE_STATUS_HISTORY%ROWTYPE;
  recPHONE_STATUS_HISTORY2 cPHONE_STATUS_HISTORY%ROWTYPE;
  vCONTRACT_DATE        DATE;
  vCONTRACT_ID          CONTRACTS.CONTRACT_ID%TYPE;
  vCREDIT CONTRACTS.IS_CREDIT_CONTRACT%TYPE;
  --vPAYMENTS_VALUE       NUMBER(15, 2);
  --vBILLS_VALUE          NUMBER(15, 2);
  vSTART_BALANCE_VALUE  NUMBER(15, 2);
  vSTART_BALANCE_DATE   DATE;
  vSTART_BALANCE_DATE_FOR_PAYMS DATE;
  vABON_PAYMENT_START_DATE DATE;
--  vABON_PAYMENT_SUM     NUMBER(15, 2);
  vSERVICE_START_DATE DATE; -- Дана начала  расчёта абонплаты за услугу.
  vSERVICE_END_DATE DATE;   -- Дата окончания расчёта абонплаты за услугу.
  vNEW_TURN_ON_COST NUMBER; -- Стоимость подключение тарифной опции (из справочника).
  vNEW_MONTHLY_COST NUMBER; -- Стоимость опции в месяц (из справочника).
  ABON_PAY_DAY_AFTER_BLOCK BOOLEAN;
  HISTORY_ID_ACT INTEGER;
  HISTORY_ID_BL INTEGER;
  HISTORY_ID_END_DATE DATE;
  REC_BILL_DATE DATE;
  REC_BILL_SUM NUMBER;
  REC_REMARK VARCHAR2(300);
  rec_REPORT DB_REPORT%ROWTYPE;
  FLAG_CURR_MONTH INTEGER;
  FLAG_DATA_OPTIONS_CURR_MONTH INTEGER;
  PAYMENTS_PREV_MONTH INTEGER;
  vCALC_ABON_PAYMENT_TO_MONTHEND BOOLEAN; -- Признак расчёта абонплаты до конца месяца
  --
  -- Количество дней, на которые надо делать коррекцию расчёта абонплаты.
  -- Если дата активации не совпадает с датой договора, то нужно делать расчёт от даты активации.
  vCORRECT_ACTIVATION_DATE_DAYS INTEGER;
  vTEMP_DATE_BEGIN_ABON DATE; -- Временная переменная(хранит дату активации)
  PREV_STATUS NUMBER;
  pCALC_ABON_PAYMENT_TO_MONTHEND INTEGER;
  TEMP_DATE_END_SCHET DATE;  -- Дата, по-которую абонка рассчитана
  vDATE_SERVICE_CHECK DATE;
  vSERVER_NAME VARCHAR2(50 CHAR);
  vCALC_OPTIONS_DAILY_ACTIV varchar2(30 char);
  vLAST_DAY_OPTION_ADD DATE;
  vCOUNT_ACT_OPTION INTEGER;
  vDUMMY_PH PH_W_D_A%ROWTYPE;
  vFIX_YEAR_MONTH_ID INTEGER;
  vSERVICE_PAID_FULL INTEGER;
  vDUMMY_TPT TARIFF_PAY_TYPE%rowtype;
--
  /*PROCEDURE APPEND_ROW(pDATE DATE, pCOST NUMBER, pDESCRIPTION VARCHAR2) IS
    C BINARY_INTEGER;
  BEGIN
    IF pCOST <> 0 THEN
      C := pDATE_ROWS.COUNT+1;
      pDATE_ROWS(C) := pDATE;
      pCOST_ROWS(C) := pCOST;
      IF pFILL_DESCRIPTION THEN
        pDESCRIPTION_ROWS(C) := pDESCRIPTION;
      END IF;
    END IF;



  END;*/
--
BEGIN
  --

  --
  OPEN ACC_ID;
  FETCH ACC_ID INTO vACCOUNT_ID;
  IF ACC_ID%NOTFOUND THEN
    vACCOUNT_ID:=0;
  END IF;
  CLOSE ACC_ID;
  --
  vCALC_ABON_PAYMENT_TO_MONTHEND := ('1' = MS_CONSTANTS.GET_CONSTANT_VALUE('CALC_ABON_PAYMENT_TO_MONTH_END'));
  IF vCALC_ABON_PAYMENT_TO_MONTHEND THEN
    OPEN PH_W_D_A;
    FETCH PH_W_D_A INTO vDUMMY_PH;
    IF PH_W_D_A%FOUND THEN
      pCALC_ABON_PAYMENT_TO_MONTHEND:=0;
    ELSE
      OPEN TARIFF_PAY_TYPE;
      FETCH TARIFF_PAY_TYPE INTO vDUMMY_TPT;
      IF TARIFF_PAY_TYPE%FOUND THEN
        pCALC_ABON_PAYMENT_TO_MONTHEND:=vDUMMY_TPT.CALC_ABON_PAYMENT_TO_NOW;
      ELSE
        pCALC_ABON_PAYMENT_TO_MONTHEND:=1;
      END IF;
      CLOSE TARIFF_PAY_TYPE;
    END IF;
    CLOSE PH_W_D_A;
  ELSE
    pCALC_ABON_PAYMENT_TO_MONTHEND:=0;
  END IF;
  -- Количество дней коррекции даты активации
  vCORRECT_ACTIVATION_DATE_DAYS := NVL(MS_CONSTANTS.GET_CONSTANT_VALUE('CORRECT_ACTIVATION_DATE_DAYS'), 0);
  --
 -- vSERVER_NAME:=MS_CONSTANTS.GET_CONSTANT_VALUE('SERVER_NAME');
  --
  vCALC_OPTIONS_DAILY_ACTIV:=MS_CONSTANTS.GET_CONSTANT_VALUE('CALC_OPTIONS_DAILY_ACTIV');
  --
  OPEN C_CONTRACT;
  FETCH C_CONTRACT INTO vCONTRACT_DATE, vCONTRACT_ID, vCREDIT;
  CLOSE C_CONTRACT;
  -- Корректировка баланса
  OPEN C_BALANCE(pPHONE_NUMBER, vCONTRACT_DATE);
  FETCH C_BALANCE INTO vSTART_BALANCE_DATE, vSTART_BALANCE_VALUE, vFIX_YEAR_MONTH_ID;
  IF C_BALANCE%NOTFOUND THEN
    vSTART_BALANCE_DATE := NVL(vCONTRACT_DATE, TO_DATE('01.01.2000', 'DD.MM.YYYY'));
    -- Дата для зачёта платежей особенная - на 4 дня меньше договора
    vSTART_BALANCE_DATE_FOR_PAYMS := vSTART_BALANCE_DATE-cDAYS_PAYMENT_BEFORE_CONTRACT;
    vSTART_BALANCE_VALUE := 0;
  ELSE
    vSTART_BALANCE_DATE_FOR_PAYMS := vSTART_BALANCE_DATE;
  END IF;
  CLOSE C_BALANCE;
  IF vSTART_BALANCE_VALUE <> 0 THEN
  --  APPEND_ROW(vSTART_BALANCE_DATE, vSTART_BALANCE_VALUE, 'Стартовый баланс');

    for q in (select pPHONE_NUMBER, vSTART_BALANCE_DATE,  vSTART_BALANCE_VALUE, 'Стартовый баланс' from dual) loop
          pipe row (q);
          end loop;

  END IF;
  --Учет депозитов
  IF vCONTRACT_ID IS NOT NULL THEN
    OPEN DEP(vCONTRACT_ID);
    FETCH DEP INTO recDEP;
    CLOSE DEP;
    OPEN OPER(vCONTRACT_ID,recDEP.DATE_DEPOSITE_CHANGE);
    FETCH OPER INTO recOPER;
    CLOSE OPER;
  --  APPEND_ROW(recDEP.DATE_DEPOSITE_CHANGE, -recDEP.CURRENT_DEPOSITE_VALUE, 'Депозит клиента. '||recOPER.NOTE);


  for q in (select pPHONE_NUMBER, recDEP.DATE_DEPOSITE_CHANGE,  -recDEP.CURRENT_DEPOSITE_VALUE, 'Депозит клиента. '||recOPER.NOTE from dual) loop
          pipe row (q);
          end loop;

  END IF;
  -- Платежи после даты договора
  FOR rec IN (
    SELECT
      PAYMENT_DATE,
      PAYMENT_SUM,
      PAYMENT_REMARK
    FROM
      V_FULL_BALANCE_PAYMENTS
    WHERE
      V_FULL_BALANCE_PAYMENTS.PHONE_NUMBER=pPHONE_NUMBER
      AND (
        V_FULL_BALANCE_PAYMENTS.PAYMENT_DATE >= vSTART_BALANCE_DATE_FOR_PAYMS
        OR (V_FULL_BALANCE_PAYMENTS.CONTRACT_ID = vCONTRACT_ID
             and V_FULL_BALANCE_PAYMENTS.PAYMENT_REMARK<>'Стартовый баланс'
             AND vFIX_YEAR_MONTH_ID IS NULL)
        )
      AND (pBALANCE_DATE IS NULL OR V_FULL_BALANCE_PAYMENTS.PAYMENT_DATE <= pBALANCE_DATE)
      )
  LOOP
   -- APPEND_ROW(rec.PAYMENT_DATE, rec.PAYMENT_SUM, 'Оплата: '||rec.PAYMENT_REMARK);

     for q in (select pPHONE_NUMBER, rec.PAYMENT_DATE,  rec.PAYMENT_SUM, 'Оплата: '||rec.PAYMENT_REMARK from dual) loop
          pipe row (q);
          end loop;

  END LOOP;
  -- начисления
  FLAG_CURR_MONTH:=0; --зА ТЕК МЕСЯЦ СЧЕТ ЕЩЕ НЕ ВЫСТАВЛЕН
  FOR rec IN (
    SELECT
      BILL_DATE,
      -NVL(V_FULL_BALANCE_BILLS.BILL_SUM, 0) BILL_SUM,
      V_FULL_BALANCE_BILLS.REMARK
      --'Начислено согласно счёту оператора за прошедший месяц'
    FROM
      V_FULL_BALANCE_BILLS
    WHERE
      V_FULL_BALANCE_BILLS.PHONE_NUMBER=pPHONE_NUMBER
      AND V_FULL_BALANCE_BILLS.BILL_DATE >= vSTART_BALANCE_DATE----vCORRECT_ACTIVATION_DATE_DAYS
      AND (pBALANCE_DATE IS NULL OR V_FULL_BALANCE_BILLS.BILL_DATE <= pBALANCE_DATE)
      and ((V_FULL_BALANCE_BILLS.BILL_CHECKED=1 and ms_constants.GET_CONSTANT_VALUE('USE_BILL_CHECK')='1')
            or (ms_constants.GET_CONSTANT_VALUE('USE_BILL_CHECK')<>'1'))
      )
  LOOP
    IF TO_CHAR(SYSDATE,'YYYYMM')=TO_CHAR(rec.BILL_DATE,'YYYYMM') THEN --ПОПАДЕТСЯ ЛИ ТЕКУЩИЙ МЕСЯЦ В ДАННОЙ СТРОКЕ
      FLAG_CURR_MONTH:=1;
    END IF;
    IF SUBSTR(rec.REMARK,1,1)='Д' THEN --ЕСЛИ ДЕТАЛИЗАЦИЯ ТО УТОЧНИМ
      rec_REPORT.DATE_LAST_UPDATE:=NULL;
      IF TO_NUMBER(TO_CHAR(SYSDATE,'DD'))-DAYS_NESTABIL>0
          OR TO_CHAR(rec.BILL_DATE,'YYYYMM')<>TO_CHAR(SYSDATE,'YYYYMM') THEN --DAYS_NESTABIL ДНЕЙ ОТ НАЧАЛА МЕСЯЦА НЕПОНЯТКИ С БИЛАЙНОМ
        OPEN DB_REPORT(TO_NUMBER(TO_CHAR(rec.BILL_DATE,'YYYYMM')));
        FETCH DB_REPORT INTO rec_REPORT;
        CLOSE DB_REPORT;
        IF rec_REPORT.DATE_LAST_UPDATE IS NOT NULL THEN
          IF (rec.BILL_DATE IS NULL) OR (rec.BILL_SUM>rec_REPORT.BILL_SUM) THEN
            rec.BILL_DATE:=rec_REPORT.DATE_LAST_UPDATE;
            rec.BILL_SUM:=rec_REPORT.BILL_SUM;
            rec.REMARK:=rec_REPORT.REMARKS;
          END IF;
        END IF;
      END IF;
     -- APPEND_ROW(rec.BILL_DATE, rec.BILL_SUM, rec.REMARK);
      for q in (select pPHONE_NUMBER, rec.BILL_DATE,  rec.BILL_SUM, rec.REMARK from dual) loop
          pipe row (q);
          end loop;


    ELSE
   --   APPEND_ROW(rec.BILL_DATE, rec.BILL_SUM, rec.REMARK);

        for q in (select pPHONE_NUMBER, rec.BILL_DATE,  rec.BILL_SUM, rec.REMARK from dual) loop
          pipe row (q);
          end loop;

    END IF;
  END LOOP;
  IF (FLAG_CURR_MONTH=0) AND (TO_NUMBER(TO_CHAR(SYSDATE,'DD'))-DAYS_NESTABIL>0)
      AND (pBALANCE_DATE IS NULL
            OR TO_NUMBER(TO_CHAR(SYSDATE,'YYYYMM')) = TO_NUMBER(TO_CHAR(pBALANCE_DATE,'YYYYMM'))) THEN --ЗА ТЕК МЕСЯЦ НЕ БЫЛО НИЧЕГО, ПРОБУЕМ НАЙТИ ОТЧЕТ
    rec_REPORT.DATE_LAST_UPDATE:=NULL;
    OPEN DB_REPORT(TO_NUMBER(TO_CHAR(SYSDATE,'YYYYMM')));
    FETCH DB_REPORT INTO rec_REPORT;
    CLOSE DB_REPORT;
    IF rec_REPORT.DATE_LAST_UPDATE IS NOT NULL THEN
    --  APPEND_ROW(rec_REPORT.DATE_LAST_UPDATE, rec_REPORT.BILL_SUM, rec_REPORT.REMARKS);
       for q in (select pPHONE_NUMBER, rec_REPORT.DATE_LAST_UPDATE,  rec_REPORT.BILL_SUM, rec_REPORT.REMARKS from dual) loop
          pipe row (q);
          end loop;
    END IF;
  END IF;
  -- Абонплата по тарифу
  -- Не учитываем историю изменения тарифа и статуса номера (нет данных)!
  -- Не учитываем историю изменения условий тарифов (нет данных)
  --
  IF '1' = MS_CONSTANTS.GET_CONSTANT_VALUE('CALC_ABON_PAYMENT_BLOCK_5_DAYS') THEN
    ABON_PAY_DAY_AFTER_BLOCK:=TRUE;
  ELSE
    ABON_PAY_DAY_AFTER_BLOCK:=FALSE;
  END IF;
  --
  -- Найдем дату активации
  IF vCORRECT_ACTIVATION_DATE_DAYS<>0 THEN
    OPEN NEW_DATE_ABON(vSTART_BALANCE_DATE, vCORRECT_ACTIVATION_DATE_DAYS);
    FETCH NEW_DATE_ABON INTO vTEMP_DATE_BEGIN_ABON;
    IF NEW_DATE_ABON%NOTFOUND THEN
      vTEMP_DATE_BEGIN_ABON:=vSTART_BALANCE_DATE;
    END IF;
    CLOSE NEW_DATE_ABON;
  ELSE
    vTEMP_DATE_BEGIN_ABON:=vSTART_BALANCE_DATE;
  END IF;
  -- Определим дату начала расчёта
  SELECT MAX(LAST_DATE)
  INTO vABON_PAYMENT_START_DATE
  FROM (
    -- Счета (первый день после последнего счёта)
    SELECT
      TRUNC(DB_LOADER_BILLS.DATE_END)+1 LAST_DATE
    FROM DB_LOADER_BILLS
    WHERE DB_LOADER_BILLS.PHONE_NUMBER = pPHONE_NUMBER
      and ((DB_LOADER_BILLS.BILL_CHECKED=1 and ms_constants.GET_CONSTANT_VALUE('USE_BILL_CHECK')='1')
            or (ms_constants.GET_CONSTANT_VALUE('USE_BILL_CHECK')<>'1'))
    UNION ALL
    -- Счета нофого формата
    SELECT TRUNC(LAST_DAY(TO_DATE(TO_CHAR(DB_LOADER_FULL_FINANCE_BILL.YEAR_MONTH)||'01', 'YYYYMMDD')))+1 LAST_DATE
      FROM DB_LOADER_FULL_FINANCE_BILL
      WHERE DB_LOADER_FULL_FINANCE_BILL.PHONE_NUMBER = pPHONE_NUMBER
        AND DB_LOADER_FULL_FINANCE_BILL.COMPLETE_BILL = 1
        and DB_LOADER_FULL_FINANCE_BILL.YEAR_MONTH <=201310
    UNION ALL
    -- либо дата баланса/договора
    SELECT vTEMP_DATE_BEGIN_ABON
    FROM DUAL
  );
  IF vABON_PAYMENT_START_DATE<vSTART_BALANCE_DATE THEN
    vABON_PAYMENT_START_DATE:=vSTART_BALANCE_DATE;
  END IF;
  -- Начислено
  FOR recPAYMENTS IN (
  SELECT DISTINCT
    DB_LOADER_ACCOUNT_PHONES.YEAR_MONTH,
    TO_DATE(DB_LOADER_ACCOUNT_PHONES.YEAR_MONTH, 'YYYYMM') BEGIN_DATE,
    ADD_MONTHS(TO_DATE(DB_LOADER_ACCOUNT_PHONES.YEAR_MONTH, 'YYYYMM'), 1)-1 END_DATE,
    TO_DATE(DB_LOADER_ACCOUNT_PHONES.YEAR_MONTH, 'YYYYMM') FIRST_MONTH_DATE,
    ADD_MONTHS(TO_DATE(DB_LOADER_ACCOUNT_PHONES.YEAR_MONTH, 'YYYYMM'), 1)-1 LAST_MONTH_DATE,
    DB_LOADER_ACCOUNT_PHONES.PHONE_IS_ACTIVE,
    DB_LOADER_ACCOUNT_PHONES.CELL_PLAN_CODE
  FROM
    DB_LOADER_ACCOUNT_PHONES
  WHERE
    DB_LOADER_ACCOUNT_PHONES.PHONE_NUMBER=pPHONE_NUMBER
    AND (pBALANCE_DATE IS NULL OR TO_DATE(DB_LOADER_ACCOUNT_PHONES.YEAR_MONTH, 'YYYYMM')<=pBALANCE_DATE)
    AND DB_LOADER_ACCOUNT_PHONES.YEAR_MONTH >= TO_CHAR(vABON_PAYMENT_START_DATE, 'YYYYMM')
  UNION ALL
  -- А здесь добавим информацию текущего месяц, если он уже начался, а данные ещё не загружены.
  -- Все сведения берём из предыдущего месяца.
SELECT
    TO_NUMBER(TO_CHAR(
      ADD_MONTHS(
        TO_DATE(DB_LOADER_ACCOUNT_PHONES.YEAR_MONTH, 'YYYYMM'),
        1), -- Увеличим номер месяца на 1
      'YYYYMM'
        )) as YEAR_MONTH,
    ADD_MONTHS(TO_DATE(DB_LOADER_ACCOUNT_PHONES.YEAR_MONTH, 'YYYYMM'), 1) BEGIN_DATE,
    ADD_MONTHS(TO_DATE(DB_LOADER_ACCOUNT_PHONES.YEAR_MONTH, 'YYYYMM'), 2)-1 END_DATE,
    ADD_MONTHS(TO_DATE(DB_LOADER_ACCOUNT_PHONES.YEAR_MONTH, 'YYYYMM'), 1) FIRST_MONTH_DATE,
    ADD_MONTHS(TO_DATE(DB_LOADER_ACCOUNT_PHONES.YEAR_MONTH, 'YYYYMM'), 2)-1 LAST_MONTH_DATE,
    DB_LOADER_ACCOUNT_PHONES.PHONE_IS_ACTIVE,
    DB_LOADER_ACCOUNT_PHONES.CELL_PLAN_CODE
  FROM
    DB_LOADER_ACCOUNT_PHONES
  WHERE
    DB_LOADER_ACCOUNT_PHONES.PHONE_NUMBER=pPHONE_NUMBER
    AND DB_LOADER_ACCOUNT_PHONES.YEAR_MONTH = TO_CHAR(SYSDATE-5, 'YYYYMM')
    AND NOT EXISTS(
      SELECT 1 FROM DB_LOADER_ACCOUNT_PHONES
      WHERE DB_LOADER_ACCOUNT_PHONES.YEAR_MONTH=TO_NUMBER(TO_CHAR(NVL(pBALANCE_DATE, SYSDATE), 'YYYYMM'))
      )
    )
  LOOP
--    dbms_output.put_line('recPAYMENTS.END_DATE=' || recPAYMENTS.END_DATE);
if pPERIOD_ACTIV=true then vPERIOD_ACTIV:=0; end if;
if pPERIOD_ACTIV=false then vPERIOD_ACTIV:=1; end if;

    IF NVL(vCREDIT, 0)<>1 THEN -- Если 1, то договор кредитный, тогда абонку не считаем
      IF recPAYMENTS.BEGIN_DATE < vABON_PAYMENT_START_DATE THEN
        recPAYMENTS.BEGIN_DATE := vABON_PAYMENT_START_DATE;
      END IF;
      IF pCALC_ABON_PAYMENT_TO_MONTHEND=1 THEN
        -- Абонплата считается на конец текущего месяца.
        NULL;
      ELSE
        -- Абонплату нужно считать по текущую дату.
        IF recPAYMENTS.END_DATE > TRUNC(SYSDATE) THEN
          recPAYMENTS.END_DATE := TRUNC(SYSDATE);
        END IF;
      END IF;
      PREV_STATUS:=NULL;
      TEMP_DATE_END_SCHET:=TRUNC(recPAYMENTS.END_DATE+1);
      OPEN cPHONE_STATUS_HISTORY(pPHONE_NUMBER, recPAYMENTS.BEGIN_DATE, recPAYMENTS.END_DATE, pCALC_ABON_PAYMENT_TO_MONTHEND);
      FETCH cPHONE_STATUS_HISTORY INTO recPHONE_STATUS_HISTORY;
      LOOP
        if pPERIOD_ACTIV=true then
          vPERIOD_ACTIV:=vPERIOD_ACTIV + recPHONE_STATUS_HISTORY.PHONE_IS_ACTIVE;
           END IF;
        IF TRUNC(recPHONE_STATUS_HISTORY.END_DATE)>=TRUNC(TEMP_DATE_END_SCHET-1) THEN
          recPHONE_STATUS_HISTORY.END_DATE:=TRUNC(TEMP_DATE_END_SCHET-1);
        END IF;
        IF (recPHONE_STATUS_HISTORY.END_DATE>=recPHONE_STATUS_HISTORY.BEGIN_DATE)
            AND(TRUNC(recPHONE_STATUS_HISTORY.BEGIN_DATE)<=TRUNC(TEMP_DATE_END_SCHET-1)) THEN
          -- Первый раз всегда заходим в цикл, даже если нет записей.
          -- Установим значения по умолчанию, если истории нет
          IF recPHONE_STATUS_HISTORY.CELL_PLAN_CODE IS NULL THEN
            recPHONE_STATUS_HISTORY.CELL_PLAN_CODE := recPAYMENTS.CELL_PLAN_CODE;
          END IF;
          IF recPHONE_STATUS_HISTORY.PHONE_IS_ACTIVE IS NULL THEN
            recPHONE_STATUS_HISTORY.PHONE_IS_ACTIVE := recPAYMENTS.PHONE_IS_ACTIVE;
          END IF;
          IF ABON_PAY_DAY_AFTER_BLOCK THEN
            IF (recPHONE_STATUS_HISTORY.PHONE_IS_ACTIVE=0)
                  AND (PREV_STATUS IS NULL
                         OR PREV_STATUS=1) THEN
              IF recPHONE_STATUS_HISTORY.END_DATE-recPHONE_STATUS_HISTORY.BEGIN_DATE>=5 THEN
                recPHONE_STATUS_HISTORY.END_DATE:=recPHONE_STATUS_HISTORY.BEGIN_DATE+5;
              END IF;
            END IF;
          END IF;
          IF recPHONE_STATUS_HISTORY.BEGIN_DATE < recPAYMENTS.BEGIN_DATE THEN
            recPHONE_STATUS_HISTORY.BEGIN_DATE:=recPAYMENTS.BEGIN_DATE;
          END IF;
          -- Определим дневную стоимость
          recPHONE_STATUS_HISTORY.DAYLY_PRICE := recPHONE_STATUS_HISTORY.DAYLY_PRICE
              + (recPHONE_STATUS_HISTORY.MONTHLY_PRICE / (recPAYMENTS.LAST_MONTH_DATE - recPAYMENTS.FIRST_MONTH_DATE + 1));
          IF (NOT(vACCOUNT_ID=54 AND TO_NUMBER(TO_CHAR(recPHONE_STATUS_HISTORY.END_DATE, 'YYYYMM'))<=201202))
              AND (TRUNC(recPHONE_STATUS_HISTORY.BEGIN_DATE)<=TRUNC(recPHONE_STATUS_HISTORY.END_DATE)) THEN
           /* APPEND_ROW(
              recPHONE_STATUS_HISTORY.BEGIN_DATE,
              --Процент владельца
              RECALC_CHARGE_COST(pPHONE_NUMBER, -(recPHONE_STATUS_HISTORY.DAYLY_PRICE*(recPHONE_STATUS_HISTORY.END_DATE-recPHONE_STATUS_HISTORY.BEGIN_DATE+1))),
              'Абонплата ('
                || recPHONE_STATUS_HISTORY.CELL_PLAN_CODE
                || CASE WHEN recPHONE_STATUS_HISTORY.PHONE_IS_ACTIVE = 1 THEN
                  ', активный'
                  ELSE
                  ', блокирован'
                  END
                || ') c ' || TO_CHAR(recPHONE_STATUS_HISTORY.BEGIN_DATE, 'DD.MM.YYYY') || ' по ' || TO_CHAR(recPHONE_STATUS_HISTORY.END_DATE, 'DD.MM.YYYY') || ' ('
                || ROUND(RECALC_CHARGE_COST(pPHONE_NUMBER, recPHONE_STATUS_HISTORY.DAYLY_PRICE), 2) || ' руб./день)'
              );*/

            for q in (select pPHONE_NUMBER, recPHONE_STATUS_HISTORY.BEGIN_DATE,
              --Процент владельца
              RECALC_CHARGE_COST(pPHONE_NUMBER, -(recPHONE_STATUS_HISTORY.DAYLY_PRICE*(recPHONE_STATUS_HISTORY.END_DATE-recPHONE_STATUS_HISTORY.BEGIN_DATE+1))),
              'Абонплата ('
                || recPHONE_STATUS_HISTORY.CELL_PLAN_CODE
                || CASE WHEN recPHONE_STATUS_HISTORY.PHONE_IS_ACTIVE = 1 THEN
                  ', активный'
                  ELSE
                  ', блокирован'
                  END
                || ') c ' || TO_CHAR(recPHONE_STATUS_HISTORY.BEGIN_DATE, 'DD.MM.YYYY') || ' по ' || TO_CHAR(recPHONE_STATUS_HISTORY.END_DATE, 'DD.MM.YYYY') || ' ('
                || ROUND(RECALC_CHARGE_COST(pPHONE_NUMBER, recPHONE_STATUS_HISTORY.DAYLY_PRICE), 2) || ' руб./день)' from dual) loop
          pipe row (q);
          end loop;


          END IF;
          TEMP_DATE_END_SCHET:=TRUNC(recPHONE_STATUS_HISTORY.BEGIN_DATE);
        END IF;
        PREV_STATUS:=recPHONE_STATUS_HISTORY.PHONE_IS_ACTIVE;
        FETCH cPHONE_STATUS_HISTORY INTO recPHONE_STATUS_HISTORY;
        EXIT WHEN cPHONE_STATUS_HISTORY%NOTFOUND;
      END LOOP;
      CLOSE cPHONE_STATUS_HISTORY;
--      vABON_PAYMENT_SUM := vABON_PAYMENT_SUM +
--        (recPAYMENTS.DAYLY_PRICE * (recPAYMENTS.END_DATE - recPAYMENTS.START_DATE + 1));
    END IF;
-- Проверка наличия данных этого месяца
    FLAG_DATA_OPTIONS_CURR_MONTH:=0;
    FOR recFLAG IN (
      SELECT
        DB_LOADER_ACCOUNT_PHONE_OPTS.OPTION_CODE
      FROM
        DB_LOADER_ACCOUNT_PHONE_OPTS
      WHERE
        DB_LOADER_ACCOUNT_PHONE_OPTS.YEAR_MONTH=recPAYMENTS.YEAR_MONTH
        AND DB_LOADER_ACCOUNT_PHONE_OPTS.PHONE_NUMBER=pPHONE_NUMBER
      )
    LOOP
      FLAG_DATA_OPTIONS_CURR_MONTH:=1;
      EXIT;
    END LOOP;
    PAYMENTS_PREV_MONTH:=CASE
                           WHEN recPAYMENTS.YEAR_MONTH-ROUND(recPAYMENTS.YEAR_MONTH/100)*100=1 THEN recPAYMENTS.YEAR_MONTH-89
                           ELSE recPAYMENTS.YEAR_MONTH-1
                         END;
    FOR recSERVICES IN (
      SELECT
        DB_LOADER_ACCOUNT_PHONE_OPTS.OPTION_CODE,
        DB_LOADER_ACCOUNT_PHONE_OPTS.OPTION_NAME,
        DB_LOADER_ACCOUNT_PHONE_OPTS.TURN_ON_DATE,
        DB_LOADER_ACCOUNT_PHONE_OPTS.TURN_OFF_DATE,
        DB_LOADER_ACCOUNT_PHONE_OPTS.TURN_ON_COST,
        DB_LOADER_ACCOUNT_PHONE_OPTS.MONTHLY_PRICE,
        ACCOUNTS.OPERATOR_ID
      FROM
        DB_LOADER_ACCOUNT_PHONE_OPTS,
        ACCOUNTS
      WHERE --ACCOUNT_ID=45
        DB_LOADER_ACCOUNT_PHONE_OPTS.ACCOUNT_ID=ACCOUNTS.ACCOUNT_ID
        AND (
          (DB_LOADER_ACCOUNT_PHONE_OPTS.YEAR_MONTH=recPAYMENTS.YEAR_MONTH
            AND FLAG_DATA_OPTIONS_CURR_MONTH=1)
          OR (DB_LOADER_ACCOUNT_PHONE_OPTS.YEAR_MONTH=PAYMENTS_PREV_MONTH
            AND FLAG_DATA_OPTIONS_CURR_MONTH=0
            AND DB_LOADER_ACCOUNT_PHONE_OPTS.TURN_OFF_DATE>=TO_DATE(TO_CHAR(recPAYMENTS.YEAR_MONTH)||'01','YYYYMMDD') )
            )
        AND DB_LOADER_ACCOUNT_PHONE_OPTS.PHONE_NUMBER=pPHONE_NUMBER -- '9037786589'
       -- AND (DB_LOADER_ACCOUNT_PHONE_OPTS.TURN_ON_COST <> 0 OR DB_LOADER_ACCOUNT_PHONE_OPTS.MONTHLY_PRICE <> 0)
        AND (pBALANCE_DATE IS NULL OR DB_LOADER_ACCOUNT_PHONE_OPTS.TURN_ON_DATE <= pBALANCE_DATE)
      )
    LOOP
      -- Начальная дата
      vSERVICE_START_DATE := recPAYMENTS.BEGIN_DATE; -- Начало месяца
      IF vSERVICE_START_DATE < recSERVICES.TURN_ON_DATE THEN
        vSERVICE_START_DATE := TRUNC(recSERVICES.TURN_ON_DATE); -- Дата подключения
      END IF;
      -- Конечная дата
      vSERVICE_END_DATE := recPAYMENTS.LAST_MONTH_DATE; -- Конец месяца
      --
      vDATE_SERVICE_CHECK:=recSERVICES.TURN_ON_DATE+1;
      IF vDATE_SERVICE_CHECK<vCONTRACT_DATE THEN
        vDATE_SERVICE_CHECK:=vCONTRACT_DATE+1;
      END IF;
      IF vDATE_SERVICE_CHECK<TO_DATE(recPAYMENTS.YEAR_MONTH||'01', 'YYYYMMDD') THEN
        vDATE_SERVICE_CHECK:=TO_DATE(recPAYMENTS.YEAR_MONTH||'01', 'YYYYMMDD')+1;
      END IF;
      OPEN CODE(vDATE_SERVICE_CHECK+5); -- Дата подключения услуги + 5 дней на случай запаздывания загрузки
      FETCH CODE INTO recCODE; -- ПОЛУЧАМ КОД ТАРИФА В ТОТ МИГ
      CLOSE CODE;             --
      GET_TARIFF_OPTION_COST(
        recSERVICES.OPERATOR_ID,
        GET_PHONE_TARIFF_ID(pPHONE_NUMBER, recCODE, vDATE_SERVICE_CHECK), -- Тариф БЕРЕМ по функции
        recSERVICES.OPTION_CODE,
        vDATE_SERVICE_CHECK,
        vNEW_TURN_ON_COST,
        vNEW_MONTHLY_COST
        );
      -- Если стоимость в справочнике задана, то используем её.
      recSERVICES.TURN_ON_COST := NVL(NVL(vNEW_TURN_ON_COST, recSERVICES.TURN_ON_COST), 0);
      recSERVICES.MONTHLY_PRICE := NVL(NVL(vNEW_MONTHLY_COST, recSERVICES.MONTHLY_PRICE), 0);
      -- Стоимость подключения списываем только в том месяце, в котором подключили.
      IF recSERVICES.TURN_ON_COST <> 0 THEN
        -- Если стоимость подключения ненулевая,
        -- то надо проверить дату подключения.
        -- Если дата подключения в текущем месяце, то надо её учесть.
        IF TO_CHAR(recSERVICES.TURN_ON_DATE, 'YYYYMM') = recPAYMENTS.YEAR_MONTH THEN
         /* APPEND_ROW(
            recSERVICES.TURN_ON_DATE,
            --Процент владельца
            RECALC_CHARGE_COST(pPHONE_NUMBER, -recSERVICES.TURN_ON_COST),
            'Подключена услуга ' || recSERVICES.OPTION_NAME
              || ' (' || recSERVICES.OPTION_CODE
              || ') с ' || TO_CHAR(recSERVICES.TURN_ON_DATE, 'DD.MM.YYYY')
            );*/

         for q in (select  pPHONE_NUMBER, recSERVICES.TURN_ON_DATE,
            --Процент владельца
            RECALC_CHARGE_COST(pPHONE_NUMBER, -recSERVICES.TURN_ON_COST),
            'Подключена услуга ' || recSERVICES.OPTION_NAME
              || ' (' || recSERVICES.OPTION_CODE
              || ') с ' || TO_CHAR(recSERVICES.TURN_ON_DATE, 'DD.MM.YYYY') from dual) loop
          pipe row (q);
          end loop;

        END IF;
      END IF;
      -- Ежемесячная абонентская плата за услугу
      IF (recSERVICES.MONTHLY_PRICE <> 0)AND(NVL(vCREDIT, 0)<>1) AND (vPERIOD_ACTIV > 0) THEN
        --
        --   Списание абонплаты делаем так:
        --   - Если услуга подключена в текущем месяце, то по количеству дней
        --     от даты подключения до конца месяца, либо до даты отключения,
        --     либо до текущей даты, если абонплату считаем "по сегодня".
        --   - Если услуга подключена ранее, то в размере месячной платы, либо
        --     по количеству дней от начала месяца до даты отключения.
        --   - Если услуга подключена позднее (если счёта ещё нет), то списание не делаем.
        --
        -- Если абонплата считается не до конца месяца, то корректируем дату окончания
        IF NOT vCALC_ABON_PAYMENT_TO_MONTHEND THEN
          IF vSERVICE_END_DATE > TRUNC(NVL(pBALANCE_DATE, SYSDATE)) THEN
            vSERVICE_END_DATE := TRUNC(NVL(pBALANCE_DATE, SYSDATE));
          END IF;
        END IF;
        -- Если услуга отключена ранее конца проверяемого месяца, то
        -- дата окончания услуги корректируется
        IF vSERVICE_END_DATE > recSERVICES.TURN_OFF_DATE THEN
          vSERVICE_END_DATE := recSERVICES.TURN_OFF_DATE;
        END IF;
        --
        vSERVICE_PAID_FULL:=0;
        IF (pPHONE_NUMBER='9099093514')AND(recSERVICES.OPTION_CODE='MN_UNLIMC')and(vSERVICE_END_DATE>=TRUNC(NVL(pBALANCE_DATE, SYSDATE))) then
          IF vSERVICE_END_DATE>=trunc(sysdate) then
            vSERVICE_END_DATE:=
              CASE
                WHEN TO_NUMBER(TO_CHAR(SYSDATE, 'DD'))<=25 THEN
                  TO_DATE('25'||TO_CHAR(SYSDATE, 'MMYYYY'), 'DDMMYYYY')
                ELSE TO_DATE('25'||TO_CHAR(ADD_MONTHS(SYSDATE, 1), 'MMYYYY'), 'DDMMYYYY')
              END;
            vSERVICE_PAID_FULL:=1;
          END IF;
        END IF;
        --
        IF (recSERVICES.OPTION_CODE='GPRS_FS' or recSERVICES.OPTION_CODE='GPRS_1GB')AND(vSERVICE_END_DATE>SYSDATE) THEN
          vSERVICE_END_DATE:=SYSDATE;
        END IF;
        --
        IF vCALC_OPTIONS_DAILY_ACTIV='1' THEN
          vLAST_DAY_OPTION_ADD:=vSERVICE_START_DATE-1;
          vCOUNT_ACT_OPTION:=0;
          FOR recACTIV IN OPT_ACT(vSERVICE_START_DATE, vSERVICE_END_DATE) LOOP
            IF recACTIV.BEGIN_DATE<=vLAST_DAY_OPTION_ADD THEN
              recACTIV.BEGIN_DATE:=vLAST_DAY_OPTION_ADD+1;
            END IF;
            IF recACTIV.END_DATE>vSERVICE_END_DATE THEN
              recACTIV.END_DATE:=vSERVICE_END_DATE;
            END IF;
            vCOUNT_ACT_OPTION:=vCOUNT_ACT_OPTION+(TRUNC(recACTIV.END_DATE)-TRUNC(recACTIV.BEGIN_DATE)+1);
            vLAST_DAY_OPTION_ADD:=recACTIV.END_DATE;
          END LOOP;
        END IF;
        -- Списание
        IF (vSERVICE_START_DATE <= vSERVICE_END_DATE)
            AND (pBALANCE_DATE IS NULL OR vSERVICE_START_DATE <= pBALANCE_DATE) THEN
          IF vSERVICE_PAID_FULL=0 THEN
          /*  APPEND_ROW(
              vSERVICE_START_DATE,
              --Процент владельца
              RECALC_CHARGE_COST(pPHONE_NUMBER,
                -recSERVICES.MONTHLY_PRICE
                * CASE
                    WHEN vCALC_OPTIONS_DAILY_ACTIV='1' THEN vCOUNT_ACT_OPTION
                    ELSE (TRUNC(vSERVICE_END_DATE) - TRUNC(vSERVICE_START_DATE) + 1)
                  END
                / (TRUNC(recPAYMENTS.LAST_MONTH_DATE) - TRUNC(recPAYMENTS.FIRST_MONTH_DATE) + 1))
              ,
              'Абонплата за услугу ' || recSERVICES.OPTION_NAME
                || ' (' || recSERVICES.OPTION_CODE
                || ') с ' || TO_CHAR(vSERVICE_START_DATE, 'DD.MM.YYYY')
                || ' по ' || TO_CHAR(vSERVICE_END_DATE, 'DD.MM.YYYY')
                || CASE
                     WHEN vCALC_OPTIONS_DAILY_ACTIV='1' THEN ' Был акт. дн: '||TO_CHAR(vCOUNT_ACT_OPTION)
                     ELSE ''
                   END
              );*/

         for q in (select  pPHONE_NUMBER, vSERVICE_START_DATE,
              --Процент владельца
              RECALC_CHARGE_COST(pPHONE_NUMBER,
                -recSERVICES.MONTHLY_PRICE
                * CASE
                    WHEN vCALC_OPTIONS_DAILY_ACTIV='1' THEN vCOUNT_ACT_OPTION
                    ELSE (TRUNC(vSERVICE_END_DATE) - TRUNC(vSERVICE_START_DATE) + 1)
                  END
                / (TRUNC(recPAYMENTS.LAST_MONTH_DATE) - TRUNC(recPAYMENTS.FIRST_MONTH_DATE) + 1))
              ,
              'Абонплата за услугу ' || recSERVICES.OPTION_NAME
                || ' (' || recSERVICES.OPTION_CODE
                || ') с ' || TO_CHAR(vSERVICE_START_DATE, 'DD.MM.YYYY')
                || ' по ' || TO_CHAR(vSERVICE_END_DATE, 'DD.MM.YYYY')
                || CASE
                     WHEN vCALC_OPTIONS_DAILY_ACTIV='1' THEN ' Был акт. дн: '||TO_CHAR(vCOUNT_ACT_OPTION)
                     ELSE ''
                   END   from dual) loop
          pipe row (q);
          end loop;

          ELSE
           /* APPEND_ROW(
              vSERVICE_START_DATE,
              --Процент владельца
              RECALC_CHARGE_COST(pPHONE_NUMBER,
                CASE
                  WHEN TO_NUMBER(TO_CHAR(SYSDATE, 'DD'))<=25 THEN -recSERVICES.MONTHLY_PRICE
                  ELSE  -recSERVICES.MONTHLY_PRICE*2
                END)
              ,
              'Плата за услугу ' || recSERVICES.OPTION_NAME || ' до ' ||
              TO_CHAR(CASE
                        WHEN TO_NUMBER(TO_CHAR(SYSDATE, 'DD'))<=25 THEN
                          TO_DATE('25'||TO_CHAR(SYSDATE, 'MMYYYY'), 'DDMMYYYY')
                        ELSE TO_DATE('25'||TO_CHAR(ADD_MONTHS(SYSDATE, 1), 'MMYYYY'), 'DDMMYYYY')
                      END, 'DD.MM.YYYY')
              );*/

            for q in (select  pPHONE_NUMBER, vSERVICE_START_DATE,
              --Процент владельца
              RECALC_CHARGE_COST(pPHONE_NUMBER,
                CASE
                  WHEN TO_NUMBER(TO_CHAR(SYSDATE, 'DD'))<=25 THEN -recSERVICES.MONTHLY_PRICE
                  ELSE  -recSERVICES.MONTHLY_PRICE*2
                END)
              ,
              'Плата за услугу ' || recSERVICES.OPTION_NAME || ' до ' ||
              TO_CHAR(CASE
                        WHEN TO_NUMBER(TO_CHAR(SYSDATE, 'DD'))<=25 THEN
                          TO_DATE('25'||TO_CHAR(SYSDATE, 'MMYYYY'), 'DDMMYYYY')
                        ELSE TO_DATE('25'||TO_CHAR(ADD_MONTHS(SYSDATE, 1), 'MMYYYY'), 'DDMMYYYY')
                      END, 'DD.MM.YYYY')  from dual) loop
          pipe row (q);
          end loop;


          END IF;
        END IF;
      END IF;
    END LOOP;
  END LOOP;
END;




function get_abonent_balance ( pPHONE_NUM IN VARCHAR2 default null, pdate_balance IN date default null) return number is
  res number;
  begin

   select sum(round(t.cost_rows,2)) into res
    from TABLE(CALCBALANCEROWS2(pPHONE_NUMBER => pPHONE_NUM,pBALANCE_DATE => pdate_balance)) t;
     RETURN res;

      end;

function ABON_BALANS_WITHOUTSORT (paccount_id in integer)
  return tblABONBALANS
  pipelined

 is

begin

    for q in (

SELECT t.PHONE_NUMBER_FEDERAL, t.OPERATOR_NAME, t.SURNAME,
       t.NAME, t.PATRONYMIC, t.BDATE, t.CONTACT_INFO,
       t.BALANCE, t.DISCONNECT_LIMIT, t.CONNECT_LIMIT, t.IS_VIP,
       t.PHONE_IS_ACTIVE_CODE, t.ACCOUNT_ID, t.STATUS_DATE,
       t.TARIFF_NAME, t.TARIFF_ID, t.LOADER_SCRIPT_NAME, t.HAND_BLOCK,
       T.IS_CREDIT_CONTRACT,
       CASE
         WHEN t.phone_is_active_code = 0
           THEN
             CASE
               WHEN T.PHONE_CONSERVATION=1 THEN 'Блок.'
               ELSE 'Сохр.'
             END
         ELSE 'Акт.'
       END AS phone_is_active,
       CASE
          WHEN balance < NVL (disconnect_limit, 0)
             THEN balance - NVL (disconnect_limit, 0)
          ELSE TO_NUMBER (NULL)
       END limit_exceed_sum,
       T.ACCOUNT_NUMBER,
       T.COMPANY_NAME,
       CASE
          WHEN t.IS_DISCOUNT_OPERATOR = 1
             THEN 'Да'
          ELSE 'Нет'
       END AS IS_DISCOUNT,
       T.COLOR
  FROM (SELECT c.phone_number_federal, operators.operator_name,
               a.surname, a.NAME, a.patronymic, a.bdate, a.contact_info,
               get_abonent_balance (c.phone_number_federal) balance,
               c.disconnect_limit, c.connect_limit, C.IS_CREDIT_CONTRACT,
               DECODE (a.is_vip, 1, 'Да', NULL) is_vip,
               (SELECT db_loader_account_phones.phone_is_active
                  FROM db_loader_account_phones
                  WHERE db_loader_account_phones.phone_number = c.phone_number_federal
                    AND ROWNUM<=1
                    AND (db_loader_account_phones.year_month =
                        (SELECT MAX (t2.year_month)
                           FROM db_loader_account_phones t2
                           WHERE t2.phone_number = c.phone_number_federal)
                        )
               ) AS phone_is_active_code,
               (SELECT db_loader_account_phones.CONSERVATION
                  FROM db_loader_account_phones
                  WHERE db_loader_account_phones.phone_number = c.phone_number_federal
                    AND ROWNUM<=1
                    AND (db_loader_account_phones.year_month =
                        (SELECT MAX (t2.year_month)
                           FROM db_loader_account_phones t2
                           WHERE t2.phone_number = c.phone_number_federal)
                        )
               ) AS PHONE_CONSERVATION,
               ac.ACCOUNT_ID,
               (SELECT TRUNC (MAX (db_loader_account_phone_hists.begin_date))
                 FROM db_loader_account_phone_hists
                 WHERE db_loader_account_phone_hists.phone_number = c.phone_number_federal
                --    AND ROWNUM<=1
               ) AS status_date,
               (SELECT NVL (tariffs.tariff_name, db_loader_account_phones.cell_plan_code)
                  FROM db_loader_account_phones, tariffs
                  WHERE db_loader_account_phones.phone_number = c.phone_number_federal
                    AND ROWNUM<=1
                    AND tariffs.tariff_id(+) =
                        get_phone_tariff_id(
                          db_loader_account_phones.phone_number,
                          db_loader_account_phones.cell_plan_code,
                          db_loader_account_phones.last_check_date_time
                          )
                    AND (db_loader_account_phones.year_month =
                        (SELECT MAX (t2.year_month)
                           FROM db_loader_account_phones t2
                           WHERE t2.phone_number = c.phone_number_federal)
                        )
               ) AS tariff_name,
               (SELECT get_phone_tariff_id(
                    db_loader_account_phones.phone_number,
                    db_loader_account_phones.cell_plan_code,
                    db_loader_account_phones.last_check_date_time
                    )
                  FROM db_loader_account_phones
                  WHERE db_loader_account_phones.phone_number = c.phone_number_federal
                    AND ROWNUM<=1
                    AND (db_loader_account_phones.year_month =
                        (SELECT MAX (t2.year_month)
                           FROM db_loader_account_phones t2
                           WHERE t2.phone_number = c.phone_number_federal)
                        )
               ) AS TARIFF_ID,
               operators.loader_script_name,
               c.hand_block,
               ac.ACCOUNT_NUMBER,
               ac.COMPANY_NAME,
               CASE
                 WHEN PHONE_NUMBER_ATTRIBUTES.IS_DISCOUNT_OPERATOR=1
                        AND PHONE_NUMBER_ATTRIBUTES.DISCOUNT_BEGIN_DATE<=SYSDATE
                        AND ADD_MONTHS(PHONE_NUMBER_ATTRIBUTES.DISCOUNT_BEGIN_DATE,
                                       PHONE_NUMBER_ATTRIBUTES.DISCOUNT_VALIDITY)>=SYSDATE
                   THEN 1
                 ELSE 0
               END AS IS_DISCOUNT_OPERATOR,
               CASE
                 WHEN PHONE_NUMBER_ATTRIBUTES.DISCOUNT_BEGIN_DATE<=SYSDATE
                        AND ADD_MONTHS(PHONE_NUMBER_ATTRIBUTES.DISCOUNT_BEGIN_DATE,
                                       PHONE_NUMBER_ATTRIBUTES.DISCOUNT_VALIDITY)>=SYSDATE+7
                   THEN 0
                 ELSE 1
               END AS COLOR
          FROM v_contracts c, abonents a, operators, PHONE_NUMBER_ATTRIBUTES, ACCOUNTS AC
          WHERE GET_ACCOUNT_ID_BY_PHONE(c.PHONE_NUMBER_FEDERAL)=paccount_id
            and c.abonent_id = a.abonent_id
            AND c.contract_cancel_date IS NULL
            AND operators.operator_id(+) = c.operator_id
            and ac.ACCOUNT_ID(+) = GET_ACCOUNT_ID_BY_PHONE(c.PHONE_NUMBER_FEDERAL)
            AND PHONE_NUMBER_ATTRIBUTES.PHONE_NUMBER(+) = C.PHONE_NUMBER_FEDERAL
            AND c.phone_number_federal IN (SELECT p1.phone_number
                                       FROM db_loader_account_phones p1
                                       WHERE p1.year_month =(SELECT MAX(p2.year_month)
                                                               FROM db_loader_account_phones p2
                                                               --where p2.ACCOUNT_ID=p1.ACCOUNT_ID
                                           ))
     ) t ) loop
      pipe row (q);
          end loop;

     RETURN;


     end;

   function pip(in_p rc_t1)
      return tab_t pipelined
     parallel_enable (partition in_p by range(account_id))
        order in_p by (phone_number_federal)
      is
        v_rec rowABONBALANS;
      begin
        loop
         fetch in_p into v_rec;
         exit when in_p%notfound;
         pipe row(v_rec);
       end loop;
       return;
     end;


 function CALC_BALANCE_STAT_BY_YM(
  pPHONE_NUMBER  VARCHAR2,
  pBALANCE_DATE  DATE DEFAULT NULL,
  pYEAR_MONTH  INTEGER
  ) return tblCALCBALANCESTATBYYM
pipelined is
--#Version=1

  pBALANCE NUMBER:=0;
  pCHARGES NUMBER:=0;
  pABON NUMBER:=0;
  pABON_BE NUMBER:=0;
  pABON_BL_BE NUMBER:=0;
  pUSL NUMBER:=0 ;
  pBILLS NUMBER:=0;
  pBILL_AB NUMBER:=0;
  pBILL_AB_BE NUMBER:=0;
  pBILL_USL NUMBER:=0;

  vBALANCE_DATE DATE;
  vvBALANCE_DATE DATE;
  vDAYS integer;
  vCODE VARCHAR2(20 CHAR);
  vSUM VARCHAR2(20 CHAR);
  vACT NUMBER;
  vABON INTEGER;
  vAB_BE_AC NUMBER(13, 4);
  vAB_BE_BL NUMBER(13, 4);

  FUNCTION TO_NUM(RES IN VARCHAR2) RETURN NUMBER IS
    ITOG NUMBER(15,4);
    vRES VARCHAR2(15 CHAR);
    BEGIN
      vRES:=REPLACE(RES, ',', '.');
      BEGIN
        ITOG:=TO_NUMBER(vRES);
      EXCEPTION
        WHEN OTHERS THEN
          ITOG:=TO_NUMBER(REPLACE(vRES, '.', ','));
      END;
      RETURN ITOG;
    END;
BEGIN

  pBALANCE:=0;
  pCHARGES:=0;
  pABON:=0;
  pABON_BE:=0;
  pABON_BL_BE:=0;
  pUSL:=0;
  pBILLS:=0;
  pBILL_AB:=0;
  pBILL_AB_BE:=0;
  pBILL_USL:=0;
  vBALANCE_DATE:=pBALANCE_DATE;

  select last_day(to_date(pYEAR_MONTH, 'yyyymm'))-to_date(pYEAR_MONTH, 'yyyymm')+1 into vDAYS from dual;
   -- select last_day(to_date(pYEAR_MONTH, 'yyyymm')) into vvBALANCE_DATE from dual;
   select trunc(sysdate) into vvBALANCE_DATE from dual;
/*
 CALC_BALANCE_ROWS2(pPHONE_NUMBER, DATE_ROWS, COST_ROWS, DESCRIPTION_ROWS, TRUE, vBALANCE_DATE);
  L := COST_ROWS.LAST;*/

    FOR x IN ( select t1.phone_number, t1.date_rows, nvl(t1.cost_rows,0) cost_rows, t1.DESCRIPTION_ROWS from
TABLE(Balance.CALCBALANCEROWS2(pPHONE_NUMBER,/*pBALANCE_DATE*/sysdate)) t1) LOOP

      pBALANCE := pBALANCE + x.COST_ROWS;

      IF (TO_CHAR(TRUNC(x.DATE_ROWS),'YYYYMM')=TO_CHAR(pYEAR_MONTH)) AND (x.COST_ROWS < 0) THEN
        pCHARGES := pCHARGES + x.COST_ROWS;
        IF INSTR(x.DESCRIPTION_ROWS, 'Абонплата (') > 0 THEN
          pABON := pABON + x.COST_ROWS;
          if pABON_BE <> -1 then
            vCODE:=SUBSTR(x.DESCRIPTION_ROWS, INSTR(x.DESCRIPTION_ROWS, '(') + 1,  INSTR(x.DESCRIPTION_ROWS, ',') - INSTR(x.DESCRIPTION_ROWS, '(') - 1);
            vSUM:=SUBSTR(x.DESCRIPTION_ROWS, INSTR(x.DESCRIPTION_ROWS, '(', 1, 2) + 1,  INSTR(x.DESCRIPTION_ROWS, ' ', INSTR(x.DESCRIPTION_ROWS, '(', 1, 2)) - INSTR(x.DESCRIPTION_ROWS, '(', 1, 2) - 1);
            IF INSTR(x.DESCRIPTION_ROWS, 'активный') > 0 THEN
              vACT:=1;
            ELSE
              vACT:=0.5;
            END IF;
            vABON:= -1;
            SELECT OPERATOR_MONTHLY_ABON_ACTIV, OPERATOR_MONTHLY_ABON_BLOCK INTO vAB_BE_AC, vAB_BE_BL
              FROM TARIFFS TR
              WHERE TR.TARIFF_CODE = vCODE
                AND TR.OPERATOR_MONTHLY_ABON_ACTIV IS NOT NULL
                AND TR.OPERATOR_MONTHLY_ABON_BLOCK IS NOT NULL
                AND ROWNUM <=1;
            IF (vAB_BE_AC <> -1) AND (vAB_BE_AC IS NOT NULL) THEN
              IF vACT = 1 THEN
                pABON_BE:=pABON_BE + (vAB_BE_AC/vDAYS) * (x.COST_ROWS/TO_NUM(vSUM));
              ELSE
                pABON_BE:=pABON_BE + (vAB_BE_BL/vDAYS) * (x.COST_ROWS/TO_NUM(vSUM));
                pABON_BL_BE:=pABON_BL_BE + (vAB_BE_BL/vDAYS) * (x.COST_ROWS/TO_NUM(vSUM));
              END IF;
            ELSE
              pABON_BE:= -1;
            END IF;
          end if;
        END IF;
        IF INSTR(x.DESCRIPTION_ROWS, 'Абонплата за услугу') > 0 THEN
          pUSL := pUSL + x.COST_ROWS;
        END IF;
      END IF;

    END LOOP;
  SELECT -SUM(V.BILL_SUM_NEW), -SUM(V.ABON_TP_NEW), -SUM(V.ABON_TP_OLD), -SUM(V.ABON_ADD_NEW) INTO pBILLS, pBILL_AB, pBILL_AB_BE, pBILL_USL
    FROM V_BILL_FINANCE_FOR_CLIENTS V
    WHERE V.PHONE_NUMBER = pPHONE_NUMBER
      AND V.YEAR_MONTH = pYEAR_MONTH;

     for q in (select   pPHONE_NUMBER ,  pBALANCE_DATE,  pYEAR_MONTH,  ROUND(pBALANCE, 4) ,  ROUND(pCHARGES, 4),  ROUND(pABON, 4)  ,  ROUND(pABON_BE, 4) ,
  ROUND(pABON_BL_BE, 4) ,   ROUND(pUSL, 4) ,  ROUND(pBILLS, 4) ,  ROUND(pBILL_AB, 4) ,
  ROUND(pBILL_AB_BE, 4) ,  ROUND(pBILL_USL, 4)  from dual) loop
          pipe row (q);
          end loop;


END;

PROCEDURE CALC_VIRT_BALANCE(
  pPHONE_NUMBER IN VARCHAR2,
  pBALANCE_DATE IN DATE DEFAULT NULL,
  pYEAR_MONTH IN INTEGER,
  pBALANCE IN OUT NUMBER,
  pCHARGES IN OUT NUMBER,
  pABON IN OUT NUMBER,
  pABON_BE IN OUT NUMBER,
  pABON_BL_BE IN OUT NUMBER,
  pUSL IN OUT NUMBER,
  pBILLS IN OUT NUMBER,
  pBILL_AB IN OUT NUMBER,
  pBILL_AB_BE IN OUT NUMBER,
  pBILL_USL IN OUT NUMBER
  ) IS
--#Version=1
  DATE_ROWS DBMS_SQL.DATE_TABLE;
  COST_ROWS DBMS_SQL.NUMBER_TABLE;
  DESCRIPTION_ROWS DBMS_SQL.VARCHAR2_TABLE;
  vRESULT NUMBER(15, 2);
  L BINARY_INTEGER;
  vBALANCE_DATE DATE;
  vDAYS integer;
  vCODE VARCHAR2(20 CHAR);
  vSUM VARCHAR2(20 CHAR);
  vACT NUMBER;
  vABON INTEGER;
  vAB_BE_AC NUMBER(13, 4);
  vAB_BE_BL NUMBER(13, 4);

   CURSOR TARIFFS_MONTLY(pCODE in varchar2) IS
        SELECT OPERATOR_MONTHLY_ABON_ACTIV, OPERATOR_MONTHLY_ABON_BLOCK
              FROM TARIFFS TR
              WHERE TR.TARIFF_CODE = pCODE
                AND TR.OPERATOR_MONTHLY_ABON_ACTIV IS NOT NULL
                AND TR.OPERATOR_MONTHLY_ABON_BLOCK IS NOT NULL
                AND ROWNUM <=1;

vTARIFFS_MONTLY TARIFFS_MONTLY%rowtype;


  FUNCTION TO_NUM(RES IN VARCHAR2) RETURN NUMBER IS
    ITOG NUMBER(15,4);
    vRES VARCHAR2(15 CHAR);
    BEGIN
      vRES:=REPLACE(RES, ',', '.');
      BEGIN
        ITOG:=TO_NUMBER(vRES);
      EXCEPTION
        WHEN OTHERS THEN
          ITOG:=TO_NUMBER(REPLACE(vRES, '.', ','));
      END;
      RETURN ITOG;
    END;





BEGIN
  pBALANCE:=0;
  pCHARGES:=0;
  pABON:=0;
  pABON_BE:=0;
  pABON_BL_BE:=0;
  pUSL:=0;
  pBILLS:=0;
  pBILL_AB:=0;
  pBILL_AB_BE:=0;
  pBILL_USL:=0;
  vBALANCE_DATE:=pBALANCE_DATE;
  select last_day(to_date(pYEAR_MONTH, 'yyyymm'))-to_date(pYEAR_MONTH, 'yyyymm')+1 into vDAYS from dual;
  CALC_BALANCE_ROWS2(pPHONE_NUMBER, DATE_ROWS, COST_ROWS, DESCRIPTION_ROWS, TRUE, vBALANCE_DATE);
  L := COST_ROWS.LAST;
  IF L IS NOT NULL THEN
    FOR I IN COST_ROWS.FIRST..L LOOP
      pBALANCE := pBALANCE + COST_ROWS(I);
      IF (TO_CHAR(TRUNC(DATE_ROWS(I)),'YYYYMM')=TO_CHAR(pYEAR_MONTH)) AND (COST_ROWS(I) < 0) THEN
        pCHARGES := pCHARGES + COST_ROWS(I);
        IF INSTR(DESCRIPTION_ROWS(I), 'Абонплата (') > 0 THEN
          pABON := pABON + COST_ROWS(I);
          if pABON_BE <> -1 then
            vCODE:=SUBSTR(DESCRIPTION_ROWS(I), INSTR(DESCRIPTION_ROWS(I), '(') + 1,  INSTR(DESCRIPTION_ROWS(I), ',') - INSTR(DESCRIPTION_ROWS(I), '(') - 1);
            vSUM:=SUBSTR(DESCRIPTION_ROWS(I), INSTR(DESCRIPTION_ROWS(I), '(', 1, 2) + 1,  INSTR(DESCRIPTION_ROWS(I), ' ', INSTR(DESCRIPTION_ROWS(I), '(', 1, 2)) - INSTR(DESCRIPTION_ROWS(I), '(', 1, 2) - 1);
            IF INSTR(DESCRIPTION_ROWS(I), 'активный') > 0 THEN
              vACT:=1;
            ELSE
              vACT:=0.5;
            END IF;
            vABON:= -1;


       /*     SELECT OPERATOR_MONTHLY_ABON_ACTIV, OPERATOR_MONTHLY_ABON_BLOCK INTO vAB_BE_AC, vAB_BE_BL
              FROM TARIFFS TR
              WHERE TR.TARIFF_CODE = vCODE
                AND TR.OPERATOR_MONTHLY_ABON_ACTIV IS NOT NULL
                AND TR.OPERATOR_MONTHLY_ABON_BLOCK IS NOT NULL
                AND ROWNUM <=1;*/

OPEN TARIFFS_MONTLY(vCODE);
FETCH TARIFFS_MONTLY INTO vTARIFFS_MONTLY;

   if TARIFFS_MONTLY%found then
   vAB_BE_AC:=vTARIFFS_MONTLY.Operator_Monthly_Abon_Activ;
   vAB_BE_BL:= vTARIFFS_MONTLY.Operator_Monthly_Abon_Block;
   ELSE
   vAB_BE_AC:=0;
   vAB_BE_BL:= 0;
   END IF;

    close  TARIFFS_MONTLY;

            IF (vAB_BE_AC <> -1) AND (vAB_BE_AC IS NOT NULL) THEN
              IF vACT = 1 THEN
                pABON_BE:=pABON_BE + (vAB_BE_AC/vDAYS) * (COST_ROWS(I)/TO_NUM(vSUM));
              ELSE
                pABON_BE:=pABON_BE + (vAB_BE_BL/vDAYS) * (COST_ROWS(I)/TO_NUM(vSUM));
                pABON_BL_BE:=pABON_BL_BE + (vAB_BE_BL/vDAYS) * (COST_ROWS(I)/TO_NUM(vSUM));
              END IF;
            ELSE
              pABON_BE:= -1;
            END IF;
          end if;
        END IF;
        IF INSTR(DESCRIPTION_ROWS(I), 'Абонплата за услугу') > 0 THEN
          pUSL := pUSL + COST_ROWS(I);
        END IF;
      END IF;
    END LOOP;
  END IF;
  SELECT -SUM(V.BILL_SUM_NEW), -SUM(V.ABON_TP_NEW), -SUM(V.ABON_TP_OLD), -SUM(V.ABON_ADD_NEW) INTO pBILLS, pBILL_AB, pBILL_AB_BE, pBILL_USL
    FROM V_BILL_FINANCE_FOR_CLIENTS V
    WHERE V.PHONE_NUMBER = pPHONE_NUMBER
      AND V.YEAR_MONTH = pYEAR_MONTH;
  pBALANCE:=ROUND(pBALANCE, 4);
  pCHARGES:=ROUND(pCHARGES, 4);
  pABON:=ROUND(pABON, 4);
  pABON_BE:=ROUND(pABON_BE, 4);
  pABON_BL_BE:=ROUND(pABON_BL_BE, 4);
  pUSL:=ROUND(pUSL, 4);
  pBILLS:=ROUND(pBILLS, 4);
  pBILL_AB:=ROUND(pBILL_AB, 4);
  pBILL_AB_BE:=ROUND(pBILL_AB_BE, 4);
  pBILL_USL:=ROUND(pBILL_USL, 4);

END;


procedure virtual_balphone(pyear_month number, sessionid number, pacc_id varchar2, pis_credit number default 0) is
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

delete from virtual_balance_phone where (session_id=sessionid or balance_date<sysdate-1);
commit;

if pIS_CREDIT=1 then vIsCredit:=' and nvl(b.IS_CREDIT_CONTRACT,0)=1 ';end if;
if pIS_CREDIT<>1 then vIsCredit:=' ';end if;

if pacc_id<>'-1' then
vacc_id:=  '  fb.ACCOUNT_ID in ('||pacc_id||') and ';
  end if;

--кол-во джобов из настроек constants
ncount_part:=nvl(ms_constants.GET_CONSTANT_VALUE('TEMP_JOBSBALANCE'),1);

execute immediate
'SELECT count(*)
          FROM db_loader_full_finance_bill fb, v_contracts b
          WHERE '||vacc_id||'
          year_month ='||pyear_month||' and fb.COMPLETE_BILL = 1
          and fb.phone_number=b.phone_number_federal '||vIsCredit||'
           and (b.CONTRACT_CANCEL_DATE is null
 or trunc(b.CONTRACT_CANCEL_DATE)>=(to_date('''||pyear_month||'01'',''yyyymmdd''))) ' into ncount;

if ncount<1000 then cpart:=ncount ; end if;
if ncount>=1000 then cpart:=round(ncount/ncount_part);end if;

execute immediate

'insert into virtual_balance_phone (phone_number,balance_date,num,flag,session_id, comments, year_month )
 select  tt.phone_number,last_day(to_date('||pyear_month||',''YYYYMM'')), ceil(tt.rn / '||cpart||') vnum, 0,
 '||sessionid||','''||pacc_id||''','||pyear_month||'  from (select row_number() over(order by phone_number) rn, t.*
          from (
                  SELECT distinct fb.PHONE_NUMBER
          FROM db_loader_full_finance_bill fb, v_contracts b
          WHERE '||vacc_id||'
             year_month ='||pyear_month||' and fb.COMPLETE_BILL = 1
              and fb.phone_number=b.phone_number_federal  '||vIsCredit||'
               and (b.CONTRACT_CANCEL_DATE is null
 or trunc(b.CONTRACT_CANCEL_DATE)>=(to_date('''||pyear_month||'01'',''yyyymmdd'')))
              ) t) tt ';

 commit;

  end;


 procedure virtual_balance_jobs(sessionid number) is
 vJobn binary_integer;
 vWhat varchar2(32767);
begin
for i in (select distinct num from virtual_balance_phone where session_id=sessionid) loop
vWhat := ' balance.virtual_rep_bal(' || i.num  || ',' ||sessionid || ');';
     dbms_job.submit(vJobn, vWhat, Sysdate, null, false, 0);
     commit;
   end loop;
   end;


 procedure virtual_rep_bal(nnum number, sessionid number)
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

for rec in (select *  from virtual_balance_phone vbp where num=nnum and session_id=sessionid)
  loop
i:=i+1;
 CALC_VIRT_BALANCE(REC.PHONE_NUMBER, SYSDATE, rec.year_month, pBALANCE,
      pCHARGES, pABON, pABON_BE, pABON_BL_BE, pUSL,
      pBILLS, pBILL_AB, pBILL_AB_BE, pBILL_USL);

insert into  virtual_balance
(phone_number,kr_av,pcharges,pabon,pusl,pbills,pbill_ab, pbill_usl,pbalance,
pabon_be, pbill_ab_be,pabon_bl_be, session_id, year_month,balance_date,DATE_REPORT)
values
(rec.phone_number,null,pCHARGES,pABON,pusl,pbills,pBILL_AB,pbill_usl,pbalance,
pabon_be,pbill_ab_be,pabon_bl_be,sessionid,rec.year_month,rec.balance_date, sysdate);

           if mod(i,20)=0 then
           commit;
           end if;

end loop;
  commit;
end;


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
         V_BILL_FINANCE_FOR_CLIENTS v
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
/