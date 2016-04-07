
  CREATE OR REPLACE FUNCTION "CORP_MOBILE"."CRM_CONNECT_LIMIT_N" 
(PHONE_NUMBER VARCHAR2)
RETURN VARCHAR2 IS
tmpVar NUMBER;
DiscLim NUMBER;
ConLim NUMBER;
bal NUMBER;
BEGIN
   tmpVar := 0;
   
   SELECT COUNT (1) into tmpVar
        FROM V_PHONES_FOR_UNLOCK_CRM_N vv
        WHERE vv.PHONE_NUMBER_FEDERAL = PHONE_NUMBER;
   
   IF tmpVar=1 THEN 
   
      SELECT vv.balance, NVL(vv.disconnect_limit,0), NVL(vv.connect_limit, NVL(vv.balunlock,0)) into bal, DiscLim, ConLim
        FROM V_PHONES_FOR_UNLOCK_CRM_N vv
        WHERE vv.PHONE_NUMBER_FEDERAL = PHONE_NUMBER; 
      
      if bal - DiscLim > ConLim then
        RETURN 'Да';
      else
        RETURN 'Недостаточно денежных средств';             
      end if;   
                   
   ELSE
   
        RETURN 'Нет';
        
   END IF;  
                   
   EXCEPTION
     WHEN NO_DATA_FOUND THEN
        RETURN 'Ошибка при разблокировке номера';
     WHEN OTHERS THEN
       -- Consider logging the error and then re-raise
       RETURN 'Ошибка при разблокировке номера';
       RAISE;
END CRM_CONNECT_LIMIT_N;