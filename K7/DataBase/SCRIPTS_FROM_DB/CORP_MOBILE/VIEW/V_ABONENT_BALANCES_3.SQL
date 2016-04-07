
  CREATE OR REPLACE FORCE VIEW "CORP_MOBILE"."V_ABONENT_BALANCES_3" ("PHONE_NUMBER_FEDERAL", "OPERATOR_NAME", "SURNAME", "NAME", "PATRONYMIC", "BDATE", "CONTACT_INFO", "DISCONNECT_LIMIT", "CONNECT_LIMIT", "IS_CREDIT_CONTRACT", "IS_VIP", "PHONE_IS_ACTIVE_CODE", "CONSERVATION", "ACCOUNT_ID", "STATUS_DATE", "TARIFF_NAME", "TARIFF_ID", "LOADER_SCRIPT_NAME", "HAND_BLOCK", "DESCRIPTION", "DOP_STATUS") AS 
  SELECT c.phone_number_federal, operators.operator_name,
       a.surname, a.NAME, a.patronymic, a.bdate, a.contact_info,
       c.disconnect_limit, c.connect_limit, C.IS_CREDIT_CONTRACT,
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
       (SELECT TRUNC (db_loader_account_phones.last_change_status_date)
                 FROM db_loader_account_phones
                 WHERE db_loader_account_phones.phone_number = c.phone_number_federal
            AND (db_loader_account_phones.year_month =
                (SELECT MAX (t2.year_month)
                   FROM db_loader_account_phones t2
                   WHERE t2.phone_number = c.phone_number_federal)
                )
            
            AND ROWNUM<=1
       ) AS status_date,
       (SELECT NVL (tariffs.tariff_name, db_loader_account_phones.cell_plan_code)
          FROM db_loader_account_phones, tariffs
          WHERE db_loader_account_phones.phone_number = c.phone_number_federal
            AND ROWNUM<=1
            AND tariffs.tariff_id(+) =ct.CURR_TARIFF_ID
            AND (db_loader_account_phones.year_month =
                (SELECT MAX (t2.year_month)
                   FROM db_loader_account_phones t2
                   WHERE t2.phone_number = c.phone_number_federal)
                )
       ) AS tariff_name,
       ct.CURR_TARIFF_ID AS TARIFF_ID,
       operators.loader_script_name,
       c.hand_block,
       a.description,
       ds.dop_status_name dop_status
  FROM v_contracts c, abonents a, operators, contract_dop_statuses ds,contracts ct
  WHERE c.abonent_id = a.abonent_id
     and c.CONTRACT_ID=ct.CONTRACT_ID
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