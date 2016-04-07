
  CREATE OR REPLACE PROCEDURE "SIM_TRADE"."FORCE_UPD_HIST_STATUS_CHG_DAT2" (
  BSAL_ID IN VARCHAR2
  ) IS
vSOAP_ANSWER XMLTYPE;
vDATE_REPORT DATE;
BEGIN
  SELECT L.SOAP_ANSWER, L.INSERT_date INTO vSOAP_ANSWER, vDATE_REPORT
    FROM BEELINE_SOAP_API_LOG L
    WHERE L.BSAL_ID = TO_NUMBER ('17050718');
  INSERT INTO API_GET_CTN_INFO_LIST_TEMP(ctn, statusDate, status, pricePlan, reasonStatus, lastActivity, activationDate, subscriberHLR)
    SELECT extractvalue (value(d) ,'CTNInfoList/ctn') ctn
                 ,extractvalue (value(d) ,'/CTNInfoList/statusDate') statusDate
                 ,extractvalue (value(d) ,'/CTNInfoList/status') status
                 ,extractvalue (value(d) ,'/CTNInfoList/pricePlan') pricePlan
                 ,extractvalue (value(d) ,'/CTNInfoList/reasonStatus') reasonStatus
                 ,extractvalue (value(d) ,'/CTNInfoList/lastActivity') lastActivity
                 ,extractvalue (value(d) ,'/CTNInfoList/activationDate') activationDate
                 ,extractvalue (value(d) ,'/CTNInfoList/subscriberHLR') subscriberHLR
            FROM TABLE(XmlSequence(vSOAP_ANSWER.extract('S:Envelope/S:Body/ns0:getCTNInfoListResponse/CTNInfoList'
                                                            ,'xmlns:S="http://schemas.xmlsoap.org/soap/envelope/" xmlns:ns0="urn:uss-wsapi:Subscriber"'))) D;    
  COMMIT;  
FOR REC IN( select substr(d.ctn, -10) ctn
                         , CASE WHEN d.status = 'ACTIVE' THEN 1
                         ELSE 0 END stat
                         ,d.reasonStatus reason
                         ,d.pricePlan plan
                         ,CONVERT_PCKG.TIMESTAMP_TZ_TO_DATE(d.statusDate) statusDate
                         ,bsc.IS_CONSERVATION
                         ,bsc.IS_SYSTEM_BLOCK
                     from API_GET_CTN_INFO_LIST_TEMP d
                     left outer join BEELINE_STATUS_CODE bsc on bsc.STATUS_CODE = d.reasonStatus  
                     )
 LOOP
   -- DBMS_OUTPUT.PUT_LINE( REC.ctn ||' BEGIN');
   BEGIN 
   FORCE_UPD_HIST_STATUS_CHG_DATE(REC.ctn, REC.statusDate, REC.STAT, REC.plan, REC.reason, vDATE_REPORT );
      DELETE from API_GET_CTN_INFO_LIST_TEMP WHERE  substr(ctn, -10) = REC.CTN;
      COMMIT;
   EXCEPTION
      WHEN OTHERS THEN 
      --NULL;
      DBMS_OUTPUT.PUT_LINE( REC.ctn ||' error');
   END;
   -- DBMS_OUTPUT.PUT_LINE( REC.ctn ||' END');
 END LOOP;
END; 