
insert into tariffs (TARIFF_CODE, OPERATOR_ID, TARIFF_NAME, IS_ACTIVE, PHONE_NUMBER_TYPE)
select distinct cell_plan_code, 3, cell_plan_code, 1, 0 from db_loader_account_phones
minus
select tariff_code, 3, tariff_code, 1, 0 from tariffs

delete from received_payments

delete from contract_changes

delete from contract_cancels

delete from contracts

delete from abonents

insert into abonents (SURNAME, NAME, PATRONYMIC)
select phone_number, phone_number, phone_number from db_loader_account_phones

filials



insert into contracts (CONTRACT_NUM, CONTRACT_DATE, FILIAL_ID, OPERATOR_ID, PHONE_NUMBER_FEDERAL, PHONE_NUMBER_CITY, 
  PHONE_NUMBER_TYPE, TARIFF_ID, SIM_NUMBER, SERVICE_ID, DISCONNECT_LIMIT, CONFIRMED, ABONENT_ID
  )
select rownum, --null, GET_NEXT_CONTRACT_NUMBER,
  to_date('01.12.2010', 'dd.mm.yyyy'),
  16,
  3, -- Билайн
  phone_number,
  null, -- Неизвестно
  (select phone_number_type from tariffs where tariffs.TARIFF_CODE = CELL_PLAN_CODE),
  (select tariff_id from tariffs where tariffs.TARIFF_CODE = CELL_PLAN_CODE),
  null,
  0,
  0,
  1,
  (select abonent_id from abonents where surname = phone_number)
  from db_loader_account_phones
  where year_month=201012
  and phone_number <> '00000000000'
  

select phone_number from db_loader_account_phones
where year_month=201012
group by phone_number
having count(phone_number) > 1

and phone_number is

-- Приблизительная дата договора (по счетам)
update contracts
set contract_date = (
SELECT MIN(DATE_BEGIN) FROM DB_LOADER_BILLS
where DB_LOADER_BILLS.phone_number= contracts.phone_number_federal
)

create table temp_balances (
  phone_number varchar2(10),
  balance_value number(15, 2)
)

-- Загрузка из Excel
Мастером загрузки

-- все ли балансы есть в договорах?
SELECT *
FROM temp_balances
WHERE PHONE_NUMBER NOT IN (
SELECT PHONE_NUMBER_FEDERAL
FROM CONTRACTS
)
 
-- Переносим балансы
INSERT INTO CONTRACT_BALANCES (CONTRACT_ID, BALANCE_DATE, BALANCE_VALUE)
SELECT 
  (SELECT CONTRACT_ID 
  FROM CONTRACTS
  WHERE CONTRACTS.PHONE_NUMBER_FEDERAL=TEMP_BALANCES.PHONE_NUMBER
  ),
  TO_DATE('20.12.2010', 'DD.MM.YYYY'),
  BALANCE_VALUE
  FROM TEMP_BALANCES;
