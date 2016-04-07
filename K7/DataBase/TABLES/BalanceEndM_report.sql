--#if isclient("GSM_CORP") then
--#if not TableExists("BALANCEENDM_REPORT") then
create table BalanceEndM_Report
(
  login VARCHAR2(30),
  year_month INTEGER,
  phone_number VARCHAR2(11),
  date_balance date,
  balance NUMBER,
  phone_is_active NUMBER(1),
  begin_date DATE,
  SUBSCRIBER_PAYMENT_NEW NUMBER,
  activ INTEGER,
  all_calls NUMBER,
  diler_calls NUMBER,
  bill_sum_new NUMBER,
  diler_sum NUMBER,
  tariff_name VARCHAR2(100),
  SESSION_ID INTEGER,
  DATE_REPORT DATE,
  type_abon VARCHAR2(30)
 
);

grant select, insert, update, delete on BalanceEndM_report to LONTANA_COPY_AN;
grant select, insert, update, delete on BalanceEndM_report to LONTANA_COPY_LEV;
grant select, insert, update, delete on BalanceEndM_report to LONTANA_ROLE;
grant select on BalanceEndM_report to LONTANA_ROLE_RO;

alter table BalanceEndM_Report add (EXIT_PLUS varchar2(30));
COMMENT ON COLUMN BalanceEndM_Report.EXIT_PLUS IS 'Счет погашен';

--#end if
--#end if
