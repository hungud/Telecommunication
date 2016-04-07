
  CREATE OR REPLACE TRIGGER "CORP_MOBILE"."TIU_CONTRACTS" 
--#Version=5
--v5 23.11.2015 Соколов - Исправил сортировку по приоретету при вставке запси в таблицу CONTRACTS. 
--3 Добавление логирование изменения доп. статусов
  BEFORE INSERT OR UPDATE ON CONTRACTS FOR EACH ROW
DECLARE 
  pCELL_PLAN_CODE1 VARCHAR2(50 CHAR); 
  pCELL_PLAN_CODE2 VARCHAR2(50 CHAR); 
  CURSOR C(pDATE IN DATE, pPHONE_NUMBER IN VARCHAR2) IS 
    SELECT DB_LOADER_ACCOUNT_PHONE_HISTS.* 
      FROM DB_LOADER_ACCOUNT_PHONE_HISTS 
      WHERE DB_LOADER_ACCOUNT_PHONE_HISTS.PHONE_NUMBER = pPHONE_NUMBER 
        AND DB_LOADER_ACCOUNT_PHONE_HISTS.END_DATE > pDATE 
        AND DB_LOADER_ACCOUNT_PHONE_HISTS.BEGIN_DATE < pDATE 
      ORDER BY DB_LOADER_ACCOUNT_PHONE_HISTS.END_DATE DESC;  
