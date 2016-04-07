
  CREATE OR REPLACE PROCEDURE "CORP_MOBILE"."GET_PHONE_DETAIL_DB" (
  pPHONE_NUMBER  IN INTEGER,
  pYEAR IN INTEGER,
  pMONTH IN INTEGER, 
  pCURSOR OUT SYS_REFCURSOR) AS
  
  sql_stmt VARCHAR2(2000);
  
BEGIN
 
    sql_stmt :=  'select c.subscr_no as SELF_NUMBER,
            c.call_date as SERVICE_DATE,
            c.call_time as SERVICE_TIME,
            (select dl.SERVICE_NAME from DB_LOADER_SERVICE_TYPES dl
            where dl.service_code=c.servicetype) as SERVICE_TYPE,
            decode(c.servicedirection,1,''Исходящий'',2,''Входящий'',3,''переадресаци'',''Неопределено'') as SERVICE_DIRECTION,
            decode(c.subscr_no,c.calling_no,c.dialed_dig,c.calling_no) as OTHER_NUMBER,
            c.dur as DURATION,
            case 
              when c.dur<=2 then 0
              else ceil(c.dur/60)
            end DURATION_MIN,
            c.call_cost as SERVICE_COST,
            decode(c.isroaming,''1'',''Да'','''') as IS_ROAMING,
            c.roamingzone as ROAMING_ZONE,
            substr(c.at_ft_de,1,100) as ADD_INFO,
            TRIM( BOTH chr(13) FROM c.cell_id) as BASE_STATION_CODE,
            c.costnovat as COST_NO_VAT,
            (select bb.zone_name from BEELINE_BS_ZONES bb
            where bb.beeline_bs_zone_id=TRIM( BOTH chr(13) FROM c.cell_id)) as BS_PLACE
                --INTO vRESULT
             from call_' || pMONTH || '_' || pYEAR || ' c
            where c.subscr_no ='|| pPHONE_NUMBER||
            'order by c.start_time';
   
 OPEN pCURSOR FOR sql_stmt;
             
END;