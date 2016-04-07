CREATE OR REPLACE PACKAGE COLLECTOR_PCKG AS
--
--#Version=2
--v.1 2015.09.10 Крайнов. Создание пакета
--
  PROCEDURE READ_XML_DETAIL_FROM_BILL(
    pPHONE_NUMBER IN VARCHAR2,
    pYEAR_MONTH IN INTEGER
    );
--
  FUNCTION GET_BILLING_CALLS_PIPE(
    pPHONE_NUMBER IN VARCHAR2,
    pYEAR_MONTH IN INTEGER
    ) RETURN COLLECTOR_CALLS_TABLE PIPELINED;  
--
  PROCEDURE LOAD_XML_FILE0(
    pFILE_NAME IN VARCHAR2
    ); 
--    
END;
/

CREATE OR REPLACE PACKAGE BODY COLLECTOR_PCKG AS
--
  FUNCTION TO_NUM(
    VAL IN VARCHAR2
    ) RETURN NUMBER IS
    ITOG NUMBER;
  BEGIN
    BEGIN
      ITOG:=TO_NUMBER(REPLACE(VAL, ',', '.'));
    EXCEPTION
      WHEN OTHERS THEN
        ITOG:=TO_NUMBER(REPLACE(VAL, '.', ','));
    END;
    RETURN ITOG;
  END;  
--
  PROCEDURE READ_XML_DETAIL_FROM_BILL(
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
--
  FUNCTION GET_BILLING_CALLS_PIPE(
    pPHONE_NUMBER IN VARCHAR2,
    pYEAR_MONTH IN INTEGER
    ) RETURN COLLECTOR_CALLS_TABLE PIPELINED AS
    pragma AUTONOMOUS_TRANSACTION;
    CCR COLLECTOR_CALLS_ROW := COLLECTOR_CALLS_ROW(NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
  BEGIN
    READ_XML_DETAIL_FROM_BILL(pPHONE_NUMBER, pYEAR_MONTH);
    FOR rec IN (SELECT *
                  FROM COLLECTOR_TEMP_DETAILS)
    LOOP
      CCR.USAGE_CONNECT_DATE:=REPLACE(REC.USAGE_CONNECT_DATE, '/', '.')||'.'||TO_CHAR(TRUNC(pYEAR_MONTH/100)); --Добавление года
      CCR.USAGE_CONNECT_TIME:=REC.USAGE_CONNECT_TIME;
      CCR.USAGE_OTHER_NUMBER:=REC.USAGE_OTHER_NUMBER;
      CCR.USAGE_DIALED_DIGITS:=REC.USAGE_DIALED_DIGITS;
      CCR.USAGE_DATA_VOLUME:=REC.USAGE_DATA_VOLUME;
      CCR.USAGE_DURATION:=REC.USAGE_DURATION;
      CCR.USAGE_FEATURE_DESCRIPTION:=REC.USAGE_FEATURE_DESCRIPTION;
      CCR.USAGE_AT_CHARGE_AMT:=TO_NUM(REC.USAGE_AT_CHARGE_AMT)*1.18; -- Добавление НДС
      CCR.USAGE_CELL_ID:=REC.USAGE_CELL_ID;
      CCR.USAGE_AT_NUM_MINS_TO_RATE:=REC.USAGE_AT_NUM_MINS_TO_RATE;
      CCR.USAGE_CALL_ACTION_CODE:=REC.USAGE_CALL_ACTION_CODE;
      commit;
      PIPE ROW(CCR);
    END LOOP;    
    RETURN;              
  END;
--
  PROCEDURE LOAD_XML_FILE0(
    pFILE_NAME IN VARCHAR2
    ) IS
    L_cLOB cLOB;
    L_BFILE BFILE;
    dir_name varchar2(300 char);
    vDest Integer:=1;
    vSrcs Integer:=1;
    vLang Integer:=Dbms_Lob.Default_Lang_Ctx;
    vWars Number;
    vLang2 Integer:=NLS_CHARSET_ID('CL8MSWIN1251'); 
    vCSid integer:=NLS_CHARSET_ID('CL8MSWIN1251');
    CREATE_NEW_DIR VARCHAR2(1000 CHAR);
  BEGIN
    dir_name:='XML_BILL_FILES';
    INSERT INTO collector_bill_xml(FILE_NAME, XML_TXT, XML_CHECKED)
      VALUES(pFILE_NAME, EMPTY_CLOB(), -1) 
      RETURNING XML_TXT INTO L_cLOB;
    L_BFILE := BFILENAME( DIR_NAME, pFILE_NAME );
    DBMS_LOB.FILEOPEN( L_BFILE );
    Dbms_Lob.LoadClobFromFile(L_cLOB,L_BFILE,Dbms_Lob.GetLength(L_BFILE),vDest, vSrcs, vCSid, vLang2 ,vWars );
    DBMS_LOB.FILECLOSE( L_BFILE );
  END;
--
END;
/
