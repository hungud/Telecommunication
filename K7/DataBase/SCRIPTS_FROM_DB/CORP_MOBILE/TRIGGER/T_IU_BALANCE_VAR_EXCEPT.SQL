
  CREATE OR REPLACE TRIGGER "CORP_MOBILE"."T_IU_BALANCE_VAR_EXCEPT" 
  before insert or update on balance_var_except  
  for each row
declare
  -- local variables here
begin
  IF INSERTING then 
    :new.var_except_id:=s_balance_var_except.nextval;
    :new.date_create:=sysdate;
    :new.user_create:=user;
  elsIF UPDATING then 
    :new.date_close:=sysdate;
    :new.user_create:=:old.user_create||';'||user;
  end if;
  
end T_IU_BALANCE_VAR_EXCEPT;

ALTER TRIGGER "CORP_MOBILE"."T_IU_BALANCE_VAR_EXCEPT" ENABLE