CREATE OR REPLACE FORCE VIEW CRM_V_INFO
--
AS
select 
    -- 
--#Version=6
--v6. Афросин  23.09.2015 - переделал оперделение possible_voluntary_block. 
--                          убрал "если форма оплаты кредитная, то possible_voluntary_block: "Нет"" 
--                          Сделано по задаче http://redmine.tarifer.ru/issues/3395 
--v5.Афросин  29.07.2015 - переделал оперделение possible_voluntary_block. Сделал вместо
--                1) Баланс номера более суточного списания абонентской платы по тарифу в 3 раза
--              вот это
--             1) Баланс номера более 0
--            соглано задаче http://redmine.tarifer.ru/issues/3123
--v4.Матюнин  21.05.2015 - определение действующего обещанного платежа делается через V_ACTIVE_PROMISED_PAYMENTS
--v3.Афроосин 16.03.2015 - Добавил номер счета в возвращаемый ответ
--v2.Афроосин 16.01.2015 - Добавил номер счета в возвращаемый ответ
/*
    возможность добровольной блокировки - possible_voluntary_block: Варианты: "Да", "Есть обещанный платеж", "Недостаточно денежных средств" 
    Значение "Да" присваивается если:
    1) Баланс номера более 0
    2) Нет действующего не погашенного обещанного платежа
    В случае если не выполнен пункт 1, тогда значение possible_voluntary_block: "Недостаточно денежных средств" 
    В случае если не выполнен пункт 2, тогда значение possible_voluntary_block: "Есть обещанный платеж"
    
    3) если форма оплаты кредитная, то possible_voluntary_block: "Нет"
       есть номера городские, у которых списывается абонентская плата за гор. номер даже в блокировке им тоже присваивать possible_voluntary_block: "Нет" 
      (как мне сказали это городские номера "Совинтел")
*/ 
  t.*,
  CASE
    WHEN  PHONE_IS_ACTIVE = 0
         OR EXISTS
                 (
                   SELECT 1
                   FROM
                     DB_LOADER_ACCOUNT_PHONE_OPTS
                   WHERE
                     DB_LOADER_ACCOUNT_PHONE_OPTS.OPTION_CODE IN ('RDIRECT_A',
                                                                     'RDIRECT_C',
                                                                     'RDIRECT_K',
                                                                     'RDIRECT_S')
                    AND DB_LOADER_ACCOUNT_PHONE_OPTS.PHONE_NUMBER = t.PHONE_NUMBER
                    AND DB_LOADER_ACCOUNT_PHONE_OPTS.TURN_ON_DATE <= SYSDATE
                    AND (
                          DB_LOADER_ACCOUNT_PHONE_OPTS.TURN_OFF_DATE >= SYSDATE
                          OR DB_LOADER_ACCOUNT_PHONE_OPTS.TURN_OFF_DATE IS NULL
                        )
                    AND DB_LOADER_ACCOUNT_PHONE_OPTS.YEAR_MONTH = t.year_month)
    THEN
      'Нет'
  ELSE
    CASE
      WHEN NVL (promised_payment_status, -19894) = -19894
           AND   t.balance > 0
       THEN
          'Да'
    ELSE
      CASE NVL (promised_payment_status, -19894)
        WHEN -19894 THEN
          'Недостаточно денежных средств'
      ELSE
       'Есть обещанный платеж'
      END
    END
  END
  possible_voluntary_block
FROM
  (
    SELECT
      DB.PHONE_NUMBER PHONE_NUMBER,
      GET_ABONENT_BALANCE (DB.PHONE_NUMBER) balance,
      CASE
         WHEN DB.PHONE_IS_ACTIVE = 1 THEN
          'Активный'
         WHEN NVL (DB.PHONE_IS_ACTIVE, 0) = 0
              AND DB.CONSERVATION = 1
         THEN
            'На сохранении'
         WHEN NVL (DB.PHONE_IS_ACTIVE, 0) = 0
              AND DB.CONSERVATION = 0
         THEN
            'Неактивный'
      END
      is_active,
      NVL (DB.PHONE_IS_ACTIVE, 0) PHONE_IS_ACTIVE,
      DOP.DOP_STATUS_NAME dop_status,
      TAR.TARIFF_NAME TARIFF_NAME,
      HIST.DATE_LAST_UPDATED UPDATED,
      CRM_CONNECT_LIMIT (DB.PHONE_NUMBER) POSSIBLE_TO_UNLOCK,
      ac.account_number ban,
      (
        SELECT
          SUM (promised_sum)
        FROM
          V_ACTIVE_PROMISED_PAYMENTS pp
        WHERE
          PP.PHONE_NUMBER = DB.PHONE_NUMBER
      )  promised_payment_status, -- 
      NVL (CON.IS_CREDIT_CONTRACT, 0) IS_CREDIT_CONTRACT,
      year_month
    FROM db_loader_account_phones db,
         db_loader_account_phone_hists hist,
         contracts con,
         tariffs tar,
         CONTRACT_DOP_STATUSES dop,
         accounts ac
    WHERE
      year_month = TO_NUMBER(TO_CHAR (SYSDATE, 'yyyymm'))
      AND DB.PHONE_NUMBER = HIST.PHONE_NUMBER
      AND HIST.END_DATE = TO_DATE ('01.01.3000', 'dd.mm.yyyy')
      AND CON.PHONE_NUMBER_FEDERAL(+) = DB.PHONE_NUMBER
      AND CON.CONTRACT_ID NOT IN (SELECT CAN.CONTRACT_ID
                                    FROM contract_cancels can)
      AND tar.tariff_id = CON.CURR_TARIFF_ID
      AND DOP.DOP_STATUS_ID(+) = CON.DOP_STATUS
      AND db.account_id = ac.account_id
) t    
          ;


CREATE SYNONYM CRM_USER.V_INFO FOR CRM_V_INFO;


GRANT SELECT ON CRM_V_INFO TO CRM_USER;
