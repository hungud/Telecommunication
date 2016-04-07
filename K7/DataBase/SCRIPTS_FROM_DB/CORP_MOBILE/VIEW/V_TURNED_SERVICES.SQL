
  CREATE OR REPLACE FORCE VIEW "CORP_MOBILE"."V_TURNED_SERVICES" ("USER_ID", "OPTION_NAME", "OPTION_CODE", "TURN_ON_DATE") AS 
  SELECT contracts.contract_id user_id,
       NVL(TARIFF_OPTIONS.OPTION_NAME, db_loader_account_phone_opts.option_name) option_name,
       db_loader_account_phone_opts.option_code,
       db_loader_account_phone_opts.turn_on_date
  FROM contracts, 
       db_loader_account_phone_opts,
       TARIFF_OPTIONS,
       TARIFF_OPTION_COSTS,
       TARIFF_OPTION_NEW_COST
  WHERE contracts.phone_number_federal = db_loader_account_phone_opts.phone_number
    AND db_loader_account_phone_opts.year_month = TO_NUMBER (TO_CHAR (SYSDATE, 'YYYYMM'))
    AND TARIFF_OPTIONS.OPTION_CODE(+) = db_loader_account_phone_opts.option_code
    AND TARIFF_OPTION_COSTS.TARIFF_OPTION_ID(+) = TARIFF_OPTIONS.TARIFF_OPTION_ID
    AND NOT EXISTS (SELECT 1 
                      FROM TARIFF_OPTION_NEW_COST
                      WHERE TARIFF_OPTION_NEW_COST.TARIFF_OPTION_COST_ID=TARIFF_OPTION_COSTS.TARIFF_OPTION_COST_ID
                        AND TARIFF_OPTION_NEW_COST.TARIFF_ID=CONTRACTS.TARIFF_ID) 