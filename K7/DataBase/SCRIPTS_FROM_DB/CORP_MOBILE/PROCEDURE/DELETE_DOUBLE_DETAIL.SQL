
  CREATE OR REPLACE PROCEDURE "CORP_MOBILE"."DELETE_DOUBLE_DETAIL" (
  SUBSCR_NO varchar2 default NULL 
  ) IS
--
--#Verion=3
-- v3. 24.04.2015 - Крайнов. Параметризация запросов.
-- v2. 12.01.2015 - Матюнин. При переходе с месяца на месяц, если в загружаемой детализациипо АПИ имелись данные за предыдущий месяц, 
--                           то они в предыдщем месяце дублировались, так как процедура зачистки дублей брала SYSDATE в качестве определения месяца. 
--                           Исправлено: теперь рассматриваем и предыдущий период   
--
BEGIN
  if SUBSCR_NO is null then
    execute immediate 
      'delete from CALL_' || to_char(sysdate, 'mm_yyyy') || ' td
         where td.DBF_ID = ' || MS_CONSTANTS.GET_CONSTANT_VALUE('API_DBF_ID') || ' 
           and exists (select 1 
                         from CALL_' || to_char(sysdate, 'mm_yyyy') || ' td1
                           where td.START_TIME = td1.START_TIME
                             and td.SUBSCR_NO = td1.SUBSCR_NO
                             and td.CALL_COST = td1.CALL_COST
                             and td1.DBF_ID <> ' || MS_CONSTANTS.GET_CONSTANT_VALUE('API_DBF_ID') || ')';
    /*                         
      -- v2 -- смотрим и за предыдущий месяц, в период с перехода с месяца на месяц
    execute immediate 
      'delete from CALL_' || to_char(add_months(sysdate, -1), 'mm_yyyy') || ' td
         where td.DBF_ID = ' || MS_CONSTANTS.GET_CONSTANT_VALUE('API_DBF_ID') || ' 
           and exists (select 1 
                         from CALL_' || to_char(add_months(sysdate, -1), 'mm_yyyy') || ' td1
                         where td.START_TIME = td1.START_TIME
                           and td.SUBSCR_NO = td1.SUBSCR_NO
                           and td.CALL_COST = td1.CALL_COST
                           and td1.DBF_ID <> ' || MS_CONSTANTS.GET_CONSTANT_VALUE('API_DBF_ID') || ')';
    */
  else
    execute immediate 
      'delete from CALL_' || to_char(sysdate, 'mm_yyyy') || ' td
         where td.DBF_ID = ' || MS_CONSTANTS.GET_CONSTANT_VALUE('API_DBF_ID') || ' 
           and td.SUBSCR_NO = :pSUBSCR_NO
           and exists (select 1 
                         from CALL_' || to_char(sysdate, 'mm_yyyy') || ' td1
                         where td.START_TIME = td1.START_TIME
                           and td.SUBSCR_NO = td1.SUBSCR_NO
                           and td.CALL_COST = td1.CALL_COST
                           and td1.DBF_ID <> ' || MS_CONSTANTS.GET_CONSTANT_VALUE('API_DBF_ID') || ')'
      USING SUBSCR_NO;
    /*  
    -- v2 -- смотрим и за предыдущий месяц, в период с перехода с месяца на месяц
    execute immediate 
      'delete from CALL_' || to_char(add_months(sysdate, -1), 'mm_yyyy') || ' td
         where td.DBF_ID = ' || MS_CONSTANTS.GET_CONSTANT_VALUE('API_DBF_ID') || ' 
           and td.SUBSCR_NO = :pSUBSCR_NO
           and exists (select 1 
                         from CALL_' || to_char(add_months(sysdate, -1), 'mm_yyyy') || ' td1
                         where td.START_TIME = td1.START_TIME
                           and td.SUBSCR_NO = td1.SUBSCR_NO
                           and td.CALL_COST = td1.CALL_COST
                           and td1.DBF_ID <> ' || MS_CONSTANTS.GET_CONSTANT_VALUE('API_DBF_ID') || ')'
      USING SUBSCR_NO;
    */    
  end if;
end;