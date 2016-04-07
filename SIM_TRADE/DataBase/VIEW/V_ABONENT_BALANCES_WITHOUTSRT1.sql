--
--Version=4
--
--v2. Афросин - вывел реальную дату смены статуса
-- 3. 11.12.2014 Леонов Ю.- Добавлено поле ДАТА ДОГОВОРА
-- v4. 14.09.2015 Кочнев Е. #3344 в отчете "Текущие балансы, статус номера отображался более точно

CREATE OR REPLACE FORCE VIEW V_ABONENT_BALANCES_WITHOUTSRT1
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
   HAND_BLOCK_DATE_END,
   TYPE_PAYMENT,
   PHONE_IS_ACTIVE,
   LIMIT_EXCEED_SUM,
   ACCOUNT_NUMBER,
   COMPANY_NAME,
   IS_DISCOUNT,
   COLOR,
   DESCRIPTION,
   DOP_STATUS,
   SESSION_ID
)
AS
select 
          t."PHONE_NUMBER_FEDERAL",
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
          T."HAND_BLOCK_DATE_END",
          T."TYPE_PAYMENT",
          nvl(t.COMMENT_CLENT, t.phone_is_active) AS phone_is_active,
   T."LIMIT_EXCEED_SUM",
   T."ACCOUNT_NUMBER",
   T."COMPANY_NAME",
   T."IS_DISCOUNT",
   T."COLOR",
   T."DESCRIPTION",
   T."DOP_STATUS",
   T."SESSION_ID"
   from (
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
          T."HAND_BLOCK_DATE_END",
          CASE
             WHEN t.is_credit_contract = 1 THEN 'Кредит'
             ELSE 'Аванс'
          END
             AS TYPE_PAYMENT,
          CASE
             WHEN t.phone_is_active_code = 0
             THEN
                CASE
                   WHEN T.PHONE_CONSERVATION = 1 THEN 'Сохр.'
                   ELSE 'Блок.'
                END
             ELSE
                'Акт.'
          END
             AS phone_is_active,
             BSC.COMMENT_CLENT,
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
          T.COLOR,
          T.DESCRIPTION,
          T.DOP_STATUS,
          t.session_id,
          t.status_id
     FROM (SELECT c.phone_number_federal,
                  operators.operator_name,
                  a.surname,
                  a.NAME,
                  a.patronymic,
                  a.bdate,
                  a.contact_info,
                  --get_abonent_balance (c.phone_number_federal) balance,
                  bll.summ BALANCE,
                  c.disconnect_limit,
                  c.connect_limit,
                  C.IS_CREDIT_CONTRACT,
                  a.description,
                  ds.dop_status_name dop_status,
                  DECODE (a.is_vip, 1, 'Да', NULL) is_vip,
                  (SELECT db_loader_account_phones.phone_is_active
                     FROM db_loader_account_phones
                    WHERE     db_loader_account_phones.phone_number =
                                 c.phone_number_federal
                          AND ROWNUM <= 1
                          AND (db_loader_account_phones.year_month =
                                  (SELECT MAX (t2.year_month)
                                     FROM db_loader_account_phones t2
                                    WHERE t2.phone_number =
                                             c.phone_number_federal)))
                     AS phone_is_active_code,
                  (SELECT db_loader_account_phones.CONSERVATION
                     FROM db_loader_account_phones
                    WHERE     db_loader_account_phones.phone_number =
                                 c.phone_number_federal
                          AND ROWNUM <= 1
                          AND (db_loader_account_phones.year_month =
                                  (SELECT MAX (t2.year_month)
                                     FROM db_loader_account_phones t2
                                    WHERE t2.phone_number =
                                             c.phone_number_federal)))
                     AS PHONE_CONSERVATION,
                  ac.ACCOUNT_ID,
                  (SELECT db_loader_account_phones.LAST_CHANGE_STATUS_DATE
                     FROM db_loader_account_phones
                    WHERE     db_loader_account_phones.phone_number =
                                 c.phone_number_federal
                          AND ROWNUM <= 1
                          AND (db_loader_account_phones.year_month =
                                  (SELECT MAX (t2.year_month)
                                     FROM db_loader_account_phones t2
                                    WHERE t2.phone_number =
                                             c.phone_number_federal)))
                     AS status_date,
                  (SELECT NVL (tariffs.tariff_name,
                               db_loader_account_phones.cell_plan_code)
                     FROM db_loader_account_phones, tariffs
                    WHERE     db_loader_account_phones.phone_number =
                                 c.phone_number_federal
                          AND ROWNUM <= 1
                          AND tariffs.tariff_id(+) =
                                 get_phone_tariff_id (
                                    db_loader_account_phones.phone_number,
                                    db_loader_account_phones.cell_plan_code,
                                    db_loader_account_phones.last_check_date_time)
                          AND (db_loader_account_phones.year_month =
                                  (SELECT MAX (t2.year_month)
                                     FROM db_loader_account_phones t2
                                    WHERE t2.phone_number =
                                             c.phone_number_federal)))
                     AS tariff_name,
                  (SELECT get_phone_tariff_id (
                             db_loader_account_phones.phone_number,
                             db_loader_account_phones.cell_plan_code,
                             db_loader_account_phones.last_check_date_time)
                     FROM db_loader_account_phones
                    WHERE     db_loader_account_phones.phone_number =
                                 c.phone_number_federal
                          AND ROWNUM <= 1
                          AND (db_loader_account_phones.year_month =
                                  (SELECT MAX (t2.year_month)
                                     FROM db_loader_account_phones t2
                                    WHERE t2.phone_number =
                                             c.phone_number_federal)))
                     AS TARIFF_ID,
                  operators.loader_script_name,
                  c.hand_block,
                  c.HAND_BLOCK_DATE_END,
                  ac.ACCOUNT_NUMBER,
                  ac.COMPANY_NAME,
                  CASE
                     WHEN     PHONE_NUMBER_ATTRIBUTES.IS_DISCOUNT_OPERATOR =
                                 1
                          AND PHONE_NUMBER_ATTRIBUTES.DISCOUNT_BEGIN_DATE <=
                                 SYSDATE
                          AND ADD_MONTHS (
                                 PHONE_NUMBER_ATTRIBUTES.DISCOUNT_BEGIN_DATE,
                                 PHONE_NUMBER_ATTRIBUTES.DISCOUNT_VALIDITY) >=
                                 SYSDATE
                     THEN
                        1
                     ELSE
                        0
                  END
                     AS IS_DISCOUNT_OPERATOR,
                  CASE
                     WHEN     PHONE_NUMBER_ATTRIBUTES.DISCOUNT_BEGIN_DATE <=
                                 SYSDATE
                          AND ADD_MONTHS (
                                 PHONE_NUMBER_ATTRIBUTES.DISCOUNT_BEGIN_DATE,
                                 PHONE_NUMBER_ATTRIBUTES.DISCOUNT_VALIDITY) >=
                                 SYSDATE + 7
                     THEN
                        0
                     ELSE
                        1
                  END
                     AS COLOR,
                  bll.session_id,
                  (SELECT db_loader_account_phones.status_id
                     FROM db_loader_account_phones
                    WHERE     db_loader_account_phones.phone_number =
                                 c.phone_number_federal
                          AND ROWNUM <= 1
                          AND (db_loader_account_phones.year_month =
                                  (SELECT MAX (t2.year_month)
                                     FROM db_loader_account_phones t2
                                    WHERE t2.phone_number =
                                             c.phone_number_federal))) status_id
                  
             FROM v_contracts c,
                  abonents a,
                  operators,
                  PHONE_NUMBER_ATTRIBUTES,
                  ACCOUNTS AC,
                  contract_dop_statuses ds,
                  testdelta_balance bll
            WHERE     c.abonent_id = a.abonent_id
                  AND c.contract_cancel_date IS NULL
                  AND operators.operator_id(+) = c.operator_id
                  AND ac.ACCOUNT_ID(+) =
                         GET_ACCOUNT_ID_BY_PHONE (c.PHONE_NUMBER_FEDERAL)
                  AND PHONE_NUMBER_ATTRIBUTES.PHONE_NUMBER(+) =
                         C.PHONE_NUMBER_FEDERAL
                  AND c.dop_status = ds.dop_status_id(+)
                  AND c.phone_number_federal = bll.phone_number
                  --AND t.STATUS_ID = BSC.STATUS_ID
                  AND c.phone_number_federal IN (SELECT p1.phone_number
                                                   FROM db_loader_account_phones p1
                                                  WHERE p1.year_month =
                                                           (SELECT MAX (
                                                                      p2.year_month)
                                                              FROM db_loader_account_phones p2 
                                                                                              )))
          t, BEELINE_STATUS_CODE BSC
          where t.STATUS_ID = BSC.STATUS_ID(+)) t;



--GRANT SELECT ON V_ABONENT_BALANCES_WITHOUTSRT1 TO CORP_MOBILE_ROLE;

--GRANT SELECT ON V_ABONENT_BALANCES_WITHOUTSRT1 TO CORP_MOBILE_ROLE_RO;
