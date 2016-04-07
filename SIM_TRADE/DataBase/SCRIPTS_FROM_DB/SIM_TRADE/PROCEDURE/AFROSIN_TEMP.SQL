
  CREATE OR REPLACE PROCEDURE "SIM_TRADE"."AFROSIN_TEMP" as
begin
  for c in (SELECT SUBSTR (d.ctn, -10) pCTN,
                                  CASE WHEN d.status = 'ACTIVE' THEN 1 ELSE 0 END pPHONE_IS_ACTIVE,
                                  d.reasonStatus pREASONSTATUS,
                                  d.pricePlan pPRICEPLAN,
                                  CONVERT_PCKG.TIMESTAMP_TZ_TO_DATE (
                                     d.statusDate)
                                     pSTATUSDATE,
                                  CASE
                                    WHEN d.status = 'ACTIVE' THEN 0
                                      ELSE bsc.IS_CONSERVATION
                                  END IS_CONSERVATION,
                                  CASE
                                   WHEN d.status = 'ACTIVE' THEN 0
                                   ELSE bsc.IS_SYSTEM_BLOCK
                                  END IS_SYSTEM_BLOCK,
                                  d.REPORT_DATE as pDATE_REPOR
                             FROM API_GET_CTN_INFO_LIST_TEMP d
                                  LEFT OUTER JOIN BEELINE_STATUS_CODE bsc
                                     ON bsc.STATUS_CODE = d.reasonStatus)
  loop
    FORCE_UPD_HIST_STATUS_CHG_DATE (
   c.pCTN,
   c.pSTATUSDATE,
   c.pPHONE_IS_ACTIVE,
   c.pPRICEPLAN,
   c.pREASONSTATUS,
   c.pDATE_REPOR);
  end loop;  
 end;