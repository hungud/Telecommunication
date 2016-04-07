
  CREATE OR REPLACE TRIGGER "CORP_MOBILE"."TBUI_ABONENTS_VIP" 
  before insert or update on abonents_vip  
  for each row
declare
  -- local variables here
begin
  if inserting then :new.user_created:=user; end if;
  :new.date_last_update:=sysdate;
end TBUI_ABONENTS_VIP;

ALTER TRIGGER "CORP_MOBILE"."TBUI_ABONENTS_VIP" ENABLE