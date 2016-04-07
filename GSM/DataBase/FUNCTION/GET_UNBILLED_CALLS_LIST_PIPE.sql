CREATE OR REPLACE FUNCTION GET_UNBILLED_CALLS_LIST_PIPE(pPhoneNumber in varchar2)
--
--#version=2
--v2 20.05.2015 - Афросин убрал лишнюю выборку.
--v1 20.05.2015 - Кочнев для зад.2790
  RETURN CALLS_LIST_TABLE
  pipelined AS
    --
    CURSOR C IS
      SELECT ACCOUNTS.LOGIN, 
             ACCOUNTS.New_Pswd, 
             accounts.account_number
        FROM DB_LOADER_ACCOUNT_PHONES, 
             ACCOUNTS
        WHERE DB_LOADER_ACCOUNT_PHONES.PHONE_NUMBER = pPhoneNumber
          AND ACCOUNTS.ACCOUNT_ID = DB_LOADER_ACCOUNT_PHONES.ACCOUNT_ID
          AND DB_LOADER_ACCOUNT_PHONES.YEAR_MONTH = (select max(YEAR_MONTH) 
                                                       from DB_LOADER_ACCOUNT_PHONES 
                                                       where PHONE_NUMBER = pPhoneNumber); 
  vREC C%ROWTYPE;
   pANSWER SOAP_API_ANSWER_TYPE := SOAP_API_ANSWER_TYPE(NULL, NULL,null);                                                       
                                                       
  clt   CALLS_LIST_TP := CALLS_LIST_TP(NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
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
           
         select 
         to_char(to_timestamp_tz(extractvalue (value(d) ,'UnbilledCallsList/callDate'), 'yyyy-mm-dd"T"hh24:mi:ss tzh:tzm'), 'dd.mm.yyyy hh24:mi:ss tzh:tzm') callDate,
         trim(extractvalue (value(d) ,'UnbilledCallsList/callNumber')) callNumber, 
         trim(extractvalue (value(d) ,'UnbilledCallsList/callToNumber')) callToNumber,
         extractvalue (value(d) ,'UnbilledCallsList/serviceName') serviceName,
         extractvalue (value(d) ,'UnbilledCallsList/callType') callType,
         extractvalue (value(d) ,'UnbilledCallsList/dataVolume') dataVolume,
         extractvalue (value(d) ,'UnbilledCallsList/callAmt') callAmt,
         extractvalue (value(d) ,'UnbilledCallsList/callDuration')  callDuration  
         from 
         table(XmlSequence(pANSWER.ANSWER.extract('S:Envelope/S:Body/ns0:getUnbilledCallsListResponse/UnbilledCallsList'  ,'xmlns:S="http://schemas.xmlsoap.org/soap/envelope/" xmlns:ns0="urn:uss-wsapi:Subscriber"'))) d
         ) T                                      
                   )
                   
                   LOOP  
                    clt.CALLDATE := SUBSTR(cs.callDate,1,26);
                    clt.CALLNUMBER := cs.callNumber;
                    clt.CALLTONUMBER := cs.callToNumber;
                    clt.SERVICENAME := cs.serviceName;
                    clt.CALLTYPE := cs.callType;
                    clt.DATAVOLUME := cs.dataVolume;
                    clt.CALLAMT := cs.callAmt;
                    clt.CALLDURATION := cs.callDuration;
                    
                     pipe ROW(clt);
      
                   END LOOP;
       return;
    end if;   
  end;
/
GRANT EXECUTE ON GET_UNBILLED_CALLS_LIST_PIPE TO LONTANA_ROLE;
GRANT EXECUTE ON GET_UNBILLED_CALLS_LIST_PIPE TO LONTANA_ROLE_RO;