
  CREATE OR REPLACE PROCEDURE "CORP_MOBILE"."BLOCK_PHONE_WITH_DOPSTATUS" 
AS
  --V2. Мтюнин. Не берем в расчет исклоючения, справочник номеров с запретом блокировки 
  --v1. Алексеев.  
  --блокировка номеров с доп статусами на сохранение
  CURSOR C
  IS
     SELECT 
       BL.ACCESS_BLOCK, 
       BL.ACCESS_UNLOCK, 
       BL.COMMENT_CLENT, 
       BL.DOP_STATUS_ID, 
       BL.DOP_STATUS_NAME, 
       BL.PHONE_IS_ACTIVE, 
       BL.PHONE_NUMBER, 
       BL.STATUS_ID, 
       BL.YEAR_MONTH
     FROM V_BLOCK_PHONE_WITH_DOPSTATUS bl
     WHERE 
            NOT EXISTS
              (
                SELECT 1
                FROM AUTO_BLOCKED_PHONE
                WHERE AUTO_BLOCKED_PHONE.PHONE_NUMBER = BL.PHONE_NUMBER                    
                AND (AUTO_BLOCKED_PHONE.BLOCK_DATE_TIME > SYSDATE - 30/24/60) -- Не более 30 минут паузы
                AND AUTO_BLOCKED_PHONE.Note like '%Заявка на блок №%'
              )
     AND 
            NOT EXISTS
               (
                 SELECT 1
                 FROM QUEUE_PHONE_REBLOCK
                 WHERE QUEUE_PHONE_REBLOCK.PHONE_NUMBER = BL.PHONE_NUMBER
               )
     AND 
            NOT EXISTS 
               (
                   SELECT 1
                   FROM BEELINE_TICKETS B
                   WHERE B.PHONE_NUMBER = BL.PHONE_NUMBER
                       AND B.TICKET_TYPE = 9
                       AND B.DATE_CREATE > SYSDATE - 30/24/60
                       AND ((B.ANSWER IS NULL) OR (B.ANSWER = 1))
               )
     AND    NOT EXISTS -- V2 НЕ БЕРЕМ В РАСЧЕТ ИСКЛОЮЧЕНИЯ
               (
                   SELECT 1
                   FROM PHONE_NUMBER_BLOCK_DENIED 
                   WHERE PHONE_NUMBER_BLOCK_DENIED.PHONE_NUMBER = BL.PHONE_NUMBER 
               )           
     ;
        
  vSTR VARCHAR2(1000 CHAR);   
begin
  --пробегаем по всем отобранным номерам
  FOR vREC IN C 
  LOOP
    BEGIN
      vSTR := '';
      --если статус неактивный
      IF NVL(vREC.PHONE_IS_ACTIVE, 0) <> 1 THEN
        --отправляем номер на переблок на сохранение
        INSERT INTO QUEUE_PHONE_REBLOCK(PHONE_NUMBER) VALUES (vREC.PHONE_NUMBER);
        COMMIT;
      ELSIF NVL(vREC.PHONE_IS_ACTIVE, 0) = 1 THEN --если номер активен, блокируем на сохранение
        --блокируем
        vSTR := BEELINE_API_PCKG.LOCK_PHONE(vREC.PHONE_NUMBER, 1, 'S1B');   
      END IF;
    EXCEPTION
      WHEN OTHERS THEN
        NULL;
        INSERT INTO AAA(SSS1,SSS2)
        VALUES(vREC.PHONE_NUMBER, 'Сбой блокировки номера с доп. статусом на сохранение '||TO_CHAR(SYSDATE, 'DD.MM.YYYY HH24:MI:SS')||'. '||vSTR);
        COMMIT;
    END;
  END LOOP;
end;