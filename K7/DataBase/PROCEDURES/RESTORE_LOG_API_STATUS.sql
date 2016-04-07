CREATE OR REPLACE PROCEDURE RESTORE_LOG_API_STATUS IS 
vSOAP_ANSWER XMLTYPE;
vREPORT_DATE DATE;
BEGIN
  for rec in (select BSAL_ID 
                FROM BEELINE_SOAP_API_LOG 
                where load_type = 3 
                  AND INSERT_DATE >= TO_DATE('16.01.2015 23:03:46', 'DD.MM.YYYY HH24:MI:SS')
                ORDER BY INSERT_DATE ASC )
  LOOP
    SELECT L.SOAP_ANSWER, l.INSERT_DATE INTO vSOAP_ANSWER, vREPORT_DATE
      FROM BEELINE_SOAP_API_LOG L
     -- WHERE L.BSAL_ID = TO_NUMBER ('17050718');
      WHERE L.BSAL_ID = REC.BSAL_ID;
    INSERT INTO API_GET_CTN_INFO_LIST_TEMP(ctn, statusDate, status, pricePlan, reasonStatus, lastActivity, activationDate, subscriberHLR, REPORT_DATE)
      SELECT extractvalue (value(d) ,'CTNInfoList/ctn') ctn
                   ,extractvalue (value(d) ,'/CTNInfoList/statusDate') statusDate
                   ,extractvalue (value(d) ,'/CTNInfoList/status') status
                   ,extractvalue (value(d) ,'/CTNInfoList/pricePlan') pricePlan
                   ,extractvalue (value(d) ,'/CTNInfoList/reasonStatus') reasonStatus
                   ,extractvalue (value(d) ,'/CTNInfoList/lastActivity') lastActivity
                   ,extractvalue (value(d) ,'/CTNInfoList/activationDate') activationDate
                   ,extractvalue (value(d) ,'/CTNInfoList/subscriberHLR') subscriberHLR,
                   vREPORT_DATE
              FROM TABLE(XmlSequence(vSOAP_ANSWER.extract('S:Envelope/S:Body/ns0:getCTNInfoListResponse/CTNInfoList'
                                                              ,'xmlns:S="http://schemas.xmlsoap.org/soap/envelope/" xmlns:ns0="urn:uss-wsapi:Subscriber"'))) D;    
    COMMIT;   
  END LOOP;                                                 
END;
/
