
  CREATE OR REPLACE FUNCTION "CORP_MOBILE"."CRM_CONNECT_LIMIT" 
(PHONE_NUMBER VARCHAR2) 
RETURN VARCHAR2 IS
tmpVar  NUMBER;
DiscLim NUMBER;
ConLim  NUMBER;
bal     NUMBER;
b_lim   NUMBER; 
ub_lim  NUMBER;

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
        select count(1) into tmpVar
          FROM V_UNBLOCK_BETWEEN_LIMITS V
         WHERE NOT EXISTS 
                         (SELECT 1 FROM AUTO_UNBLOCKED_PHONE R
                           WHERE R.PHONE_NUMBER = V.PHONE_NUMBER_FEDERAL
                             AND R.UNBLOCK_DATE_TIME > SYSDATE - 15/24/60)
           and V.PHONE_NUMBER_FEDERAL = PHONE_NUMBER;       
        if tmpVar > 0 then
          select V.BLOCK_LIMIT, v.UNBLOCK_LIMIT into b_lim, ub_lim
            FROM V_UNBLOCK_BETWEEN_LIMITS V
           WHERE NOT EXISTS 
                           (SELECT 1 FROM AUTO_UNBLOCKED_PHONE R
                             WHERE R.PHONE_NUMBER = V.PHONE_NUMBER_FEDERAL
                               AND R.UNBLOCK_DATE_TIME > SYSDATE - 15/24/60)
             and V.PHONE_NUMBER_FEDERAL = PHONE_NUMBER; 
          IF (bal > b_lim) AND (bal < ub_lim) THEN
            RETURN 'Да';
          else
           RETURN 'Недостаточно денежных средств';             
          end if;
        else
          RETURN 'Недостаточно денежных средств';
        end if;
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
END CRM_CONNECT_LIMIT;