
  CREATE OR REPLACE TRIGGER "SIM_TRADE"."TIU_TARIFF_OPTIONS" 
BEFORE INSERT OR UPDATE
ON TARIFF_OPTIONS
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
BEGIN
  IF INSERTING THEN
    IF NVL(:NEW.TARIFF_OPTION_ID, 0) = 0 then
      :NEW.TARIFF_OPTION_ID := NEW_TARIFF_OPTION_ID;
    END IF;
    :NEW.USER_CREATED := USER;
    :NEW.DATE_CREATED := SYSDATE;
  END IF;
  :NEW.USER_LAST_UPDATED := USER;
  :NEW.DATE_LAST_UPDATED := SYSDATE;
  
  if UPDATING then
    IF    nvl( :OLD.TARIFF_OPTION_ID , -1 )                                 <> nvl( :NEW.TARIFF_OPTION_ID , -1 )
      OR  nvl( :OLD.OPERATOR_ID , -1 )                                      <> nvl( :NEW.OPERATOR_ID , -1 )
      OR  nvl( :OLD.OPTION_CODE , '-1' )                                    <> nvl( :NEW.OPTION_CODE , '-1' )
      OR  nvl( :OLD.OPTION_NAME , '-1' )                                    <> nvl( :NEW.OPTION_NAME , '-1' )
      OR  nvl( :OLD.USER_CREATED , '-1' )                                   <> nvl( :NEW.USER_CREATED , '-1' )      
      OR  nvl( :OLD.DATE_CREATED , to_date('01.01.1900','dd.mm.yyyy') )     <> nvl( :NEW.DATE_CREATED , to_date('01.01.1900','dd.mm.yyyy') )
      OR  nvl( :OLD.KOEF_KOMISS , -1 )                                      <> nvl( :NEW.KOEF_KOMISS , -1 ) 
      OR  nvl( :OLD.CALC_UNBLOCK , -1 )                                     <> nvl( :NEW.CALC_UNBLOCK , -1 ) 
      OR  nvl( :OLD.DISCR_SPISANIE , -1 )                                   <> nvl( :NEW.DISCR_SPISANIE , -1 ) 
      OR  nvl( :OLD.OPTION_NAME_FOR_AB , '-1' )                             <> nvl( :NEW.OPTION_NAME_FOR_AB , '-1' )
    THEN       
    INSERT INTO SH_TARIFF_OPTIONS
       ( TARIFF_OPTION_ID, OPERATOR_ID, OPTION_CODE, OPTION_NAME, USER_CREATED, DATE_CREATED, USER_LAST_UPDATED, DATE_LAST_UPDATED, KOEF_KOMISS, CALC_UNBLOCK, DISCR_SPISANIE, OPTION_NAME_FOR_AB, UPDATE_USER, UPDATE_TIME )
    VALUES
       ( :old.TARIFF_OPTION_ID, :old.OPERATOR_ID, :old.OPTION_CODE, :old.OPTION_NAME, :old.USER_CREATED, :old.DATE_CREATED, :old.USER_LAST_UPDATED, :old.DATE_LAST_UPDATED, :old.KOEF_KOMISS, :old.CALC_UNBLOCK, :old.DISCR_SPISANIE, :old.OPTION_NAME_FOR_AB, USER, SYSDATE );
    END IF;   
  end if;  
END;

ALTER TRIGGER "SIM_TRADE"."TIU_TARIFF_OPTIONS" ENABLE