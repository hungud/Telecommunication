CREATE OR REPLACE PROCEDURE ADD_COLLECTOR_CALLS(
  pYEAR_MONTH IN INTEGER,
  pFILE_ID IN INTEGER DEFAULT NULL
  ) IS  
  CURSOR C(pACC_ID IN INTEGER, pYM IN INTEGER, pPHONE IN VARCHAR2) IS 
    SELECT * 
      FROM DB_LOADER_FULL_FINANCE_BILL
      WHERE ACCOUNT_ID = pACC_ID 
        AND YEAR_MONTH = pYM
        AND PHONE_NUMBER = pPHONE;
  cDUMMY C%ROWTYPE;
  VAT CONSTANT NUMBER(15,4):= 1.18; 
  vX XMLTYPE;
  vACCOUNT_ID INTEGER;
  I INTEGER;
  E_NODE INTEGER;
  vPHONE_NUMBER VARCHAR2(10 CHAR);
BEGIN
  FOR rec IN (SELECT CB.*, ROWID
                FROM COLLECTOR_BILL_XML CB
                WHERE CB.YEAR_MONTH = pYEAR_MONTH
                  AND (pFILE_ID IS NULL OR CB.FILE_ID = pFILE_ID))
  LOOP
    vX:=XMLTYPE(REC.XML_TXT);
    vX:=vX.extract('XML_BILL/ECare_Corporate_Str/ECare_Ban_Str/ECare_Ben_Str/ECare_Ben_Summary_Str');
    DELETE FROM COLLECTOR_CALL_FROM_BILL
      WHERE FILE_ID = REC.FILE_ID;
    -- Детальная инфа по номеру, выбор номеров
    FOR details IN (SELECT VALUE(TA) VALUE_XML                        
                    FROM TABLE(XMLSequence(vX.extract('ECare_Ben_Summary_Str/ECare_Sub_Main_Str'))) TA )
    LOOP      
      -- Звонки       
      FOR phone IN (SELECT EXTRACTVALUE(VALUE(TA), 'ECare_SubscriberInfo/CHG_subscriber_no') PHONE_NUMBER,
                           VALUE(TA) VALUE_XML                        
                      FROM TABLE(XMLSequence((details.VALUE_XML).extract('ECare_Sub_Main_Str/ECare_SubscriberInfo'))) TA )
      LOOP 
        IF LENGTH(phone.PHONE_NUMBER) > 7 THEN
          vPHONE_NUMBER:=phone.PHONE_NUMBER;
        END IF;
      end loop;
      -- Скидки
      FOR calls IN (SELECT EXTRACTVALUE(VALUE(TA), '*/USAGE_connect_date') USAGE_connect_date,
                           EXTRACTVALUE(VALUE(TA), '*/USAGE_connect_time') USAGE_connect_time,
                           EXTRACTVALUE(VALUE(TA), '*/USAGE_other_number') USAGE_other_number,
                           EXTRACTVALUE(VALUE(TA), '*/USAGE_duration') USAGE_duration,
                           EXTRACTVALUE(VALUE(TA), '*/USAGE_at_charge_amt') USAGE_at_charge_amt,
                           EXTRACTVALUE(VALUE(TA), '*/USAGE_feature_description') USAGE_feature_description,
                           EXTRACTVALUE(VALUE(TA), '*/USAGE_cell_id') USAGE_cell_id,
                           EXTRACTVALUE(VALUE(TA), '*/USAGE_at_num_mins_to_rate') USAGE_at_num_mins_to_rate,
                           EXTRACTVALUE(VALUE(TA), '*/USAGE_call_action_code') USAGE_call_action_code
                      FROM TABLE(XMLSequence((details.VALUE_XML).extract('ECare_Sub_Main_Str/ECare_Sub_Usages/*'))) TA )
      LOOP
        INSERT INTO COLLECTOR_CALL_FROM_BILL(YEAR_MONTH, FILE_ID, PHONE_NUMBER, 
                                             USAGE_connect_date, USAGE_connect_time, USAGE_other_number, 
                                             USAGE_duration, USAGE_at_charge_amt, USAGE_feature_description, 
                                             USAGE_cell_id, USAGE_at_num_mins_to_rate, USAGE_call_action_code)
          VALUES(rec.YEAR_MONTH, rec.FILE_ID, vPHONE_NUMBER, 
                 calls.USAGE_connect_date, calls.USAGE_connect_time, calls.USAGE_other_number, 
                 calls.USAGE_duration, calls.USAGE_at_charge_amt, calls.USAGE_feature_description, 
                 calls.USAGE_cell_id, calls.USAGE_at_num_mins_to_rate, calls.USAGE_call_action_code);     
      END LOOP;        
    END LOOP;  
    COMMIT;
  END LOOP;  
END;
/