rec C%ROWTYPE;    
vDATE_CONTRACT DATE; 
vSTART INTEGER;
vEND INTEGER;
BEGIN 
  IF INSERTING THEN 
    IF NVL(:NEW.CONTRACT_ID, 0) = 0 then 
      :NEW.CONTRACT_ID := NEW_CONTRACT_ID; 
    END IF; 
    :NEW.USER_CREATED := USER; 
    :NEW.DATE_CREATED := SYSDATE;
    INSERT INTO QUEUE_CURRENT_BALANCES(PHONE_NUMBER, QUEUE_TYPE) VALUES(:NEW.PHONE_NUMBER_FEDERAL, 50);  
    BEGIN 
        SELECT CELL_PLAN_CODE INTO pCELL_PLAN_CODE1 FROM DB_LOADER_ACCOUNT_PHONES dlp WHERE dlp.phone_number=:NEW.PHONE_NUMBER_FEDERAL AND dlp.last_check_date_time =                                                                       
            (select max(dlp1.last_check_date_time)                                                                                                                                                                                          
               from db_loader_account_phones dlp1                                                                                                                                                                                           
              where dlp1.phone_number = dlp.phone_number);                                                                                                                                                                                  
        SELECT TARIFF_CODE INTO pCELL_PLAN_CODE2 FROM TARIFFS TR WHERE TR.TARIFF_ID=:NEW.TARIFF_ID;                                                                                                                                          
        IF pCELL_PLAN_CODE1=pCELL_PLAN_CODE2 THEN                                                                                                                                                                                           
          :NEW.CURR_TARIFF_ID := :NEW.TARIFF_ID;                                                                                                                                                                                              
        ELSE                                                                                                                                                                                                                                
         select TARIFF_ID INTO :NEW.CURR_TARIFF_ID from                                                                                                                                                                                      
          (select * from tariffs TR WHERE TR.TARIFF_CODE=pCELL_PLAN_CODE1 AND NVL(TR.TARIFF_PRIORITY, 0)=(select max(NVL(TR1.TARIFF_PRIORITY, 0)) from tariffs TR1 WHERE TR1.TARIFF_CODE=pCELL_PLAN_CODE1)) WHERE ROWNUM=1;           
        END IF;                                                                                                                                                                                                                             
    EXCEPTION 
      WHEN OTHERS THEN NULL; 
    END; 
  END IF; 
  IF (INSERTING) OR ((UPDATING) AND (:NEW.CONTRACT_DATE <> :OLD.CONTRACT_DATE)) THEN 
    vDATE_CONTRACT:=:NEW.CONTRACT_DATE; 
    OPEN C(vDATE_CONTRACT, :NEW.PHONE_NUMBER_FEDERAL); 
    FETCH C INTO rec; 
    IF C%FOUND THEN 
      UPDATE DB_LOADER_ACCOUNT_PHONE_HISTS 
        SET DB_LOADER_ACCOUNT_PHONE_HISTS.END_DATE=vDATE_CONTRACT - 1/24/60/60 
        WHERE DB_LOADER_ACCOUNT_PHONE_HISTS.HISTORY_ID=rec.HISTORY_ID; 
      INSERT INTO DB_LOADER_ACCOUNT_PHONE_HISTS(PHONE_NUMBER, BEGIN_DATE, END_DATE, PHONE_IS_ACTIVE, CELL_PLAN_CODE) 
        VALUES(rec.PHONE_NUMBER, vDATE_CONTRACT, rec.END_DATE, rec.PHONE_IS_ACTIVE, rec.CELL_PLAN_CODE); 
      --commit;   
    END IF; 
    CLOSE C; 
  END IF; 
  IF UPDATING THEN 
    IF :NEW.TARIFF_ID<>:OLD.TARIFF_ID THEN 
      :NEW.CURR_TARIFF_ID := :NEW.TARIFF_ID;                                                                                                                                                                                              
      INSERT INTO PHONES_TARIF_FOR_RECALC (PHONE_NUMBER) VALUES (:NEW.PHONE_NUMBER_FEDERAL); 
    END IF; 
    IF :NEW.CURR_TARIFF_ID<>:OLD.CURR_TARIFF_ID THEN 
        INSERT INTO QUEUE_CURRENT_BALANCES(PHONE_NUMBER, QUEUE_TYPE) VALUES(:NEW.PHONE_NUMBER_FEDERAL, 45); 
    END IF; 
  END IF; 
  IF NOT(UPDATING and (NVL(:NEW.SEND_ACTIV, 0) <> NVL(:OLD.SEND_ACTIV, 0))) THEN 
    :NEW.USER_LAST_UPDATED := USER; 
    :NEW.DATE_LAST_UPDATED := SYSDATE; 
  END IF; 
  IF UPDATING AND (NVL(:NEW.DOP_STATUS,0)<>NVL(:OLD.DOP_STATUS,0)) THEN 
    INSERT INTO LOG_DOP_STATUS  
      (PHONE_NUMBER,DOP_STATUS_ID_OLD,DOP_STATUS_ID_NEW,USER_LAST_UPDATED,DATE_LAST_UPDATED)  
    VALUES  
      (:NEW.PHONE_NUMBER_FEDERAL, :OLD.DOP_STATUS, :NEW.DOP_STATUS, USER, SYSDATE);
    IF (NVL(:NEW.DOP_STATUS,0)=0 and NVL(:OLD.DOP_STATUS,0) = 222) THEN
      -- В случае снятия первоначальной блокировки, обновить дату контракта на текущую
      :NEW.CONTRACT_DATE := trunc(sysdate);
    END IF;   
  END IF; 
  IF INSERTING AND :NEW.DOP_STATUS IS NOT NULL THEN 
    INSERT INTO LOG_DOP_STATUS  
  (PHONE_NUMBER,DOP_STATUS_ID_OLD,DOP_STATUS_ID_NEW,USER_LAST_UPDATED,DATE_LAST_UPDATED)  
  VALUES  
  (:NEW.PHONE_NUMBER_FEDERAL, NULL, :NEW.DOP_STATUS, USER, SYSDATE); 
  END IF; 
  --:NEW.CURR_TARIFF_ID:=GET_CURR_PHONE_TARIFF_ID(:NEW.PHONE_NUMBER_FEDERAL); 
  --логирование изменений в контрактах пользователями  
  if  Updating then
    IF nvl( :OLD.CONTRACT_ID , -1) <> nvl( :NEW.CONTRACT_ID , -1)
        OR nvl( :OLD.CONTRACT_NUM , -1) <> nvl( :NEW.CONTRACT_NUM , -1)
        OR nvl( :OLD.CONTRACT_DATE , to_date('01.01.1900','dd.mm.yyyy') ) <> nvl( :NEW.CONTRACT_DATE , to_date('01.01.1900','dd.mm.yyyy') )
        OR nvl( :OLD.FILIAL_ID , -1) <> nvl( :NEW.FILIAL_ID , -1)
        OR nvl( :OLD.OPERATOR_ID, -1) <> nvl( :NEW.OPERATOR_ID, -1)             
        OR nvl( :OLD.PHONE_NUMBER_FEDERAL , '-1') <> nvl( :NEW.PHONE_NUMBER_FEDERAL , '-1')    
        OR nvl( :OLD.PHONE_NUMBER_CITY , '-1') <> nvl( :NEW.PHONE_NUMBER_CITY , '-1')      
        OR nvl( :OLD.PHONE_NUMBER_TYPE , -1)   <> nvl( :NEW.PHONE_NUMBER_TYPE , -1)       
        OR nvl( :OLD.TARIFF_ID , -1 ) <> nvl( :NEW.TARIFF_ID , -1 ) 
        OR nvl( :OLD.SIM_NUMBER ,  '-1' ) <> nvl( :NEW.SIM_NUMBER ,  '-1' )
        OR nvl( :OLD.SERVICE_ID , -1 ) <> nvl( :NEW.SERVICE_ID , -1 )
        OR nvl( :OLD.DISCONNECT_LIMIT , -1 ) <> nvl( :NEW.DISCONNECT_LIMIT , -1 )
        OR nvl( :OLD.CONFIRMED , -1 )          <> nvl( :NEW.CONFIRMED , -1 )             
        OR nvl( :OLD.USER_CREATED , '-1' )     <> nvl( :NEW.USER_CREATED , '-1' )
        OR nvl( :OLD.DATE_CREATED , to_date('01.01.1900','dd.mm.yyyy') ) <> nvl( :NEW.DATE_CREATED , to_date('01.01.1900','dd.mm.yyyy') )
        OR nvl( :OLD.ABONENT_ID , -1 )      <> nvl( :NEW.ABONENT_ID , -1 )        
        OR nvl( :OLD.RECEIVED_SUM , -1 )    <> nvl( :NEW.RECEIVED_SUM , -1 )       
        OR nvl( :OLD.START_BALANCE , -1 )   <> nvl( :NEW.START_BALANCE , -1 )            
        OR nvl( :OLD.GOLD_NUMBER_SUM , -1 ) <> nvl( :NEW.GOLD_NUMBER_SUM , -1 )          
        OR nvl( :OLD.HAND_BLOCK , -1 )      <> nvl( :NEW.HAND_BLOCK , -1 )               
        OR nvl( :OLD.USER_PASSWORD , '-1' ) <> nvl( :NEW.USER_PASSWORD , '-1' )            
        OR nvl( :OLD.CONNECT_LIMIT , -1 )   <> nvl( :NEW.CONNECT_LIMIT , -1 )            
        OR nvl( :OLD.HAND_BLOCK_DATE_END , to_date('01.01.1900','dd.mm.yyyy')  ) <> nvl( :NEW.HAND_BLOCK_DATE_END , to_date('01.01.1900','dd.mm.yyyy')  )       
        OR nvl( :OLD.IS_CREDIT_CONTRACT , -1 ) <> nvl( :NEW.IS_CREDIT_CONTRACT , -1 )       
        OR nvl( :OLD.COMMENTS , '-1' )         <> nvl( :NEW.COMMENTS , '-1' )
        OR nvl( :OLD.SEND_ACTIV , -1 )         <> nvl( :NEW.SEND_ACTIV , -1 )
        OR nvl( :OLD.CURR_TARIFF_ID , -1 )     <> nvl( :NEW.CURR_TARIFF_ID , -1 )                                                 
        OR nvl( :OLD.DOP_STATUS  , -1 )        <> nvl( :NEW.DOP_STATUS , -1 )                                                    
        OR nvl( :OLD.BALANCE_NOTICE_HAND_BLOCK , -1 ) <> nvl( :NEW.BALANCE_NOTICE_HAND_BLOCK , -1 )                                      
        OR nvl( :OLD.BALANCE_BLOCK_HAND_BLOCK , -1 )  <> nvl( :NEW.BALANCE_BLOCK_HAND_BLOCK , -1 )                                       
        OR nvl( :OLD.ABON_TP_DISCOUNT , -1 )          <> nvl( :NEW.ABON_TP_DISCOUNT , -1 )                                               
        OR nvl( :OLD.INSTALLMENT_PAYMENT_DATE , to_date('01.01.1900','dd.mm.yyyy')  ) <> nvl( :NEW.INSTALLMENT_PAYMENT_DATE , to_date('01.01.1900','dd.mm.yyyy')  )                                       
        OR nvl( :OLD.INSTALLMENT_PAYMENT_SUM , -1 )     <> nvl( :NEW.INSTALLMENT_PAYMENT_SUM , -1 )
        OR nvl( :OLD.INSTALLMENT_PAYMENT_MONTHS , -1 )  <> nvl( :NEW.INSTALLMENT_PAYMENT_MONTHS , -1 )
        OR nvl( :OLD.DEALER_KOD    , -1 )               <> nvl( :NEW.DEALER_KOD , -1 )                                                  
        OR nvl( :OLD.INSTALLMENT_ADVANCED_REPAYMENT , to_date('01.01.1900','dd.mm.yyyy')  ) <> nvl( :NEW.INSTALLMENT_ADVANCED_REPAYMENT , to_date('01.01.1900','dd.mm.yyyy')  )                                  
        OR nvl( :OLD.GROUP_ID  , -1 )       <> nvl( :NEW.GROUP_ID , -1 )                                                          
        OR nvl( :OLD.OPTION_GROUP_ID , -1 ) <> nvl( :NEW.OPTION_GROUP_ID , -1 )                                                   
        OR nvl( :OLD.MN_ROAMING , -1 )      <> nvl( :NEW.MN_ROAMING , -1 )                                                        
        OR nvl( :OLD.PARAMDISABLE_SMS , '-1' ) <> nvl( :NEW.PARAMDISABLE_SMS , '-1' )  THEN  
      insert into sh_contracts(contract_id, contract_num, contract_date, filial_id, operator_id, phone_number_federal, 
                               phone_number_city, phone_number_type, tariff_id, sim_number, service_id, disconnect_limit, 
                               confirmed, user_created, date_created, user_last_updated, date_last_updated, abonent_id, 
                               received_sum, start_balance, gold_number_sum, hand_block, user_password, connect_limit, 
                               hand_block_date_end, is_credit_contract, comments, send_activ, curr_tariff_id, dop_status, 
                               balance_notice_hand_block, balance_block_hand_block, abon_tp_discount, installment_payment_date, 
                               installment_payment_sum, installment_payment_months, dealer_kod, installment_advanced_repayment, 
                               group_id, option_group_id, mn_roaming, paramdisable_sms, update_user, update_time)
        values(:old.contract_id, :old.contract_num, :old.contract_date, :old.filial_id, :old.operator_id, :old.phone_number_federal, 
               :old.phone_number_city, :old.phone_number_type, :old.tariff_id, :old.sim_number, :old.service_id, :old.disconnect_limit, 
               :old.confirmed, :old.user_created, :old.date_created, :old.user_last_updated, :old.date_last_updated, :old.abonent_id, 
               :old.received_sum, :old.start_balance, :old.gold_number_sum, :old.hand_block, :old.user_password, :old.connect_limit, 
               :old.hand_block_date_end, :old.is_credit_contract, :old.comments, :old.send_activ, :old.curr_tariff_id, :old.dop_status, 
               :old.balance_notice_hand_block, :old.balance_block_hand_block, :old.abon_tp_discount, :old.installment_payment_date, 
               :old.installment_payment_sum, :old.installment_payment_months, :old.dealer_kod, :old.installment_advanced_repayment, 
               :old.group_id, :old.option_group_id, :old.mn_roaming, :old.paramdisable_sms, user, sysdate);
    END IF;    
    IF :NEW.DAILY_ABON_BANNED = 1 THEN
      DELETE FROM PHONE_NUMBER_WITH_DAILY_ABON
        WHERE PHONE_NUMBER_WITH_DAILY_ABON.PHONE_NUMBER = :NEW.phone_number_federal;
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
ALTER TRIGGER "CORP_MOBILE"."TIU_CONTRACTS" ENABLE