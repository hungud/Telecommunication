CREATE OR REPLACE PROCEDURE CHANGE_CONTRACT_DOP_STATUS IS
--
-- #VERSION=5
--
-- #v=5 11.12.2014 Матюнин Разблокировать только, те для которых текущий баланс больше нуля.(Поступивший платеж должен покрывать имеющийся дол )
-- #v=4 09.12.2014 Матюнин изменил учет платежей только на те, что поступают из биллайна. Ручные платежи не учитываем.
-- #v=3 03.12.2014 Афросин добавил запись о смене доп статуса в таблицу LOG_CHANGE_CONTRACT_DOP_STATUS   
-- #VERSION=2 - исправлены косяки предыдущей версии 
  vPAYMENT_SUM NUMBER;
  vRECEIVED_PAYMENT_ID INTEGER;  
  vPAYMENT_DATE_TIME DATE ;            
  vVPHONE_NUMBER_FEDERAL VARCHAR2 (10 CHAR);
  vCONTRACT_ID INTEGER;  
  vCONTRACT_DATE DATE;
  vDOP_STATUS NUMBER DEFAULT NULL;
  vRes VARCHAR2 (1000 char);
    
--  CURSOR CUR_CONTRACTS IS        
--    select CN.CONTRACT_ID, CN.CONTRACT_DATE, CN.PHONE_NUMBER_FEDERAL, CDS.DOP_STATUS_ID--, IOT.BALANCE
--      from contracts cn
--          ,CONTRACT_DOP_STATUSES cds
--          ,IOT_CURRENT_BALANCE IOT
--     where CDS.DOP_STATUS_ID = CN.DOP_STATUS
--       AND CDS.DOP_STATUS_ID = 242
--       and IOT.PHONE_NUMBER = CN.PHONE_NUMBER_FEDERAL
--       and nvl(IOT.BALANCE,0) > 0
--  ;
  
--  CURSOR CUR_PAY(vCONTRACT_ID INTEGER, vVPHONE_NUMBER_FEDERAL VARCHAR2) IS    
--    SELECT RP.RECEIVED_PAYMENT_ID, RP.PAYMENT_SUM, RP.PAYMENT_DATE_TIME
--      INTO vRECEIVED_PAYMENT_ID, vPAYMENT_SUM, vPAYMENT_DATE_TIME 
--      FROM RECEIVED_PAYMENTS RP
--     WHERE RP.CONTRACT_ID = vCONTRACT_ID
--  ;
  
--  CURSOR CUR_PAY(vCONTRACT_ID INTEGER, vVPHONE_NUMBER_FEDERAL VARCHAR2, vCONTRACT_DATE DATE) IS        
--        select PAYMENT_SUM, PAYMENT_DATE
--        INTO vPAYMENT_SUM, vPAYMENT_DATE_TIME
--        from 
--           (
--           -- v4. Учитываются только платежи из биллайна
----            SELECT RP.PAYMENT_SUM, RP.PAYMENT_DATE_TIME PAYMENT_DATE
----              FROM RECEIVED_PAYMENTS RP
----             WHERE RP.CONTRACT_ID = vCONTRACT_ID
----               AND TRUNC(RP.PAYMENT_DATE_TIME) >= vCONTRACT_DATE
----               and RP.PAYMENT_SUM > 0 
----            UNION
--            SELECT DP.PAYMENT_SUM, DP.PAYMENT_DATE
--              FROM DB_LOADER_PAYMENTS DP
--             WHERE DP.PHONE_NUMBER = vVPHONE_NUMBER_FEDERAL
--               AND DP.PAYMENT_DATE >= vCONTRACT_DATE
--               and DP.PAYMENT_SUM > 0
--           )  
--           ;    
   cursor CUR_CONTRACTS IS
    select CN.CONTRACT_ID, CN.CONTRACT_DATE, CN.PHONE_NUMBER_FEDERAL, CDS.DOP_STATUS_ID, GET_ABONENT_BALANCE(cn.PHONE_NUMBER_FEDERAL) balanc,
           (
            SELECT DP.PAYMENT_DATE
              FROM DB_LOADER_PAYMENTS DP
             WHERE DP.PHONE_NUMBER = CN.PHONE_NUMBER_FEDERAL
               AND DP.PAYMENT_DATE >= CN.CONTRACT_DATE
               and DP.PAYMENT_SUM > 0
               and rownum < 2
           ) PAYMENT_DATE         
      from contracts cn
          ,CONTRACT_DOP_STATUSES cds
          ,IOT_CURRENT_BALANCE IOT
     where CDS.DOP_STATUS_ID = CN.DOP_STATUS
       AND CDS.DOP_STATUS_ID = 242
       and IOT.PHONE_NUMBER = CN.PHONE_NUMBER_FEDERAL      
       and exists
           (
            SELECT 1
              FROM DB_LOADER_PAYMENTS DP
             WHERE DP.PHONE_NUMBER = CN.PHONE_NUMBER_FEDERAL
               AND DP.PAYMENT_DATE >= CN.CONTRACT_DATE
               and DP.PAYMENT_SUM > 0
           )
      ;
      
BEGIN
  --  При поступлении средств необходимо разблокировать номер, снять доп. статус и изменить дату договора на дату поступления средств.
  --  Сделать отчет, по которому будет видно список номеров, с которых снят доп статус и дата снятия.
  
  -- ОПРЕДЕЛЯЕМ СПИСОК ДОГОВОРОВ (НОМЕРОВ), ПО КОТОРЫМ ПРОСТАВЛЕН ДОП СТАТУС = "ПРЕДПРОДАЖНАЯ ПОДГОТОВКА" 
  FOR REC IN CUR_CONTRACTS LOOP
    vPAYMENT_SUM := 0;
    vPAYMENT_DATE_TIME := to_date('01.01.1900','dd.mm.yyyy');
    
--    --  Для найденного номера ищем, был ли платеж
--    OPEN CUR_PAY (REC.CONTRACT_ID, REC.PHONE_NUMBER_FEDERAL, REC.CONTRACT_DATE);
--    FETCH CUR_PAY INTO vPAYMENT_SUM, vPAYMENT_DATE_TIME;
--    CLOSE CUR_PAY;
    
    IF NVL(rec.balanc, 0) >0 THEN -- ЕСЛИ НОМЕР, НА КОТОРЫЙ ПОСТУПИЛ ПЛАТЕЖ, БАЛАНС ПОЛОЖИТЕЛЕН   
      UPDATE CONTRACTS CN       --  ЧИСТИМ ДОП СТАТУС И ОБНОВЛЯЕМ ДАТУ ДОГОВОРА 
      SET CN.DOP_STATUS = NULL
         ,CN.CONTRACT_DATE = TRUNC(NVL(REC.PAYMENT_DATE, vPAYMENT_DATE_TIME))
      WHERE CN.CONTRACT_ID = REC.CONTRACT_ID; 
            
      --  Для найденного номера снимаем блокировку 
      vRes := BEELINE_API_PCKG.UNLOCK_PHONE(REC.PHONE_NUMBER_FEDERAL);           

      --  ЗАПИСЫВАЕМ В ЛОГ
      INSERT INTO LOG_CHANGE_CONTRACT_DOP_STATUS ( PHONE_NUMBER, DATE_CREATED, DOP_STATUS_ID)
                                          values ( rec.PHONE_NUMBER_FEDERAL, trunc(sysdate), REC.DOP_STATUS_ID) ;
      COMMIT; 
    END IF;
    
  END LOOP; 
END;
/