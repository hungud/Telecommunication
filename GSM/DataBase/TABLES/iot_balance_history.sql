-- Create table
create table IOT_BALANCE_HISTORY
(
  phone_number NUMBER not null,
  start_time   DATE not null,
  end_time     DATE,
  last_update  DATE,
  balance      NUMBER not null,
  constraint PK_BALANCE_HISTORY_PHONE_NUMB primary key (PHONE_NUMBER, START_TIME)
)
organization index;
-- Add comments to the columns 
comment on column IOT_BALANCE_HISTORY.last_update
  is 'Дата обновления для поля баланс ';

grant select on  iot_balance_history to corp_mobile_role_ro;

grant all on  iot_balance_history to corp_mobile_role;
