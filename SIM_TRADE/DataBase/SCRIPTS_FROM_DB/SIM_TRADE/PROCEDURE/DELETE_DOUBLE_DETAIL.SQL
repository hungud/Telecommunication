
  CREATE OR REPLACE PROCEDURE "SIM_TRADE"."DELETE_DOUBLE_DETAIL" (
   SUBSCR_NO    VARCHAR2 DEFAULT NULL)
IS
--
--#Verion=1
--
BEGIN
   -- DBF_ID = 7529 - вид загрузки из АПИ (только К7)
   IF SUBSCR_NO IS NULL
   THEN
      EXECUTE IMMEDIATE
            'delete from CALL_'
         || TO_CHAR (SYSDATE, 'mm_yyyy')
         || ' td
    where td.DBF_ID = '
         || MS_CONSTANTS.GET_CONSTANT_VALUE ('API_DBF_ID')
         || ' 
      and exists ( 
                    select 1 from CALL_'
         || TO_CHAR (SYSDATE, 'mm_yyyy')
         || ' td1
                    where td.START_TIME = td1.START_TIME
                      and td.SUBSCR_NO = td1.SUBSCR_NO
                      and td.CALL_COST = td1.CALL_COST
                      and td1.DBF_ID <> '
         || MS_CONSTANTS.GET_CONSTANT_VALUE ('API_DBF_ID')
         || ' 
                 )';
   ELSE
      EXECUTE IMMEDIATE
            'delete from CALL_'
         || TO_CHAR (SYSDATE, 'mm_yyyy')
         || ' td
    where td.DBF_ID = '
         || MS_CONSTANTS.GET_CONSTANT_VALUE ('API_DBF_ID')
         || ' 
      and td.SUBSCR_NO = '''
         || SUBSCR_NO
         || '''
      and exists ( 
                    select 1 from CALL_'
         || TO_CHAR (SYSDATE, 'mm_yyyy')
         || ' td1
                    where td.START_TIME = td1.START_TIME
                      and td.SUBSCR_NO = td1.SUBSCR_NO
                      and td.CALL_COST = td1.CALL_COST
                      and td1.DBF_ID <> '
         || MS_CONSTANTS.GET_CONSTANT_VALUE ('API_DBF_ID')
         || ' 
                 )';
   END IF;
END;