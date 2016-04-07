CREATE OR REPLACE VIEW V_TURNED_SERVICES AS
--#Version=3
-- 3. ƒобавлено условие, чтобы не показывать отключенные услуги в личном кабинете абонента 
   SELECT contracts.contract_id user_id,
          NVL (TARIFF_OPTIONS.OPTION_NAME,
               db_loader_account_phone_opts.option_name)
             option_name,
          db_loader_account_phone_opts.option_code,
          db_loader_account_phone_opts.turn_on_date
     FROM contracts,
          db_loader_account_phone_opts,
          TARIFF_OPTIONS,
          TARIFF_OPTION_COSTS
    WHERE     db_loader_account_phone_opts.phone_number =
                 contracts.phone_number_federal(+)
          AND db_loader_account_phone_opts.year_month =
                 TO_NUMBER (TO_CHAR (SYSDATE, 'YYYYMM'))
          AND (   DB_LOADER_ACCOUNT_PHONE_OPTS.TURN_OFF_DATE IS NULL
               OR DB_LOADER_ACCOUNT_PHONE_OPTS.TURN_OFF_DATE > SYSDATE)
          AND db_loader_account_phone_opts.option_code =
                 TARIFF_OPTIONS.OPTION_CODE(+)
          AND TARIFF_OPTIONS.TARIFF_OPTION_ID =
                 TARIFF_OPTION_COSTS.TARIFF_OPTION_ID(+);