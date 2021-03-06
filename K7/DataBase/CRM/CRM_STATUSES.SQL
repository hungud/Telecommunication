CREATE OR REPLACE FORCE VIEW CRM_V_STATUSES
AS
SELECT
  DB_LOADER_ACCOUNT_PHONE_HISTS.PHONE_NUMBER,
  TRUNC(DB_LOADER_ACCOUNT_PHONE_HISTS.BEGIN_DATE) as BEGIN_DATE,
  CASE 
    WHEN DB_LOADER_ACCOUNT_PHONE_HISTS.END_DATE = TO_DATE('01.01.3000', 'DD.MM.YYYY') THEN
      TO_DATE(NULL)
    ELSE
      TRUNC(DB_LOADER_ACCOUNT_PHONE_HISTS.END_DATE)
  END as END_DATE,
  DB_LOADER_ACCOUNT_PHONE_HISTS.PHONE_IS_ACTIVE,
  NVL(TARIFFS.TARIFF_NAME, DB_LOADER_ACCOUNT_PHONE_HISTS.CELL_PLAN_CODE) TARIFF_NAME
FROM
  DB_LOADER_ACCOUNT_PHONE_HISTS,
  TARIFFS
WHERE
--  DB_LOADER_ACCOUNT_PHONE_HISTS.PHONE_NUMBER=:PHONE_NUMBER
--  AND 
        TARIFFS.TARIFF_ID(+)=GET_PHONE_TARIFF_ID(
        DB_LOADER_ACCOUNT_PHONE_HISTS.PHONE_NUMBER,
        DB_LOADER_ACCOUNT_PHONE_HISTS.CELL_PLAN_CODE,
        DB_LOADER_ACCOUNT_PHONE_HISTS.BEGIN_DATE
        )
ORDER BY
  DB_LOADER_ACCOUNT_PHONE_HISTS.END_DATE DESC NULLS FIRST;

GRANT SELECT ON CRM_V_STATUSES TO CRM_USER;
CREATE SYNONYM CRM_USER.STATUSES FOR CRM_V_STATUSES;
