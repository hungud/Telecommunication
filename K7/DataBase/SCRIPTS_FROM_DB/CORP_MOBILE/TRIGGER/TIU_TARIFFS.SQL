
  CREATE OR REPLACE TRIGGER "CORP_MOBILE"."TIU_TARIFFS" 
BEFORE INSERT OR UPDATE
ON TARIFFS
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
BEGIN
  IF INSERTING THEN
    IF NVL(:NEW.TARIFF_ID, 0) = 0 then
      :NEW.TARIFF_ID := NEW_TARIFF_ID;
    END IF;
    :NEW.USER_CREATED := USER;
    :NEW.DATE_CREATED := SYSDATE;
  END IF;
  :NEW.USER_LAST_UPDATED := USER;
  :NEW.DATE_LAST_UPDATED := SYSDATE;
  
  IF NVL(:NEW.PHONE_NUMBER_TYPE, 0) = 0 THEN
    :NEW.PHONE_NUMBER_TYPE := 0;  
  END IF;
  
  if  UPDATING then    
    IF      nvl( :OLD.TARIFF_ID , -1)                                         <> nvl( :NEW.TARIFF_ID , -1)
        OR  nvl( :OLD.TARIFF_CODE , '-1')                                     <> nvl( :NEW.TARIFF_CODE , '-1')
        OR  nvl( :OLD.OPERATOR_ID , -1 )                                      <> nvl( :NEW.OPERATOR_ID , -1 )
        OR  nvl( :OLD.TARIFF_NAME , '-1')                                     <> nvl( :NEW.TARIFF_NAME , '-1')
        OR  nvl( :OLD.IS_ACTIVE , -1)                                         <> nvl( :NEW.IS_ACTIVE , -1)    
        OR  nvl( :OLD.START_BALANCE , -1 )                                    <> nvl( :NEW.START_BALANCE , -1 )      
        OR  nvl( :OLD.CONNECT_PRICE , -1)                                     <> nvl( :NEW.CONNECT_PRICE , -1)       
        OR  nvl( :OLD.ADVANCE_PAYMENT , -1 )                                  <> nvl( :NEW.ADVANCE_PAYMENT , -1 ) 
        OR  nvl( :OLD.USER_CREATED , '-1' )                                   <> nvl( :NEW.USER_CREATED , '-1' )
        OR  nvl( :OLD.DATE_CREATED , to_date('01.01.1900','dd.mm.yyyy') )     <> nvl( :NEW.DATE_CREATED , to_date('01.01.1900','dd.mm.yyyy') )
        OR  nvl( :OLD.PHONE_NUMBER_TYPE , -1 )                                <> nvl( :NEW.PHONE_NUMBER_TYPE , -1 )        
        OR  nvl( :OLD.DAYLY_PAYMENT , -1 )                                    <> nvl( :NEW.DAYLY_PAYMENT , -1 )        
        OR  nvl( :OLD.DAYLY_PAYMENT_LOCKED , -1 )                             <> nvl( :NEW.DAYLY_PAYMENT_LOCKED , -1 )            
        OR  nvl( :OLD.MONTHLY_PAYMENT , -1 )                                  <> nvl( :NEW.MONTHLY_PAYMENT , -1 )          
        OR  nvl( :OLD.MONTHLY_PAYMENT_LOCKED , -1 )                           <> nvl( :NEW.MONTHLY_PAYMENT_LOCKED , -1 )                
        OR  nvl( :OLD.CALC_KOEFF , -1 )                                       <> nvl( :NEW.CALC_KOEFF , -1 )           
        OR  nvl( :OLD.FREE_MONTH_MINUTES_CNT_FOR_RPT , -1 )                   <> nvl( :NEW.FREE_MONTH_MINUTES_CNT_FOR_RPT , -1 )            
        OR  nvl( :OLD.BALANCE_BLOCK , -1  )                                   <> nvl( :NEW.BALANCE_BLOCK , -1  )                                              
        OR  nvl( :OLD.BALANCE_UNBLOCK , -1 )                                  <> nvl( :NEW.BALANCE_UNBLOCK , -1 )       
        OR  nvl( :OLD.BALANCE_NOTICE , -1 )                                   <> nvl( :NEW.BALANCE_NOTICE , -1 ) 
        OR  nvl( :OLD.TARIFF_ADD_COST , -1 )                                  <> nvl( :NEW.TARIFF_ADD_COST , -1 )
        OR  nvl( :OLD.BALANCE_BLOCK_CREDIT , -1 )                             <> nvl( :NEW.BALANCE_BLOCK_CREDIT , -1 )                                                 
        OR  nvl( :OLD.BALANCE_UNBLOCK_CREDIT  , -1 )                          <> nvl( :NEW.BALANCE_UNBLOCK_CREDIT , -1 )                                                     
        OR  nvl( :OLD.BALANCE_NOTICE_CREDIT , -1 )                            <> nvl( :NEW.BALANCE_NOTICE_CREDIT , -1 )                                     
        OR  nvl( :OLD.TARIFF_CODE_CRM , '-1' )                                <> nvl( :NEW.TARIFF_CODE_CRM , '-1' )                                      
        OR  nvl( :OLD.TARIFF_PRIORITY , -1 )                                  <> nvl( :NEW.TARIFF_PRIORITY , -1 )                                         
        OR  nvl( :OLD.TARIFF_ABON_DAILY_PAY , -1 )                            <> nvl( :NEW.TARIFF_ABON_DAILY_PAY , -1 )
        OR  nvl( :OLD.TARIFF_ACTION_PLUS_SMS , -1 )                           <> nvl( :NEW.TARIFF_ACTION_PLUS_SMS , -1 )
        OR  nvl( :OLD.FILIAL_ID    , -1 )                                     <> nvl( :NEW.FILIAL_ID , -1 )                         
        OR  nvl( :OLD.OPERATOR_MONTHLY_ABON_ACTIV  , -1 )                     <> nvl( :NEW.OPERATOR_MONTHLY_ABON_ACTIV , -1 )                                                          
        OR  nvl( :OLD.OPERATOR_MONTHLY_ABON_BLOCK , -1 )                      <> nvl( :NEW.OPERATOR_MONTHLY_ABON_BLOCK , -1 )                                                   
        OR  nvl( :OLD.CALC_KOEFF_DETAL , -1 )                                 <> nvl( :NEW.CALC_KOEFF_DETAL , -1 )                                                      
     THEN       
     INSERT INTO SH_TARIFFS
       ( TARIFF_ID, TARIFF_CODE, OPERATOR_ID, TARIFF_NAME, IS_ACTIVE,  START_BALANCE, CONNECT_PRICE, ADVANCE_PAYMENT, USER_CREATED, DATE_CREATED, USER_LAST_UPDATED, DATE_LAST_UPDATED, PHONE_NUMBER_TYPE, DAYLY_PAYMENT, DAYLY_PAYMENT_LOCKED, MONTHLY_PAYMENT, MONTHLY_PAYMENT_LOCKED, CALC_KOEFF, FREE_MONTH_MINUTES_CNT_FOR_RPT, BALANCE_BLOCK, BALANCE_UNBLOCK, BALANCE_NOTICE, TARIFF_ADD_COST, BALANCE_BLOCK_CREDIT, BALANCE_UNBLOCK_CREDIT, BALANCE_NOTICE_CREDIT, TARIFF_CODE_CRM, TARIFF_PRIORITY, TARIFF_ABON_DAILY_PAY, TARIFF_ACTION_PLUS_SMS, FILIAL_ID, OPERATOR_MONTHLY_ABON_ACTIV, OPERATOR_MONTHLY_ABON_BLOCK, CALC_KOEFF_DETAL, UPDATE_USER, UPDATE_TIME )
     VALUES
       ( :old.TARIFF_ID, :old.TARIFF_CODE, :old.OPERATOR_ID, :old.TARIFF_NAME, :old.IS_ACTIVE, :old.START_BALANCE, :old.CONNECT_PRICE, :old.ADVANCE_PAYMENT, :old.USER_CREATED, :old.DATE_CREATED, :old.USER_LAST_UPDATED, :old.DATE_LAST_UPDATED, :old.PHONE_NUMBER_TYPE, :old.DAYLY_PAYMENT, :old.DAYLY_PAYMENT_LOCKED, :old.MONTHLY_PAYMENT, :old.MONTHLY_PAYMENT_LOCKED, :old.CALC_KOEFF, :old.FREE_MONTH_MINUTES_CNT_FOR_RPT, :old.BALANCE_BLOCK, :old.BALANCE_UNBLOCK, :old.BALANCE_NOTICE, :old.TARIFF_ADD_COST, :old.BALANCE_BLOCK_CREDIT, :old.BALANCE_UNBLOCK_CREDIT, :old.BALANCE_NOTICE_CREDIT, :old.TARIFF_CODE_CRM, :old.TARIFF_PRIORITY, :old.TARIFF_ABON_DAILY_PAY, :old.TARIFF_ACTION_PLUS_SMS, :old.FILIAL_ID, :old.OPERATOR_MONTHLY_ABON_ACTIV, :old.OPERATOR_MONTHLY_ABON_BLOCK, :old.CALC_KOEFF_DETAL, USER, SYSDATE );
    END IF;   
  end if; 
END;
ALTER TRIGGER "CORP_MOBILE"."TIU_TARIFFS" ENABLE