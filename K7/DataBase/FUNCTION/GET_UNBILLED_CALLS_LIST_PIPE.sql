CREATE OR REPLACE FUNCTION CORP_MOBILE.GET_UNBILLED_CALLS_LIST_PIPE(pPhoneNumber in varchar2)
--
--#version=2
--v1 26.05.2015 - Кочнев для зад.2885
  RETURN CALLS_LIST_TABLE
  pipelined AS
    --
    CURSOR C IS
      SELECT a.LOGIN, a.New_Pswd, a.account_number
        FROM DB_LOADER_ACCOUNT_PHONES db_l, 
             ACCOUNTS a
        WHERE db_l.PHONE_NUMBER = pPhoneNumber
          AND a.ACCOUNT_ID = db_l.ACCOUNT_ID
          AND db_l.YEAR_MONTH = 
           (select max(YEAR_MONTH) from DB_LOADER_ACCOUNT_PHONES where PHONE_NUMBER = pPhoneNumber); 
           
    vREC C%ROWTYPE;
    pANSWER SOAP_API_ANSWER_TYPE := SOAP_API_ANSWER_TYPE(NULL, NULL,null);                                                       
                                                       
    clt CALLS_LIST_TP := CALLS_LIST_TP(NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
    
   
    ch Integer;
    mn integer;
    sc integer;
    min_ch varchar2(15);
    
  begin
    OPEN C;
    FETCH C INTO vREC;
    
    CLOSE C;
    
    IF vREC.LOGIN IS NOT NULL THEN
      
      pANSWER:=BEELINE_SOAP_API_PCKG.getUnbilledCallsList(BEELINE_SOAP_API_PCKG.auth(vREC.LOGIN, vREC.New_Pswd), pPhoneNumber, vREC.account_number, '');
      --  select SOAP_ANSWER into pANSWER.ANSWER  from BEELINE_SOAP_API_LOG; 
       
       FOR cs IN( 
         
        select callDate, callNumber, callToNumber, serviceName,callType,dataVolume, callAmt, callDuration
        FROM (  
          with xmltable1 as (select t.soap_answer from BEELINE_SOAP_API_LOG t ) 
         select 
         to_char(to_timestamp_tz(extractvalue (value(d) ,'UnbilledCallsList/callDate'), 'yyyy-mm-dd"T"hh24:mi:ss tzh:tzm'), 'dd.mm.yyyy hh24:mi:ss tzh:tzm') callDate,
         trim(extractvalue (value(d) ,'UnbilledCallsList/callNumber')) callNumber, 
         trim(extractvalue (value(d) ,'UnbilledCallsList/callToNumber')) callToNumber,
         extractvalue (value(d) ,'UnbilledCallsList/serviceName') serviceName,
         extractvalue (value(d) ,'UnbilledCallsList/callType') callType,
         extractvalue (value(d) ,'UnbilledCallsList/dataVolume') dataVolume,
         extractvalue (value(d) ,'UnbilledCallsList/callAmt') callAmt,
         extractvalue (value(d) ,'UnbilledCallsList/callDuration')  callDuration  
         from xmltable1 t1,  table(XmlSequence(pANSWER.ANSWER.extract('S:Envelope/S:Body/ns0:getUnbilledCallsListResponse/UnbilledCallsList'  ,'xmlns:S="http://schemas.xmlsoap.org/soap/envelope/" xmlns:ns0="urn:uss-wsapi:Subscriber"'))) d
         ) T                                      
                   )
                   
                   LOOP  
                     ch:=0; mn:=0; sc:=0;
                     select to_number(trim(to_char(to_date(cs.callDuration,'HH24:MI:SS'),'HH24'))), 
                            to_number(trim(to_char(to_date(cs.callDuration,'HH24:MI:SS'),'MI'))), 
                            to_number(trim(to_char(to_date(cs.callDuration,'HH24:MI:SS'),'SS'))) 
                     into ch, mn, sc from dual;
                     
                     if (sc > 3) then
                       mn := mn + 1;
                     end if;
                     
                     if (ch > 0) then
                       mn := mn + (ch*60);
                     end if;
                                 
                     select to_char(mn) into min_ch from dual;
                            
                     -- min_ch := cs.callDuration;
                    clt.CALLDATE := SUBSTR(cs.callDate,1,26);
                    clt.CALLNUMBER := cs.callNumber;
                    clt.CALLTONUMBER := cs.callToNumber;
                    clt.SERVICENAME := cs.serviceName;
                    clt.CALLTYPE := cs.callType;
                    clt.DATAVOLUME := cs.dataVolume;
                    clt.CALLAMT := cs.callAmt;
                    clt.CALLDURATION := min_ch;
                    
                     pipe ROW(clt);
      
                   END LOOP;
       return;
    end if;   
  end;
/
