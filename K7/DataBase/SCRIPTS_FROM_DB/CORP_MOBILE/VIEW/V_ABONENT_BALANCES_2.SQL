
  CREATE OR REPLACE FORCE VIEW "CORP_MOBILE"."V_ABONENT_BALANCES_2" ("PHONE_NUMBER_FEDERAL", "OPERATOR_NAME", "SURNAME", "NAME", "PATRONYMIC", "BDATE", "CONTACT_INFO", "DISCONNECT_LIMIT", "CONNECT_LIMIT", "IS_CREDIT_CONTRACT", "DEALER_KOD", "IS_VIP", "PHONE_IS_ACTIVE_CODE", "CONSERVATION", "ACCOUNT_ID", "STATUS_DATE", "TARIFF_NAME", "TARIFF_ID", "LOADER_SCRIPT_NAME", "HAND_BLOCK", "DESCRIPTION", "DOP_STATUS", "DOP_STATUS_ID", "BALANCE_NOTICE_HAND_BLOCK", "BALANCE_BLOCK_HAND_BLOCK", "CONTRACT_ID", "CONTRACT_DATE") AS 
  SELECT                                                         --#Version=6
                                                                            --
                              -- 6. 30.10.2015 Алексеев. Добавлена дата контракта
                              -- 5. 31.10.2014 Крайнов. Добавлен ИД контракта.
                            -- 4. 21.10.2014 Крайнов. Добавлен ИД доп статуса.
 -- 3. 02.10.2014 Леонов Ю.Изменен селект с DB_LOADER_ACCOUNT_PHONE_HISTS.BEGIN_DATE на db_loader_account_phones.last_change_status_date
                                      -- 2. Уколов. Рефакторинг для ускорения.
                                                                            --
          c.phone_number_federal,
          operators.operator_name,
          a.surname,
          a.NAME,
          a.patronymic,
          a.bdate,
          a.contact_info,
          c.disconnect_limit,
          c.connect_limit,
          C.IS_CREDIT_CONTRACT,
          C.DEALER_KOD,
          DECODE (a.is_vip, 1, 'Да', NULL) is_vip,
          V_ACCOUNT_PHONE_STATUSES.phone_is_active AS phone_is_active_code,
          V_ACCOUNT_PHONE_STATUSES.CONSERVATION,
          V_ACCOUNT_PHONE_STATUSES.account_id,
          (SELECT TRUNC (db_loader_account_phones.last_change_status_date)
             FROM db_loader_account_phones
            WHERE db_loader_account_phones.phone_number =
                     c.phone_number_federal
                  AND (db_loader_account_phones.year_month =
                          (SELECT MAX (t2.year_month)
                             FROM db_loader_account_phones t2
                            WHERE t2.phone_number = c.phone_number_federal))
                  AND ROWNUM <= 1)
             AS status_date,
          NVL (tariffs.tariff_name, V_ACCOUNT_PHONE_STATUSES.cell_plan_code)
             AS tariff_name,
          tariffs.TARIFF_ID,
          operators.loader_script_name,
          c.hand_block,
          a.description,
          ds.dop_status_name dop_status,
          ds.DOP_STATUS_ID,
          c.balance_notice_hand_block,
          c.balance_block_hand_block,
          C.CONTRACT_ID,
          C.CONTRACT_DATE
     FROM v_contracts c,
          abonents a,
          operators,
          contract_dop_statuses ds,
          V_ACCOUNT_PHONE_STATUSES,
          tariffs
    WHERE     c.abonent_id = a.abonent_id
          AND c.contract_cancel_date IS NULL
          AND operators.operator_id(+) = c.operator_id
          AND V_ACCOUNT_PHONE_STATUSES.phone_number = c.phone_number_federal
          AND c.dop_status = ds.dop_status_id(+)
          AND tariffs.tariff_id(+) =
                 get_phone_tariff_id (
                    V_ACCOUNT_PHONE_STATUSES.phone_number,
                    V_ACCOUNT_PHONE_STATUSES.cell_plan_code,
                    V_ACCOUNT_PHONE_STATUSES.last_check_date_time)
          AND EXISTS
                 (SELECT 1
                    FROM db_loader_account_phones p1
                   WHERE p1.year_month = (SELECT MAX (p2.year_month)
                                            FROM db_loader_account_phones p2)
                         AND P1.PHONE_NUMBER = c.phone_number_federal
                         AND ROWNUM = 1)