
  CREATE OR REPLACE FORCE VIEW "CORP_MOBILE"."V_ACCOUNT_PHONE_STATUSES" ("ACCOUNT_ID", "YEAR_MONTH", "PHONE_NUMBER", "PHONE_IS_ACTIVE", "CELL_PLAN_CODE", "NEW_CELL_PLAN_CODE", "NEW_CELL_PLAN_DATE", "LAST_CHECK_DATE_TIME", "ORGANIZATION_ID", "CONSERVATION", "SYSTEM_BLOCK") AS 
  select 
--#Version=1
ACCOUNT_ID, 
  YEAR_MONTH, 
  PHONE_NUMBER, 
  PHONE_IS_ACTIVE, 
  CELL_PLAN_CODE, 
  NEW_CELL_PLAN_CODE, 
  NEW_CELL_PLAN_DATE, 
  LAST_CHECK_DATE_TIME, 
  ORGANIZATION_ID, 
  CONSERVATION, 
  SYSTEM_BLOCK
from db_loader_account_phones where (phone_number, year_month, account_id) in (
  select phone_number, year_month, max(account_id)
  from db_loader_account_phones
  where (phone_number, year_month) in (
    select phone_number, MAX(year_month) year_month from db_loader_account_phones
    where phone_number is not null
    and year_month >= TO_NUMBER(to_char(add_months(sysdate, -1), 'YYYYMM'))
    group by phone_number
  )
  group by phone_number, year_month
) 