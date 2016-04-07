
  CREATE OR REPLACE TRIGGER "SIM_TRADE"."TBIU_MNP_REMOVE" 
  before insert or update ON MNP_REMOVE for each row
begin
  if INSERTING then 
    :new.is_active:=0;
    :new.user_created:=user;
    :new.date_created:=sysdate;
    :new.date_activate:=null;   
  end if;
 if nvl(:old.is_active,0)>0 and UPDATING then 
   :new.phone_number:=:old.phone_number;
   :new.temp_phone_number:=:old.temp_phone_number;
 end if;
end TBIU_MNP_REMOVE; 

ALTER TRIGGER "SIM_TRADE"."TBIU_MNP_REMOVE" ENABLE