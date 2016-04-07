--#if isclient("GSM_CORP") then
--#if not TableExists("BALANCEENDM_BALANCE_PHONE") then
create table BalanceEndM_balance_phone
(
  phone_number VARCHAR2(11),
  balance_date DATE,
  num          INTEGER,
  session_id   INTEGER,
  accounts     VARCHAR2(512),
  year_month   NUMBER
);

grant select, insert, update, delete on BalanceEndM_balance_phone to LONTANA_COPY_AN;
grant select, insert, update, delete on BalanceEndM_balance_phone to LONTANA_COPY_LEV;
grant select, insert, update, delete on BalanceEndM_balance_phone to LONTANA_ROLE;
grant select on BalanceEndM_balance_phone to LONTANA_ROLE_RO;

--#end if
--#end if

