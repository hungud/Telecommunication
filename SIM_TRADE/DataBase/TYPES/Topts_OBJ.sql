create or replace type Topts_OBJ is object (
  account_id           INTEGER,
  year_month           INTEGER,
  phone_number         VARCHAR2(10 CHAR),
  option_code          VARCHAR2(30 CHAR),
  option_name          VARCHAR2(200 CHAR),
  option_parameters    VARCHAR2(500 CHAR),
  turn_on_date         DATE,
  turn_off_date        DATE,
  last_check_date_time DATE,
  turn_on_cost         NUMBER(15,2),
  monthly_price        NUMBER(15,2)
);
/
