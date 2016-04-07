
  CREATE OR REPLACE FORCE VIEW "CORP_MOBILE"."V_CONTRACTS_HAND_BLOCK" ("ACCOUNT_ID", "PHONE_NUMBER", "CONTRACT_NUM", "CONTRACT_DATE", "HAND_BLOCK", "CONTRACT_CANCEL_DATE", "CURRENT_BALANCE", "USER_LAST_UPDATED", "COMMENTS", "FIO") AS 
  SELECT p.account_id,
 c.PHONE_NUMBER_FEDERAL PHONE_NUMBER,
 c.CONTRACT_NUM,
 c.CONTRACT_DATE,
 C.HAND_BLOCK,
 c.CONTRACT_CANCEL_DATE,
 GET_ABONENT_BALANCE(c.phone_number_federal) CURRENT_BALANCE,
 c.USER_LAST_UPDATED,
 c.COMMENTS,
 a.surname||DECODE(a.name, NULL ,'', ' '||a.name)||DECODE(a.patronymic, NULL, '', ' '||a.patronymic) fio
FROM
  v_contracts c, db_loader_account_phones p,abonents a
WHERE c.PHONE_NUMBER_FEDERAL = p.phone_number
     AND c.abonent_id = a.abonent_id
  -- Проверяем только в самом позднем загруженном периоде и последние л/ц
     AND p.YEAR_MONTH =
       (SELECT max(p_old.year_month )
       FROM DB_LOADER_ACCOUNT_PHONES p_old
       WHERE p.phone_number=p_old.phone_number
       )
     AND p.account_id =
       (SELECT max(p_old.account_id)
       FROM DB_LOADER_ACCOUNT_PHONES p_old
       WHERE p.phone_number=p_old.phone_number
       )

--GRANT SELECT ON v_contracts_hand_block TO CORP_MOBILE_ROLE;
--GRANT SELECT ON v_contracts_hand_block TO CORP_MOBILE_ROLE_RO
