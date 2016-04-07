
  CREATE OR REPLACE PROCEDURE "CORP_MOBILE"."CHANGE_CONTRACT_DOP_STATUS" IS
-- #VERSION=10
--
-- #v=9 15.10.2015 Крайнов Добавил снятие доп статуса 402
-- #v=9 15.10.2015 Кочнев убрал проверку на коллектор для отработку номеров с доп статусом Предпродажная блокировка 342
-- #v=8 02.07.2015 Афросин добавил отработку номеров с доп статусом Предпродажная блокировка 200
-- #v=7 28.05.2015 Афросин добавил отработку номеров с доп статусом Предпродажная блокировка 500
-- #м=6 28.04.2015 Крайнов Запрет по отмененным контрактам
-- #v=5 11.12.2014 Матюнин Разблокировать только, те для которых текущий баланс больше нуля.(Поступивший платеж должен покрывать имеющийся долг )
-- #v=4 09.12.2014 Матюнин изменил учет платежей только на те, что поступают из биллайна. Ручные платежи не учитываем.
-- #v=3 03.12.2014 Афросин добавил запись о смене доп статуса в таблицу LOG_CHANGE_CONTRACT_DOP_STATUS
-- #VERSION=2 - исправлены косяки предыдущей версии
  vPAYMENT_SUM             NUMBER;
  vRECEIVED_PAYMENT_ID     INTEGER;
  vPAYMENT_DATE_TIME       DATE;
  vVPHONE_NUMBER_FEDERAL   VARCHAR2 (10 CHAR);
  vCONTRACT_ID             INTEGER;
  vCONTRACT_DATE           DATE;
  vDOP_STATUS              NUMBER DEFAULT NULL;
  vRes                     VARCHAR2 (1000 CHAR);
  CURSOR CUR_CONTRACTS IS
    SELECT CN.CONTRACT_ID,
           CN.CONTRACT_DATE,
           CN.PHONE_NUMBER_FEDERAL,
           CDS.DOP_STATUS_ID,
           GET_ABONENT_BALANCE(cn.PHONE_NUMBER_FEDERAL) balanc,
           (SELECT DP.PAYMENT_DATE
              FROM DB_LOADER_PAYMENTS DP
              WHERE DP.PHONE_NUMBER = CN.PHONE_NUMBER_FEDERAL
                AND DP.PAYMENT_DATE >= CN.CONTRACT_DATE
                AND DP.PAYMENT_SUM > 0
                AND ROWNUM < 2) PAYMENT_DATE
      FROM contracts cn, CONTRACT_DOP_STATUSES cds, 
           IOT_CURRENT_BALANCE IOT
      WHERE CDS.DOP_STATUS_ID = CN.DOP_STATUS
        AND (CDS.DOP_STATUS_ID = 242 --предпродажная блокировка
             OR ((CDS.DOP_STATUS_ID = 342 
                   AND nvl(GET_ABONENT_BALANCE(cn.PHONE_NUMBER_FEDERAL), 0) >= 500)  --предпродажная блокировка 500
                 OR (CDS.DOP_STATUS_ID = 362 
                     AND nvl(GET_ABONENT_BALANCE(cn.PHONE_NUMBER_FEDERAL), 0) >= 200)  --предпродажная блокировка 200
                )  
            ) 
        AND IOT.PHONE_NUMBER = CN.PHONE_NUMBER_FEDERAL
        AND NOT EXISTS (SELECT 1
                          FROM contract_cancels cc
                          WHERE cc.CONTRACT_ID = cn.CONTRACT_ID)
        AND EXISTS (SELECT 1
                      FROM DB_LOADER_PAYMENTS DP
                      WHERE DP.PHONE_NUMBER = CN.PHONE_NUMBER_FEDERAL
                        AND DP.PAYMENT_DATE >= CN.CONTRACT_DATE
                        AND DP.PAYMENT_SUM > 0);
