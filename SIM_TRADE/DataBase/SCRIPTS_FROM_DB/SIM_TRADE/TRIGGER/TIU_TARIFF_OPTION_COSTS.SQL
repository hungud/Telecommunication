
  CREATE OR REPLACE TRIGGER "SIM_TRADE"."TIU_TARIFF_OPTION_COSTS" 
BEFORE INSERT OR UPDATE
ON TARIFF_OPTION_COSTS
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
BEGIN
  IF INSERTING THEN
    IF NVL(:NEW.TARIFF_OPTION_COST_ID, 0) = 0 then
      :NEW.TARIFF_OPTION_COST_ID := NEW_TARIFF_OPTION_COST_ID;
    END IF;
    :NEW.USER_CREATED := USER;
    :NEW.DATE_CREATED := SYSDATE;
  END IF;
  :NEW.USER_LAST_UPDATED := USER;
  :NEW.DATE_LAST_UPDATED := SYSDATE;
  
  if UPDATING then
    IF    nvl( :OLD.TARIFF_OPTION_COST_ID , -1 )                          <> nvl( :NEW.TARIFF_OPTION_COST_ID , -1 )
      OR  nvl( :OLD.TARIFF_OPTION_ID , -1 )                               <> nvl( :NEW.TARIFF_OPTION_ID , -1 )
      OR  nvl( :OLD.BEGIN_DATE , to_date('01.01.1900','dd.mm.yyyy') )     <> nvl( :NEW.BEGIN_DATE , to_date('01.01.1900','dd.mm.yyyy') )
      OR  nvl( :OLD.END_DATE , to_date('01.01.1900','dd.mm.yyyy') )       <> nvl( :NEW.END_DATE , to_date('01.01.1900','dd.mm.yyyy') )
      OR  nvl( :OLD.TARIFF_ID , -1 )                                      <> nvl( :NEW.TARIFF_ID , -1 ) 
      OR  nvl( :OLD.TURN_ON_COST , -1 )                                   <> nvl( :NEW.TURN_ON_COST , -1 ) 
      OR  nvl( :OLD.MONTHLY_COST , -1 )                                   <> nvl( :NEW.MONTHLY_COST , -1 )
      OR  nvl( :OLD.USER_CREATED , '-1' )                                 <> nvl( :NEW.USER_CREATED , '-1' )      
      OR  nvl( :OLD.DATE_CREATED , to_date('01.01.1900','dd.mm.yyyy') )   <> nvl( :NEW.DATE_CREATED , to_date('01.01.1900','dd.mm.yyyy') )
      OR  nvl( :OLD.OPERATOR_TURN_ON_COST , -1 )                          <> nvl( :NEW.OPERATOR_TURN_ON_COST , -1 ) 
      OR  nvl( :OLD.OPERATOR_MONTHLY_COST , -1 )                          <> nvl( :NEW.OPERATOR_MONTHLY_COST , -1 ) 
     THEN       
     INSERT INTO SH_TARIFF_OPTION_COSTS
       ( TARIFF_OPTION_COST_ID, TARIFF_OPTION_ID, BEGIN_DATE, END_DATE, TARIFF_ID, TURN_ON_COST, MONTHLY_COST, USER_CREATED, DATE_CREATED, USER_LAST_UPDATED, DATE_LAST_UPDATED, OPERATOR_TURN_ON_COST, OPERATOR_MONTHLY_COST, UPDATE_USER, UPDATE_TIME )
     VALUES
       ( :old.TARIFF_OPTION_COST_ID, :old.TARIFF_OPTION_ID, :old.BEGIN_DATE, :old.END_DATE, :old.TARIFF_ID, :old.TURN_ON_COST, :old.MONTHLY_COST, :old.USER_CREATED, :old.DATE_CREATED, :old.USER_LAST_UPDATED, :old.DATE_LAST_UPDATED, :old.OPERATOR_TURN_ON_COST, :old.OPERATOR_MONTHLY_COST, USER, SYSDATE );
    END IF;   
  end if;
END;

ALTER TRIGGER "SIM_TRADE"."TIU_TARIFF_OPTION_COSTS" ENABLE