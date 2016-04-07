CREATE OR REPLACE TYPE CALL_TYPE AS OBJECT
(
  SUBSCR_NO varchar2(11),
  START_TIME date,
  AT_FT_CODE varchar2(6),
  DBF_ID integer,
  call_cost number,
  costnovat number,
  dur number,
  IMEI varchar2(15),
  ServiceType      varchar2(1),
  ServiceDirection number(1),
  IsRoaming        varchar2(1),
  RoamingZone      varchar2(6),
  CALL_DATE varchar2(10),
  CALL_TIME varchar2(8),
  DURATION varchar2(8),
  DIALED_DIG varchar2(21),
  AT_FT_DE varchar2(240),
  AT_FT_DESC varchar2(240),
  CALLING_NO varchar2(21),
  AT_CHG_AMT varchar2(14),
  DATA_VOL varchar2(14),
  CELL_ID varchar2(6),
  MN_UNLIM number(1),
  cost_chng number,
  PROV_ID INTEGER
)
/