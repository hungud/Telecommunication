CREATE OR REPLACE VIEW V_AUTO_BLOCKED_PHONE AS
-- Version = 1
--
-- 1. 2015.11.09. Крайнов. Создание.
  SELECT DLAP.ACCOUNT_ID, ABP.PHONE_NUMBER, ABP.ABONENT_FIO, ABP.BALLANCE, ABP.BLOCK_DATE_TIME, 
         DECODE(ABP.MANUAL_BLOCK, 0, 'Авто', 'Ручная') TYPE_BLOCK, 
         NVL((SELECT USER_FIO 
                FROM USER_NAMES 
                WHERE USER_NAMES.USER_NAME=ABP.USER_NAME
                  AND ROWNUM <= 1), ABP.USER_NAME) USER_NAME, 
         case 
           when (select count(*) from  fraud_blocked_phone fb
                   where fb.phone_number=ABP.PHONE_NUMBER and fb.status=1
                     and fb.date_block between ABP.BLOCK_DATE_TIME 
                           and nvl((select min(abp2.block_date_time) from AUTO_BLOCKED_PHONE abp2
                                      where abp2.phone_number=ABP.PHONE_NUMBER
                                        and abp2.block_date_time>ABP.BLOCK_DATE_TIME),sysdate)) = 0 
             then ABP.NOTE 
           else 'Блокирован по подозрению в мошенничестве' 
         end NOTE,  ABP.TICKET_ID,        
         CASE
           WHEN ABP.TICKET_ID IS NULL THEN 'Заявка неизвестна' 
           WHEN BT.TICKET_ID IS NULL THEN 'Заявка не найдена'
           WHEN BT.ANSWER = 1 THEN 'Выполнено'
           WHEN BT.ANSWER = 0 THEN 'Отказано'
           ELSE 'Выполняется'
         END ANSWER
    FROM AUTO_BLOCKED_PHONE ABP,
         DB_LOADER_ACCOUNT_PHONES DLAP, 
         BEELINE_TICKETS BT 
    WHERE ABP.TICKET_ID = BT.TICKET_ID(+)
      AND ABP.PHONE_NUMBER=DLAP.PHONE_NUMBER(+)
      AND TO_NUMBER(TO_CHAR(ABP.BLOCK_DATE_TIME,'YYYYMM'))=DLAP.YEAR_MONTH(+);
    
GRANT SELECT ON V_AUTO_BLOCKED_PHONE TO LONTANA_ROLE;    
    
GRANT SELECT ON V_AUTO_BLOCKED_PHONE TO LONTANA_ROLE_RO;    
