
  CREATE OR REPLACE TYPE "CORP_MOBILE"."PHONE_STATE_TYPE" AS OBJECT
(
  account_id           INTEGER,
  year_month           INTEGER,
  phone_number         VARCHAR2(10 CHAR),
  phone_is_active      NUMBER(1),
  cell_plan_code       VARCHAR2(50 CHAR),
  new_cell_plan_code   VARCHAR2(50 CHAR),
  new_cell_plan_date   DATE,
  last_check_date_time DATE,
  organization_id      VARCHAR2(100 CHAR),
  conservation         NUMBER(1),
  system_block         NUMBER(1)
);