BEGIN
  --  При поступлении средств необходимо разблокировать номер, снять доп. статус и изменить дату договора на дату поступления средств.
  --  Сделать отчет, по которому будет видно список номеров, с которых снят доп статус и дата снятия.
  -- ОПРЕДЕЛЯЕМ СПИСОК ДОГОВОРОВ (НОМЕРОВ), ПО КОТОРЫМ ПРОСТАВЛЕН ДОП СТАТУС = "ПРЕДПРОДАЖНАЯ ПОДГОТОВКА"
  FOR REC IN CUR_CONTRACTS
  LOOP
    vPAYMENT_SUM := 0;
    vPAYMENT_DATE_TIME := TO_DATE ('01.01.1900', 'dd.mm.yyyy');
    --    --  Для найденного номера ищем, был ли платеж
    --    OPEN CUR_PAY (REC.CONTRACT_ID, REC.PHONE_NUMBER_FEDERAL, REC.CONTRACT_DATE);
    --    FETCH CUR_PAY INTO vPAYMENT_SUM, vPAYMENT_DATE_TIME;
    --    CLOSE CUR_PAY;
    IF NVL (rec.balanc, 0) > 0 THEN -- ЕСЛИ НОМЕР, НА КОТОРЫЙ ПОСТУПИЛ ПЛАТЕЖ, БАЛАНС ПОЛОЖИТЕЛЕН
      UPDATE CONTRACTS CN   --  ЧИСТИМ ДОП СТАТУС И ОБНОВЛЯЕМ ДАТУ ДОГОВОРА
        SET CN.DOP_STATUS = NULL,
            CN.CONTRACT_DATE = TRUNC (NVL (REC.PAYMENT_DATE, vPAYMENT_DATE_TIME))
        WHERE CN.CONTRACT_ID = REC.CONTRACT_ID;
      --  Для найденного номера снимаем блокировку
      vRes := BEELINE_API_PCKG.UNLOCK_PHONE (REC.PHONE_NUMBER_FEDERAL);
      --  ЗАПИСЫВАЕМ В ЛОГ
      INSERT INTO LOG_CHANGE_CONTRACT_DOP_STATUS(PHONE_NUMBER, DATE_CREATED, DOP_STATUS_ID)
        VALUES(rec.PHONE_NUMBER_FEDERAL, TRUNC (SYSDATE), REC.DOP_STATUS_ID);
      COMMIT;
    END IF;
  END LOOP;
  -- Отменяем Доп Статус 402 - Нехватка средств на абонку по услугам.
  FOR rec IN (select x.*, get_abonent_balance(x.PHONE_NUMBER_FEDERAL) bal
                from (select c.PHONE_NUMBER_FEDERAL, C.CONTRACT_ID,
                             l.UNBLOCK_LIMIT, 
                             (select count(*) 
                                from db_loader_abonent_periods d
                                where d.YEAR_MONTH = to_number(to_char(sysdate, 'yyyymm'))
                                  and d.PHONE_NUMBER = c.PHONE_NUMBER_FEDERAL
                                  and d.IS_ACTIVE = 1 ) is_active,
                             get_discr_abon_add(c.PHONE_NUMBER_FEDERAL) abon_add       
                        from v_contracts c,
                             v_phone_limits l
                        where c.DOP_STATUS = 402
                          and c.PHONE_NUMBER_FEDERAL = l.PHONE_NUMBER_FEDERAL(+)) x
                where get_abonent_balance(x.PHONE_NUMBER_FEDERAL) > x.UNBLOCK_LIMIT  
                                                                    + case 
                                                                        when x.is_active = 0 then 1 
                                                                        else 0 
                                                                      end * x.abon_add)
  LOOP
    UPDATE CONTRACTS CN   --  ЧИСТИМ ДОП СТАТУС И ОБНОВЛЯЕМ ДАТУ ДОГОВОРА
        SET CN.DOP_STATUS = NULL
        WHERE CN.CONTRACT_ID = REC.CONTRACT_ID;
    --  ЗАПИСЫВАЕМ В ЛОГ
    INSERT INTO LOG_CHANGE_CONTRACT_DOP_STATUS(PHONE_NUMBER, DATE_CREATED, DOP_STATUS_ID)
      VALUES(rec.PHONE_NUMBER_FEDERAL, TRUNC(SYSDATE), 402);
    --  Для найденного номера снимаем блокировку
    vRes := BEELINE_API_PCKG.UNLOCK_PHONE (REC.PHONE_NUMBER_FEDERAL, 0);
    COMMIT;
  END LOOP;                                                                      
END; 