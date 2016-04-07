CREATE OR REPLACE PROCEDURE READ_XML_DETAIL_FROM_BILL(
  pPHONE_NUMBER IN VARCHAR2,
  pYEAR_MONTH IN INTEGER
  ) IS
  vX XMLTYPE;
BEGIN
  EXECUTE IMMEDIATE 'TRUNCATE TABLE COLLECTOR_TEMP_BILL_XML';
  EXECUTE IMMEDIATE 'TRUNCATE TABLE COLLECTOR_TEMP_DETAILS';
  FOR rec IN (SELECT *
                FROM COLLECTOR_XML_FILES CXF
                WHERE CXF.PHONE_NUMBER = pPHONE_NUMBER
                  AND CXF.YEAR_MONTH = pYEAR_MONTH)
  LOOP
    LOAD_XML_FILE(REC.FILE_NAME, 1, pYEAR_MONTH);
  END LOOP;       
  FOR rec IN (select *
                from COLLECTOR_TEMP_BILL_XML)
  loop
      dbms_output.put_line('bill');
    vX:=XMLTYPE(REC.XML_TXT);
    --vX:=vX.extract('XML_BILL/ECare_Corporate_Str/ECare_Ban_Str/ECare_Ben_Str/ECare_Ben_Summary_Str');
    FOR details IN (SELECT VALUE(TA) VALUE_XML                        
                      FROM TABLE(XMLSequence(vX.extract('XML_BILL/ECare_Corporate_Str/ECare_Ban_Str/ECare_Ben_Str/ECare_Ben_Summary_Str/ECare_Sub_Main_Str'))) TA
                      where EXTRACTVALUE(VALUE(TA), 'ECare_Sub_Main_Str/ECare_SubscriberInfo/CHG_subscriber_no') = pPHONE_NUMBER 
                      )
    LOOP  
      dbms_output.put_line('phone');
      FOR calls IN (SELECT EXTRACTVALUE(VALUE(TA), '*/USAGE_connect_date') USAGE_connect_date,
                           EXTRACTVALUE(VALUE(TA), '*/USAGE_connect_time') USAGE_connect_time,
                           EXTRACTVALUE(VALUE(TA), '*/USAGE_other_number') USAGE_other_number,
                           EXTRACTVALUE(VALUE(TA), '*/USAGE_dialed_digits') USAGE_dialed_digits,
                           EXTRACTVALUE(VALUE(TA), '*/USAGE_data_volume') USAGE_data_volume,
                           EXTRACTVALUE(VALUE(TA), '*/USAGE_duration') USAGE_duration,
                           EXTRACTVALUE(VALUE(TA), '*/USAGE_feature_description') USAGE_feature_description,
                           EXTRACTVALUE(VALUE(TA), '*/USAGE_at_charge_amt') USAGE_at_charge_amt,
                           EXTRACTVALUE(VALUE(TA), '*/USAGE_cell_id') USAGE_cell_id,
                           EXTRACTVALUE(VALUE(TA), '*/USAGE_at_num_mins_to_rate') USAGE_at_num_mins_to_rate,
                           EXTRACTVALUE(VALUE(TA), '*/USAGE_call_action_code') USAGE_call_action_code
                      FROM TABLE(XMLSequence((details.VALUE_XML).extract('ECare_Sub_Main_Str/ECare_Sub_Usages/*'))) TA )
      LOOP
     -- dbms_output.put_line('row');
        INSERT INTO COLLECTOR_TEMP_DETAILS(USAGE_connect_date, USAGE_connect_time, USAGE_other_number, 
                                           USAGE_dialed_digits, USAGE_data_volume, USAGE_duration, 
                                           USAGE_at_charge_amt, USAGE_feature_description, USAGE_cell_id, 
                                           USAGE_at_num_mins_to_rate, USAGE_call_action_code)
          VALUES(calls.USAGE_connect_date, calls.USAGE_connect_time, calls.USAGE_other_number, 
                 calls.USAGE_dialed_digits, calls.USAGE_data_volume, calls.USAGE_duration, 
                 calls.USAGE_at_charge_amt, calls.USAGE_feature_description, calls.USAGE_cell_id, 
                 calls.USAGE_at_num_mins_to_rate, calls.USAGE_call_action_code);     
      END LOOP;  
    end loop;
  end loop;                           
END;  