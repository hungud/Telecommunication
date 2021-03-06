CREATE OR REPLACE TYPE CALL_TEMP_TYPE AS OBJECT
(  subscr_no  VARCHAR2(11),
  ch_seiz_dt VARCHAR2(16),
  at_ft_code VARCHAR2(6),
  at_chg_amt VARCHAR2(14),
  calling_no VARCHAR2(21),
  duration   VARCHAR2(8),
  data_vol   VARCHAR2(14),
  imei       VARCHAR2(15),
  cell_id    VARCHAR2(6),
  dialed_dig VARCHAR2(21),
  at_ft_desc VARCHAR2(100),
  dbf_id     INTEGER
)
