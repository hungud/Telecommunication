
  CREATE OR REPLACE TRIGGER "SIM_TRADE"."TIBR_SIM" 
  before insert ON SIM   for each row
declare
begin
  select s_sim_id.nextval into :new.sim_id from dual;
end tibr_sim;


ALTER TRIGGER "SIM_TRADE"."TIBR_SIM" ENABLE