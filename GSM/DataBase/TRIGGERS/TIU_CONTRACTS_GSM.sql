CREATE OR REPLACE TRIGGER TIU_CONTRACTS
--
--Version=#2
--
--v.2 Арфросин 28.10.2014 - Добавил NVL в IF NOT(UPDATING and (:NEW.SEND_ACTIV<>:OLD.SEND_ACTIV)) THEN
--
BEFORE INSERT OR UPDATE
ON CONTRACTS
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
DECLARE 
  pCELL_PLAN_CODE1 VARCHAR2(50 CHAR); 
  pCELL_PLAN_CODE2 VARCHAR2(50 CHAR); 
BEGIN
  IF INSERTING THEN
    IF NVL(:NEW.CONTRACT_ID, 0) = 0 then
      :NEW.CONTRACT_ID := NEW_CONTRACT_ID;
    END IF;
    :NEW.USER_CREATED := USER;
    :NEW.DATE_CREATED := SYSDATE;
    BEGIN 
        SELECT CELL_PLAN_CODE INTO pCELL_PLAN_CODE1 FROM DB_LOADER_ACCOUNT_PHONES dlp WHERE dlp.phone_number=:NEW.PHONE_NUMBER_FEDERAL AND dlp.last_check_date_time =                                                                       
            (select max(dlp1.last_check_date_time)                                                                                                                                                                                          
               from db_loader_account_phones dlp1                                                                                                                                                                                           
              where dlp1.phone_number = dlp.phone_number);                                                                                                                                                                                  
        SELECT TARIFF_CODE INTO pCELL_PLAN_CODE2 FROM TARIFFS TR WHERE TR.TARIFF_ID=:NEW.TARIFF_ID;                                                                                                                                          
        IF pCELL_PLAN_CODE1=pCELL_PLAN_CODE2 THEN                                                                                                                                                                                           
          :NEW.CURR_TARIFF_ID := :NEW.TARIFF_ID;                                                                                                                                                                                              
        ELSE
          :NEW.CURR_TARIFF_ID := -3;                                                                                                                                                                                                                               
         --select TARIFF_ID INTO :NEW.CURR_TARIFF_ID from                                                                                                                                                                                      
          --(select * from tariffs TR WHERE TR.TARIFF_CODE=pCELL_PLAN_CODE1 AND NVL(TR.TARIFF_PRIORITY, 9999)=(select min(NVL(TR1.TARIFF_PRIORITY, 9999)) from tariffs TR1 WHERE TR1.TARIFF_CODE=pCELL_PLAN_CODE1)) WHERE ROWNUM=1;           
        END IF;                                                                                                                                                                                                                             
    EXCEPTION 
      WHEN OTHERS THEN NULL; 
    END; 
  END IF;
  IF NOT(UPDATING and (nvl(:NEW.SEND_ACTIV, -1)<>nvl(:OLD.SEND_ACTIV, -1))) THEN
    :NEW.USER_LAST_UPDATED := USER;
    :NEW.DATE_LAST_UPDATED := SYSDATE;
  END IF;
  IF UPDATING THEN 
    IF :NEW.TARIFF_ID<>:OLD.TARIFF_ID THEN 
      :NEW.CURR_TARIFF_ID := :NEW.TARIFF_ID;                                                                                                                                                                                              
      INSERT INTO PHONES_TARIF_FOR_RECALC (PHONE_NUMBER) VALUES (:NEW.PHONE_NUMBER_FEDERAL); 
    END IF; 
  END IF; 
  if  Updating then
    IF      nvl( :OLD.CONTRACT_ID , -1)                                          <> nvl( :NEW.CONTRACT_ID , -1)
        OR  nvl( :OLD.CONTRACT_NUM , -1)                                         <> nvl( :NEW.CONTRACT_NUM , -1)
        OR  nvl( :OLD.CONTRACT_DATE , to_date('01.01.1900','dd.mm.yyyy') )       <> nvl( :NEW.CONTRACT_DATE , to_date('01.01.1900','dd.mm.yyyy') )
        OR  nvl( :OLD.FILIAL_ID , -1)                                            <> nvl( :NEW.FILIAL_ID , -1)
        OR  nvl( :OLD.OPERATOR_ID, -1)                                           <> nvl( :NEW.OPERATOR_ID, -1)
        OR  nvl( :OLD.PHONE_NUMBER_FEDERAL , '-1')                               <> nvl( :NEW.PHONE_NUMBER_FEDERAL , '-1')
        OR  nvl( :OLD.PHONE_NUMBER_CITY , '-1')                                  <> nvl( :NEW.PHONE_NUMBER_CITY , '-1')
        OR  nvl( :OLD.PHONE_NUMBER_TYPE , -1)                                    <> nvl( :NEW.PHONE_NUMBER_TYPE , -1)
        OR  nvl( :OLD.TARIFF_ID , -1 )                                           <> nvl( :NEW.TARIFF_ID , -1 )
        OR  nvl( :OLD.SIM_NUMBER ,  '-1' )                                       <> nvl( :NEW.SIM_NUMBER ,  '-1' )
        OR  nvl( :OLD.SERVICE_ID , -1 )                                          <> nvl( :NEW.SERVICE_ID , -1 )
        OR  nvl( :OLD.DISCONNECT_LIMIT , -1 )                                    <> nvl( :NEW.DISCONNECT_LIMIT , -1 )
        OR  nvl( :OLD.CONFIRMED , -1 )                                           <> nvl( :NEW.CONFIRMED , -1 )
        OR  nvl( :OLD.USER_CREATED , '-1' )                                      <> nvl( :NEW.USER_CREATED , '-1' )
        OR  nvl( :OLD.DATE_CREATED , to_date('01.01.1900','dd.mm.yyyy') )        <> nvl( :NEW.DATE_CREATED , to_date('01.01.1900','dd.mm.yyyy') )
        OR  nvl( :OLD.ABONENT_ID , -1 )                                          <> nvl( :NEW.ABONENT_ID , -1 )
        OR  nvl( :OLD.RECEIVED_SUM , -1 )                                        <> nvl( :NEW.RECEIVED_SUM , -1 )
        OR  nvl( :OLD.START_BALANCE , -1 )                                       <> nvl( :NEW.START_BALANCE , -1 )
        OR  nvl( :OLD.GOLD_NUMBER_SUM , -1 )                                     <> nvl( :NEW.GOLD_NUMBER_SUM , -1 )
        OR  nvl( :OLD.HAND_BLOCK , -1 )                                          <> nvl( :NEW.HAND_BLOCK , -1 )
        OR  nvl( :OLD.USER_PASSWORD , '-1' )                                     <> nvl( :NEW.USER_PASSWORD , '-1' )
        OR  nvl( :OLD.CONNECT_LIMIT , -1 )                                       <> nvl( :NEW.CONNECT_LIMIT , -1 )
        OR  nvl( :OLD.DATE_LAST_SET_PASS , to_date('01.01.1900','dd.mm.yyyy')  ) <> nvl( :NEW.DATE_LAST_SET_PASS , to_date('01.01.1900','dd.mm.yyyy')  )       
        OR  nvl( :OLD.COUNT_SET_PASS_BY_DAY , -1 )                               <> nvl( :NEW.COUNT_SET_PASS_BY_DAY , -1 )       
        OR  nvl( :OLD.HAND_BLOCK_DATE_END , to_date('01.01.1900','dd.mm.yyyy') ) <> nvl( :NEW.HAND_BLOCK_DATE_END , to_date('01.01.1900','dd.mm.yyyy')  )    
        OR  nvl( :OLD.COMMENTS , '-1' )                                          <> nvl( :NEW.COMMENTS , '-1' )
        OR  nvl( :OLD.IS_CREDIT_CONTRACT , -1 )                                  <> nvl( :NEW.IS_CREDIT_CONTRACT , -1 )
        OR  nvl( :OLD.SEND_ACTIV , -1 )                                          <> nvl( :NEW.SEND_ACTIV , -1 )
        OR  nvl( :OLD.DOP_STATUS  , -1 )                                         <> nvl( :NEW.DOP_STATUS , -1 )
        OR  nvl( :OLD.DEALER_KOD    , -1 )                                       <> nvl( :NEW.DEALER_KOD , -1 )
        OR  nvl( :OLD.CURR_TARIFF_ID , -1 )                                      <> nvl( :NEW.CURR_TARIFF_ID , -1 )    
        OR  nvl( :OLD.ABON_TP_DISCOUNT , -1 )                                    <> nvl( :NEW.ABON_TP_DISCOUNT , -1 )
        OR  nvl( :OLD.INSTALLMENT_PAYMENT_DATE , to_date('01.01.1900','dd.mm.yyyy')  ) <> nvl( :NEW.INSTALLMENT_PAYMENT_DATE , to_date('01.01.1900','dd.mm.yyyy')  )                                       
        OR  nvl( :OLD.INSTALLMENT_PAYMENT_SUM , -1 )                             <> nvl( :NEW.INSTALLMENT_PAYMENT_SUM , -1 )
        OR  nvl( :OLD.INSTALLMENT_PAYMENT_MONTHS , -1 )                          <> nvl( :NEW.INSTALLMENT_PAYMENT_MONTHS , -1 )
        OR  nvl( :OLD.INSTALLMENT_ADVANCED_REPAYMENT , to_date('01.01.1900','dd.mm.yyyy')  ) <> nvl( :NEW.INSTALLMENT_ADVANCED_REPAYMENT , to_date('01.01.1900','dd.mm.yyyy')  )                                  
        OR  nvl( :OLD.GROUP_ID  , -1 )                                           <> nvl( :NEW.GROUP_ID , -1 )                                                          
        OR  nvl( :OLD.OPTION_GROUP_ID , -1 )                                     <> nvl( :NEW.OPTION_GROUP_ID , -1 )
        OR  nvl( :OLD.MN_ROAMING , -1 )                                          <> nvl( :NEW.MN_ROAMING , -1 )
        OR  nvl( :OLD.PARAMDISABLE_SMS , '-1' )                                  <> nvl( :NEW.PARAMDISABLE_SMS , '-1' )
    THEN      
    INSERT INTO SH_CONTRACTS
       ( CONTRACT_ID, CONTRACT_NUM, CONTRACT_DATE, FILIAL_ID, OPERATOR_ID, PHONE_NUMBER_FEDERAL, PHONE_NUMBER_CITY, PHONE_NUMBER_TYPE, TARIFF_ID, SIM_NUMBER, SERVICE_ID, DISCONNECT_LIMIT, CONFIRMED, USER_CREATED, DATE_CREATED, USER_LAST_UPDATED, DATE_LAST_UPDATED, ABONENT_ID, RECEIVED_SUM, START_BALANCE, GOLD_NUMBER_SUM, HAND_BLOCK, USER_PASSWORD, CONNECT_LIMIT, DATE_LAST_SET_PASS, COUNT_SET_PASS_BY_DAY, HAND_BLOCK_DATE_END, COMMENTS, IS_CREDIT_CONTRACT, SEND_ACTIV, DOP_STATUS, DEALER_KOD, ABON_TP_DISCOUNT, INSTALLMENT_PAYMENT_DATE, INSTALLMENT_PAYMENT_SUM, INSTALLMENT_PAYMENT_MONTHS, INSTALLMENT_ADVANCED_REPAYMENT, GROUP_ID, OPTION_GROUP_ID, MN_ROAMING, UPDATE_TIME, UPDATE_USER, PARAMDISABLE_SMS )
    VALUES
       ( :old.CONTRACT_ID, :old.CONTRACT_NUM, :old.CONTRACT_DATE, :old.FILIAL_ID, :old.OPERATOR_ID, :old.PHONE_NUMBER_FEDERAL, :old.PHONE_NUMBER_CITY, :old.PHONE_NUMBER_TYPE, :old.TARIFF_ID, :old.SIM_NUMBER, :old.SERVICE_ID, :old.DISCONNECT_LIMIT, :old.CONFIRMED, :old.USER_CREATED, :old.DATE_CREATED, :old.USER_LAST_UPDATED, :old.DATE_LAST_UPDATED, :old.ABONENT_ID, :old.RECEIVED_SUM, :old.START_BALANCE, :old.GOLD_NUMBER_SUM, :old.HAND_BLOCK, :old.USER_PASSWORD, :old.CONNECT_LIMIT, :old.DATE_LAST_SET_PASS, :old.COUNT_SET_PASS_BY_DAY, :old.HAND_BLOCK_DATE_END, :old.COMMENTS, :old.IS_CREDIT_CONTRACT, :old.SEND_ACTIV, :old.DOP_STATUS, :old.DEALER_KOD, :old.ABON_TP_DISCOUNT, :old.INSTALLMENT_PAYMENT_DATE, :old.INSTALLMENT_PAYMENT_SUM, :old.INSTALLMENT_PAYMENT_MONTHS, :old.INSTALLMENT_ADVANCED_REPAYMENT, :old.GROUP_ID, :old.OPTION_GROUP_ID, :old.MN_ROAMING, sysdate, user, :old.PARAMDISABLE_SMS);
    END IF;   
  end if; 
END;
/