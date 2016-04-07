
  CREATE OR REPLACE TRIGGER "SIM_TRADE"."TIU_CONTRACTS" 
  BEFORE INSERT OR UPDATE ON CONTRACTS
  REFERENCING NEW AS NEW OLD AS OLD FOR EACH ROW
declare
  vSTART integer;
  vEND integer;
BEGIN
  IF INSERTING THEN
    IF NVL(:NEW.CONTRACT_ID, 0) = 0 then
      :NEW.CONTRACT_ID := NEW_CONTRACT_ID;
    END IF;
    :NEW.USER_CREATED := USER;
    :NEW.DATE_CREATED := SYSDATE;
  END IF;
  :NEW.USER_LAST_UPDATED := USER;
  :NEW.DATE_LAST_UPDATED := SYSDATE;
  
  if  Updating then
    IF      nvl( :OLD.CONTRACT_ID , -1)                                       <> nvl( :NEW.CONTRACT_ID , -1)
        OR  nvl( :OLD.CONTRACT_NUM , -1)                                      <> nvl( :NEW.CONTRACT_NUM , -1)
        OR  nvl( :OLD.CONTRACT_DATE , to_date('01.01.1900','dd.mm.yyyy') )    <> nvl( :NEW.CONTRACT_DATE , to_date('01.01.1900','dd.mm.yyyy') )
        OR  nvl( :OLD.FILIAL_ID , -1)                                         <> nvl( :NEW.FILIAL_ID , -1)
        OR  nvl( :OLD.OPERATOR_ID, -1)                                        <> nvl( :NEW.OPERATOR_ID, -1)             
        OR  nvl( :OLD.PHONE_NUMBER_FEDERAL , '-1')                            <> nvl( :NEW.PHONE_NUMBER_FEDERAL , '-1')    
        OR  nvl( :OLD.PHONE_NUMBER_CITY , '-1')                               <> nvl( :NEW.PHONE_NUMBER_CITY , '-1')      
        OR  nvl( :OLD.PHONE_NUMBER_TYPE , -1)                                 <> nvl( :NEW.PHONE_NUMBER_TYPE , -1)       
        OR  nvl( :OLD.TARIFF_ID , -1 )                                        <> nvl( :NEW.TARIFF_ID , -1 ) 
        OR  nvl( :OLD.SIM_NUMBER ,  '-1' )                                    <> nvl( :NEW.SIM_NUMBER ,  '-1' )
        OR  nvl( :OLD.SERVICE_ID , -1 )                                       <> nvl( :NEW.SERVICE_ID , -1 )
        OR  nvl( :OLD.DISCONNECT_LIMIT , -1 )                                 <> nvl( :NEW.DISCONNECT_LIMIT , -1 )
        OR  nvl( :OLD.CONFIRMED , -1 )                                        <> nvl( :NEW.CONFIRMED , -1 )             
        OR  nvl( :OLD.USER_CREATED , '-1' )                                   <> nvl( :NEW.USER_CREATED , '-1' )
        OR  nvl( :OLD.DATE_CREATED , to_date('01.01.1900','dd.mm.yyyy') )     <> nvl( :NEW.DATE_CREATED , to_date('01.01.1900','dd.mm.yyyy') )
        OR  nvl( :OLD.ABONENT_ID , -1 )                                       <> nvl( :NEW.ABONENT_ID , -1 )        
        OR  nvl( :OLD.RECEIVED_SUM , -1 )                                     <> nvl( :NEW.RECEIVED_SUM , -1 )       
        OR  nvl( :OLD.START_BALANCE , -1 )                                    <> nvl( :NEW.START_BALANCE , -1 )            
        OR  nvl( :OLD.GOLD_NUMBER_SUM , -1 )                                  <> nvl( :NEW.GOLD_NUMBER_SUM , -1 )          
        OR  nvl( :OLD.HAND_BLOCK , -1 )                                       <> nvl( :NEW.HAND_BLOCK , -1 ) 
        OR  nvl( :OLD.CONNECT_LIMIT , -1 )                                    <> nvl( :NEW.CONNECT_LIMIT , -1 )            
        OR  nvl( :OLD.IS_CREDIT_CONTRACT , -1 )                               <> nvl( :NEW.IS_CREDIT_CONTRACT , -1 )       
        OR  nvl( :OLD.COMMENTS , '-1' )                                       <> nvl( :NEW.COMMENTS , '-1' )
        OR  nvl( :OLD.SEND_ACTIV , -1 )                                       <> nvl( :NEW.SEND_ACTIV , -1 )
        OR  nvl( :OLD.HAND_BLOCK_DATE_END , to_date('01.01.1900','dd.mm.yyyy')  ) <> nvl( :NEW.HAND_BLOCK_DATE_END , to_date('01.01.1900','dd.mm.yyyy')  )       
        OR  nvl( :OLD.DOP_STATUS  , -1 )                                      <> nvl( :NEW.DOP_STATUS , -1 )                                                    
        OR  nvl( :OLD.DEALER_KOD    , -1 )                                    <> nvl( :NEW.DEALER_KOD , -1 )                                                  
        OR  nvl( :OLD.ABON_TP_DISCOUNT , -1 )                                 <> nvl( :NEW.ABON_TP_DISCOUNT , -1 )                                               
        OR  nvl( :OLD.INSTALLMENT_PAYMENT_DATE , to_date('01.01.1900','dd.mm.yyyy')  ) <> nvl( :NEW.INSTALLMENT_PAYMENT_DATE , to_date('01.01.1900','dd.mm.yyyy')  )                                       
        OR  nvl( :OLD.INSTALLMENT_PAYMENT_SUM , -1 )                          <> nvl( :NEW.INSTALLMENT_PAYMENT_SUM , -1 )
        OR  nvl( :OLD.INSTALLMENT_PAYMENT_MONTHS , -1 )                       <> nvl( :NEW.INSTALLMENT_PAYMENT_MONTHS , -1 )
        OR  nvl( :OLD.INSTALLMENT_ADVANCED_REPAYMENT , to_date('01.01.1900','dd.mm.yyyy')  ) <> nvl( :NEW.INSTALLMENT_ADVANCED_REPAYMENT , to_date('01.01.1900','dd.mm.yyyy')  )                                  
        OR  nvl( :OLD.GROUP_ID  , -1 )                                        <> nvl( :NEW.GROUP_ID , -1 )                                                       
        OR  nvl( :OLD.BALANCE_BLOCK_HAND_BLOCK , -1 )                         <> nvl( :NEW.BALANCE_BLOCK_HAND_BLOCK , -1 )                                       
        OR  nvl( :OLD.BALANCE_NOTICE_HAND_BLOCK , -1 )                        <> nvl( :NEW.BALANCE_NOTICE_HAND_BLOCK , -1 )                                      
        OR  nvl( :OLD.MN_ROAMING , -1 )                                       <> nvl( :NEW.MN_ROAMING , -1 )                                                        
        OR  nvl( :OLD.CURR_TARIFF_ID , -1 )                                   <> nvl( :NEW.CURR_TARIFF_ID , -1 )                                                 
        OR  nvl( :OLD.USER_PASSWORD , '-1' )                                  <> nvl( :NEW.USER_PASSWORD , '-1' )            
        OR  nvl( :OLD.OPTION_GROUP_ID , -1 )                                  <> nvl( :NEW.OPTION_GROUP_ID , -1 )                                                   
        OR  nvl( :OLD.PARAMDISABLE_SMS , '-1' )                               <> nvl( :NEW.PARAMDISABLE_SMS , '-1' )                                            
    THEN
      INSERT INTO SH_CONTRACTS
        ( CONTRACT_ID, CONTRACT_NUM, CONTRACT_DATE, FILIAL_ID, OPERATOR_ID, PHONE_NUMBER_FEDERAL, PHONE_NUMBER_CITY, PHONE_NUMBER_TYPE, TARIFF_ID, SIM_NUMBER, SERVICE_ID, DISCONNECT_LIMIT, CONFIRMED, USER_CREATED, DATE_CREATED, USER_LAST_UPDATED, DATE_LAST_UPDATED, ABONENT_ID, RECEIVED_SUM, START_BALANCE, GOLD_NUMBER_SUM, HAND_BLOCK, CONNECT_LIMIT, IS_CREDIT_CONTRACT, COMMENTS, SEND_ACTIV, HAND_BLOCK_DATE_END, DOP_STATUS, DEALER_KOD, ABON_TP_DISCOUNT, INSTALLMENT_PAYMENT_DATE, INSTALLMENT_PAYMENT_SUM, INSTALLMENT_PAYMENT_MONTHS, INSTALLMENT_ADVANCED_REPAYMENT, GROUP_ID, BALANCE_BLOCK_HAND_BLOCK, BALANCE_NOTICE_HAND_BLOCK, MN_ROAMING, CURR_TARIFF_ID, USER_PASSWORD, OPTION_GROUP_ID, PARAMDISABLE_SMS, update_user, update_time)
      VALUES
        ( :OLD.CONTRACT_ID, :OLD.CONTRACT_NUM, :OLD.CONTRACT_DATE, :OLD.FILIAL_ID, :OLD.OPERATOR_ID, :OLD.PHONE_NUMBER_FEDERAL, :OLD.PHONE_NUMBER_CITY, :OLD.PHONE_NUMBER_TYPE, :OLD.TARIFF_ID, :OLD.SIM_NUMBER, :OLD.SERVICE_ID, :OLD.DISCONNECT_LIMIT, :OLD.CONFIRMED, :OLD.USER_CREATED, :OLD.DATE_CREATED, :OLD.USER_LAST_UPDATED, :OLD.DATE_LAST_UPDATED, :OLD.ABONENT_ID, :OLD.RECEIVED_SUM, :OLD.START_BALANCE, :OLD.GOLD_NUMBER_SUM, :OLD.HAND_BLOCK, :OLD.CONNECT_LIMIT, :OLD.IS_CREDIT_CONTRACT, :OLD.COMMENTS, :OLD.SEND_ACTIV, :OLD.HAND_BLOCK_DATE_END, :OLD.DOP_STATUS, :OLD.DEALER_KOD, :OLD.ABON_TP_DISCOUNT, :OLD.INSTALLMENT_PAYMENT_DATE, :OLD.INSTALLMENT_PAYMENT_SUM, :OLD.INSTALLMENT_PAYMENT_MONTHS, :OLD.INSTALLMENT_ADVANCED_REPAYMENT, :OLD.GROUP_ID, :OLD.BALANCE_BLOCK_HAND_BLOCK, :OLD.BALANCE_NOTICE_HAND_BLOCK, :OLD.MN_ROAMING, :OLD.CURR_TARIFF_ID, :OLD.USER_PASSWORD, :OLD.OPTION_GROUP_ID, :OLD.PARAMDISABLE_SMS, user, sysdate );
    END IF;   
  end if;  
  IF INSERTING THEN
    vSTART:=TO_NUMBER(TO_CHAR(:NEW.contract_date, 'YYYYMM'));
    vEND:=TO_NUMBER(TO_CHAR(SYSDATE, 'YYYYMM'));
    FOR I IN TRUNC(vSTART/100)..TRUNC(vEND/100) 
    LOOP
      FOR J IN 1..12 
      LOOP
        IF (I*100 + J >= vSTART) AND (I*100 + J <= vEND) THEN
          INSERT INTO QUEUE_ABONENT_PER_REBILD(YEAR_MONTH, PHONE_NUMBER)
            VALUES(I*100 + J, :NEW.phone_number_federal);
        END IF;
      END LOOP;
    END LOOP;  
  END IF; 
END; 
ALTER TRIGGER "SIM_TRADE"."TIU_CONTRACTS" ENABLE