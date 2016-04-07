CREATE GLOBAL TEMPORARY TABLE COLLECTOR_TEMP_DETAILS(
  USAGE_connect_date varchar2(15 char),
  USAGE_connect_time varchar2(15 char),
  USAGE_other_number varchar2(30 char),
  USAGE_dialed_digits varchar2(15 char),
  USAGE_data_volume varchar2(15 char),
  USAGE_duration varchar2(15 char),
  USAGE_feature_description varchar2(150 char),
  USAGE_at_charge_amt varchar2(15 char),
  USAGE_cell_id varchar2(15 char),
  USAGE_at_num_mins_to_rate varchar2(15 char),
  USAGE_call_action_code varchar2(15 char)
  ) ON COMMIT PRESERVE ROWS NOCACHE;