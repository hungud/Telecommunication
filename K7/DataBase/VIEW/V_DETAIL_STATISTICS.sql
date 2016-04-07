CREATE OR REPLACE VIEW V_DETAIL_STATISTICS AS
  SELECT CS.YEAR_MONTH, 
         CS.SUBSCR_NO, 
         SUM(CS.CALL_SUM) ESTIMATE_SUM,
         SUM(CASE 
               WHEN HC.IS_ROAMING=0 AND HC.SERVICE_ID=1 THEN 
                 CS.CALL_SUM 
               ELSE 0 
             END) CALLS_LOCAL_COST,
         SUM(CASE 
               WHEN HC.IS_ROAMING=0 AND HC.SERVICE_ID=1 AND HC.C_ACT_CD=1 THEN 
                 CS.ZERO_COST_DUR 
               ELSE 0 
             END) CALLS_LOCAL_Z_IN_DUR,
         SUM(CASE 
               WHEN HC.IS_ROAMING=0 AND HC.SERVICE_ID=1 AND HC.C_ACT_CD=2 THEN 
                 CS.ZERO_COST_DUR 
               ELSE 0 
             END) CALLS_LOCAL_Z_OUT_DUR,
         SUM(CASE 
               WHEN HC.IS_ROAMING=0 AND HC.SERVICE_ID=1 AND HC.C_ACT_CD=1 THEN 
                 CS.CALL_SUM 
               ELSE 0 
             END) CALLS_LOCAL_IN_COST,
         SUM(CASE 
               WHEN HC.IS_ROAMING=0 AND HC.SERVICE_ID=1 AND HC.C_ACT_CD=1 THEN 
                 CS.DUR - CS.ZERO_COST_DUR 
               ELSE 0 
             END) CALLS_LOCAL_NZ_IN_DUR,
         SUM(CASE 
               WHEN HC.IS_ROAMING=0 AND HC.SERVICE_ID=1 AND HC.C_ACT_CD=2 THEN 
                 CS.CALL_SUM 
               ELSE 0 
             END) CALLS_LOCAL_OUT_COST,
         SUM(CASE 
               WHEN HC.IS_ROAMING=0 AND HC.SERVICE_ID=1 AND HC.C_ACT_CD=2 THEN 
                 CS.DUR - CS.ZERO_COST_DUR 
               ELSE 0 
             END) CALLS_LOCAL_NZ_OUT_DUR,
         SUM(CASE 
               WHEN HC.IS_ROAMING=0 AND HC.SERVICE_ID=2 THEN 
                 CS.CALL_SUM 
               ELSE 0 
             END) CALLS_OTHER_CITY_COST,
         SUM(CASE 
               WHEN HC.IS_ROAMING=0 AND HC.SERVICE_ID=2 AND HC.C_ACT_CD=1 THEN 
                 CS.ZERO_COST_DUR 
               ELSE 0 
             END) CALLS_OTHER_CITY_Z_IN_DUR,
         SUM(CASE 
               WHEN HC.IS_ROAMING=0 AND HC.SERVICE_ID=2 AND HC.C_ACT_CD=2 THEN 
                 CS.ZERO_COST_DUR 
               ELSE 0 
             END) CALLS_OTHER_CITY_Z_OUT_DUR,
         SUM(CASE 
               WHEN HC.IS_ROAMING=0 AND HC.SERVICE_ID=2 AND HC.C_ACT_CD=1 THEN  
                 CS.CALL_SUM 
               ELSE 0  
             END) CALLS_OTHER_CITY_IN_COST,
         SUM(CASE  
               WHEN HC.IS_ROAMING=0 AND HC.SERVICE_ID=2 AND HC.C_ACT_CD=1 THEN  
                 CS.DUR - CS.ZERO_COST_DUR 
               ELSE 0  
             END) CALLS_OTHER_CITY_NZ_IN_DUR,
         SUM(CASE  
               WHEN HC.IS_ROAMING=0 AND HC.SERVICE_ID=2 AND HC.C_ACT_CD=2 THEN  
                 CS.CALL_SUM 
               ELSE 0  
             END) CALLS_OTHER_CITY_OUT_COST,
         SUM(CASE  
               WHEN HC.IS_ROAMING=0 AND HC.SERVICE_ID=2 AND HC.C_ACT_CD=2 THEN  
                 CS.DUR - CS.ZERO_COST_DUR 
               ELSE 0  
             END) CALLS_OTHER_CITY_NZ_OUT_DUR,
         SUM(CASE  
               WHEN HC.IS_ROAMING=0 AND HC.SERVICE_ID=3 THEN  
                 CS.CALL_SUM 
               ELSE 0  
             END) CALLS_OTHER_COUNTRY_COST,
         SUM(CASE  
               WHEN HC.IS_ROAMING=0 AND HC.SERVICE_ID=3 AND HC.C_ACT_CD=1 THEN  
                 CS.ZERO_COST_DUR 
               ELSE 0  
             END) CALLS_OTHER_COUNTRY_Z_IN_DUR,
         SUM(CASE  
               WHEN HC.IS_ROAMING=0 AND HC.SERVICE_ID=3 AND HC.C_ACT_CD=2 THEN  
                 CS.ZERO_COST_DUR 
               ELSE 0  
             END) CALLS_OTHER_COUNTRY_Z_OUT_DUR,
         SUM(CASE  
               WHEN HC.IS_ROAMING=0 AND HC.SERVICE_ID=3 AND HC.C_ACT_CD=1 THEN  
                 CS.CALL_SUM 
               ELSE 0  
             END) CALLS_OTHER_COUNTRY_IN_COST,
         SUM(CASE  
               WHEN HC.IS_ROAMING=0 AND HC.SERVICE_ID=3 AND HC.C_ACT_CD=1 THEN  
                 CS.DUR - CS.ZERO_COST_DUR 
               ELSE 0  
             END) CALLS_OTHER_COUNTRY_NZ_IN_DUR,
         SUM(CASE  
               WHEN HC.IS_ROAMING=0 AND HC.SERVICE_ID=3 AND HC.C_ACT_CD=2 THEN  
                 CS.CALL_SUM 
               ELSE 0  
             END) CALLS_OTHER_COUNTRY_OUT_COST,
         SUM(CASE  
               WHEN HC.IS_ROAMING=0 AND HC.SERVICE_ID=3 AND HC.C_ACT_CD=2 THEN  
                 CS.DUR - CS.ZERO_COST_DUR 
               ELSE 0  
             END) CALLS_OTHER_COUNTRY_NZ_OUT_DUR,
         SUM(CASE  
               WHEN HC.IS_ROAMING=0 AND HC.SERVICE_ID=4 THEN  
                 CS.CALL_SUM 
               ELSE 0  
             END) INTERNET_COST,
         SUM(CASE  
               WHEN HC.IS_ROAMING=0 AND HC.SERVICE_ID=4 THEN  
                 CASE 
                   WHEN HC.UOM = 'MB' THEN CS.DATA_VOL 
                   WHEN HC.UOM = 'KB' THEN TRUNC(CS.DATA_VOL/1024, 2) 
                   ELSE 0 
                 END 
               ELSE 0  
             END) INTERNET_VOL,
         SUM(CASE  
               WHEN HC.IS_ROAMING=0 AND HC.SERVICE_ID=5 THEN  
                 CS.CALL_SUM 
               ELSE 0  
             END) MESSAGES_SMS_COST,
         SUM(CASE  
               WHEN HC.IS_ROAMING=0 AND HC.SERVICE_ID=5 THEN  
                 1 
               ELSE 0  
             END) MESSAGES_SMS_COUNT,
         SUM(CASE  
               WHEN HC.IS_ROAMING=0 AND HC.SERVICE_ID=6 THEN  
                 CS.CALL_SUM 
               ELSE 0  
             END) MESSAGES_MMS_COST,
         SUM(CASE  
               WHEN HC.IS_ROAMING=0 AND HC.SERVICE_ID=6 THEN  
                 1 
               ELSE 0  
             END) MESSAGES_MMS_COUNT,
         SUM(CASE  
               WHEN HC.IS_ROAMING=0 AND HC.SERVICE_ID=7 THEN  
                 CS.CALL_SUM 
               ELSE 0  
             END) ADD_SERVICE_COST,
         SUM(CASE  
               WHEN HC.IS_ROAMING=0 AND HC.SERVICE_ID=7 THEN  
                 1 
               ELSE 0  
             END) ADD_SERVICE_COUNT,
         SUM(CASE  
               WHEN HC.IS_ROAMING=0 AND HC.SERVICE_ID=8 THEN  
                 CS.CALL_SUM 
               ELSE 0  
             END) OTHER_COST,
         SUM(CASE  
               WHEN HC.IS_ROAMING=0 AND HC.SERVICE_ID=8 THEN 
                 1 
               ELSE 0  
             END) OTHER_COUNT,
         SUM(CASE  
               WHEN HC.IS_ROAMING=1 THEN  
                 CS.CALL_SUM 
               ELSE 0  
             END) NATIONAL_ROAMING_COST,
         SUM(CASE  
               WHEN HC.IS_ROAMING=1 AND HC.SERVICE_ID=1 THEN  
                 CS.CALL_SUM 
               ELSE 0  
             END) NATIONAL_ROAMING_CALLS,
         SUM(CASE  
               WHEN HC.IS_ROAMING=1 AND HC.SERVICE_ID=1 AND HC.C_ACT_CD=1 THEN  
                 CS.DUR 
               ELSE 0  
             END) NATIONAL_ROAMING_CALLS_IN_DUR,
         SUM(CASE  
               WHEN HC.IS_ROAMING=1 AND HC.SERVICE_ID=1 AND HC.C_ACT_CD=2 THEN  
                 CS.DUR 
               ELSE 0  
             END) NATIONAL_ROAMING_CALLS_OUT_DUR,
         SUM(CASE  
               WHEN HC.IS_ROAMING=1 AND HC.SERVICE_ID=4 THEN 
                 CS.CALL_SUM 
               ELSE 0  
             END) NATIONAL_ROAMING_INTERNET,
         SUM(CASE  
               WHEN HC.IS_ROAMING=1 AND HC.SERVICE_ID=4 THEN 
                 CASE 
                   WHEN HC.UOM = 'MB' THEN CS.DATA_VOL 
                   WHEN HC.UOM = 'KB' THEN TRUNC(CS.DATA_VOL/1024, 2) 
                   ELSE 0 
                 END 
               ELSE 0  
             END) NATIONAL_ROAMING_INTERNET_VOL,
         SUM(CASE  
               WHEN HC.IS_ROAMING=1 AND HC.SERVICE_ID=5 THEN 
                 CS.CALL_SUM 
               ELSE 0  
             END) NATIONAL_ROAMING_MESSAGES,
         SUM(CASE  
               WHEN HC.IS_ROAMING=1 THEN 
                 CS.CALL_SUM 
               ELSE 0  
             END) OTHER_COUNTRY_ROAMING_COST,
         SUM(CASE 
               WHEN HC.IS_ROAMING=2 AND HC.SERVICE_ID=1 THEN 
                 CS.CALL_SUM 
               ELSE 0 
             END) OTHER_COUNTRY_ROAMING_CALLS,
         SUM(CASE 
               WHEN HC.IS_ROAMING=2 AND HC.SERVICE_ID=1 AND HC.C_ACT_CD=1 THEN 
                 CS.DUR 
               ELSE 0 
             END) OTHER_COUNTRY_R_CALLS_IN_DUR,
         SUM(CASE 
               WHEN HC.IS_ROAMING=2 AND HC.SERVICE_ID=1 AND HC.C_ACT_CD=2 THEN 
                 CS.DUR 
               ELSE 0 
             END) OTHER_COUNTRY_R_CALLS_OUT_DUR,
         SUM(CASE 
               WHEN HC.IS_ROAMING=2 AND HC.SERVICE_ID=4 THEN 
                 CS.CALL_SUM 
               ELSE 0 
             END) OTHER_COUNTRY_ROAMING_INTERNET,
         SUM(CASE 
               WHEN HC.IS_ROAMING=2 AND HC.SERVICE_ID=4 THEN 
                 CASE 
                   WHEN HC.UOM = 'MB' THEN CS.DATA_VOL 
                   WHEN HC.UOM = 'KB' THEN TRUNC(CS.DATA_VOL/1024, 2) 
                   ELSE 0 
                 END 
               ELSE 0 
             END) OTHER_COUNTRY_R_INTERNET_VOL,
         SUM(CASE 
               WHEN HC.IS_ROAMING=2 AND HC.SERVICE_ID=5 THEN 
                 CS.CALL_SUM 
               ELSE 0 
             END) OTHER_COUNTRY_ROAMING_MESSAGES,
         MAX(CS.DATE_LAST_UPDATE) DATE_LAST_UPDATE           
    FROM CALL_STATISTICS CS,
         HOT_BILLING_CALL_AT_FT_CODE HC
    WHERE CS.AT_FT_CODE = HC.AT_FT_CODE(+)
    GROUP BY CS.YEAR_MONTH, CS.SUBSCR_NO;

GRANT SELECT ON V_DETAIL_STATISTICS TO CORP_MOBILE_ROLE;

GRANT SELECT ON V_DETAIL_STATISTICS TO CORP_MOBILE_ROLE_RO;    