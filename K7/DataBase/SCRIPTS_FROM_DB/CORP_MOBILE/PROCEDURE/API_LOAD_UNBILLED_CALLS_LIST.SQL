
  CREATE OR REPLACE PROCEDURE "CORP_MOBILE"."API_LOAD_UNBILLED_CALLS_LIST" (
  pHONE_NUMBER IN VARCHAR2
  ) IS 
  pbsal_id VARCHAR2 (20);
  vSOAP_ANSWER XMLTYPE;
  vPHONE_NUMBER VARCHAR2(10 CHAR);
BEGIN
  pbsal_id := beeline_api_pckg.phone_detail_call (pHONE_NUMBER);
  --
  DELETE FROM API_GET_UNBILLED_CALLS_LIST;   
  --
  SELECT L.SOAP_ANSWER, L.PHONE INTO vSOAP_ANSWER, vPHONE_NUMBER 
    FROM BEELINE_SOAP_API_LOG L
    WHERE L.BSAL_ID = TO_NUMBER (pBSAL_ID);
  --
  INSERT INTO API_GET_UNBILLED_CALLS_LIST(callDate, callNumber, callToNumber, serviceName, callType, dataVolume, callAmt, callDuration)
    SELECT  extractvalue (value(d) ,'/UnbilledCallsList/callDate') callDate
           ,extractvalue (value(d) ,'/UnbilledCallsList/callNumber') callNumber
           ,extractvalue (value(d) ,'/UnbilledCallsList/callToNumber') callToNumber
           ,extractvalue (value(d) ,'/UnbilledCallsList/serviceName') serviceName
           ,extractvalue (value(d) ,'/UnbilledCallsList/callType') callType
           ,extractvalue (value(d) ,'/UnbilledCallsList/dataVolume') dataVolume
           ,extractvalue (value(d) ,'/UnbilledCallsList/callAmt') callAmt
           ,extractvalue (value(d) ,'/UnbilledCallsList/callDuration') callDuration
      FROM TABLE(XmlSequence(vSOAP_ANSWER.extract('S:Envelope/S:Body/ns0:getUnbilledCallsListResponse/UnbilledCallsList',
                                                  'xmlns:S="http://schemas.xmlsoap.org/soap/envelope/" xmlns:ns0="urn:uss-wsapi:Subscriber"'))) D;  
  --  
END; 