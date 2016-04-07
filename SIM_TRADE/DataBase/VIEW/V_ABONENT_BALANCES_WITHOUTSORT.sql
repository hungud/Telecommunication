--#Version=7
-- 2. Котенков Исправлена условная подстановка поля CONSERVATION 
-- 3. Котенков Добавлена выдача двух полей hand_block_date_end и type_payment
-- 4. Котенков Добавлена выдача двух полей description и dop_status
-- 5.02.10.2014 Леонов Ю.Изменен селект с DB_LOADER_ACCOUNT_PHONE_HISTS.BEGIN_DATE на db_loader_account_phones.last_change_status_date
-- 6. 11.12.2014 Леонов Ю.- Добавлено поле ДАТА ДОГОВОРА
-- 7. 14.09.2015 Кочнев Е.- Изменено отображение поля PHONE_IS_ACTIVE

CREATE OR REPLACE FORCE VIEW SIM_TRADE.V_ABONENT_BALANCES_WITHOUTSORT
(
   PHONE_NUMBER_FEDERAL,
   OPERATOR_NAME,
   SURNAME,
   NAME,
   PATRONYMIC,
   BDATE,
   CONTACT_INFO,
   BALANCE,
   DISCONNECT_LIMIT,
   CONNECT_LIMIT,
   IS_VIP,
   PHONE_IS_ACTIVE_CODE,
   ACCOUNT_ID,
   STATUS_DATE,
   TARIFF_NAME,
   TARIFF_ID,
   LOADER_SCRIPT_NAME,
   HAND_BLOCK,
   IS_CREDIT_CONTRACT,
   PHONE_IS_ACTIVE,
   LIMIT_EXCEED_SUM,
   ACCOUNT_NUMBER,
   COMPANY_NAME,
   IS_DISCOUNT,
   COLOR
)
AS
SELECT t."PHONE_NUMBER_FEDERAL",
          t."OPERATOR_NAME",
          t."SURNAME",
          t."NAME",
          t."PATRONYMIC",
          t."BDATE",
          t."CONTACT_INFO",
          t."BALANCE",
          t."DISCONNECT_LIMIT",
          t."CONNECT_LIMIT",
          t."IS_VIP",
          t."PHONE_IS_ACTIVE_CODE",
          t."ACCOUNT_ID",
          t."STATUS_DATE",
          t."TARIFF_NAME",
          t."TARIFF_ID",
          t."LOADER_SCRIPT_NAME",
          t."HAND_BLOCK",
          T."IS_CREDIT_CONTRACT",
          nvl(t.COMMENT_CLENT, t.phone_is_active_) AS phone_is_active,
          --t.phone_is_active_,
          CASE
             WHEN balance < NVL (disconnect_limit, 0)
             THEN
                balance - NVL (disconnect_limit, 0)
             ELSE
                TO_NUMBER (NULL)
          END
             limit_exceed_sum,
          T.ACCOUNT_NUMBER,
          T.COMPANY_NAME,
          CASE WHEN t.IS_DISCOUNT_OPERATOR = 1 THEN 'Да' ELSE 'Нет' END
             AS IS_DISCOUNT,
          T.COLOR
     FROM
(select NVL (tr.tariff_name, ttt.cell_plan_code) AS tariff_name, 
  BSC.COMMENT_CLENT,
  CASE
     WHEN ttt.phone_is_active_code = 0
     THEN
        CASE
          WHEN ttt.PHONE_CONSERVATION = 1 
          THEN 'Блок.'
          ELSE 'Сохр.'
           END
        ELSE
           'Акт.'
  END AS phone_is_active_,

     ttt.*  from
(select 
c.phone_number_federal,--
c.disconnect_limit,--
c.connect_limit,--
C.IS_CREDIT_CONTRACT,--
get_abonent_balance (c.phone_number_federal) balance,
c.hand_block,--
ab.surname,--
ab.NAME,--
ab.patronymic,--
ab.bdate,--
ab.contact_info,--
op.operator_name,--
op.loader_script_name,--
dbload_a_p.ACCOUNT_ID, --
dbload_a_p.LAST_CHANGE_STATUS_DATE AS status_date, -- 
dbload_a_p.phone_is_active phone_is_active_code, --
dbload_a_p.CONSERVATION AS PHONE_CONSERVATION, --
dbload_a_p.status_id,
dbload_a_p.cell_plan_code,
DECODE (ab.is_vip, 1, 'Да', NULL) is_vip, --
ac.ACCOUNT_NUMBER, --
ac.COMPANY_NAME, --
get_phone_tariff_id (dbload_a_p.phone_number,
                     dbload_a_p.cell_plan_code,
                     dbload_a_p.LAST_CHANGE_STATUS_DATE) AS TARIFF_ID,
  CASE
     WHEN pna.IS_DISCOUNT_OPERATOR = 1 
      AND pna.DISCOUNT_BEGIN_DATE <= SYSDATE
      AND ADD_MONTHS (pna.DISCOUNT_BEGIN_DATE,pna.DISCOUNT_VALIDITY) >= SYSDATE
    THEN 1
    ELSE 0
  END AS IS_DISCOUNT_OPERATOR,
  
  CASE
    WHEN pna.DISCOUNT_BEGIN_DATE <= SYSDATE
     AND ADD_MONTHS (pna.DISCOUNT_BEGIN_DATE,pna.DISCOUNT_VALIDITY) >= SYSDATE + 7
    THEN 0
    ELSE 1
  END AS COLOR
FROM v_contracts c,
     abonents ab,
     operators op,
      (
       select 
              dblap.ACCOUNT_ID, 
              dblap.PHONE_NUMBER,
              Max(LAST_CHANGE_STATUS_DATE) LAST_CHANGE_STATUS_DATE,
              dblap.year_month, 
              dblap.phone_is_active,
              dblap.CONSERVATION,
              dblap.status_id,
              dblap.cell_plan_code
         from DB_LOADER_ACCOUNT_PHONES dblap
         where dblap.year_month = 
                                 (SELECT MAX(p2.year_month) FROM db_loader_account_phones p2)
      group by ACCOUNT_ID, PHONE_NUMBER, year_month, phone_is_active, CONSERVATION, status_id, cell_plan_code 
      order by dblap.PHONE_NUMBER
      ) dbload_a_p,
   ACCOUNTS AC,
   PHONE_NUMBER_ATTRIBUTES pna
where c.contract_cancel_date IS NULL     
  and c.abonent_id = ab.abonent_id
  and c.operator_id = op.operator_id(+) 
  and c.phone_number_federal = dbload_a_p.phone_number
  and dbload_a_p.ACCOUNT_ID =ac.ACCOUNT_ID(+)  
  AND C.PHONE_NUMBER_FEDERAL = pna.PHONE_NUMBER(+)
 ) ttt, tariffs tr, BEELINE_STATUS_CODE BSC                                    
 where  tr.tariff_id(+) = ttt.TARIFF_ID
   and ttt.STATUS_ID = BSC.STATUS_ID) t;


GRANT SELECT ON SIM_TRADE.V_ABONENT_BALANCES_WITHOUTSORT TO SIM_TRADE_ROLE;

