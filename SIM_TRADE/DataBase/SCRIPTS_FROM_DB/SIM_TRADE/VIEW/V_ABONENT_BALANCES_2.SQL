
  CREATE OR REPLACE FORCE VIEW "SIM_TRADE"."V_ABONENT_BALANCES_2" ("CONTRACT_ID", "PHONE_NUMBER_FEDERAL", "OPERATOR_NAME", "SURNAME", "NAME", "PATRONYMIC", "BDATE", "CONTACT_INFO", "DISCONNECT_LIMIT", "CONNECT_LIMIT", "IS_CREDIT_CONTRACT", "DEALER_KOD", "IS_VIP", "PHONE_IS_ACTIVE_CODE", "CONSERVATION", "ACCOUNT_ID", "STATUS_DATE", "TARIFF_NAME", "TARIFF_ID", "LOADER_SCRIPT_NAME", "HAND_BLOCK", "DESCRIPTION", "DOP_STATUS", "BALANCE_NOTICE_HAND_BLOCK", "BALANCE_BLOCK_HAND_BLOCK") AS 
  SELECT
--
--Version=4
--
--v.4 Афросин 21.10.2015 Добавил contract_id
--
  C.CONTRACT_ID,
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
 (SELECT db_loader_account_phones.phone_is_active
    FROM db_loader_account_phones
    WHERE db_loader_account_phones.phone_number = c.phone_number_federal
      AND ROWNUM<=1
      AND (db_loader_account_phones.year_month =
          (SELECT MAX (t2.year_month)
             FROM db_loader_account_phones t2
             WHERE t2.phone_number = c.phone_number_federal)
          )
 ) AS phone_is_active_code,
   
 (SELECT db_loader_account_phones.CONSERVATION
    FROM db_loader_account_phones
    WHERE db_loader_account_phones.phone_number = c.phone_number_federal
      AND ROWNUM<=1
      AND (db_loader_account_phones.year_month =
          (SELECT MAX (t2.year_month)
             FROM db_loader_account_phones t2
             WHERE t2.phone_number = c.phone_number_federal)
          )
     ) AS CONSERVATION,
   
 (SELECT db_loader_account_phones.account_id
    FROM db_loader_account_phones
    WHERE db_loader_account_phones.phone_number = c.phone_number_federal
      AND ROWNUM<=1
      AND (db_loader_account_phones.year_month =
          (SELECT MAX (t2.year_month)
             FROM db_loader_account_phones t2
             WHERE t2.phone_number = c.phone_number_federal)
          )
 ) AS account_id,
   
 (SELECT TRUNC (MAX (db_loader_account_phone_hists.begin_date))
   FROM db_loader_account_phone_hists
   WHERE db_loader_account_phone_hists.phone_number = c.phone_number_federal
      AND ROWNUM<=1
 ) AS status_date,
       
 (SELECT NVL (tariffs.tariff_name, db_loader_account_phones.cell_plan_code)
    FROM db_loader_account_phones, tariffs
    WHERE db_loader_account_phones.phone_number = c.phone_number_federal
      AND ROWNUM<=1
      AND tariffs.tariff_id(+) =
          get_phone_tariff_id(
            db_loader_account_phones.phone_number,
            db_loader_account_phones.cell_plan_code,
            db_loader_account_phones.last_check_date_time
            )
      AND (db_loader_account_phones.year_month =
          (SELECT MAX (t2.year_month)
             FROM db_loader_account_phones t2
             WHERE t2.phone_number = c.phone_number_federal)
          )
 ) AS tariff_name,
   
 (SELECT get_phone_tariff_id(
      db_loader_account_phones.phone_number,
      db_loader_account_phones.cell_plan_code,
      db_loader_account_phones.last_check_date_time
      )
    FROM db_loader_account_phones
    WHERE db_loader_account_phones.phone_number = c.phone_number_federal
      AND ROWNUM<=1
      AND (db_loader_account_phones.year_month =
          (SELECT MAX (t2.year_month)
             FROM db_loader_account_phones t2
             WHERE t2.phone_number = c.phone_number_federal)
          )
 ) AS TARIFF_ID,
 operators.loader_script_name,
 c.hand_block,
 a.description,
 ds.dop_status_name dop_status,
 c.balance_notice_hand_block,
 c.balance_block_hand_block
FROM
v_contracts c,
abonents a,
operators,
contract_dop_statuses ds
WHERE c.abonent_id = a.abonent_id
 AND c.contract_cancel_date IS NULL
 AND operators.operator_id(+) = c.operator_id
 AND c.dop_status = ds.dop_status_id(+)
 AND exists (SELECT 1
                FROM db_loader_account_phones p1
                WHERE p1.year_month =(SELECT MAX(p2.year_month)
                                        FROM db_loader_account_phones p2)
                  AND P1.PHONE_NUMBER = c.phone_number_federal
                  AND ROWNUM = 1
              )