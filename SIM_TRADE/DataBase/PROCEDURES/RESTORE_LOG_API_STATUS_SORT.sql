CREATE OR REPLACE PROCEDURE RESTORE_LOG_API_STATUS_SORT IS 
pragma AUTONOMOUS_TRANSACTION;
BEGIN
  for rec in (select distinct ctn 
                FROM API_GET_CTN_INFO_LIST_TEMP 
                ORDER BY ctn ASC )
  LOOP
    delete
      from API_GET_CTN_INFO_LIST_TEMP d
      where ctn = rec.ctn
        and exists (select 1
                      from API_GET_CTN_INFO_LIST_TEMP b
                      where b.CTN = d.CTN
                        and b.STATUSDATE = d.STATUSDATE
                        and b.STATUS = d.STATUS
                        and b.PRICEPLAN = d.PRICEPLAN
                        and b.REASONSTATUS = d.REASONSTATUS
                        and b.LASTACTIVITY = d.LASTACTIVITY
                        and b.ACTIVATIONDATE = d.ACTIVATIONDATE
                        and b.REPORT_DATE > d.REPORT_DATE ) 
        and exists (select 1
                      from API_GET_CTN_INFO_LIST_TEMP b
                      where b.CTN = d.CTN
                        and b.STATUSDATE = d.STATUSDATE
                        and b.STATUS = d.STATUS
                        and b.PRICEPLAN = d.PRICEPLAN
                        and b.REASONSTATUS = d.REASONSTATUS
                        and b.LASTACTIVITY = d.LASTACTIVITY
                        and b.ACTIVATIONDATE = d.ACTIVATIONDATE
                        and b.REPORT_DATE < d.REPORT_DATE);  
    COMMIT;   
  END LOOP;                                                 
END;
/

