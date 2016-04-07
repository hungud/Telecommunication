
  CREATE OR REPLACE PROCEDURE "CORP_MOBILE"."RESTORE_LOG_API_STATUS3" IS 
vSOAP_ANSWER XMLTYPE;
vREPORT_DATE DATE;
BEGIN
  for rec in (/*select BSAL_ID 
                FROM BEELINE_SOAP_API_LOG 
                where load_type = 3 
                  AND INSERT_DATE >= TO_DATE('16.01.2015 23:03:46', 'DD.MM.YYYY HH24:MI:SS')
                ORDER BY INSERT_DATE ASC 
                */
              SELECT * 
                FROM ACCOUNTS
                WHERE ACCOUNT_ID  IN (93,99)
                /*  AND ACCOUNT_ID NOT IN (SELECT DISTINCT ACCOUNT_ID
                                           FROM API_GET_CTN_INFO_LIST_TEMP)*/
                ORDER BY ACCOUNT_ID deSC 
              )
  LOOP
    FOR rec2 IN(SELECT BSAL_ID,  INSERT_DATE
                  FROM BEELINE_SOAP_API_LOG 
                  where load_type = 3 
                    AND INSERT_DATE >= TRUNC(to_date('23012015','ddmmyyyy')) +12/24
                    AND INSERT_DATE <= TRUNC(to_date('23012015','ddmmyyyy')) +20/24
                    AND ACCOUNT_ID = REC.ACCOUNT_ID
                    AND PHONE IS NULL
                  order by INSERT_DATE desc
                    )
    LOOP
      if rec2.BSAL_ID is not null then
        SELECT L.SOAP_ANSWER, l.INSERT_DATE INTO vSOAP_ANSWER, vREPORT_DATE
          FROM BEELINE_SOAP_API_LOG L
         -- WHERE L.BSAL_ID = TO_NUMBER ('17050718');
          WHERE L.BSAL_ID = REC2.BSAL_ID
         /* WHERE load_type = 3 
            AND INSERT_DATE >= TRUNC(SYSDATE)
            AND ACCOUNT_ID = REC.ACCOUNT_ID
            AND PHONE IS NULL
            AND INSERT_DATE = REC2.INSERT_DATE*/
          ;
        INSERT INTO API_GET_CTN_INFO_LIST_TEMP(ctn, statusDate, status, pricePlan, reasonStatus, lastActivity, activationDate, subscriberHLR, REPORT_DATE, ACCOUNT_ID)
          SELECT extractvalue (value(d) ,'CTNInfoList/ctn') ctn
                       ,extractvalue (value(d) ,'/CTNInfoList/statusDate') statusDate
                       ,extractvalue (value(d) ,'/CTNInfoList/status') status
                       ,extractvalue (value(d) ,'/CTNInfoList/pricePlan') pricePlan
                       ,extractvalue (value(d) ,'/CTNInfoList/reasonStatus') reasonStatus
                       ,extractvalue (value(d) ,'/CTNInfoList/lastActivity') lastActivity
                       ,extractvalue (value(d) ,'/CTNInfoList/activationDate') activationDate
                       ,extractvalue (value(d) ,'/CTNInfoList/subscriberHLR') subscriberHLR,
                       vREPORT_DATE,
                       REC.ACCOUNT_ID
                  FROM TABLE(XmlSequence(vSOAP_ANSWER.extract('S:Envelope/S:Body/ns0:getCTNInfoListResponse/CTNInfoList'
                                                                  ,'xmlns:S="http://schemas.xmlsoap.org/soap/envelope/" xmlns:ns0="urn:uss-wsapi:Subscriber"'))) D;    
        COMMIT;  
      end if;
    END LOOP; 
  END LOOP;                                                 
END; 