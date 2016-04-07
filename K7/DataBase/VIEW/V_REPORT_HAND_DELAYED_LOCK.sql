CREATE OR REPLACE VIEW V_REPORT_HAND_DELAYED_LOCK AS
SELECT 
    --  #version=1
    --  v1. 29.06.2015 - Матюнин И. 
    --  создана для задачи http://redmine.tarifer.ru/issues/2600:
    --  отчет по отложенной блокировке: кем ,когда и с каким балансом была включена
    --
       T.PHONE_NUMBER_FEDERAL AS PHONE_NUMBER,  -- Номер телефона
-- ----------------------------  OK  ------------------------------------------------
       NVL( ( SELECT SH.UPDATE_USER 
                FROM SH_CONTRACTS SH  
               WHERE SH.CONTRACT_ID = T.CONTRACT_ID 
                 AND SH.DATE_CREATED IN 
                        ( SELECT MIN(SH1.DATE_CREATED) FROM SH_CONTRACTS SH1   
                           WHERE SH1.CONTRACT_ID=T.CONTRACT_ID 
                             AND SH1.HAND_BLOCK_DATE_END = T.HAND_BLOCK_DATE_END   
                        )   
                 AND ROWNUM <=1   
            ),  
            T.USER_LAST_UPDATED   
          ) AS USER_NAME,                         --  Пользователь, установивший блокировку
       -- ----------------------------  OK  ------------------------------------------------
       NVL( ( SELECT SH.DATE_CREATED 
                FROM SH_CONTRACTS SH   
               WHERE SH.CONTRACT_ID=T.CONTRACT_ID 
                 AND SH.DATE_CREATED IN 
                        ( SELECT MIN(SH1.DATE_CREATED) FROM SH_CONTRACTS SH1  
                           WHERE SH1.CONTRACT_ID = T.CONTRACT_ID 
                             AND SH1.HAND_BLOCK_DATE_END = T.HAND_BLOCK_DATE_END    
                        )       
                 AND ROWNUM <=1        
            ), 
            SHN.DATE_CREATED 
          ) AS BLOCK_DATE_TIME,                         --  Дата установления блокировки
       -- ----------------------------  OK  ------------------------------------------------
       T.START_BALANCE AS BALLANCE,             --  Баланс на момент установления
       -- ----------------------------  OK  ------------------------------------------------
       NVL( ( SELECT SH.UPDATE_USER 
                FROM SH_CONTRACTS SH   
                WHERE SH.CONTRACT_ID = T.CONTRACT_ID 
                  AND SH.HAND_BLOCK_DATE_END = T.HAND_BLOCK_DATE_END 
                  AND SH.DATE_CREATED = 
                        ( SELECT MIN(SH1.DATE_CREATED) FROM SH_CONTRACTS SH1   
                           WHERE SH1.CONTRACT_ID=T.CONTRACT_ID 
                             AND SH1.HAND_BLOCK_DATE_END = T.HAND_BLOCK_DATE_END     
                        ) 
                  AND ROWNUM <=1       
            )
           ,T.USER_LAST_UPDATED    
          ) AS UNBLOCK_USER_NAME,                     --  пользователь , отключивший
       -- ----------------------------  OK  ------------------------------------------------
       T.HAND_BLOCK_DATE_END AS UNBLOCK_DATE_TIME,    --  дата отключения
       -- ----------------------------  OK  ------------------------------------------------
       ( SELECT MAX(I.BALANCE)    
           FROM IOT_BALANCE_HISTORY I   
           WHERE I.PHONE_NUMBER = T.PHONE_NUMBER_FEDERAL   
             AND I.START_TIME <= T.HAND_BLOCK_DATE_END    
             AND (
                  (I.END_TIME >= T.HAND_BLOCK_DATE_END ) 
                 OR 
                  (I.END_TIME IS NULL)
                 ) 
       ) AS BALLANCE_UNLOCK,    --  баланс на момент отключения
       -- ----------------------------  OK  ------------------------------------------------
       NVL(T.BALANCE_NOTICE_HAND_BLOCK,0) AS BALANCE_NOTICE_HAND_BLOCK   -- Баланс предупреждения
       -- ----------------------------  OK  ------------------------------------------------
 FROM CONTRACTS T, 
      SH_CONTRACTS SHN   
WHERE NVL(T.HAND_BLOCK, 0) = 1       
  AND T.CONTRACT_DATE IN 
           ( SELECT MAX(T1.CONTRACT_DATE) 
               FROM CONTRACTS T1
              WHERE T1.PHONE_NUMBER_FEDERAL = T.PHONE_NUMBER_FEDERAL   
                AND NVL(T1.HAND_BLOCK, 0) = 1 
           )    
  AND SHN.DATE_LAST_UPDATED = 
           ( SELECT MAX(DATE_LAST_UPDATED) 
               FROM SH_CONTRACTS SHN1  
              WHERE SHN1.CONTRACT_ID = T.CONTRACT_ID  
                AND SHN1.HAND_BLOCK_DATE_END IS NULL  
           )   
  AND SHN.CONTRACT_ID = T.CONTRACT_ID     
  AND SHN.HAND_BLOCK_DATE_END IS NULL  -- начало
ORDER BY T.CONTRACT_ID  
;

grant select on V_REPORT_HAND_DELAYED_LOCK to corp_mobile_role;
grant select on V_REPORT_HAND_DELAYED_LOCK to corp_mobile_role_ro;  

