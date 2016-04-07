-- Create table
create table IOT_CURRENT_BALANCE(
  phone_number NUMBER not null,
  last_update  DATE not null,
  update_type  NUMBER not null,
  balance NUMBER,
  constraint PK_CURRENT_BALANCE primary key (PHONE_NUMBER)
) organization index;
-- Add comments to the table 
comment on table IOT_CURRENT_BALANCE is 'рейсыхе аюкюмяш днцнбнпмшу мнлепнб';
-- Add comments to the columns 
comment on column IOT_CURRENT_BALANCE.phone_number is 'мнлеп ';
comment on column IOT_CURRENT_BALANCE.last_update is 'дюрю ябефеярх';
comment on column IOT_CURRENT_BALANCE.update_type is 'нрйсдю опхькн намнбкемхе';
comment on column IOT_CURRENT_BALANCE.balance is 'аюкюмя';
-- Create/Recreate primary, unique and foreign key constraints 
alter table IOT_CURRENT_BALANCE
  add constraint PK_UPD_TYPE foreign key(UPDATE_TYPE)
  references BALANCE_UPD_TYPES(UPD_ID);
-- Grant/Revoke object privileges 
--grant select, insert, update, delete, alter on IOT_CURRENT_BALANCE to CORP_MOBILE_ROLE;
--grant select on IOT_CURRENT_BALANCE to CORP_MOBILE_ROLE_RO;
grant select, insert, update, delete, alter on IOT_CURRENT_BALANCE to SIM_TRADE_ROLE;
--grant select, insert, update, delete, alter on IOT_CURRENT_BALANCE to LONTANA_ROLE;
CREATE UNIQUE INDEX U_IOT_CB_PHONE_NUMBER ON IOT_CURRENT_BALANCE(PHONE_NUMBER);